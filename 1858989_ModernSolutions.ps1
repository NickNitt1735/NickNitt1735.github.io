$filePath = "$($PSScriptRoot)\"

function KillThatProcess($theApplication) {
   $numProcesses = 0
   $numProcesses = (Get-Process $theApplication -ErrorAction SilentlyContinue).count
   Write-Host ""
   Write-Host "There are $numProcesses processes with the name $theApplication, proceed?  Y/N"
   $yesOrNo =  Read-Host

   if($yesOrNo -eq 'y' -or $yesOrNo -eq 'Y') {
       
       if($numProcesses -gt 0) {
           Write-Host ""
           spps -processname $theApplication -WhatIf
       }

       

   }else {
   Write-Host ""
   Write-Host "Operation Cancelled" -ForegroundColor Red -BackgroundColor Yellow
   Write-Host ""
   Write-Host "Enter anything to continue the program"
   Read-Host


   }
}

function Bamboozle($filePath, $scriptName) {
$letterList = 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
$randomNumber = Get-Random -Maximum 26
$letterUsed =  $letterList[$randomNumber]
Write-Host "Now go look through the files in that folder and try to find a $letterUsed."
Write-Host ""
$chosenFiles = Get-Item $filePath* -Exclude $scriptName -Filter "*$letterUsed*"

For($i=0; $i -lt $chosenFiles.count; $i++) {
    Remove-Item $chosenFiles[$i] -WhatIf
}


}









DO {

    Write-Host "What program would you like to close?"
    [double]$appAsNum = 0
    [string]$application = read-host
    $successfulConversion = [double]::TryParse($application, [ref]$appAsNum)

    if($successfulConversion -eq $true) {
        Write-Host "Please enter a name of an application, not a number"
    }

} While ($successfulConversion -eq $true)

KillThatProcess $application


Write-Host ""
Write-Host "Please enter a file path.  If the filePath does not exist, the directory of the current script will be used."
[string]$scriptName = $MyInvocation.MyCommand.Name
$filePath = read-host
$pathExist = Test-Path $filePath

if($pathExist -eq $false) {
    $filePath = "$($PSScriptRoot)\"
}

Write-Host ""

Bamboozle $filePath $scriptName

Read-Host