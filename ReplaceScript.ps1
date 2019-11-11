$path = "C:\Users\Lucca\source\repos\PublicFieldsToProperties\PublicFieldsToProperties"
$pattern = "(public) ([A-Za-z]*) ([A-Za-z]*)((;)|( =))"
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
            $content = $content -replace $m,$new
        }
        Set-Content -Path $f.FullName -Value $content
    }    
}
