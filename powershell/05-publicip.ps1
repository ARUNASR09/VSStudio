$ResourceGroupName = "rg-az104-dev-eus-01"
$Location          = "eastus"  
$PublicIpName   =    "pip-web-dev-eus-01"
$NicName           = "nic-dev-eus-web-01"
$IpConfigName=   "ipconfig-web-01"

$Pip = New-AzPublicIpAddress -Name $PublicIpName `
-ResourceGroupName $ResourceGroupName `
-Location $Location `
-Sku Standard `
-AllocationMethod Static

$Nic = Get-AzNetworkInterface -Name $NicName -ResourceGroupName $ResourceGroupName

Set-AzNetworkInterfaceIpConfig -Name $IpConfigName `
-NetworkInterface $Nic `
-PublicIpAddress $Pip 

Set-AzNetworkInterface -NetworkInterface $Nic