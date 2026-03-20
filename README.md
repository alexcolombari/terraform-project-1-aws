# AWS Infrastructure Automation with Terraform & LocalStack

## 🚀 Overview
This repository demonstrates a complete **Infrastructure as Code (IaC)** workflow. It aims to simulate a production-ready cloud environment locally, focusing on security, data resilience, and developer experience (DevEx).

This project automates the provisioning of AWS resources in a local environment (WSL2/Ubuntu). It uses Terraform to manage S3 buckets (with versioning) and IAM users. An integrated setup script automates the entire process from Docker to the Terraform application.

---

### Key Features:
* **Automated Provisioning:** One-click setup using a custom Bash script (`setup.sh`).
* **S3 Resilience:** Buckets created with **Versioning** enabled and Public Access Blocks.
* **Scalable IAM:** Dynamic creation of multiple users using `for_each` loops and `list(string)` variables.
* **Security First:** Granular IAM Policies following the **Principle of Least Privilege (PoLP)**.
* **Cloud Simulation:** Powered by **LocalStack**, ensuring zero AWS costs during development.

---

## 🛠 Tech Stack
* **IaC:** Terraform
* **OS:** WSL2 (Ubuntu 24.04)
* **Emulator:** LocalStack (Docker)
* **CLI Tools:** AWS CLI / awslocal

---

## ⚙️ Quick Start (The SRE Way)
I've included a `setup.sh` script to handle the heavy lifting. This script automates the Docker container startup, environment variables, and Terraform initialization.

1.  **Clone the repo and enter the folder:**
    ```bash
    git clone <your-repo-url>
    cd projeto_terraform
    ```

2.  **Run the automated setup:**
    ```bash
    chmod +x setup.sh
    ./setup.sh
    ```

3.  **Verify the resources:**
    ```bash
    # List created buckets
    awslocal s3 ls
    
    # Check attached policies for a user
    awslocal iam list-attached-user-policies --user-name alex
    ```

---

## 📁 Project Structure
* `main.tf`: Core logic for S3, IAM, and Security Policies.
* `providers.tf`: LocalStack endpoint and AWS provider configuration.
* `variables.tf`: Reusable definitions for regions, environment names, and user lists.
* `outputs.tf`: Automatic display of ARNs and Bucket names after deployment.
* `setup.sh`: Orchestration script for the entire environment.
* `.gitignore`: Pre-configured to exclude `.tfstate` and sensitive local files.

---

## 🔍 Troubleshooting & Lessons Learned
As part of my transition to SRE, I documented and solved several local environment challenges:
* **WSL Interoperability:** Fixed `Exec format error` by migrating from Windows binaries to native Linux tools within WSL.
* **S3 Addressing:** Resolved `no such host` issues by enforcing `s3_use_path_style = true`.
* **Credential Chain:** Configured the Terraform provider to bypass real AWS STS validation for 100% local execution.