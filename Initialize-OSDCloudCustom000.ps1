Import-Module OSD -Force

$GitRawPath="https://raw.githubusercontent.com/tsicha-aa/OSD-PUB/main"
$DellCCTK="DellCCTK4.1"
$DellBiosSettingsFile="Bios-Settings.cctk"

$OSDModuleResource.OSDCloud.Values.Language="de-de","en-us"
$OSDModuleResource.OSDCloud.Default.Language="de-de"
$OSDModuleResource.OSDCloud.Values.Edition="Enterprise","Pro"
$OSDModuleResource.StartOSDCloudGUI.updateFirmware=$true
$OSDModuleResource.StartOSDCloudGUI.WindowsUpdate=$true
$OSDModuleResource.StartOSDCloudGUI.updateFirmware=$true
$OSDModuleResource.StartOSDCloudGUI.WindowsUpdateDrivers=$true
$OSDModuleResource.StartOSDCloudGUI.ClearDiskConfirm=$false

if ((Get-MyComputerManufacturer -Brief) -eq 'Dell') {
	Add-Type -AssemblyName PresentationFramework
	$msgBoxInput =  [System.Windows.MessageBox]::Show('Update Dell Bios Settings?','BIOS Settings','YesNoCancel','Question')
	switch  ($msgBoxInput) {
		'Yes' {
			Save-WebFile -SourceUrl $GitRawPath/BIOS/$DellCCTK.zip -DestinationDirectory "$env:temp"
			Expand-Archive "$env:temp\$DellCCTK.zip" -DestinationPath "$env:temp\$DellCCTK"
			Save-WebFile -SourceUrl $GitRawPath/BIOS/Bios-Settings.cctk -DestinationDirectory "$env:temp"
			&"$env:temp\$DellCCTK\cctk.exe" -i "$env:temp\$DellBiosSettingsFile"
		}
	}
}

Start-OSDCloudGUI -Brand "Anita Services GmbH"

#wpeutil reboot

