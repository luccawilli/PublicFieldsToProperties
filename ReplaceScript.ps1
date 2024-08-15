$path = "C:\root-git\perigonAhab\PerigonDesktop"
$pattern = "(public)(( static)|()) ([A-Za-z0-9._<>\?\[\]]*)(( )*) ([A-Za-z0-9_-]*)((;)|( = ))"
$files = Get-Childitem -Path $path -Filter "*.cs" -Recurse -Exclude "*.resx.cs"
foreach ($f in $files){
    $content = Get-Content $f.FullName -Encoding utf8
    $match = $content -match $pattern
    if($match){
        foreach ($m in $match){
			if($new -notlike "* _*"){
				$new = $m -replace "=","{ get; set; } ="   
				if($new -notlike "*=*"){
					$new = $new -replace ";"," { get; set; }"  
				}
			}
			else {
				$new = $m -replace "public","private"
			}
            $content = $content -replace [regex]::escape($m),$new
        }
        Set-Content -Path $f.FullName -Value $content -Encoding utf8
    }    
}
