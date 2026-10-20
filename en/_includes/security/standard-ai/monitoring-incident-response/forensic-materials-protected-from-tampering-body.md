{#ai-forensic3-id}

Requirement ID: `AI-FORENSIC3`

{#ai-forensic3-requirement}

**Requirement**

Logs and exports used in forensic investigation must be kept separately from the reviewed system's active administrators. Write, read, and delete permissions must be separated; the time, source, and integrity of the record must be verified. The retention period must be as per the approved policy and legal requirements.

{#ai-forensic3-implementation}

**Implementation**

For a secure {{ at-name }} destination, you can use [audit log](../../../../security/standard/audit-logs.md) based recommendations.

In {{ objstorage-name }}, versioning and [Object Lock](../../../../storage/concepts/object-lock.md) can support immutability if configured correctly, but indefinite lock hold and retention period require separate management.

Write and read identities are separated; the hash manifest and export refer to the exact object version. Object Lock gets enabled only after storage is approved: data protected by it may become undeletable.

{#ai-forensic3-check}

**Check**

Select a saved incident, verify the chain from the original record to the archive, effective permissions, and the ability to detect modification. The application's active administrator must not single-handedly modify or delete the only copy. An allowed attempt to modify or delete a protected synthetic object must behave as per the lock mode; the restored version is verified by hash.

{#ai-forensic3-artifacts}

**Artifact**

* Log permissions.
* Only copy modification test.
* Bucket, policy, ACL, versioning, lock, and encryption configuration.
* Object version and hash.
