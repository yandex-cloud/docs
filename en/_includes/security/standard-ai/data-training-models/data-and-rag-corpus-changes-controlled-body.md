{#ai-data6-id}

Requirement ID: `AI-DATA6`

{#ai-data6-requirement}

**Requirement**

Source, intermediate, and published versions must have verifiable IDs or checksums. For every process, the system must record the owner, change creator, code or configuration version, performed checks, decision to publish, and rollback procedure to restore the previous secure version. Ingestion, cleansing, chunking, indexing, and publication must be handled by a trusted identity through a repeatable workflow. An non-verified object must not become available to the production system.

The acceptance check must align with the source risk level and, prior to publication, detect unsupported formats, corrupted structure, unexpected executable content, and categories prohibited by the organization. Model traffic moderation does not replace a full review of the dataset.

{#ai-data6-implementation}

**Implementation**

In {{ objstorage-name }}, you can enable [versioning](../../../../storage/operations/buckets/versioning.md) to track object history, and, to enforce immutability, use [object locks](../../../../storage/concepts/object-lock.md) considering their rules and timelines.

In {{ ai-search-name }}, uploading files and creating a vector store is part of the documented [indexing process]({{ link-docs-ai }}ai-studio/concepts/search/index.html). The application must separately implement document authorization and content admission.

A manifest maps a logical release to the exact IDs and hashes of objects, files, and indexes. Each change creates a new version and enforces a new approval; the only copy is never overwritten. The object lock is enabled only after the retention period is approved: locked versions may become undeletable. For storages without versioning, an immutable release copy and change record are saved.

{#ai-data6-check}

**Check**

1. Trace a published version from the source object to down to the index or dataset.
1. Attempt to bypass a check and publish a modified object.
1. As a separate step, use a synthetic object to check that a new version is created while you retain access to the previous version and can use it for recovery.

The requirement is met if the bypass attempt is rejected, and the saved data allow you to identify the active version and change initiator.

{#ai-data6-artifacts}

**Artifact**

* Version-to-source mapping.
* Check bypass test.
* Release manifest with hashes.
* Change event.
* Recovery test.
