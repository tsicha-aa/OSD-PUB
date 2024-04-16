Import-Module OSD -Force

$OSDModuleResource.OSDCloud.Values.Language="de-de","en-us"
$OSDModuleResource.OSDCloud.Default.Language="de-de"
$OSDModuleResource.OSDCloud.Values.Edition="Enterprise","Pro"
$OSDModuleResource.StartOSDCloudGUI.updateFirmware=$true
$OSDModuleResource.StartOSDCloudGUI.WindowsUpdate=$true
$OSDModuleResource.StartOSDCloudGUI.updateFirmware=$true
$OSDModuleResource.StartOSDCloudGUI.WindowsUpdateDrivers=$true
Start-OSDCloudGUI -Brand "Anita Services GmbH"

#wpeutil reboot
