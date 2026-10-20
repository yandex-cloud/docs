{#ai-rel2-id}

Requirement ID: `AI-REL2`

{#ai-rel2-requirement}

**Requirement**

The model, index, and associated configuration must each have defined compatibility requirements, phased replacement sequence, rollback criteria, previous safe compatible set, and method for revoking an unsafe version. A rollback must not reintroduce a known vulnerability, prohibited data, or a revoked secret. Revocation must cover every production endpoint, alias, direct reference, and workaround that could have been used to select the version.

{#ai-rel2-implementation}

**Implementation**

Service-specific tools are used only within their documented scope: {{ serverless-containers-name }} revisions and deployment and rollback events from the [{{ at-name }} reference](../../../../serverless-containers/at-ref.md), [{{ objstorage-name }} object versions](../../../../storage/operations/buckets/versioning.md), or the application's own versioning scheme. The availability of object history does not guarantee a functional rollback of the entire AI system.

The rollback target is defined per environment: for serverless environments, it is the previous verified revision or version; for {{ k8s }}, the previous image and configuration; for {{ compute-name }}, the image, disk, and configuration recovery plan; for RAG, the previous corpus or index manifest, or a rebuild procedure; for {{ ai-studio-name }}, the previous instance, guardrail, and index configurations.

Before release, backward compatibility of the data and index is verified. A reference to a previous version without a specific ID and verified compatibility is not considered a rollback plan.

{#ai-rel2-check}

**Check**

In the test environment, perform the replacement and rollback of the related package.

1. Check that the active version can be identified, the log associates the initiator with the change, and the revoked version cannot be selected through the standard process.
1. The rollback rehearsal includes switching to the previous target, functional and security checks; reverting to the new version can only be performed after approval.

A rollback is not considered valid if it exposes data from a newer state.

{#ai-rel2-artifacts}

**Artifact**

* Replacement and rollback test.
* Initiator log.
* Revoked version unavailability.
* Rollback target IDs.
* Return approval.
