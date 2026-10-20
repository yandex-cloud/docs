{#ai-audit2-id}

Requirement ID: `AI-AUDIT2`

{#ai-audit2-requirement}

**Requirement**

The logging schema must remove or transform secrets, personal data, full prompts, responses, documents, and dialog history before sending a record to {{ cloud-logging-full-name }} or another destination. Such content can be stored only if backed with a documented purpose, legal basis, retention period, access scope, and deletion method.

A minimum application record contains the request, subject, and resource IDs, model and configuration versions, policy result, invoked tool, and technical outcome. Every system has logging; no `N/A` result is allowed for this requirement.

{{ cloud-logging-name }} accepts application records. Official guides do not mandate any universal removal of secrets or personal data from any application content, so the schema and record editing remain part of the application. Read and write permissions must comply with the [{{ cloud-logging-name }} access model](../../../../logging/security/index.md), and the retention period must align with the approved policy and actual [retention period configuration](../../../../logging/operations/retention-period.md).

{#ai-audit2-check}

**Check**

1. Review a sample of successful, failed, and denied requests.
1. Check that there are no API keys, {{ lockbox-short-name }} values, or unapproved content.
1. For permitted dialog storage, confirm the purpose, period, access, deletion, and connection with the legal approach under [{#T}](../../../../security/standard-ai/compliance-pii.md).
1. Additionally, send synthetic markers for secrets and personal data: events must preserve correlation but not the marker values.
1. Also check log reader bindings.

{#ai-audit2-artifacts}

**Artifact**

* Logging schema.
* Record selection.
* Storage purpose confirmation.
* Test events with synthetic markers.
* Log reader bindings.
