{#profile-mos-applicability}

**Scope and status**

This profile applies if {{ mos-name }} is the RAG knowledge store.

{#profile-mos-flow}

**Flow and trust boundaries**

`source → ingestion environment → cluster and index`; separately, `search environment → {{ OS }} endpoint → result → model`. The application authorizes access to the document before returning a retrieved chunk.

{#profile-mos-authentication}

**Workload identity and authentication**

{{ iam-name }} manages the service's resource and the data environment connection uses an internal {{ OS }} user and their password. An IAM binding by itself does not authenticate the search query. The user, password, and internal role mappings are verified separately as per the [user management guide](../../../../managed-opensearch/operations/cluster-users.md).

{#profile-mos-roles}

**Roles and scope**

`managed-opensearch.user` is used to work with the cluster; `managed-opensearch.auditor` and `managed-opensearch.viewer` allow reading the available configuration; `managed-opensearch.editor` enables updating the resource; and `managed-opensearch.admin` additionally manages access.

If you opt for a customer {{ kms-short-name }} key when creating or restoring the cluster, the subject performing the operation should also be assigned the `kms.keys.user` role or higher for that specific key according to [this storage guide](../../../../managed-opensearch/concepts/storage.md). The exact operation is checked against the [access model](../../../../managed-opensearch/security/index.md).

These roles do not replace the internal permissions of the index or end user authorization.

{#profile-mos-network}

**Network**

The following are recorded: {{ vpc-short-name }}, subnets, host groups, security groups, FQDNs, and public access flag. The connection uses TLS as per [this guide](../../../../managed-opensearch/operations/connect/index.md); `0.0.0.0/0` shown in this example is not an approved access rule.

{#profile-mos-secrets}

**Secrets and credentials**

The internal user's password is stored in {{ lockbox-short-name }} or another approved storage system and delivered through the runtime profile. The certificate specifies the secret ID and version, user, and consumer, but not the secret value.

{#profile-mos-configuration}

**Configuration objects**

Cluster ID, host groups and node roles, network and security groups, public access flag, FQDNs, internal users and role mappings, indexes, aliases and filtering rules, and, optionally, the {{ kms-short-name }} key as required by the relevant documented [storage encryption mode](../../../../managed-opensearch/concepts/storage.md) (if selected).

{#profile-mos-telemetry}

**Telemetry and blind spots**

Only events from the [{{ at-name }} reference for {{ OS }}](../../../../managed-opensearch/at-ref.md) are used. They can show operations and privilege errors but do not prove that the application ACL is correct or that the end user context is complete.

{#profile-mos-checks}

**Positive and negative checks**

1. Run an allowed search and a search for another user's document.
1. Send a direct request that bypasses the application, attempt to log in with an invalid internal user account, and connect from a denied network.
1. Correlate the application request ID with the relevant service event.

{#profile-mos-inputs}

**What you need for profile implementation**

* Architecture: indexes, ingestion and search environments, and the document ACL location.
* Policy: public access, internal roles, {{ kms-short-name }}, and log retention periods.
* Legal approach: document categories and authorized recipients.
