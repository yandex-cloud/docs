{#ai-data4-id}

Requirement ID: `AI-DATA4`

{#ai-data4-requirement}

**Requirement**

For each field or object type, the data owner must define a sensitivity category, allowed recipients, and an allowed action: retain, delete, aggregate, mask, or tokenize. Fields, records, attachments, and secrets that are irrelevant for the stated scenario must be removed before transmission.

If using reversible transformation, its execution location, acceptable reversibility, and subjects with access to the key or mapping table must be defined.

Fields are mapped based on the destination: prompt, RAG context, tool data, external call, and log event; data must be deleted or transformed before crossing the boundary, not after delivery to the provider or model.

{#ai-data4-implementation}

**Implementation**

[{{ dspm-full-name }}](../../../../security-deck/concepts/dspm.md) ({{ dspm-name }}) can be used to search for specific data categories in supported sources. It does not transform the source data or establish the lawful basis for processing.

For info on the source scope, service account with the `dspm.worker` role, and extra permissions for {{ kms-short-name }}-encrypted buckets, see the [{{ dspm-name }} guide on creating a scan](../../../../security-deck/operations/dspm/create-scan). Discoveries from {{ dspm-name }} or NER are not transformations: the detected candidate must confirmed by a human reviewer or application logic.

{#ai-data4-check}

**Check**

1. Take a sample from the actual input dataset post-transformation and check it against the approved schema.
1. Try to upload prohibited fields or object.

A detection report alone, without source remediation, does not confirm minimization. Any additional sensitive field must be blocked or modified before the call and must not appear in logs. If the test fails, the affected flow must be stopped, and all cached, indexed, and logged copies must be deleted according to applicable retention policies and legal requirements. After that, the test is must be repeated.

{#ai-data4-artifacts}

**Artifact**

* Field schema.
* Post-transformation selection.
* Rejection of prohibited fields.
* Field mapping by destination.
* Record of copy deletion.
