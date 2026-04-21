$ResourceGroupName = "rg-az104-dev-eus-01"
$Location = "eastus"
$VnetName = "vnet-dev-eus-01"
$PublicIpName   =    "pip-web-dev-eus-01"

az network public-ip create `
--resource-group $ResourceGroupName `
--location $Location `
--name $PublicIpName `
--sku Standard `
--allocation-method Static `
--version IPv4