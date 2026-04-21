$ResourceGroupName = "rg-az104-dev-eus-01"
$Location = "eastus"
$VnetName = "vnet-dev-eus-01"
$AddressSpace = "10.0.0.0/16"
$SubnetName           = "snet-dev-eus-web-01"
$SubnetAddressPrefix  = "10.0.0.0/24"

az network vnet create `
--resource-group $ResourceGroupName `
--location $Location `
--name $VnetName `
--address-prefixes $AddressSpace `
--subnet-name $SubnetName `
--subnet-prefixes $SubnetAddressPrefix

