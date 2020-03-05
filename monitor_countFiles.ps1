# Kai Osthoff <ko@osthoff.net>
# March, 2020

# Today listening to https://open.spotify.com/playlist/37i9dQZF1DWXDvpUgU6QYl?si=lXw-cBpOQk6P8pFlyyrccQ while coding!

# License
# https://choosealicense.com/licenses/gpl-3.0/





# Parameters: Defaults can be overriden by datto RMM
$MonitorPath = "C:\Users"
$countLimit = 250
$recurseMode = $false


$githubLink = "https://github.com/mspautomation/rmmMonitor_countFiles"
$mspSOP = "https://github.com/mspautomation/rmmMonitor_countFiles/wiki/mspSOP"

# Are there any input from AEM?
if (Test-Path env:\MonitorPath) {
    $MonitorPath = $env:MonitorPath
}

if (Test-Path env:\mspSOP) {
    $mspSOP = $env:mspSOP
}


if (Test-Path env:\countLimit) {
    $countLimit = $env:countLimit
}

if (Test-Path env:\recurseMode) {
    $recurseMode = $env:recurseMode
}




# Need in every Script
$aem_alertStart = "<-Start Result->"
$aem_alertEnd   = "<-End Result->"
$aem_diagStart  = "<-Start Diagnostic->"
$aem_diagEnd    = "<-End Diagnostic->"
$alert          = $false

if($env:recurseMode -eq $true) {
    $count = (Get-ChildItem -Path $MonitorPath -Recurse -Directory | Measure-Object).Count
} else {
    $count = (Get-ChildItem -Path $MonitorPath | Measure-Object).Count    
}

if($count -gt $countLimit) {
    $alert = $true
} else {
    $alert = $false
}


#Output Diagnostics


#Write-Output 'Start of AEM Output:'


Write-Output $aem_alertStart
if ($alert -eq $true) {
    $aem_alert = "Warning=" + $count + " files in " + $MonitorPath
            
    }

 Else {

    $aem_alert = "Warning=" + $count + " files in " + $MonitorPath
}
Write-Output $aem_alert
Write-Output $aem_alertEnd



if ($alert -eq $true) {
Write-Output $aem_diagStart

Write-Output ""
Write-Output "`n`n"
Write-Output "SOP: " + $mspSOP +"`n"
Write-Output "Support and more for that genius Component: " + $githubLink 


Write-Output $aem_diagEnd

}




if ($alert -eq $true) { 
    Exit 1
    } Else
    {
    Exit 0
    }


#
#
