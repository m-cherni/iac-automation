# Install terraform

## Manual installation

- Download the terraform binary for your machine

- Unzip the downloaded file

- Copy or move the terraform file to /usr/local/bin

## Using ansible

To use ansible to automate the terraform installation, you can follow the instructions below.

- Ensure that you have the lastest stable version of ansible.
- Ensure that you have access to the machine where you want to install terraform
- Ensure that the user you use to run ansible has sudo access on the machine where you want to install terraform
- Ensure that you have configured access to the machine using ssh-keys

- Clone the ansible role

```
git clone -b dev/install-terraform-using-ansible --single-branch git@github.com:m-cherni/iac-automation.git
```

- Modify the inventory file and include the details of the machine and the user you want to use to install terraform

- Check that ansible can access the remote machine

```
# Change the directory
cd terraform/ansible/roles/install_terraform/

# Run the ping module to test the connection
ansible -m ping
```

- Run the playbook to install terraform

```
ansible-playbook -i inventory main.yml
```

# Use terraform with vscode

## Install vscode

For the instructions to install vscode, follow the link below:

https://code.visualstudio.com/download

## Install terraform extension for vscode

### HachiCorp extension

Install the extension HashiCorp Terraform. Go to the vscode marketplace and search for HashiCorp Terraform.

### Azure terraform extension

If you want to use Terraform with Azure cloud Shell, you can install the extension Azure Terraform.
Note that this extension needs the latest LTS version of Nodejs to be installed on your machine.

The Azure Terraform Extension connects to the Azure Cloud Shell and can run Terraform commands from the command palette to the Azure Cloud Shell.

## Use terraform within Azure Cloud Shell

First of all, configure your cloud shell, create your storage account and open a cloud shell (bash or PowerShell).
Azure Cloud Shell has terraform backed in. It may have an older version of terraform that needs to be upgraded.

## Authentication

Terraform supports different methods to authenticate to Azure:

- Authenticate to Azure through Azure CLI
- Authenticate to Azure through Managed Identity
- Authenticate to Azure using a Service Principal (using Client certificate or Client secret)

To use terraform with Azure, you have to authenticate to Azure either by login using your Azure account or by using a service principal after it was created.

Managed identity allows to authenticate without the need to store and manage any credentials but it uses a service principal behind the scene.
Note that not all resources supports access using managed identity.

### Azure CLI

First of all, make sure that Azure CLI is installed on your system, then run the command below

```
az login
```

It will open up your browser, enter your credentials and authenticate to Azure.
Once you finish authenticating successfully, you can check and or set the subscription that you want to use and start using terraform.

```
az account show

az account list --query [?=email=<your-email>] -o Table

az account set --subscription <your-subscription>
```

### Azure service principal

Login to your azure cloud account

```
az login
```

If you're using Azure Cloud Shell, set the environment variable MSYS_NO_PATHCONV to 1

```
export MSYS_NO_PATHCONV=1
```

Create the service principal

```
az ad sp create-for-rbac --name <service-princpal-name> --role Contributor --scopes <your-desired-scope>
```

Depending on what resource you will manage with terraform, you can change the role to enforce the least service principal.

In your provider section add the following credentials.

- tenant_id
- subscription_id
- client_id
- client_secret

```
provider "azurerm" {
    features {}

    tenant_id = xxxxxxx
    subscription_id = xxxxxx
    client_id = xxxxxx
    secret_id = xxxxxx
}
```

To avoid secrets leaking, use variables for these parameters by:

- Exorting environment variables using the prefix TF_VAR
- Adding them to a local .tfvars file that you configure to be ignored by git (add the .tfvars file to the .gitigonore file)
