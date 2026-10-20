{#ai-data5-id}

Requirement ID: `AI-DATA5`

{#ai-data5-requirement}

**Requirement**

The organization must define the input versions, metrics, thresholds, and known limits for checking quality, completeness, and acceptable bias for a specific scenario. Training and evaluation samples must be separated so that leakage between them does not compromise check results. For RAG, chunking quality, relevance, metadata completeness, and search reproducibility must be checked. Checks must evaluate completeness, duplicates, schema, distribution, sources, and overlap between the training and evaluation samples.

If synthetic data is used, the report must specify its proportion, retrieval method, and impact on the score. There is no single cloud-wide quality threshold. The product owner must approve the criteria in coordination with the risk officer.

The result must be approved by an independent reviewer, non-affiliated with the data producer. The report must be linked to the exact version of the dataset, model, or index. If there is no managed dataset, the `N/A` result is only acceptable if the model or API selection undergoes independent review.

{#ai-data5-manual-check}

**Manual check**

1. Repeat the approved assessment on a fixed data version and configuration.
1. Make sure there are no matching IDs or other signs of leakage. Also, check the report you saved specifying the initial version, criteria, and result.

Any data batch containing duplicates, corrupted schemas, prohibited data, or overlaps between the training and evaluation samples must block the release. Such batches must be quarantined, the source or transformation fixed, a new report generated, and check repeated.

{#ai-data5-artifacts}

**Artifact**

* Saved report with version, criteria, and result.
* Code version for checks and tests.
* Dataset hashes.
* Independent reviewer.
