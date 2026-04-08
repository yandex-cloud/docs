# Access management

In {{ stackland-name }}, access management includes authentication and authorization. The platforms supports two authorization methods: Kubernetes RBAC and IAM AccessBinding.

## Authentication {#authentication}

{{ stackland-name }} uses {{ iam-name }} for authentication. {{ iam-name }} serves as a single authentication point for all the platform components.

### Authentication methods {#auth-methods}

The platforms supports these authentication methods:

* **Local users**: Accounts created directly in {{ iam-name }}. This method is best suited for smaller teams or test environments.
* **Federated users**: IdP accounts. The supported protocols are SAML, OIDC, and LDAP.
* **Service accounts**: Accounts for automation and cross-service communication. These accounts use long-lived tokens or API keys.

### Authentication in the web console {#web-auth}

The {{ stackland-name }} web console is integrated with {{ iam-name }}. When logging in, the user is redirected to the authentication page with the login options:

* Via a username and password of a local user account.
* Via a corporate IdP (if a federation has been set up).

### Authentication in the Kubernetes API {#k8s-auth}

To access the Kubernetes API, use _kubeconfig_.

### Service access {#service-access}

For automation, e.g., from CI/CD systems, you can choose between these two authentication methods:

* **Service account token**: Long-lived Kubernetes ServiceAccount token. Suitable for systems not supporting token exchange.
* **API keys**: Keys created via {{ iam-name }} for access to the APIs of the platform services.

### Federations {#federations}

With a federation, you can use a corporate identity provider for authentication in {{ stackland-name }}. Use the `SAMLFederation` resource to configure your SAML federation:

```yaml
apiVersion: iam.stackland.yandex.cloud/v1alpha1
kind: SAMLFederation
metadata:
  name: corporate-idp
spec:
  issuer: "https://idp.example.com/realms/main"
  ssoUrl: "https://idp.example.com/realms/main/protocol/saml"
  ssoBinding: POST
  autoCreateAccountOnLogin: true
  cookieMaxAge: "12h"
  certificates:
    - name: "idp-signing-cert"
      data: |
        -----BEGIN CERTIFICATE-----
        ...
        -----END CERTIFICATE-----
  groupMapping:
    enabled: true
    mapping:
      - externalId: "idp-admins"
        internalName: "stackland-cluster-admins"
```

You can enable group mapping for your federation to have the external IdP's groups mapped to groups in {{ iam-name }}.

## Authorization {#authorization}

{{ stackland-name }} supports two authorization methods working in parallel:

* **Kubernetes RBAC**: Standard Kubernetes access management method used for Kubernetes resources (pods, deployments, services, etc).
* **IAM AccessBinding**: {{ iam-name }} method of granting permissions to subjects at different levels: clusters, projects, etc.
* **Access to platform services**: Implemented through the mechanisms of the platform services themselves, e.g., verification uses the username and password of the actual DBMS.

### Kubernetes RBAC {#k8s-rbac}

Kubernetes RBAC manages access through roles and role bindings. While a role determines the permissions (i.e., what actions on what resources), a binding assigns the role to a subject.

Standard RBAC resources:

#|
|| Resource | Action scope | Description ||
|| `ClusterRole` | Cluster | Cluster-level permissions ||
|| `ClusterRoleBinding` | Cluster | `ClusterRole` binding to a subject at the cluster level ||
|| `Role` | Namespace | Permissions within a specific namespace ||
|| `RoleBinding` | Namespace | Binding a role to a subject within a namespace ||
|#

{{ stackland-name }} additionally provides resources for project-level access management:

#|
|| Resource | Action scope | Description ||
|| `ProjectRole` | Project | Project-level permissions ||
|| `ProjectRoleBinding` | Project | Binding a role to a subject within all namespaces of the project ||
|#

Learn more about project roles in [Configuring project roles](operations/projects/project-roles.md).

### Access role bindings {#iam-access-binding}

Access role bindings are used to manage access to the platform services. A binding binds the subject with a role at a particular resource model level.

Types of bindings:

* `ClusterAccessBinding`: Cluster-level binding.
* `ProjectAccessBinding`: Project-level binding.
* `AccessBinding`: Namespace-level binding.

Example of granting an IAM role at the cluster level:

```yaml
apiVersion: iam.stackland.yandex.cloud/v1alpha1
kind: ClusterAccessBinding
metadata:
  name: user-admin-role
spec:
  roleID: admin
  subject:
    kind: User
    name: "alice@stackland"
```

Example of granting a role at the namespace level:

```yaml
apiVersion: iam.stackland.yandex.cloud/v1alpha1
kind: AccessBinding
metadata:
  name: bob-storage-admin
  namespace: my-namespace
spec:
  roleID: storage.admin
  subject:
    kind: User
    name: "bob@stackland"
```

### Subject types {#subject-types}

Role bindings support the following subject types:

* `User`: {{ iam-name }} local user.
* `Group`: {{ iam-name }} user group.
* `ServiceAccount`: Kubernetes service account.
* `FederatedUser`: External IdP user.

## Access levels {#access-levels}

You can grant access at these three [resource model](concepts/resource-model.md) levels:

### Cluster level {#cluster-level}

For access to all the {{ stackland-name }} cluster's resources.

Mechanism: `ClusterRoleBinding` and `ClusterAccessBinding`.

### Project level {#project-level}

For access to all the project's namespaces. Use for:

* Project administrators.
* Project team members.
* CI/CD systems.

Mechanism: `ProjectRoleBinding` and `ProjectAccessBinding`.

### Namespace level {#namespace-level}

For access limited to a particular namespace. Use for:

* Developers working with a particular environment.
* Service accounts of applications.
* Restricted access to the resources of the platform services.

Mechanism: `RoleBinding` and `AccessBinding`.

## Primitive roles {#primitive-roles}

In {{ stackland-full-name }}, there are primitive roles you can assign to users and groups via `RoleBinding` or `ClusterRoleBinding`, depending on the access scope you need.

### stackland:viewer

Allows you to view all main cluster resources:

* Pods, services, endpoints, and ConfigMaps.
* Deployments, `daemonset`s, `statefulset`s, and `replicaset`s.
* Ingress controllers and network policies.
* Storage classes, persistent volumes.
* {{ PG }} and Storage resources.
* Certificates and monitoring.

### stackland:editor

Includes all `stackland:viewer` permissions and enables managing applications:

* Creating, updating, and deleting pods, services and deployments.
* Managing ConfigMaps and secrets.
* Access to pod logs and port forwarding.
* Managing PostgreSQL and {{ objstorage-name }} resources.
* Managing certificates and monitoring.

### stackland:admin

The `stackland:admin` role grants full administrative permissions to manage all resources and users in the cluster.

### stackland:auditor

Extended audit permissions include all `stackland:viewer` permissions as well as permissions to:

* View secret metadata without their contents.
* Access RBAC resources (roles and access bindings).
* View network and security policies.
* Access certificates and their statuses.

## What's next {#what-is-next}

* [Creating a user](operations/iam/create-user.md)
* [Creating a user group](operations/iam/create-group.md)
* [Connecting a SAML federation](operations/iam/connect-saml-federation.md)
* [Assigning access permissions](operations/iam/assign-role.md)
* [Resource model](concepts/resource-model.md)
