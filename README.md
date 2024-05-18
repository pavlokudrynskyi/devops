# Home task

This repository contain code configuration from different areas of setup:

## CI/CD

Inside this folder you can find the templates and actual use of this template in `service/.gitlab-ci.yml`. 
Basic logic to use trunk base with custom configurations. 
CI part is pretty standard with Docker build and push to ECR. By CD we just doing the replace action for the ArgoCD app in different repository and push a new commit. 
Argo sync the changes and deploy a new version of app

## Cluster-addons
ArgoCD constantly sync this repository and apply configurations. 
As example, you can find Prom Stack and Log solution (loki&promtail). 
For application part the example of self hosted superset with custom role provisioning for initial configuration.

## Helm 
Just a simple example of self managed helm chart for applications. 
The idea behind that - make a template for multiple applications to make the manage process more simple.

## Terraform 
The main configuration for AWS infrastructure that represent dev env as example. 
Folder logic `env/region/service_type/service_name`.
Resources that not region based are stored in `global` folder. 
The configuration contains:
- VPC setup
- self managed VPN solution based on OpenVPN
- S3 bucket to store tf states
- EKS cluster with bunch of policies needed for future addons like ALB controller or ExternalDNS
- ECR repository
- ArgoCD configuration needed to deploy the rest of infrastructure for Kubernetes cluster
- Security that includes Guardduty and Security Hub Finding