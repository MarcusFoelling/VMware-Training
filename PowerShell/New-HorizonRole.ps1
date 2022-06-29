# Horizon View Role (Instant Clones Desktop Pools)
# https://docs.vmware.com/en/VMware-Horizon/2203/horizon-installation/GUID-467F552F-3034-4917-A985-B5E5FEC5C68F.html
$PrivSet = @'
Folder.Create
Folder.Delete
Datastore.AllocateSpace
Datastore.Browse
Host.Inventory.EditCluster
Host.Config.AdvancedConfig
VirtualMachine.Config.*
VirtualMachine.Interact.PowerOff
VirtualMachine.Interact.PowerOn
VirtualMachine.Interact.Reset
VirtualMachine.Interact.Suspend
VirtualMachine.Interact.SESparseMaintenance
VirtualMachine.Interact.DeviceConnection
VirtualMachine.inventory.*
VirtualMachine.State.*
VirtualMachine.Provisioning.Customize
VirtualMachine.Provisioning.DeployTemplate
VirtualMachine.Provisioning.ReadCustSpecs
VirtualMachine.Provisioning.CloneTemplate
VirtualMachine.Provisioning.Clone
VirtualMachine.Provisioning.Disk*
Resource.AssignVMToPool
Resource.HotMigrate
Global.DisableMethods
Global.EnableMethods
Global.ManageCustomFields
Global.SetCustomField
Global.VCServer
Network.Assign
StorageProfile.*
Cryptographer.Clone
Cryptographer.Decrypt
Cryptographer.Access
Cryptographer.Encrypt
Cryptographer.ManageKeys
Cryptographer.Migrate
Cryptographer.RegisterHost
'@
$Priviliges = @()
ForEach($Priv in $PrivSet.Split([Environment]::NewLine)) {
     $Priv = $Priv.Trim()
     If (!$Priv)	{ continue }     # empty line
     $Priviliges += Get-VIPrivilege -Id $Priv
     }
New-VIRole -Name 'HorizonView_Role' -Privilege $Priviliges
New-VIPermission -Entity (Get-Datacenter 'VDI') -Principal 'Domain\SA_HorizonView' -Role 'HorizonView_Role'
