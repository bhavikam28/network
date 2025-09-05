# 🛡️ From Isolation to Connectivity: AWS VPC & RAM Resource Sharing

Welcome to the repository for my AWS multi-account networking project — implementing **VPC segmentation** and **secure cross-account sharing** using **AWS RAM**, **Terraform**, and **GitHub Actions**.

> This project is based on AWS Security Reference Architecture (SRA) and demonstrates how to build secure, automated, and scalable networking foundations across AWS Organizations.

---

## 📸 Architecture Overview

<img width="876" height="594" alt="image" src="https://github.com/user-attachments/assets/892470a9-3a23-4553-8022-2863305c239b" />


**Structure:**
- **Root OU** contains two organizational units:
  - **Infrastructure OU** → Hosts the **Network Account** (centralized VPC)
  - **Sandbox OU** → Hosts the **Development Account** (consumes shared subnets)
- VPC in the Network Account includes:
  - 2 Public Subnets
  - 2 Private Subnets
  - Internet Gateway, NAT Gateway, Routing Tables
- Subnets are securely **shared via AWS RAM** to the Development Account

---

## ✨ Features

✅ Multi-account architecture via AWS Control Tower  
✅ Centralized VPC managed in a dedicated Network account  
✅ Private/Public subnets for isolation and security  
✅ Resource Access Manager (RAM) for cross-account sharing  
✅ Terraform for infrastructure provisioning  
✅ GitHub Actions for CI/CD automation  
✅ Secure IAM access via OIDC (no long-lived credentials)

---

## 🔧 Tech Stack

| Category       | Tools/Services                         |
|----------------|----------------------------------------|
| IaC            | Terraform (with GitHub version control)|
| CI/CD          | GitHub Actions                         |
| Cloud Platform | AWS (VPC, RAM, S3, NAT, IGW, Subnets)  |
| Security       | IAM, OIDC, Security Groups, NACLs      |
| Access Mgmt    | AWS Organizations, Control Tower       |

---

## 🚀 Getting Started

### 🖥️ Prerequisites
- AWS Control Tower enabled with Organizations
- Terraform CLI
- GitHub repo with configured GitHub Actions

### 📁 Folder Structure
```
network/
├── main.tf
├── variables.tf
├── outputs.tf
├── ram.tf
├── vpc.tf
└── .github/workflows/deploy.yml
```

---

## ⚙️ GitHub Actions Workflow

CI/CD is fully automated with OIDC authentication to assume IAM roles.

```yaml
name: Terraform VPC Deployment
on:
  workflow_dispatch:
permissions:
  contents: read
  id-token: write

jobs:
  terraform:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v2
        with:
          terraform_version: "1.10.3"
          cli_config_credentials_token: ${{ secrets.TFC_API_TOKEN }}

      - name: Terraform Init
        run: terraform init

      - name: Terraform Plan
        run: terraform plan -input=false

      - name: Terraform Apply
        run: terraform apply -auto-approve -input=false
```

---

## 🧱 Step-by-Step Implementation

### 🔹 Phase 1: Centralized VPC Creation
- Deployed VPC in **Network Account** with:
  - 2 Private Subnets (A & B)
  - 2 Public Subnets (A & B)
  - IGW, NAT Gateway, Route Tables
- Disabled default VPCs via Account Factory
- CIDR blocks planned for scalability

### 🔹 Phase 2: Infrastructure-as-Code with Terraform
- Stored IaC in GitHub for version control
- Built reusable modules for VPC, subnets, and RAM

### 🔹 Phase 3: CI/CD with GitHub Actions
- Automated Terraform plan + apply with validation
- Integrated with AWS via OIDC (no static keys)

### 🔹 Phase 4: Cross-Account Sharing with AWS RAM
- Enabled RAM Org sharing
- Shared all subnets with **Sandbox OU** via `ram.tf`
- Verified subnet access in **Development Account**
- Removed default VPCs from target accounts to avoid conflicts

---

## 🔐 Security Highlights

- **Private Subnets** isolate sensitive workloads (e.g., RDS)
- **NAT Gateway** allows secure internet access without exposure
- **Security Groups & NACLs** act as defense layers
- **OIDC-based Role Assumption** prevents credential leakage
- **Terraform modules** enforce consistency and security-by-default

---

## 📚 Related Blog Post

This implementation is fully documented in the Medium blog post:

**📖 [From Isolation to Connectivity: AWS VPC & RAM Resource Sharing](https://medium.com/@bhavi.28.mantri)**

---

## 📜 License

MIT © Bhavika Mantri — free to use, fork, and build upon.
