{#ai-content1-id}

Requirement ID: `AI-CONTENT1`

{#ai-content1-applicability}

**Scope**

This requirement applies if an approved product, corporate, contractual, or legal policy prohibits individual content categories or if the architecture declares guardrails to be the protective measure. The `N/A` result is acceptable for a specific route only if the approved content policy does not require guardrails for that route.

{#ai-content1-requirement}

**Requirement**

The owner must document the rule version subject to verification: input and output content categories, covered interfaces, action for each category, and behavior if the moderator commits an error or is unavailable. Actions may include blocking, restricting the response, forwarding for a manual review, or another approved reaction. An undefined moderator error must not quietly turn into a permission where the policy requires blocking.

{#ai-content1-implementation}

**Implementation**

In {{ ai-studio-name }}, guardrails can only be used within the published Preview function. A rule, dictionary, or classifier and theirs version are configuration objects; edits can be made by a subject with the documented `ai.guardrails.editor` role.

When blocked, the response has the `incomplete` status with `content_filter` for reason; however, these indicators do not replace application-level error handling. Guardrails do not decide whether data is legally admissible and do not replace the schema, {{ iam-short-name }}, personal data protection, document-level authorization, or agent action verification. For more information, see this [guardrail description]({{ link-docs-ai }}ai-studio/concepts/security/guardrails.html).

One guardrail is attached to a model instance; a custom guardrail overrides the system one, thus changing the effective category coverage. Management is effected via the management console (`{{ ai-studio-name }} → Management → Security → Guardrails`); the software management interfaces are not documented, so an exported versioned configuration and manual evidence are required. Guardrails are not a WAF.

{#ai-content1-check}

**Check**

1. For each approved category, perform allow test and deny test on each covered path. The request and response are checked separately. Request blocking is confirmed by not calling the model; and response blocking, by not displaying the result.
1. Separately simulate the moderator committing an error or being unavailable.
1. Record the rule version, observed action (`incomplete` status with `content_filter` as reason), [{{ at-full-name }}](../../../../audit-trails/index.yaml) management event pertaining to guardrail setup, and application record; a separate guardrail trigger event in {{ at-name }} is not documented and, if necessary, gets recorded as a blind spot.

A bypass via an uncovered interface or allowing where rejection is required means failure to comply. In the event of a false negative, change the category, threshold, or dictionary, wait for it to apply, and repeat the documented set of tests.

{#ai-content1-artifacts}

**Artifact**

* Rule version and exported configuration.
* Model instance and guardrail IDs.
* Blocking test.
* Management event or application record.
