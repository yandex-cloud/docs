{#ai-infra6-id}

Requirement ID: `AI-INFRA6`

{#ai-infra6-requirement}

**Requirement**

If a single environment hosts multiple systems, tenants, or data classes, the owner must isolate their identities, network paths, state, and permissions for computing resources. One tenant’s workload must never be allowed to read memory, files, secrets, logs, or temporary objects of another tenant.

{#ai-infra6-implementation}

**Implementation**

In {{ managed-k8s-name }}, use separate namespaces and `ServiceAccount` resources, {{ k8s }} RBAC, network policy, and pod restrictions. Implement IAM cluster access and {{ k8s }} RBAC at different layers. For guidelines, refer to [this {{ k8s }} security guide](../../../../security/domains/kubernetes.md) and [access management tutorials](../../../../managed-kubernetes/security/index.md).

If using dedicated GPU pools, you must separately record node groups, execution and scheduling permissions, quotas, and workload resource limits. Native GPU isolation is not guaranteed: to confirm isolation, you must provide relevant evidence for the selected runtime.

{{ serverless-containers-name }} and {{ sf-name }} isolate the managed runtime for a published model; however, the application code is still responsible for isolating tenant data and managing state between requests.

In {{ compute-name }}, the organization is also responsible for the OS, process isolation, and access to VM metadata.

Even with a single tenant, development, testing, and production environments must be isolated. You must explicitly state the unit of isolation: a cluster, node group or namespace, {{ ml-platform-name }} project, Function or Container resource, VM, folder, network, or managed service resource with the application rule for the tenant.

{#ai-infra6-check}

**Check**

1. Create two test subjects or tenants and attempt cross-tenant access to files, secrets, cache, and endpoints.
1. For {{ k8s }}, additionally check {{ iam-short-name }}, `RoleBinding`/`ClusterRoleBinding`, network policy, and workload allocation.
1. For a serverless environment, check the tenant isolation keys in each external store.

Tests must involve access attempts with a foreign tenant identity, foreign namespace, storage key, and direct endpoint. In case of a failure, the mixed cache or index must be dumped.

{#ai-infra6-artifacts}

**Artifact**

* Test of cross-tenant access to file, secret, cache, and endpoint.
* Topology and map of resources and tenants.
