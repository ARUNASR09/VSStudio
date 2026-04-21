$ResourceGroupName = "rg-az104-dev-eus-01"
$StorageAccountName = "saeusdev1234" 
$Location          = "eastus"  
$Kind              = "StorageV2"  
$Sku               = "Standard_LRS"   

New-AzStorageAccount -ResourceGroupName $ResourceGroupName `
-Name $StorageAccountName `
-Location $Location `
-Kind $Kind `
-SkuName $Sku