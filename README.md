# Kubernetes Cluster with Addons

## Project Description
This project aims to provide hands-on experience in deploying and managing Kubernetes clusters using Amazon EKS on the AWS cloud platform with Infrastructure as Code (IaC) using Terraform. The project focuses on setting up a suite of DevOps tools and implementing GitOps methodologies. Participants will learn industry best practices for container orchestration and DevOps methodologies, gaining practical skills essential for modern cloud-native application deployment.

## Deliverables
### Infrastructure Provisioning
- Set up AWS infrastructure components such as VPC, subnets, security groups, IAM roles, and necessary networking configurations to support the Kubernetes cluster.
- Create EKS, EFS, ELB, Auto-scaler, RDS, Redis, and AWS Secret Manager using Terraform.

### Amazon EKS Cluster Deployment
- Deploy a Kubernetes cluster using Amazon EKS, leveraging managed control plane capabilities for ease of management and scalability.

### Node Group Configuration
- Configure worker nodes (EC2 instances) to join the EKS cluster, ensuring proper communication and resource allocation.

### Containerized Application Deployment
- Deploy sample applications or microservices onto the Kubernetes cluster, utilizing containers and Kubernetes-native deployment strategies.

### Monitoring and Logging Integration
- Implement monitoring and logging solutions using Prometheus, Grafana, Loki, and Tempo to gather insights into cluster performance, resource utilization, and application health.

### Continuous Integration/Continuous Deployment (CI/CD) Pipeline
- Set up automated pipelines for building, testing, and deploying applications to the Kubernetes cluster using Jenkins.

### GitOps Implementation
- Use ArgoCD to deploy all Helm charts and configurations to the Kubernetes cluster.

### Security Best Practices
- Implement security measures such as network policies, RBAC (Role-Based Access Control), and AWS IAM policies to secure the Kubernetes environment and its workloads.

### Scalability and High Availability
- Configure auto-scaling policies for both the Kubernetes cluster and its underlying infrastructure components to ensure resilience and meet varying workload demands.


## Technical Details
- Use Terraform for provisioning AWS services.
- Use ArgoCD to install all tools on the Kubernetes cluster.
- Automate Grafana configurations from the Helm values file (e.g., Loki and Tempo integration).
- Jenkins will run on the Kubernetes cluster, executing each pipeline in a pod that will be automatically deleted upon completion.
- Store all application secrets in AWS Secrets Manager. Install the External Secrets Operator Helm chart to read secrets from AWS to Kubernetes.
- Create the following repositories:
  - **Application Repository**: Fork the repo and use the same branch from [here](https://github.com/mahmoud254/jenkins_nodejs_example/tree/rds_redis).
  - **ArgoCD Repository**: Store all configuration files for deploying monitoring tools (Prometheus, Grafana, Loki, Tempo), Jenkins, and the External Secrets Operator using Helm charts.
  - **Infrastructure Repository**: Store the Terraform code.

## Repository Organization
- **Infrastructure Repository**: Contains Terraform code for provisioning AWS infrastructure components and deploying the EKS cluster.
  - Repository URL: [here](https://github.com/hazemhashem/CWD-IaC.git)
  
- **ArgoCD Repository**: Contains configuration files for deploying monitoring tools (Prometheus, Grafana, Loki, Tempo), Jenkins, and the External Secrets Operator using Helm charts.
  - Repository URL: [here](https://github.com/hazemhashem/CWD-argocd.git)

- **Application Repository**: Contains the application code and configurations required to deploy the sample application, including database (RDS MySQL) and cache (ElastiCache Redis) setup.
  - Jenkinsfile code for CI.
  - ArgoCD file for deploying the application on EKS after CI.
  - Repository URL: [here](https://github.com/hazemhashem/CWD_jenkins_nodejs_example/tree/rds_redis)

## Setup Instructions
1. **Clone the Repositories**:
   ```sh
   git clone https://github.com/hazemhashem/CWD-IaC.git
   git clone https://github.com/hazemhashem/CWD-argocd.git
   git clone -b rds_redis https://github.com/hazemhashem/CWD_jenkins_nodejs_example.git

2. **cd to CWD-IaC directory **:
    - add your account_id of aws on prod.tfvars and add your own setting
    - After terraform complete use port-forwart to argoce server
        ```sh
        kubectl port-forward svc/argocd-server 5000:80 -n argocd

3. **cd to CWD-argocd directory **:
    - Edit your accountservice of external-secrts inside  directory teplates of external-secrets and manage owan cluster-secretStore and externalSecret
    - Deploy monitoring tools (Prometheus, Grafana, Loki, Tempo), Jenkins, and the External Secrets Operator using Helm charts using application Set argocd
        ```sh
        cd git-generator-argocd
        kubectl apply -f git-generator.yaml

3. **cd to CWD_jenkins_nodejs_example directory **:
    - Edit your own Pipeline of jenkins file