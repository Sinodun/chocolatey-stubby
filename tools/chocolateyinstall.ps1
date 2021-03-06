﻿$ErrorActionPreference = 'Stop'; # stop on all errors

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = "msi"
  file          = "$toolsDir\stubby-%VERSION%-x86.msi"
  file64        = "$toolsDir\stubby-%VERSION%-x64.msi"

  softwareName  = 'Stubby'

  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs

$packageName = $packageArgs.packageName
$softwareName = $packageArgs.softwareName
$installLocation = Get-AppInstallLocation $softwareName
if ($installLocation)  {
    Write-Host "$softwareName installed to '$installLocation'"
}
else { Write-Warning "Can't find $softwareName install location" }
