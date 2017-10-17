foreach ($keyword in Get-Content C:\Tools\ios.txt){
    Write-Host $keyword
    Get-ChildItem "C:\iOS\Source\*.*" -Recurse | Select-String -Pattern $keyword -CaseSensitive
    Write-Host `r`n
}
