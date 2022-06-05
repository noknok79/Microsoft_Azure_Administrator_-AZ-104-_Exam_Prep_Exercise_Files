# Need the kubernetes command-line client. This is already installed in cloud shell
az aks install-cli
    
# Download credentials and configures kubernetes cli to use them.=
az aks get-credentials --resource-group ps-course-rg --name myAKSCluster
    
# Verfiy connection
kubectl get nodes

# Deploy application using the apply command of YAML manifest found in exercise files zip
kubectl apply -f azure-vote.yaml

# Test application
kubectl get service azure-vote-front --watch