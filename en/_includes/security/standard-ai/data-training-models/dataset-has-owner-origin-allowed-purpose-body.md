{#ai-data1-id}

Requirement ID: `AI-DATA1`

{#ai-data1-requirement}

**Requirement**

Before ingestion or use, the system owner must register the dataset or RAG corpus: source, owner, lifecycle stage, sensitivity category, purpose, version, transformations, use limitations, permitted recipients, and communication with the system, model, index, or release. For an external source, the receipt and acceptance conditions must be additionally recorded. Synthetic data is marked separately as per `AI-DATA7`.

The record is created before the set is ingested; if the set is changed, a new record version is formed. If the system uses only the managed model API and does not maintain its own sets, permitted data categories and the evaluation set are recorded anyway.

{#ai-data1-implementation}

**Implementation**

{{ yandex-cloud }} provides storages and access control tools but does not form the registry of origin and permitted use for the organization. {{ ml-platform-name }} delimits access to communities and projects; a published [{{ ml-platform-name }} access model](../../../../datasphere/security/index.md) does not replace the record of origin for a specific set. The record is associated with the exact object version in the actual storage: [{{ objstorage-name }} object version](../../../../storage/concepts/versioning.md), Vector Store ID or index ID, location in [{{ mos-full-name }}](../../../../managed-opensearch/index.yaml) or [{{ ydb-full-name }}](../../../../ydb/index.yaml), or a [{{ ml-platform-name }}](../../../../datasphere/index.yaml) set.

{#ai-data1-manual-check}

**Manual check**

1. Select at least one internal, one external, and one synthetic set, if used.
1. Trace the process from a registry record to the actual object and version.
1. Additionally, select sample objects from the expanded corpus and trace each one up to the record; an object without a record gets rejected during ingestion or release, quarantined, and gets an owner, source, and classification, or gets deleted according to storage rules.

An unaccounted or unauthorized source must not end up in a training, evaluation, or index.

{#ai-data1-artifacts}

**Artifact**

* Registry record.
* Tracing up to object and version.
* Card version.
* Object version or hash.
* Approver.
