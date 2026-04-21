$AppServicePlan    = "asp-web-dev-plan-01"
$ResourceGroupName = "rg_cus_dev"
$Location          = "centralus"
$WebAppName        = "wa-app-web-dev-01" 

az appservice plan create `
--resource-group $ResourceGroupName `
  --location $Location `
  --name $AppServicePlan `
  --sku F1 `
  --is-linux

az webapp create `
--resource-group $ResourceGroupName `
--name $WebAppName `
--plan $AppServicePlan `
--runtime "PHP:8.4"