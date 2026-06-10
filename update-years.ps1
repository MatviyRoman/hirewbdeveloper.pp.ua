$root = "c:\Users\APARTNER.PRO\Desktop\site\hirewebdeveloper.pp.ua"
$allHtml = Get-ChildItem -Path $root -Filter "*.*" -Recurse | Where-Object { 
    ($_.Extension -eq ".html" -or $_.Extension -eq ".txt") -and 
    $_.FullName -notmatch '\\\.git\\' -and 
    $_.FullName -notmatch '\\\.claw\\' 
}

$count = 0

foreach ($file in $allHtml) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $original = $content
    
    $content = $content -replace '6\+ років', '10+ років'
    $content = $content -replace '6 років', '10 років'
    $content = $content -replace '6\+ years', '10+ years'
    $content = $content -replace '6 years', '10 years'
    $content = $content -replace '>6\+<', '>10+<'
    
    if ($content -ne $original) {
        [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.UTF8Encoding]::new($false))
        $count++
        $relPath = $file.FullName.Substring($root.Length)
        Write-Host "Updated $relPath"
    }
}

Write-Host "Replaced '6 years' with '10 years' in $count files"
