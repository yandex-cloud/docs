{#ai-model1-id}

Requirement ID: `AI-MODEL1`

{#ai-model1-requirement}

**Requirement**

For a self-hosted or third-party model, the owner must record its source, version, checksum, licensing and operational limitations, weight format, tokenizer, configuration, ingestion code, dependent software components, related data versions, approval status, and check results.

For a managed API, the model vendor, API, ID, or version as well as available parameters affecting its behavior are recorded instead of unavailable weights.

The record must uniquely identify the package that has passed the check and is now used in the release. Approved artifacts are copied to a controlled storage; in a production environment, direct ingestion based on a dynamic external URL is not permitted because the production environment only ingests an exact digest.

{{ objstorage-name }} can store the package files, [{{ container-registry-full-name }}](../../../../container-registry/index.yaml) can store Docker images, and {{ ml-platform-name }} can store documented resource types, including models, Docker images, and file storages. The organization must link together the actual objects and versions in a separate provenance record no matter where they are stored. See the description of resource boundaries in the [{{ container-registry-name }}](../../../../container-registry/index.yaml) and [{{ ml-platform-name }}](../../../../datasphere/concepts/resources.md) guides.

{#ai-model1-manual-check}

**Manual check**

1. Find out the model package of the running instance and compare it with the admission record.
1. Recalculate the digest of deployed files and images and compare it against the record. A modified artifact or unknown source would block admission be quarantined.

A mismatch of weight, configuration, loader, or dependency requires a new check.

{#ai-model1-artifacts}

**Artifact**

* Provenance record.
* Mapping to a running instance.
* Model card.
* Hashes and versions of objects in storage.
