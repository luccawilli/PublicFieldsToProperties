$path = "C:\ProgrameP\Main\ReleaseCandidate\RC\Perigon\PerigonService\PerigonMobile\DTO"
$pattern = "(public) ([A-Za-z0-9<>\?\[\]]*)(( )*) ([A-Za-z0-9]*)((;)|( =))"
$files = Get-Childitem -Path $path -Filter "*.cs" -Recurse
foreach ($f in $files){
    $content = Get-Content $f.FullName
    $match = $content -match $pattern
    if($match){
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
