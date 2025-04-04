# Automation with Terraform

## **Overview**

This project focuses on automating infrastructure and configuration management in **Microsoft Azure** using **Terraform** and **Ansible**. The goal is to ensure **high availability, scalability, and security** while maintaining efficiency through Infrastructure as Code (IaC) principles.

- **Terraform** provisions cloud infrastructure.
- **Ansible** automates post-provisioning configuration and software setup.

## **Prerequisites**

- **Azure Account** (Pay-as-you-go preferred)
- **Terraform Installed** (v1.x.x or later)
- **Azure CLI Installed** (for authentication and resource validation)
- **Ansible Installed** (on local machine or control node)
- **GitHub Repository** (to store Terraform & Ansible code)
- **Development Environment** (WSL, VS Code, or GitBash)

## **Project Structure**

```
📁 automation-project
│── 📂 modules
│   ├── 📂 rgroup
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── 📂 network
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── 📂 common
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── 📂 vmlinux
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── provisioner.tf
│   ├── 📂 vmwindows
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── 📂 datadisk
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── 📂 loadbalancer
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── 📂 database
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
├── 📂 roles
│   ├── profile-n01669400
│   │   ├── tasks/main.yml
│   ├── user-n01669400
│   │   ├── tasks/main.yml
│   ├── datadisk-n01669400
│   │   ├── tasks/main.yml
│   ├── webserver-n01669400
│   │   ├── tasks/main.yml
├── inventory.ini  # Defines target VMs
├── n01669400-playbook.yml  # Main Ansible playbook
├── ansible.cfg   # Configuration file
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

### **Root Module Configuration**

- Defined child modules in **Terraform-Project** root module.
- Configured **outputs.tf** to print key infrastructure details.

### **Child Module Development**

#### **Resource Group Module**

- Created a **rgroup** module to provision **HumberID-RG**.

#### **Networking Module**

- Created a **network** module to provision:
  - Virtual Network (**HumberID-VNET**)
  - Subnet (**HumberID-SUBNET**)
  - **NSG with inbound rules** for **ports 22, 3389, 5985, and 80**.

#### **Common Services Module**

- Created a **common_services** module to provision:
  - **Log Analytics Workspace**
  - **Recovery Services Vault**
  - **Storage Account (LRS Redundancy)**

#### **Linux VMs Module**

- Created a **vmlinux** module to provision **3 CentOS VMs**.
- Used **for_each** for scalability.
- Implemented **remote-exec** provisioner to display hostnames.
- Installed **Azure Monitor and Network Watcher extensions**.

#### **Windows VM Module**

- Created a **vmwindows** module to provision **1 Windows Server 2016 VM**.
- Used **count** for scalability.
- Installed **Antimalware extension**.

#### **Data Disks Module**

- Created a **datadisk** module to provision **4 x 10GB managed disks**.
- Attached disks to **all 4 VMs**.

#### **Load Balancer Module**

- Created a **loadbalancer** module to provision a **public-facing Basic Load Balancer**.
- Assigned **all 3 Linux VMs as backend pool** members.

#### **Database Module**

- Created a **database** module to provision **Azure Database for PostgreSQL Single Server**.

---

## **Ansible Roles Developed**

### **1. Profile Update Role (`profile-HumberID`)**

- Appends a test block to `/etc/profile`
- Sets an auto-logout timeout (`TMOUT=1500`)

### **2. User & Group Management Role (`user-HumberID`)**

- Creates **group**: `cloudadmins`
- Creates **users**: `user100`, `user200`, `user300`
- Adds users to `cloudadmins` and `wheel`
- Generates SSH keys for each user (no passphrase)
- Downloads the **private key** for `user100` from `VM1`

### **3. Disk Configuration Role (`datadisk-HumberID`)**

- Partitions the **10GB** disk:
  - **4GB partition** → XFS, mounted at `/part1`
  - **5GB partition** → EXT4, mounted at `/part2`

### **4. Web Server Role (`webserver-HumberID`)**

- Installs and configures **Apache**
- Creates **custom index.html** with node FQDN
- Sets file permissions (`0444`)
- Ensures **Apache auto-starts** on reboot

---

## **Terraform and Ansible Integration**

- **Terraform’s `null_resource` provisioner** triggers Ansible playbook execution.
- The playbook **configures all Linux VMs** post-provisioning.

---

## **Deployment Steps**

### **1. Clone the Repository**

```bash
git clone https://github.com/srush98/Automation-Project.git
cd Automation-Project
```

### **2. Authenticate with Azure**

```bash
az login
```

### **3. Create a storage account, container, and export key**

```bash
az storage account create --name tfstateaccount9400 --resource-group tfstate-rg-9400 --sku Standard_LRS --location "Canada Central"

