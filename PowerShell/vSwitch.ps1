<# Dies ist mein erstes PowerShell Script
    
    Marcus Andreas Fölling #>
    

$CredVC = get-credential
$VC = 'sa-vcsa-01.vclass.local'
connect-viserver -server $VC -credential $CredVC

get-vmhost -Name sa-esxi-01.vclass* | Get-VirtualSwitch -Name vSwitch0|Get-VirtualPortGroup
get-vmhost -Name sa-esxi-01.vclass* | Get-VirtualSwitch -Name vSwitch0|New-VirtualPortGroup -Name 'Production' -VLanId 100