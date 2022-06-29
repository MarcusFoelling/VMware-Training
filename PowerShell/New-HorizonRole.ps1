# Horizon View Role (Instant Clones Desktop Pools)
$PrivSet = @'
tbd
'@
$Priviliges = @()
ForEach($Priv in $PrivSet.Split([Environment]::NewLine)) {
     $Priv = $Priv.Trim()
     If (!$Priv)	{ continue }     # empty line
     $Priviliges += Get-VIPrivilege -Id $Priv
     }
New-VIRole -Name 'HorizonView_Role' -Privilege $Priviliges
New-VIPermission -Entity (Get-Datacenter 'VDI') -Principal 'Domain\SA_HorizonView' -Role 'HorizonView_Role'
