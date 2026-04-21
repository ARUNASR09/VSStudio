$ResourceGroupName = "rg-az104-dev-eus-01"
$Location = "eastus"
$VnetName = "vnet-dev-eus-01"
$AddressSpace = "10.0.0.0/16"


New-AzVirtualNetwork  -Name $VnetName -ResourceGroupName $ResourceGroupName `
-Location $Location -AddressPrefix $AddressSpace 