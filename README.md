# CCGC 5502 - Automation with Terraform Assignment

## **Overview**

This project involves provisioning a highly available, scalable, and secure infrastructure in Azure using Terraform. It includes various Azure resources such as virtual networks, virtual machines, load balancers, databases, and storage accounts. The infrastructure must be deployed non-interactively and managed using Terraform modules.

## **Prerequisites**

- **Azure Account** (Pay-as-you-go preferred)
- **Terraform Installed** (v1.x.x or later)
- **Azure CLI Installed** (for authentication and resource validation)
- **GitHub Repository** (to store the Terraform code)
- **Development Environment** (WSL, VS Code, or GitBash)

## **Project Structure**

```
📁 terraform-assignment
│── 📂 modules
│   ├── 📂 rgroup-n01669400
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── 📂 network-n01669400
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── 📂 common-n01669400
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── 📂 vmlinux-n01669400
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── provisioner.tf
│   ├── 📂 vmwindows-n01669400
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── 📂 datadisk-n01669400
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── 📂 loadbalancer-n01669400
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── 📂 database-n01669400
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│── 📄 .gitignore
│── 📄 providers.tf
│── 📄 variables.tf
│── 📄 backend.tf
│── 📄 main.tf
│── 📄 outputs.tf
│── 📄 README.md
```

## **Terraform Features Used**

- **Remote Backend:** Stored Terraform state in Azure Storage.
- **Parameterization:** Used input variables, locals, and output values.
- **Modular Approach:** Child modules for each resource category.
- **Provisioners:** Displayed hostnames of provisioned VMs.
- **Scalability:** Used `for_each` for Linux VMs and `count` for Windows VMs.

## **Deployment Steps**

### **1. Clone the Repository**

```bash
git clone https://github.com/srush98/assignment1-n01669400.git
cd assignment1-n01669400
```

### **2. Authenticate with Azure**

```bash
az login
```

### **3. Initialize Terraform**

```bash
terraform init
```

### **4. Validate Configuration**

```bash
terraform validate
```

### **5. Review Deployment Plan**

```bash
terraform plan
```

### **6. Apply Configuration (Non-Interactive)**

```bash
terraform apply --auto-approve
```

### **7. Verify Deployment**

```bash
terraform state list | nl
terraform output
```

### **8. Destroy Infrastructure (After Grading)**

```bash
terraform destroy --auto-approve
```

## **Resource Naming Convention**

- Resource names are prefixed with the last 4 digits of my Humber ID to ensure uniqueness.
- Example:
  - `n9400-RG` (Resource Group)
  - `n9400-VNET` (Virtual Network)
  - `n9400-SUBNET` (Subnet)
  - `n9400-LB` (Load Balancer)
  - and so on...

## **Tags Used for Resources**

```hcl
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "srushti.jiyani"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
```

## **Expected Outputs**

Upon successful deployment, Terraform will print:

- Resource Group name
- Virtual Network and Subnet names
- VM hostnames, FQDNs, IP addresses (Linux and Windows)
- Load Balancer name
- Database instance name
- Common services (Log Analytics, Recovery Vault, Storage Account)

## **Troubleshooting**

- **State Issues:** If `terraform refresh` shows an empty state, manually check and delete existing resources in Azure.
- **Authentication Errors:** Run `az login` and ensure the correct subscription is selected using `az account set --subscription <subscription-id>`.
- **Deployment Failures:** Review logs using `terraform plan` and `terraform apply -auto-approve` for error messages.
- **Error loading state Error:** Run this command `az storage account keys list --account-name tfstateaccount9400 --resource-group tfstate-rg-9400 --query "[0].value" --output tsv` and then export the key using this command `export ARM_ACCESS_KEY="gAlBFjXaMFd42uxT0w49wFUaZeyoCY1wDTfl1EuYsNUsIachWveIvfslg2eCoYrwe3+CHIbwd2IC+ASt/VZeAg=="`

---
