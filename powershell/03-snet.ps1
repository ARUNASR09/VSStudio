$ResourceGroupName ="rg-az104-dev-eus-01"
$VNetName          = "vnet-dev-eus-01"
$SubnetName         = "snet-dev-eus-web-01"
$SubnetAddressPrefix = "10.0.0.0/24"


$VNet = Get-AzVirtualNetwork -ResourceGroupName $ResourceGroupName -Name $VNetName

Add-AzVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork $VNet `
-AddressPrefix $SubnetAddressPrefix

$vnet | Set-AzVirtualNetwork