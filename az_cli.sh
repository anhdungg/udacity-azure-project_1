export RESOURCE_GROUP_NAME=udacity-group
export LOCATION=eastus

export VM_NAME=udacity-vm
export VM_ADMIN_USER=admin_user
-- export VM_PASS=my-passw0rd-(!)
export VM_IMAGE=Ubuntu2204
export VM_SIZE=Standard_B1ls

export SQL_SERVER_NAME=udacity-sql-server
export SQL_SERVER_ADMIN_USER=admin_user
export SQL_SERVER_ADMIN_PASSWORD='my-passw0rd-(!)'

export SQL_SERVER_FW_RULE_AZURE=azureaccess
export SQL_SERVER_FW_RULE_SPECIFIC_IP=clientid

export SQL_DATABASE_NAME=udacity-database

export STORAGE_ACCOUNT=udacityaccount
export STORAGE_CONTAINER=images


#Login
 az login

#Create resource group
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

#Delete resource group
#az group delete -n $RESOURCE_GROUP_NAME


#Create VM
az vm create \
   --resource-group $RESOURCE_GROUP_NAME \
   --name $VM_NAME \
   --location $LOCATION \
   --image $VM_IMAGE \
   --size  $VM_SIZE\
   --admin-username $VM_ADMIN_USER \
   --generate-ssh-keys \
   --verbose

#Opon ports
az vm open-port \
    --port "80" \
    --resource-group $RESOURCE_GROUP_NAME \
    --name $VM_NAME

#List VM IP
#az vm list-ip-addresses -g $RESOURCE_GROUP_NAME -n $VM_NAME


#Delete VM
# az vm delete \
#    --resource-group $RESOURCE_GROUP_NAME  \
#    --name $VM_NAME

# Create SQL Server

az sql server create \
	--name $SQL_SERVER_NAME \
	--admin-user $SQL_SERVER_ADMIN_USER \
	--admin-password $SQL_SERVER_ADMIN_PASSWORD \
	--resource-group $RESOURCE_GROUP_NAME \
	--location $LOCATION \
	--enable-public-network true \
	--verbose

# Create a firewall rule

az sql server firewall-rule create \
	-g $RESOURCE_GROUP_NAME \
	-s $SQL_SERVER_NAME \
	-n $SQL_SERVER_FW_RULE_AZURE \
	--start-ip-address 0.0.0.0 \
	--end-ip-address 0.0.0.0 \
	--verbose

# Create clientip firewall rule

az sql server firewall-rule create \
	-g $RESOURCE_GROUP_NAME \
	-s $SQL_SERVER_NAME \
	-n $SQL_SERVER_FW_RULE_SPECIFIC_IP \
	--start-ip-address 195.50.221.198 \
	--end-ip-address 195.50.221.198 \
	--verbose

# Create SQL Database

az sql db create \
	--name $SQL_DATABASE_NAME \
	--resource-group $RESOURCE_GROUP_NAME \
	--server $SQL_SERVER_NAME \
	--tier Basic \
	--verbose
 
# Delete SQL Database
 
# az sql db delete \
# 	--name $SQL_DATABASE_NAME \
# 	--resource-group $RESOURCE_GROUP_NAME \
# 	--server $SQL_SERVER_NAME \
# 	--verbose
 
# Delete SQL Server

# az sql server delete \
# 	--name $SQL_SERVER_NAME \
# 	--resource-group $RESOURCE_GROUP_NAME \
# 	--verbose
 
###

# Create Storage Account (should be lowecase, number)

az storage account create \
	--name $STORAGE_ACCOUNT \
	--resource-group $RESOURCE_GROUP_NAME \
	--location $LOCATION

# Create Container inside Storage

az storage container create \
	--account-name $STORAGE_ACCOUNT \
	--name $STORAGE_CONTAINER \
	--auth-mode login \
	--public-access container
