# Create and Configure Azure App Service

## Module 1

[Azure App Service](https://azure.microsoft.com/en-us/services/app-service/)

[App Service Documentation](https://docs.microsoft.com/en-us/azure/app-service/)

[Manage an App Service Plan in Azure](https://docs.microsoft.com/en-us/azure/app-service/app-service-plan-manage)

[Scale up an app in Azure App Service](https://docs.microsoft.com/en-us/azure/app-service/manage-scale-up)

[App Service Pricing](https://azure.microsoft.com/en-us/pricing/details/app-service/windows/)

[App Service Limits](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits#app-service-limits)

[Cloning and existing App to an App Service Environment](https://docs.microsoft.com/en-us/azure/app-service/app-service-web-app-cloning)

[Set up Azure App Service access restrictions](https://docs.microsoft.com/en-us/azure/app-service/app-service-ip-restrictions)

[Advanced usage of authentication and authorization in Azure App Service](https://docs.microsoft.com/en-us/azure/app-service/app-service-authentication-how-to)

[Set up staging environments in Azure App Service](https://docs.microsoft.com/en-us/azure/app-service/deploy-staging-slots)

[Create a static HTML web app in Azure](https://docs.microsoft.com/en-us/azure/app-service/quickstart-html)

[PowerShell samples for Azure App Service](https://docs.microsoft.com/en-us/azure/app-service/samples-powershell)

[Azure CLI samples for Azure App Service](https://docs.microsoft.com/en-us/azure/app-service/samples-cli)
##### PowerShell example from Azure docs site (above)
```powershell
# Replace the following URL with a public GitHub repo URL
$gitrepo="https://github.com/Azure-Samples/app-service-web-dotnet-get-started.git"
$webappname="mywebapp$(Get-Random)"
$location="centralus"

# Create a resource group.
New-AzResourceGroup -Name myResourceGroup -Location $location

# Create an App Service plan in Free tier.
New-AzAppServicePlan -Name $webappname -Location $location -ResourceGroupName myResourceGroup -Tier Free

# Create a web app.
New-AzWebApp -Name $webappname -Location $location -AppServicePlan $webappname -ResourceGroupName myResourceGroup

# Configure GitHub deployment from your GitHub repo and deploy once.
$PropertiesObject = @{
    repoUrl = "$gitrepo";
    branch = "master";
    isManualIntegration = "true";
}
Set-AzResource -Properties $PropertiesObject -ResourceGroupName myResourceGroup -ResourceType Microsoft.Web/sites/sourcecontrols -ResourceName $webappname/web -ApiVersion 2015-08-01 -Force
```

### Module 2

[Tutorial: Map an existing custom DNS name to Azure App Service](https://docs.microsoft.com/en-us/azure/app-service/app-service-web-tutorial-custom-domain?tabs=cname)

[Manage backup](https://docs.microsoft.com/en-us/azure/app-service/manage-backup)

[Restore an App in Azure](https://docs.microsoft.com/en-us/azure/app-service/web-sites-restore)

[Integrate your app with an Azure VNet](https://docs.microsoft.com/en-us/azure/app-service/web-sites-integrate-with-vnet)

[Subscription and service limits](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits#content-delivery-network-limits)

[Understanding Azure CDN billing](https://docs.microsoft.com/en-us/azure/cdn/cdn-billing)

[What is a content delivery network on Azure?](https://docs.microsoft.com/en-us/azure/cdn/cdn-overview)

[Tutorial: Add Azure CDN to an Azure App Service web app](https://docs.microsoft.com/en-us/azure/cdn/cdn-add-to-web-app)

[Deployment Best Practices](https://docs.microsoft.com/en-us/azure/app-service/deploy-best-practices)

[Set up staging environments in Azure App Service](https://docs.microsoft.com/en-us/azure/app-service/deploy-staging-slots)