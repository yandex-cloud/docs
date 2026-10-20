{#ai-comply2-id}

Requirement ID: `AI-COMPLY2`

{#ai-comply2-risk}

**Risk**

Hosting personal data or any other regulated data in components that fail to meet the localization, region, protection, or retention requirements, creates a risk of unauthorized processing and unaccounted data copies.

{#ai-comply2-requirement}

**Requirement**

The organization must create and maintain an up-to-date lifecycle map for regulated data within the AI workflow: ingestion, transfer, storage, backup, caching, logging, indexing, vectorization, inference, training, fine-tuning, maintenance, and deletion.

For each component processing regulated data, explicitly define:

* Permissible use and data category.
* Cloud, folder, region, availability zone, or external location.
* Resource owner and data owner.
* Backup retention period and methods for storage, deletion, destruction, and control.
* Applicable protection measures.
* Incoming and outgoing data flows, including external endpoints.

Inventory must track each copy of data, including exports. Approved services and regions must be enforced proactively via the resource creation and release policy.

{#ai-comply2-implementation}

**Implementation**

A {{ yandex-cloud }} region is a geographical area that groups availability zones. It has its own structure and services. Selecting a region does not prove legal compliance and does not describe data transfer to external systems. You cannot assume where data is processed by simply looking at resource folder. If using an external provider, you must obtain their official written records of processing locations.

{#ai-comply2-recommendation}

**Recommendation**

Ensure that the component registry encompasses, at minimum: [{{ objstorage-name }}](../../../../storage/index.yaml), [{{ mpg-full-name }}](../../../../managed-postgresql/index.yaml), or any other databases, VM disks, queues, caches, [{{ cloud-logging-name }}](../../../../logging/index.yaml), [{{ at-name }}](../../../../audit-trails/index.yaml), RAG indexes, vector databases, observability tools, administrator workstations, and external AI APIs.

{#ai-comply2-check}

**Check**

1. Trace a synthetic regulated object from the ingestion point to all its copies and recipients.
1. For each cloud resource, cross-reference its region and actual location against the approved decision.
1. Check backups, logs, indexes, caches, and work data for unaccounted copies.
1. Any unaccounted copy, external route, or region change must block modification deployment until the approval is renewed.
1. In case of a negative test, deployment or export to a prohibited branch must be blocked.

{#ai-comply2-artifacts}

**Artifact**

* Data flow map.
* Component registry.
* {{ yandex-cloud }} resource inventory.
* Region and folder configuration.
* Retention polices.
* Deletion evidence.
* Architecture review results.
* Resource exports.
* Migration or deletion record.
