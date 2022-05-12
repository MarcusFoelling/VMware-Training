#region ESXi Reports
foreach($ESXi in get-vmhost|sort-object name) {
	$ESXiCertMgr = get-view $ESXi.ExtensionData.ConfigManager.CertificateManager
	$ESXiCertMgr.CertificateInfo | Select-Object @{Name='ESXi'; Expression={$ESXi.Name.Split('.')[0]} }, NotAfter, @{Name='RemainingDays'; Expression={ ($_.NotAfter - (get-date)).days} } ,Subject, Status | format-table
} 
#endregion ESXi Reports

#region VM Reports
get-vm | get-snapshot | Select-Object VM, Name, Created, @{Name="Days";Expression={((get-date)-$_.Created).Days}}, @{Name="SizeGB";Expression={"{0:N2}" -f $_.SizeGB}}, Description | Sort-Object VM | Format-Table

get-vm | select-object Name, PowerState, NumCpu, MemoryGB, @{Name='GuestOS'; Expression={$_.Guest.OSFullName} } | sort-object Name | export-csv -NoTypeInformation -Path ("{0}\Desktop\VM_Report_{1}.csv" -f $env:userprofile, (Get-Date -Format 'yyyy-MM-dd') )
#endregion VM Reports
