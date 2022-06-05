# Create a resource group
az group create --name container-rg --location centralus

# Create and deploy Azure Container group from template
az deployment group create --resource-group container-rg --template-file azuredeploy.json

# Validate container
az container show --resource-group container-rg --name demo-container-group --output table

# Validate container
az container logs --resource-group container-rg --name demo-container-group --container-name aci-tutorial-app