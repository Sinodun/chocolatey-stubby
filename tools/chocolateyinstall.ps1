$ErrorActionPreference = 'Stop'; # stop on all errors

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = "msi"
  file          = "$toolsDir\stubby-0.2.5-i686.msi"
  file64        = "$toolsDir\stubby-0.2.5-x86_64.msi"

  softwareName  = 'Stubby'

  checksum      = '0af2de363a192ab47271bd933dbd6569e8d0879c4ba6d7b6d3f598d9185d8895'
  checksumType  = 'sha256'
  checksum64    = '0f9802200c6505444bb7dc878534bfa54f272c3e6afb469cd586d91297f6445d'
  checksumType64= 'sha256'

  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

$packageName = $packageArgs.packageName
$softwareName = $packageArgs.softwareName
$installLocation = Get-AppInstallLocation $softwareName
if ($installLocation)  {
    Write-Host "$softwareName installed to '$installLocation'"
}
else { Write-Warning "Can't find $softwareName install location" }
