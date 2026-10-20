{#ai-comply1-id}

Requirement ID: `AI-COMPLY1`

{#ai-comply1-risk}

**Risk**

Running AI scenarios without established legal, organizational, and technical requirements for personal data or other regulated data processing may lead to regulatory violations, breaches of contractual obligations, or internal policy non-compliance.

{#ai-comply1-requirement}

**Requirement**

Prior to feeding regulated data into a model, RAG database, vector index, log, backup, external API, or any other component, the authorized party must define, document, and agree upon the following:

* Goal, lawful basis, and allowed processing operations.
* Categories of subjects, data categories, and minimum required fields.
* Roles of the organization, {{ yandex-cloud }}, external providers, operators, and other recipients.
* Allowed processing and storage locations, localization rules, and cross-border transfer requirements.
* Data processing delegation terms, applicable contractual obligations, and subcontractor involvement.
* Time frames for storing, deleting, destroying, archiving, and backing up data.
* Requirements for data protection and logging, incident response, and fulfilling data subjects’ rights.
* Features of data used for training, fine-tuning, assessing, and using a model as well as building a RAG database.

This baseline must be linked to a versioned processing card detailing the goal, data classes, source, operations, exact {{ yandex-cloud }} resources and region, model and provider, recipients, storage details, technical measures, and the approving authority. This card must map to data flows defined under `AI-SDLC1`. For a production processing scenario, the `N/A` result is prohibited.

{#ai-comply1-implementation}

**Implementation**

As a data controller hosting personal data in {{ yandex-cloud }}, the customer delegates data processing to the provider under the applicable agreement terms. Information on the {{ yandex-cloud }} measures and certifications is available in its [compliance documents](../../../../security/conform.md); however, this does not replace the assessment of the customer’s specific system. The configuration of {{ yandex-cloud }} services does not translate into a legal approach. Configuration proves that controls are in place but does not establish the lawful basis.

{#ai-comply1-recommendation}

**Recommendation**

Conduct privacy and compliance assessments prior to connecting a model, external API, or RAG system. These assessments must also be performed prior to model training or fine-tuning, and ahead of any major updates to the data, recipients, region, endpoint, or architecture.

{#ai-comply1-manual-check}

**Manual check**

1. Map the approved baseline to the actual fields, subjects, models, logs, indexes, and recipients.
1. Verify that each type of regulated data, each scenario, and each recipient is covered by the baseline.
1. Do not allow the processing of undocumented data types or transfers to unauthorized recipients prior to revising and approving the baseline.
1. Select an actual resource, log, or request field and trace it to the approved processing card. An expired baseline means failure.

{#ai-comply1-artifacts}

**Artifact**

* Approved legal and compliance approach.
* AI scenario registry.
* Data flow diagram.
* Architecture description.
* List of processors and recipients.
* Agreement references.
* Baseline revision records.
* IDs of data flows and resources.
* Examples of traces without real personal data.
