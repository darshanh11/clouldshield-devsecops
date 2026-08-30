# Cloud Service Mapping

The project is implemented on AWS, but the architecture is intentionally based on concepts that transfer to Azure and GCP.

| Layer | AWS | Azure | GCP |
|---|---|---|---|
| Compute | EC2 | Azure Virtual Machines | Compute Engine |
| Network | VPC | VNet | VPC |
| IAM | IAM | Entra ID + Azure RBAC | Cloud IAM |
| Registry | ECR | Azure Container Registry | Artifact Registry |
| Monitoring | CloudWatch | Azure Monitor | Cloud Monitoring |
| Object storage | S3 | Blob Storage | Cloud Storage |
| Kubernetes | EKS | AKS | GKE |

## Interview point

Cloud providers differ in product names and implementation, but core concepts such as compute, networking, identity, storage, containers, monitoring, and automation remain transferable.
