{#ai-data-check1-id}

Requirement ID: `AI-DATA-CHECK1`

{#ai-data-check1-applicability}

**Scope**

The requirement applies to any external, custom, or otherwise untrusted dataset prior to training, fine-tuning, evaluation, or publication in a RAG system.

{#ai-data-check1-requirement}

**Requirement**

For a specific data type, the owner must define automated and manual checks: expected size and number of objects, field formats and types, mandatory metadata, sensitive data categories, structural anomalies, duplicates and outliers, source consistency, control and hidden characters, unexpected executable objects, and signs of injected instructions. The verification result is linked to the precise ID or checksum of the input version and the versions of the applied validators.

For a multi-modal set, hidden content is additionally checked if the selected analyzer is capable of detecting it; lack of this capability is flagged as a blind spot rather than a successful check.

{#ai-data-check1-implementation}

**Implementation**

An object containing a parsing error, an unknown type, or a prohibited field, or exceeding an approved threshold, is not automatically published. It is rejected or quarantined, with the reason, owner, and manual review decision recorded. The statistical anomaly threshold and manual sampling amount are defined by a specific scenario's policy. [{{ dspm-name }}](../../../../security-deck/concepts/dspm.md) can scan supported storage but does not transform data or prove its absence; guardrails do not scan the corpus outside the request flow.

{#ai-data-check1-check}

**Check**

1. Submit a valid set and a synthetic set containing an incorrect amount, missing metadata, an incompatible type, sensitive field, control or hidden character, and a corrupted object.
1. Verify the link between the report and the specific input version, automated resolution, reason entry, quarantine status, and manual resolution where applicable.

No rejected item should appear in the published version. Lack of the rejected object is also confirmed in the index; in the event of a failure, the derived indexes are rebuilt.

{#ai-data-check1-artifacts}

**Artifact**

* Test error set.
* Link between the report and the input version.
* Validator versions.
* Confirmation of the object's absence from the index.
