{#ai-supply1-id}

Requirement ID: `AI-SUPPLY1`

{#ai-supply1-applicability}

**Scope**

This requirement applies to a dataset or RAG corpus from an external author, provider, or public source.

{#ai-supply1-requirement}

**Requirement**

The source, author, or provider, date of receipt, version, terms of use, and checksum of the received object must be recorded before use. If the author publishes a signature or checksum through an independent trusted channel, it must be verified before unpacking and transformation. If independent verification is unavailable, a self-generated checksum must not be used as a substitute; source risk and the decision to accept the object must be recorded separately.

The provider record additionally contains contact details and the exact version of the accepted internal object; an isolated identity is used for downloading and importing through the preparation path. The production system only uses the accepted internal copy, not an externally hosted mutable URL.

{#ai-supply1-implementation}

**Implementation**

The received object first goes to an acceptance area that is inaccessible to production training and search. After verification, the object's immutable ID gets associated with the `AI-DATA1` record.

{#ai-supply1-check}

**Check**

Retrieve or select the saved source object again, calculate its checksum, and compare it with the acceptance record and, if available, the author's publication. A modified object or an object without the required approval must not proceed to the next stage. A checksum mismatch sends the batch to quarantine; if the check fails, derived objects, such as the index or model, are isolated as well.

{#ai-supply1-artifacts}

**Artifact**

* Acceptance record.
* Repeated retrieval and checksum comparison.
* Source and internal hashes.
* Quarantine test.
