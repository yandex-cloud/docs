### Separate service accounts are used for cluster and node group {#access}

#|
|| **kind** | **severity** | **ID** ||
|| manual | high | k8s.access ||
|#

#### Description

When creating a cluster in Managed Service for Kubernetes, specify two service accounts:

* **Cluster service account**: On behalf of this service account, Managed Service for Kubernetes manages cluster nodes, subnets for pods and services, disks, load balancers, encrypts and decrypts secrets. 
* **Node group service account**: Under this service account, Managed Service for Kubernetes cluster nodes get authenticated in Yandex Container Registry or Yandex Cloud Registry. For other container registries, you do not need to assign roles to the service account.

#### Guides and solutions to use

**Guides and solutions to use:**

Make sure that the access of IAM accounts to Managed Service for Kubernetes resources is managed at the following levels:

* Managed Service for Kubernetes service roles (access to the Yandex Cloud API). These allow you to control clusters and node groups (e.g., create a cluster, create/edit/delete a node group, and so on).
* Service roles required to access the Kubernetes API. These allow you to control cluster resources via the Kubernetes API (e.g., perform standard actions with Kubernetes: create, delete, view namespaces, work with pods, deployments, create roles, and so on). Only the basic global roles are available at cluster level: `k8s.cluster-api.cluster-admin`, `k8s.cluster-api.editor`, or `k8s.cluster-api.viewer` .
* Primitive roles. These are global primitive IAM roles that comprise service roles (e.g., the primitive `admin` role comprises both the service administration role and the administration role for access to the Kubernetes API).
* Standard Kubernetes roles. Inside the Kubernetes cluster itself, the Kubernetes tools can help you create both regular roles and cluster roles. Thus you can manage access for IAM accounts at the namespace level. To assign IAM roles at the namespace level, you can manually create RoleBinding objects in a relevant namespace stating the cloud user's IAM ID in the subjects name field.
