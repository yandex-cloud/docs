{#ai-rag-ingest1-id}

Requirement ID: `AI-RAG-INGEST1`

{#ai-rag-ingest1-applicability}

**Scope**

This requirement applies if the system creates or updates a RAG corpus or a search index.

{#ai-rag-ingest1-requirement}

**Requirement**

The loader's service identity must read only from approved sources and write only to the designated staging area and the target index. It should not have the permission to modify another production corpus simply because it resides in the same cloud or folder.

The source, version, acceptance check result, loading entity, and publication decision are linked to the update operation. Loading and search identities are separated.

Prior to recording, the loader verifies the source card, type, size, hash, and mandatory tenant and access metadata; an unapproved package is placed in quarantine.

{#ai-rag-ingest1-implementation}

**Implementation**

For [{{ ai-search-name }}]({{ link-docs-ai }}ai-studio/concepts/search/), the source object, file, vector store, and management roles are recorded.

For {{ mos-name }}, {{ ydb-short-name }}, or another storage solution, the specific roles, network boundaries, and configuration objects of the selected service are used.

The architecture can distribute reading from the source, writing to an intermediate area, and publishing across multiple identities.

In {{ ai-search-name }}, an index is created by a documented flow (`{{ ai-studio-name }} → {{ ai-search-name }} → search indexes`); Terraform manages the infrastructure but not corpus admission.

{#ai-rag-ingest1-check}

**Check**

1. Read from the approved source, write to the designated staging area, and publish a test version.
1. Then, verify that reading from an unapproved source and writing to an unauthorized index or area are rejected.
1. Rejection due to a modified hash or an invalid tenant is checked separately, prior to indexing.

The record must link the published version to the source, verification, and change subject. In the event of a failure, the loader pauses, the package is quarantined, the affected index segment is deleted or rebuilt, the compromised identity is replaced, and the test is then repeated.

{#ai-rag-ingest1-artifacts}

**Artifact**

* Successful upload of an approved object.
* Rejection of an unapproved source.
* Loader version.
* Acceptance and rejection events.
* Reindexing record.
