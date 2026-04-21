$ResourceGroupName ="rg-az104-dev-eus-01"
$VNetName          = "vnet-dev-eus-01"
$Location = "eastus"
$SubnetName         = "snet-dev-eus-web-01"
$NicName         = "nic-dev-eus-web-01"

$VNet = Get-AzVirtualNetwork -ResourceGroupName $ResourceGroupName -Name $VNetName

$SNet = Get-AzVirtualNetworkSubnetConfig  -Name $SubnetName -VirtualNetwork $VNet

New-AzNetworkInterface -Name $NicName `
-ResourceGroupName $ResourceGroupName `
-Location $Location `
-Subnet  $SNet `
-IpConfigurationName 'ipconfig-web-01'
