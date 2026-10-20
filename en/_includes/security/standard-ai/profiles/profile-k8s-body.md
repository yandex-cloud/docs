{#profile-k8s-applicability}

**Scope and status**

The profile applies if {{ managed-k8s-name }} is the AI component runtime.

{#profile-k8s-flow}

**Flow and trust boundaries**

`Ingestion → Service → Pod → AI/RAG/MCP dependencies`; {{ k8s }} API, modes and workloads are evaluated separately. [{{ iam-name }}](../../../../iam/index.yaml) manages {{ yandex-cloud }} resources, {{ k8s }} RBAC manages {{ k8s }} API objects; application authorization manages user data.

{#profile-k8s-authentication}

**Workload identity and authentication**

The following identities are separated:

* Cluster service account.
* Node group service account.
* `ServiceAccount` resource of a {{ k8s }} workload and its linked {{ iam-short-name }} account.
* {{ k8s }} API user.

If a workload does not access the [{{ yandex-cloud }} API](../../../../api-design-guide/index.yaml), its cloud credentials are marked as `N/A`.

For a workload to access the API directly without an authorized key, you can use a [workload identity federation](../../../../iam/concepts/workload-identity.md): an OIDC token of the `ServiceAccount` resource in {{ k8s }} is exchanged for an IAM token of the linked {{ iam-short-name }} service account. The External Secrets Operator retains a separate path with the specified key.

A workload utilizing a node’s service account token via the metadata service is the node’s shared identity. To implement this, you must explicitly restrict permissions and provide justification. Otherwise, the pod’s access to metadata is blocked.

{#profile-k8s-roles}

**Roles and scope**

* The subject creating a cluster and node group is assigned the `k8s.editor` role or higher and the `iam.serviceAccounts.user` role for the selected service accounts. To create these entities with public access, the subject also requires the `vpc.publicAdmin` role.
* The cluster’s service account gets the minimum `k8s.clusters.agent` role; for public access, it also gets the `vpc.publicAdmin` role. If {{ vpc-short-name }} resides in another folder, the account is assigned the `vpc.privateAdmin`, `vpc.user`, and `vpc.bridgeAdmin` roles for the folder in this network.
* The node group’s service account gets the `container-registry.images.puller` role for the selected {{ container-registry-name }} or the `cloud-registry.artifacts.puller` role for the selected {{ cloud-registry-name }}. For any other registry, these roles are not automatically assigned.
* For user access to the cloud API and {{ k8s }} API, the `k8s.viewer`, `k8s.editor`, `k8s.cluster-api.viewer`, `k8s.cluster-api.editor`, `k8s.cluster-api.admin`, and `k8s.cluster-api.cluster-admin` roles are used depending on the operation. Inside the cluster, `Role`/`RoleBinding` are applied within the namespace. `ClusterRoleBinding` must be individually substantiated.

Subject and role boundaries are checked against the [{{ k8s }} access model](../../../../managed-kubernetes/security/index.md).

{#profile-k8s-network}

**Network**

The CIDRs of the cluster, nodes, and pods, public access to the master endpoint, security groups, ingress controller, service, and network policy are recorded.

For workspaces, a default-deny rule applies, with required directions whitelisted. The pod’s access to `169.254.169.254` is blocked unless the node’s metadata token is required.

If a workload identity federation is used to access the {{ yandex-cloud }} API, the nodes are provided with an outbound path via a public IP address, NAT gateway, or NAT instance, alongside allowed outbound security group rules as per [this integration guide](../../../../tutorials/security/wlif-managed-k8s-integration.md). This condition does not require assigning a public IP address to each node if NAT is selected.

{#profile-k8s-secrets}

**Secrets and credentials**

In a workload identity federation, there is no authorized key: instead, the {{ iam-short-name }} service account, federation, federated credentials, and `system:serviceaccount:<namespace>:<ServiceAccount_name>` exact subject are recorded.

A separate [External Secrets Operator](../../../../managed-kubernetes/operations/applications/external-secrets-operator.md) documented integration uses a service account authorized key stored inside a {{ k8s }} `Secret` and the `lockbox.payloadViewer` role for a specific secret. This path with the key does not qualify as a keyless workload identity: the key, `SecretStore`, `ExternalSecret`, target `Secret`, rotation, and consumer are tracked according to `AI-SECRET1`.

{#profile-k8s-configuration}

**Configuration objects**

Cluster and node group IDs, service accounts, namespaces, `ServiceAccount` {{ k8s }} resources, deployments, jobs, `Role`/`ClusterRole` and bindings, network policies, `Ingress` and `Service` objects, security groups, pod security context, resource limits, `SecretStore`/`ExternalSecret`/`Secret`, and image digest.

For a workload identity federation, the following is also recorded: the federation active status for a cluster and node group, issuer URL and JWKS URL, workload identity federation IDs and its bindings, {{ iam-short-name }} service account ID, `yandex.cloud/federated-yc-service-account-id` annotation, and an external subject: `ServiceAccount` resource in {{ k8s }}.

For audits, `master-logging.enabled`, `audit-enabled`, `log-group-id` or `folder-id`, and the `logging.writer` role assigned to the resource service account are recorded.

{#profile-k8s-telemetry}

**Telemetry and blind spots**

The {{ k8s }} API audit is only delivered to {{ cloud-logging-name }} with `master-logging.enabled` and `audit-enabled` and configured assignment of `log-group-id` or `folder-id`. For info about these settings, see [this cluster update guide](../../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-update.md). The record content is restricted by the published [audit policy](../../../../managed-kubernetes/concepts/audit-policy.md).

The node, pod, and application logs as well as application-layer agent tracing are separate sources; the management-level audit does not prove their completeness.

{#profile-k8s-checks}

**Positive and negative checks**

1. Check {{ iam-short-name }} and RBAC individually and run an allowed and prohibited API action.
1. For a workload identity federation, check the exchange of the allowed `ServiceAccount` resource token in {{ k8s }}, confirm rejection if using a different namespace or `ServiceAccount` resource, and a failure an outbound route or rule to the {{ yandex-cloud }} API is deleted.
1. Test cross-namespace requests, the default deny network policy, and metadata endpoint.
1. Test retrieval and revocation for a test secret without outputting its value and check the image digest.
1. Check the audit event and its correlation with the pod or application log.

{#profile-k8s-inputs}

**What you need for profile implementation**

* Architecture: topology, inbound path, workload identities, and dependencies.
* Policy: RBAC, outgoing traffic, pod security settings, limits, and retention period.
* Legal approach: stored and training data.
