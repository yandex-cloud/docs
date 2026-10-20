{#ai-comply-pii4-id}

Requirement ID: `AI-COMPLY-PII4`

{#ai-comply-pii4-risk}

**Risk**

Inadequate personal data detection tools may leak sensitive data when sending requests to LLMs, or capture such data in indexes, logs, and other storage locations.

{#ai-comply-pii4-requirement}

**Requirement**

The organization must use data discovery tools aligned with the data composition and risk level: rules, regular expressions, dictionaries, NER models, classifiers, DLP/{{ dspm-name }} tools, AI gateways, or special tokenization services.

These discovery tools must support:

* Tracking of false positives and false negatives.
* Rule versioning and controlled configuration modification.
* Test suites featuring multilingual, structured, and nested inputs.
* Monitoring of errors, bypasses, and unknown field types.
* Regular quality checks using representative synthetic or allowed test data.

Misses and false triggers must be evaluated separately by data class, language, format, and path. Policy and legal approach owners must approve the acceptable result; the general threshold is not defined. A critical miss must must trigger a fail-safe state or route the stream to quarantine. If a detector is not declared, this requirement may be considered `N/A`, but the `AI-COMPLY-PII1` and `AI-COMPLY-PII3` requirements remain applicable.

{#ai-comply-pii4-implementation}

**Implementation**

The {{ dspm-name }} module in {{ sd-name }} is designed to discover sensitive information in supported sources. Use its results for data detection and control but do not treat them as a replacement for data transformation inside model queries.

{#ai-comply-pii4-recommendation}

**Recommendation**

Include non-standard wording, transliteration, nested payloads, JSON, CSV, documents, OCR texts, prompt injections, and intentionally corrupted inputs in test suites.

{#ai-comply-pii4-check}

**Check**

1. Run a test suite on synthetic data for all supported personal data categories.
1. Document the precision, recall, or any other quality metric approved for this specific scenario.
1. Make sure that changes to a rule, classifier, or model undergo the change approval procedure.
1. Confirm that an unknown or unrecognized field type does not trigger an uncontrolled transfer of the original value.
1. Known positive and negative examples must be run upon each significant detector change.

{#ai-comply-pii4-artifacts}

**Artifact**

* {{ dspm-name }}, DLP, gateway, and classifier configurations.
* Rule versions.
* Test suites.
* Quality assessment results.
* Requests and change logs.
* Test suite management rules.
* Detector versions.
