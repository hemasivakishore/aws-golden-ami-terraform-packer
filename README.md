# AWS Golden AMI Pipeline with Terraform, Packer & GitHub Actions

## 🔹 Overview
This project implements a complete **Golden AMI DevSecOps pipeline** using **AWS, Terraform, Packer, GitHub Actions, Trivy, and AWS Inspector**.  
It automates infrastructure provisioning, hardened image creation, vulnerability scanning, and security validation with gated CI/CD and notifications.

---

## 🧰 Tech Stack
- **Cloud:** AWS
- **Infrastructure as Code:** Terraform
- **Image Automation:** Packer
- **CI/CD:** GitHub Actions
- **Vulnerability Scanning:** Trivy
- **Runtime Security:** AWS Inspector v2
- **Notifications:** Slack & Gmail SMTP

---

## 🏗️ Architecture Flow

1. Terraform creates base infrastructure (VPC, Subnets, Security Groups)
2. Packer builds a hardened **Golden AMI**
3. Trivy scans the image for vulnerabilities
4. AWS Inspector validates EC2 runtime security
5. Slack & Email notify the final status

## 🔁 CI/CD Workflow (GitHub Actions)

**Pipeline Order:**
1. Terraform Infra Provisioning  
2. Packer Golden AMI Build  
3. Trivy Vulnerability Scan  
4. AWS Inspector Security Validation  
5. Final Slack & Email Notification  

Each stage runs **only if the previous stage succeeds**, enforcing strict security gating.

---

## 🔐 Security Features
- Golden Image Hardening
- Trivy High/Critical Vulnerability Blocking
- AWS Inspector v2 Runtime Analysis
- Secrets managed via GitHub Secrets
- Remote Terraform backend supported

## 🔔 Notifications
- Slack alerts for every pipeline stage
- Email alerts using Gmail SMTP
- Final notification on successful golden image creation

---

## 👨‍💻 Author
**Hema Siva Kishore**  
DevOps | Cloud | SRE  
LinkedIn *https://linkedin.com/in/hemasivakishore*
GitHub: *https://github.com/hemasivakishore/aws-golden-ami-terraform-packer*

---

## 📌 Use Case
This repository demonstrates **enterprise-grade DevSecOps automation** for:
- Secure image pipelines
- Compliance-ready infrastructure
- Cloud production environments
