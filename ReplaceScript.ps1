$path = "C:\ProgrameP\Main\ReleaseCandidate\RC\Perigon\Perigon\Service"
$tfExePath = "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\Common7\IDE\CommonExtensions\Microsoft\TeamFoundation\Team Explorer\tf.exe"
$pattern = "(public) ([A-Za-z0-9<>\?\[\]]*)(( )*) ([A-Za-z0-9_-]*)((;)|( = ))"
$files = Get-Childitem -Path $path -Filter "*.cs" -Recurse
foreach ($f in $files){
    $content = Get-Content $f.FullName
    $match = $content -match $pattern
    if($match){
	    & $tfExePath checkout $f.FullName
        foreach ($m in $match){
            $new = $m -replace "=","{ get; set; } ="   
            if($new -notlike "*=*"){
                $new = $new -replace ";"," { get; set; }"  
            }
            $content = $content -replace [regex]::escape($m),$new
        }
        Set-Content -Path $f.FullName -Value $content
    }    
}
