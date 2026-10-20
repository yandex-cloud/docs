{#ai-net5-id}

Requirement ID: `AI-NET5`

{#ai-net5-requirement}

**Requirement**

For each bucket, database, index, disk, and registry, the owner must record an exact ID, read and modification operations, subjects, network path, encryption mode or a link to `AI-CRYPT1`, and a requirement for public access. By default, model artifacts, training data, RAG documents, and logs must not be publicly accessible. The publication exception must describe a specific object and purpose.

{#ai-net5-implementation}

**Implementation**

For {{ objstorage-name }}, you need to check {{ iam-short-name }}, the ACLs, and the access policy in line with the [service access model](../../../../storage/security/index.md).

You should not consider roles assigned to [{{ mos-name }}](../../../../managed-opensearch/index.yaml) and [{{ ydb-short-name }}](../../../../ydb/index.yaml) for the {{ yandex-cloud }} resource as application authorization; such authorization is designed separately.

For Vector Store, the {{ ai-studio-name }} roles, API key scope, and application authorization are verified; no documented method for disabling the [{{ ai-search-name }}]({{ link-docs-ai }}ai-studio/concepts/search/) public network path is specified, and no private endpoint is assigned to the service.

{#ai-net5-check}

**Check**

1. Check the effective bindings, ACLs, policies, and network accessibility of each storage.
1. Perform a read operation from an authorized test subject and an unauthorized one.

A negative result must apply to the actual application path, not just the management console. The set includes unauthenticated access and access by a subject belonging to another tenant; if broad access is detected, the exposed credentials are replaced.

{#ai-net5-artifacts}

**Artifact**

* Effective bindings.
* ACL.
* Read test from authorized and unauthorized subject.
* Public access and network configuration.
