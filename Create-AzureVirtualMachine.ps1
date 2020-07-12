# Azure Settings
[string] $resourceGroupName = "rg-john"
[string] $location = "WestEurope"

# Virtual Machine Related Settings
[string] $virtualMachineName = "centos-vps-euw-webserver"
[string] $osName = "CentOS"
[string] $vmSize = "B2s"
[string] $vnetName = "centos-vnet"
[string] $subnetName = "centos-subnet"
[string] $publicIPName = "centos-publicip"
[string] $networkSecurityGroupName = "centos-nsg"
[string] $nicName = "centos-nic"

# Create Resource Group
az group create --location $location --resource-group $resourceGroupName

# Create a VNET
az network vnet --name $vnetName --subnet-name $subnetName --resource-group $resourceGroupName

# Create a Public IP
az network public-ip create --name $publicIPName --resource-group $resourceGroupName

# Create a NSG
az network nsg create --name $networkSecurityGroupName --resource-group $resourceGroupName

# Create a NIC
az network nic create --name $nicName --vnet-name $vnetName --subnet $subnetName --network-security-group $nsgName --public-ip-address $publicIPName

# Create VM
az vm create --name $virtualMachineName --size $vmSize --nics $nicName --image $osName --generate-ssh-keys --resource-group $resourceGroupName

# Open SSH port
az vm open-port --port 22 --name $virtualMachineName --resource-group $resourceGroupName


#1. Create Resource Group
#2. Create VNET
#3. Create VM (naming test-web-euw-<purpose>)
    #4. Open firewall ports (Azure)
    #5. Supply public key file to VM