{#ai-iam-leastpriv1-id}

Requirement ID: `AI-IAM-LEASTPRIV1`

{#ai-iam-leastpriv1-requirement}

**Requirement**

The production component must be executed under a separate workload identity, not always the developer's personal account. For each subject, the owner must associate the required operation with the minimum documented role and the narrowest supported assignment scope. The agent or model output is not the reason for authorization: the decision is made by {{ iam-short-name }} or backend possessing a checked user identity.

{#ai-iam-leastpriv1-implementation}

**Implementation**

The check takes into account direct, group, and inherited bindings. The resource and role model principles are described in [this {{ iam-short-name }} guide](../../../../iam/concepts/access-control/index.md).

If the organization uses [{{ iam-short-name }} access policies](../../../../iam/concepts/access-control/access-policies.md), this feature complements roles with explicit prohibitions.

The whole of the {{ ciem-name }} ({{ ciem-full-name }}) module, as part of [{{ sd-full-name }}](../../../../security-deck/index.yaml), is at the Preview stage and can be used only after an availability confirmation. It shows assigned access permissions, including direct and obtained through groups, but does not say which permission is excessive instead of the organization.

For viewing, you need the `organization-manager.viewer` role for the organization or a broader documented role. For more information, see [{{ ciem-name }}](../../../../security-deck/concepts/ciem.md) and [{#T}](../../../../security-deck/operations/ciem/view-permissions.md). [Access revocation](../../../../security-deck/operations/ciem/revoke-permissions.md) has additional restrictions by roles and group types and is not treated as available just because viewing is available.

The service account of the runtime environment is separate from the deployment identity and the administrator. The actual minimum of permissions is confirmed by a controlled test, not only by mapping to examples of documentation.

{#ai-iam-leastpriv1-check}

**Check**

1. For each production subject, export effective direct and inherited permissions in the cloud, folders, and target resources.
1. Map each role to an operation.
1. For {{ k8s }}, additionally check `RoleBinding` and `ClusterRoleBinding`.
1. For the key workload identity, run a permitted operation and an adjacent forbidden operation of creating, deleting, or reading another resource: the last one should be denied.

An unused, broad, or unjustified role must be deleted or formalized as an exclusion.

{#ai-iam-leastpriv1-artifacts}

**Artifact**

* Effective direct and inherited permissions.
* Role-to-operation mapping.
* `subject → operation → resource → role and scope → binding level` matrix.
* Masked key scopes.
