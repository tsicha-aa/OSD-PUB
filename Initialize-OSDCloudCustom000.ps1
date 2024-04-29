Import-Module OSD -Force

$GitRawPath="https://raw.githubusercontent.com/tsicha-aa/OSD-PUB/main"
$DellCCTK="DellCCTK4.1"
$DellBiosSettingsFile="Bios-Settings.cctk"
$OSDModuleResource.OSDCloud.Values.Edition="Enterprise","Pro"
$OSDModuleResource.OSDCloud.Values.Language="en-us","de-de","cs-cz","nl-nl","fr-fr","it-it","pl-pl","pt-pt","es-es","th-th"
$OSDModuleResource.OSDCloud.Default.Language="de-de"

#Following Section must match with ImageIndex (e.g. Pro Volume = 8, Pro Retail = 9, Enterprise = 6)
$OSDModuleResource.OSDCloud.Default.Edition="Pro"
$OSDModuleResource.OSDCloud.Default.Activation="Retail"
$OSDModuleResource.OSDCloud.Default.ImageIndex="9"
#End Section

$OSDModuleResource.StartOSDCloudGUI.updateFirmware=$true
$OSDModuleResource.StartOSDCloudGUI.WindowsUpdate=$true
$OSDModuleResource.StartOSDCloudGUI.WindowsUpdateDrivers=$true
$OSDModuleResource.StartOSDCloudGUI.ClearDiskConfirm=$false

if ((Get-MyComputerManufacturer -Brief) -eq 'Dell') {
	Add-Type -AssemblyName PresentationFramework
	$msgBoxInput =  [System.Windows.MessageBox]::Show('Update Dell Bios Settings?','BIOS Settings','YesNo','Question')
	switch  ($msgBoxInput) {
		'Yes' {
			Write-Host -ForegroundColor Yellow "Download Dell CCTK and Bios-Settings File"
			Save-WebFile -SourceUrl $GitRawPath/BIOS/$DellCCTK.zip -DestinationDirectory "$env:temp"
			Save-WebFile -SourceUrl $GitRawPath/BIOS/Bios-Settings.cctk -DestinationDirectory "$env:temp"
			Expand-Archive "$env:temp\$DellCCTK.zip" -DestinationPath "$env:temp\$DellCCTK" -Force
			Write-Host -ForegroundColor Yellow "Changing Dell-Bios Settings:"
			&"$env:temp\$DellCCTK\cctk.exe" -i "$env:temp\$DellBiosSettingsFile"
		}
	}
}

Start-OSDCloudGUI -Brand "Anita Services GmbH"
