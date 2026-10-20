{#ai-crypt1-id}

Requirement ID: `AI-CRYPT1`

{#ai-crypt1-requirement}

**Requirement**

Data, model artifacts, indexes, disks, and backups must use an encryption mode documented for the selected service for storage and a secure protocol for transmission. If the organization requires its own {{ kms-full-name }} key, it must confirm that the specific resource supports this mode and check permissions for the key, lifecycle, and consequences of blocking or deletion.

{#ai-crypt1-implementation}

**Implementation**

{{ objstorage-name }} supports documented [server encryption](../../../../storage/concepts/encryption.md) modes.

For {{ compute-name }} disks, images, and snapshots, {{ kms-short-name }} encryption is selected during creation and is subject to certain limitations described in the [{{ compute-name }} guides](../../../../compute/concepts/encryption.md).

These properties cannot be automatically applied to {{ ai-search-name }}, {{ OS }}, {{ ydb-short-name }}, or an external service. It is recommended to maintain a matrix in `asset → exact resource → supported mode or {{ kms-short-name }} key → required subject and role → read test` format: for {{ objstorage-name }}, server encryption mode and a custom {{ kms-short-name }} key if needed; for {{ compute-name }}, disk, image, or snapshot key and the `kms.keys.user` permission; for {{ mos-name }}, a custom key under documented preconditions. [{{ lockbox-full-name }}](../../../../lockbox/index.yaml) uses {{ kms-short-name }} inside the service itself.

For {{ ai-search-name }} and Vector store, custom {{ kms-short-name }} key management is not documented and not declared. Encryption does not replace authorization and anonymization.

{#ai-crypt1-check}

**Check**

1. For every storage, record the encryption mode, relevant key, and subjects with a permission to use the key.
1. Read a permitted object using the regular runtime environment and reject reading for a subject without the required permission for the key or object.

The test with the key inactive must be performed only on an isolated non-production resource. The last usable key is neither disabled nor deleted; the keys are updated according to the recovery plan.

{#ai-crypt1-artifacts}

**Artifact**

* Encryption configuration.
* Permitted read and unauthorized access denial.
* Key ID and bindings.
* Recovery rehearsal.
