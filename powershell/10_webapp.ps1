$AppServicePlan    = "asp-web-dev-plan-01"
$ResourceGroupName = "rg_cus_dev"
$Location          = "centralus"
$WebAppName        = "wa-app-web-dev-01"   

New-AzAppServicePlan -ResourceGroupName $ResourceGroupName `
  -Location $Location `
  -Name $AppServicePlan `
  -Tier "Free" `
  -Linux

New-AzWebApp -ResourceGroupName $ResourceGroupName `
 -Name $WebAppName `
  -Location $Location `
 -AppServicePlan $AppServicePlan
  
Set-AzResource -ResourceGroupName $ResourceGroupName `
  -ResourceType "Microsoft.Web/sites/config" `
  -ResourceName "$WebAppName/web" `
  -ApiVersion "2022-03-01" `
  -PropertyObject @{ linuxFxVersion = "PHP|8.3" } `
  -Force