az storage container create --name tfstate --account-name tfstateaccount9400

export ARM_ACCESS_KEY=$(az storage account keys list --account-name tfstateaccount9400 --query '[0].value' --output tsv)
```

### **4. Initialize and Validate Configuration**

```bash
terraform init
terraform validate
```

### **5. Review Deployment Plan**

```bash
terraform plan
```

### **6. Apply Configuration**

```bash
terraform apply --auto-approve
```

### **7. Verify Deployment**

```bash
terraform state list | nl
terraform output
```

### **8. Destroy Infrastructure**

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
- **Error loading state Error:** Run this command to export the key `export ARM_ACCESS_KEY=$(az storage account keys list --account-name tfstateaccount9400 --query '[0].value' --output tsv)`

---

## **Technical Skills Demonstrated**

### **Terraform Skills**

- Developing reusable code for provisioning Azure resources
- Managing infrastructure resources (single & multiple instances)
- Parameterization using input variables, locals, and output values
- Implementing modular architecture
- Using null provisioners
- Configuring and utilizing a remote backend

### **Azure Services & Features**

- **Identity and Access Management** (Microsoft Entra ID)
- **Networking** (Virtual networks, subnets, network security groups)
- **Security** (NSGs, security rules)
- **Storage** (Storage accounts, Azure Files, Blob containers)
- **Compute** (Windows & Linux VMs, managed disks)
- **Traffic Management** (Load balancers)
- **Monitoring** (Azure Monitor, Log Analytics Workspace)
- **Cost Optimization** (Efficient provisioning, VM shutdown when idle)
- **Azure Interfaces** (Azure Portal, CLI, Terraform)

---

## **Execution & Testing**

### **Phase I – Pre-Provisioning Validation**

1. **Initialize Terraform**
   ```bash
   terraform init
   ```
2. **Validate Configuration**
   ```bash
   terraform validate
   ```
3. **Plan Deployment**
   ```bash
   terraform plan
   ```

### **Phase II – Provisioning**

- Deploy infrastructure:
  ```bash
  terraform apply --auto-approve
  ```

### **Phase III – Post-Provisioning Validation**

1. **Check Terraform State**

   ```bash
   terraform state list | nl
   ```

2. **Retrieve Outputs**
   ```bash
   terraform output
   ```

---

### **Cleanup (Cost Management)**

- Destroy all provisioned resources after completion:
  ```bash
  terraform destroy --auto-approve
  ```

---

## **Conclusion**

This project provided hands-on experience in **Infrastructure as Code (IaC)** using **Terraform**. It reinforced critical concepts such as **modular architecture**, **parameterization**, **remote state management**, and **Azure services provisioning**. By following best practices, I successfully deployed a **highly available, scalable, and secure** infrastructure in **Azure**.

## **Key Takeaways**

- **Terraform automates infrastructure provisioning.**
- **Ansible configures post-provisioning settings.**
- **Combining Terraform & Ansible ensures end-to-end automation.**
- **Using modular design improves scalability & maintainability.**

This project reinforced **Infrastructure as Code (IaC)** best practices while automating **Azure resource provisioning & Linux configuration management**. 🚀
