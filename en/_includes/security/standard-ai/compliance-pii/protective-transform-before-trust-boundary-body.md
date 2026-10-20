{#ai-comply-pii1-id}

Requirement ID: `AI-COMPLY-PII1`

{#ai-comply-pii1-risk}

**Risk**

Transmitting personal data to an LLM or external AI service when such data is not required to perform the task at hand increases the risk of a data breach and non-compliance with data processing requirements.

{#ai-comply-pii1-requirement}

**Requirement**

If the approved solution requires transformation, the organization must perform PII detection and transformation before transferring data to a segment of the model, cloud, or external environment that is not authorized to view the original values.

For each scenario, the following must be defined:

* Data fields and categories subject to discovery and transformation.
* Algorithm, execution point, and policy version.
* Reversibility eligibility.
* Keys, mapping tables, and the detokenization sequence.
* Subjects with the permission to reverse conversion.
* Safe behavior in the event of a converter error or unavailability.

If recovery is not required, methods that are irreversible, or practically irreversible for the given scenario, are employed. If recovery is necessary, pseudonymization or tokenization is allowed, provided that the recovery is performed within the organization's controlled environment.

If the model requires only statistical properties, aggregation or other forms of detail reduction are applied. Hashing is only allowed after assessing the risk of brute-force attacks, matching, and re-identification.

The converter is placed before the first prohibited boundary; minimization is performed first, followed by the selected transformation, and the validator rejects any remaining prohibited fields.

{#ai-comply-pii1-implementation}

**Implementation**

You can use [{{ lockbox-short-name }}](../../../../lockbox/index.yaml) to store secrets and [{{ kms-short-name }}](../../../../kms/operations/index.md) to manage encryption keys; the choice and integration of these tools must align with the approved architecture. {{ kms-short-name }} and {{ dspm-name }} protect keys and mapping tables, but encryption in itself is not anonymization; {{ kms-short-name }}, {{ kms-short-name }}, and guardrails do not constitute a transformation in themselves.

{#ai-comply-pii1-recommendation}

**Recommendation**

Use semantically meaningful tokens, such as `[USER_NAME]`, `[PHONE]`, and `[ORDER_ID]`, provided they preserve the query's meaning and do not reveal the original value.

{#ai-comply-pii1-check}

**Check**

1. Using a synthetic record, trace the source field, transformation result, model request, and logs.
1. Confirm that the initial value does not cross the established confidence limit.
1. Make sure the reverse transformation is only available to an authorized subject and logged without recording the original value.
1. Provide an input containing a prohibited residual field and simulate converter unavailability: a subsequent outbound call must not take place.
1. Verify the absence of initial values ​​outside the boundaries by checking the logs and traces.

{#ai-comply-pii1-artifacts}

**Artifact**

* Transformation policies.
* Gateway or application configuration.
* Registry of tokens and keys without value disclosure.
* Test results.
* Access control model.
* Transformation type and version.
* Confirmation of the absence of data outside the boundaries.
