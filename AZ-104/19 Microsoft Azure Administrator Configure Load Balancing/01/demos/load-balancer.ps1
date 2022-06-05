<#
Create a Public Azure Load Balancer with Azure PowerShell

Ref: https://timw.info/6a27b

Tim Warner (timothy-warner@pluralsight.com)
#>

# Install and update Azure PowerShell
Install-Module -Name Az -Verbose ; Update-Help -Force -ErrorAction SilentlyContinue

# Connect to Azure
Connect-AzAccount
Set-AzContext -SubscriptionName ''

# Create a resource group
$rg = 'MyResourceGroupLB'
$loc = 'eastus'

New-AzResourceGroup -Name $rg -Location $loc

# Create Standard SKU zone-redundant public IP address
$rg = 'MyResourceGroupLB'
$loc = 'eastus'
$pubIP = 'myPublicIP'
$sku = 'Standard'
$all = 'static'

$publicIp = New-AzPublicIpAddress -ResourceGroupName $rg -Name $pubIP -Location $loc -AllocationMethod $all -SKU $sku

# Create frontend configuration
$fe = 'myFrontEnd'
$rg = 'MyResourceGroupLB'
$loc = 'eastus'
$pubIP = 'myPublicIP'

$publicIp = Get-AzPublicIpAddress -Name $pubIP -ResourceGroupName $rg

$feip = New-AzLoadBalancerFrontendIpConfig -Name $fe -PublicIpAddress $publicIp

# Create back end pool
$be = 'myBackEndPool'

$bepool = New-AzLoadBalancerBackendAddressPoolConfig -Name $be

# Create health probe
$hp = 'myHealthProbe'
$pro = 'http'
$port = '80'
$int = '360'
$cnt = '5'

$probe = New-AzLoadBalancerProbeConfig -Name $hp -Protocol $pro -Port $port -RequestPath / -IntervalInSeconds $int -ProbeCount $cnt

# Create load balancer rule
$lbr = 'myHTTPRule'
$pro = 'tcp'
$port = '80'

## $feip and $bePool are the variables from previous steps. ##

$rule = New-AzLoadBalancerRuleConfig -Name $lbr -Protocol $pro -Probe $probe -FrontendPort $port -BackendPort $port -FrontendIpConfiguration $feip -BackendAddressPool $bePool -DisableOutboundSNAT

# Create load balancer itself
$lbn = 'myLoadBalancer'
$rg = 'myResourceGroupLB'
$loc = 'eastus'
$sku = 'Standard'

$lb = New-AzLoadBalancer -ResourceGroupName $rg -Name $lbn -SKU $sku -Location $loc -FrontendIpConfiguration $feip -BackendAddressPool $bepool -Probe $probe -LoadBalancingRule $rule


