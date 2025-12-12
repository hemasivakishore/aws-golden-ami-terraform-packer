AWS Golden AMI Pipeline with Terraform, Packer & GitHub Actions

🔹 Overview

This project implements a complete Golden AMI DevSecOps pipeline using AWS, Terraform, Packer, GitHub Actions, Trivy, and AWS Inspector.
It automates infrastructure provisioning, hardened image creation, vulnerability scanning, and security validation with gated CI/CD and real-time notifications.

⸻

🧰 Tech Stack
	•	Cloud: AWS
	•	Infrastructure as Code: Terraform
	•	Image Automation: HashiCorp Packer
	•	CI/CD: GitHub Actions (Self-Hosted Runner)
	•	Security & Vulnerability Scanning: Trivy
	•	Runtime Security: AWS Inspector v2
	•	Notifications: Slack Webhooks & Gmail SMTP

⸻

🏗️ Architecture Flow
	1.	Terraform provisions VPC, Subnets, Security Groups, NAT Gateway.
	2.	Packer builds a hardened Golden AMI with system metadata + Nginx.
	3.	Trivy scans the AMI for High/Critical vulnerabilities.
	4.	Terraform deploys an EC2 instance using the Golden AMI.
	5.	AWS Inspector v2 performs runtime security analysis on the EC2 instance.
	6.	Reports are uploaded to Amazon S3.
	7.	Slack & Email send success/failure notifications for every stage.

⸻

🔁 CI/CD Workflow (GitHub Actions)

Pipeline execution order:
	1.	🏗️ Terraform Init → Plan → Apply
	2.	📦 Packer Golden AMI Build
	3.	🔍 Trivy AMI Vulnerability Scan → Upload to S3
	4.	🛡️ AWS Inspector Runtime Scan → Upload to S3
	5.	🔔 Slack + Email Notifications

Each stage is gated — next step runs only if the previous stage succeeds.

⸻

🔐 Security Features
	•	Hardened Golden AMI
	•	Trivy vulnerability scanning (High/Critical detection)
	•	AWS Inspector v2 runtime analysis
	•	Secrets stored securely in GitHub Secrets
	•	S3 backend support for Terraform state
	•	IAM roles for least privilege access

⸻

🔔 Notification System
	•	Slack Alerts: Pipeline start, AMI created, Trivy scan uploaded, Inspector scan uploaded
	•	Email Alerts: Gmail SMTP with App Password
	•	Fully automated notification workflow

⸻

📂 Repository

GitHub:
👉 https://github.com/hemasivakishore/aws-golden-ami-terraform-packer

⸻

👨‍💻 Author

V. Hema Siva Kishore
SRE | DevOps | AWS | Azure| GCP | Cloud Automation
LinkedIn: https://linkedin.com/in/hemasivakishore

⸻

📌 Use Cases

This project demonstrates enterprise-grade DevSecOps capabilities for:
	•	Golden AMI pipelines
	•	Secure cloud image lifecycle
	•	Vulnerability-aware CI/CD workflows
	•	End-to-end IaC + Image Factory + Security Automation
	•	Real production-like SRE/Platform Engineering design

⸻

🏁 Status

✔️ Infrastructure Automation
✔️ Golden AMI Creation
✔️ Trivy Scan + S3 Upload
✔️ AWS Inspector Scan + S3 Upload
✔️ Slack + Email Notifications
✔️ GitHub Actions Pipeline
✔️ Fully Automated End-to-End
