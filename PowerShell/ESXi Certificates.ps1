#region Cert Report
$CredVC = get-credential
$VC = 'sa-vcsa-01.vclass.local'
connect-viserver -server $VC -credential $CredVC
foreach($ESXi in get-vmhost|sort-object name) {
	$ESXiCertMgr = get-view $ESXi.ExtensionData.ConfigManager.CertificateManager
	$ESXiCertMgr.CertificateInfo | Select-Object @{Name='ESXi'; Expression={$ESXi.Name.Split('.')[0]} }, NotAfter, @{Name='RemainingDays'; Expression={ ($_.NotAfter - (get-date)).days} } ,Subject, Status | format-table
} 
#endregion Cert Report