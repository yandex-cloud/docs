{#ai-data7-id}

Requirement ID: `AI-DATA7`

{#ai-data7-applicability}

**Scope**

This requirement applies if synthetic data is used for training, fine-tuning, or evaluation.

{#ai-data7-requirement}

**Requirement**

For the synthetic portion of the dataset, the following must be registered: generation model or method, generator version and parameters, purpose, source data, share of synthetic records, and known limitations. Synthetic records go through the same admission and quality assurance stages as other data; their provenance must not be mixed with observed data.

Each synthetic record or batch gets the `synthetic=true` label; unprocessed generated data is not included into training or evaluation unless explicitly approved. The final batch receives a separate ID and dataset hash.

{#ai-data7-implementation}

**Implementation**

When generated via {{ ai-studio-name }} or {{ ml-platform-name }}, the record contains the available IDs of the model, API, project, or task. {{ yandex-cloud }} does not maintain a universal registry of synthetic data for the organization.

{#ai-data7-check}

**Check**

1. Trace the synthetic sample version back to the generator, source data, and parameters.
1. Check that the report shows its share and separately evaluates the required properties versus a non-synthetic control sample.

A generated test case without a label must be rejected at ingestion.

{#ai-data7-artifacts}

**Artifact**

* Synthetic portion record.
* Share and control sample report.
* Generator version.
* Unlabeled data rejection test result.
