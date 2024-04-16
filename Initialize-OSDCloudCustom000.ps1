Install-Module OSD -Force
Import-Module OSD -Force

$OSDModuleResource.OSDCloud.Values.Language="de-de","en-us"
$OSDModuleResource.OSDCloud.Default.Language="de-de"

Start-OSDCloudGUI -Brand "Anita Services GmbH"

wpeutil reboot