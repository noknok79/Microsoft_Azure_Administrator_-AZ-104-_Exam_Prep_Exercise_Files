# Create and Configure Azure Containers

## Module 1

[Azure Container Instances Documentation](https://docs.microsoft.com/en-us/azure/container-instances/)

[What is Azure Container Instances?](https://docs.microsoft.com/en-us/azure/container-instances/container-instances-overview#linux-and-windows-containers)

[Containers v. Virtual Machines](https://docs.microsoft.com/en-us/virtualization/windowscontainers/about/containers-vs-vm)

[About Windows Containers](https://docs.microsoft.com/en-us/virtualization/windowscontainers/about/)

[Quickstart: Deploy a container instance in Azure using Azure PowerShell](https://docs.microsoft.com/en-us/azure/container-instances/container-instances-quickstart-powershell)

[Azure Container Registry Documentation](https://docs.microsoft.com/en-us/azure/container-registry/)

[FAQ about Azure Container Instances](https://docs.microsoft.com/en-us/azure/container-instances/container-instances-faq)

[Update containers in Azure Container Instances](https://docs.microsoft.com/en-us/azure/container-instances/container-instances-update)

[Container groups in Azure Container Instances](https://docs.microsoft.com/en-us/azure/container-instances/container-instances-container-groups)

[Tutorial: Deploy a multi-container group using a Resource Manager template](https://docs.microsoft.com/en-us/azure/container-instances/container-instances-multi-container-group)

[Tutorial: Deploy a multi-container group using a YAML file](https://docs.microsoft.com/en-us/azure/container-instances/container-instances-multi-container-yaml)

## Module 2

[Introduction to Azure Kubernetes Service](https://docs.microsoft.com/en-us/learn/modules/intro-to-azure-kubernetes-service/1-introduction)

[Azure Kubernetes Service solution journey](https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/containers/aks-start-here?bc=%2fazure%2faks%2fbreadcrumb%2ftoc.json&toc=%2fazure%2faks%2ftoc.json)

[Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/intro-kubernetes)

[Quickstart: Deploy an Azure Kubernetes Service cluster using the Azure CLI](https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough)

[Quickstart: Deploy an Azure Kubernetes Service (AKS) cluster using the Azure portal](https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough-portal)

[Kubernetes core concepts for Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/concepts-clusters-workloads)

[Network concepts for applications in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/concepts-network)

[Storage options for applications in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/concepts-storage)

[Scaling options for applications in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/concepts-scale#cluster-autoscaler)

[Automatically scale a cluster to meet application demands on Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/cluster-autoscaler)

[Tutorial: Scale applications in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/tutorial-kubernetes-scale#autoscale-pods)

[Best practices for storage and backups in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/operator-best-practices-storage)

[Manually create and use a volume with Azure disks in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/azure-disk-volume)

[Scaling options for applications in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/concepts-scale)

[Upgrade an Azure Kubernetes Service (AKS) cluster](https://docs.microsoft.com/en-us/azure/aks/upgrade-cluster)

[Tutorial: Upgrade Kubernetes in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/tutorial-kubernetes-upgrade-cluster)


### Module 1 demo code for ACI

```bash
    # Create resource group
    az group create --name container-rg --location eastus

    # Create deployment group based on azuredeploy.json
    az deployment group create --resource-group container-rg --template-file azuredeploy.json    
    
    # View deployment state
    az container show --resource-group container-rg --name demo-container-Group --output table
    az container show --resource-group container-rg --name container-rg --output table

    # View container logs
    az container logs --resource-group container-rg --name myContainerGroup --container-name aci-tutorial-app

    # View side-car logs
    az container logs --resource-group container-rg --name myContainerGroup --container-name aci-tutorial-sidecar

```

### Module 2 demo code for AKS
```bash
    # Need the kubernetes command-line client. This is already installed in cloud shell
    az aks install-cli
    
    # Monitoring AKS cluster
    az provider show -n Microsoft.OperationsManagement -o table
    az provider show -n Microsoft.OperationalInsights -o table
    
    # Create AKS cluster
    az aks create --resource-group ps-course-rg --name myAKSCluster --node-count 1 --enable-addons monitoring --generate-ssh-keys

    az aks create --resource-group ps-course-rg --name PSAKSCluster --vm-set-type VirtualMachineScaleSets --node-count 2 --generate-ssh-keys --load-balancer-sku standard --enable-addons monitoring

    az aks nodepool add --resource-group ps-course-rg --cluster-name PSAKSCluster --name mynodepool --node-count 3

    # Download credentials and configures kubernetes cli to use them
    az aks get-credentials --resource-group ps-course-rg --name myAKSCluster
    
    
    # Verify connection
    kubectl get nodes

    # Deploy application using the apply command of YAML manifest found in exercise files zip
    kubectl apply -f azure-vote.yaml

    # Test application
    kubectl get service azure-vote-front --watch

    # Create and attach storage
    az aks show --resource-group ps-course-rg --name myAKSCluster --query nodeResourceGroup -o tsv
    # Should output 'MC_ps-course-rg_myAKSCluster_eastus'

    az disk create --resource-group MC_ps-course-rg_myAKSCluster_eastus --name myAKSDisk --size-gb 20 --query id --output tsv

    # Scaling
    # Get pods
    kubectl get pods

    # Manual scale pods
    kubectl scale --replicas=5 deployment/azure-vote-front

    # Verify
    kubectl get pods

    # Manual scale nodes
    az aks scale --resource-group ps-course-rg --name myAKSCluster --node-count 3

    # Autoscale pods

    # The following example uses the kubectl autoscale command 
    # to autoscale the number of pods in the azure-vote-front deployment. If average CPU utilization across all pods exceeds 50% of their 
    # requested usage, the autoscaler increases the pods up to a maximum of 10 instances. A minimum of 3 instances is then defined for the 
    # deployment:
    
    kubectl autoscale deployment azure-vote-front --cpu-percent=50 --min=3 --max=10

    # Show current version of AKS
    az aks show --resource-group ps-course-rg --name myAKSCluster --output table
    
    # Get available upgrades for the cluster
    az aks get-upgrades --resource-group ps-course-rg --name myAKSCluster

    # Upgrade cluster
    az aks upgrade --resource-group ps-course-rg --name myAKSCluster --kubernetes-version KUBERNETES_VERSION
    
    # Delete AKS cluster
    az group delete --name ps-course-rg --yes --no-wait   
```
