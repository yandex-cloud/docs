{#ai-supply2-id}

Requirement ID: `AI-SUPPLY2`

{#ai-supply2-applicability}

**Scope**

The requirement applies to the model, weights, tokenizer, or ingestion code received outside the approved internal pipeline.

{#ai-supply2-requirement}

**Requirement**

The model package must be associated with the source you are checking and the checksums. For access to the production network, secrets, and data, the serialization format, accompanying code, custom loader, and dependencies are checked. The first run is made in an isolated environment using `AI-MODEL2`. It is preferred to use a format that does not require you to run random code during the ingestion; however, the format name alone does not guarantee security.

{#ai-supply2-implementation}

**Implementation**

Static file check and dynamic execution answer different questions. The scope of behavioral tests, test inputs, and admissibility criteria are defined by the risk owner. The standard does not imply that the cloud scanner is able to analyze weights or hidden behavior.

{#ai-supply2-check}

**Check**

Map the package against the source and checksums, repeat the ingestion in an isolated environment, and monitor the file, process, and network actions. A mismatch, unexpected execution, or external write attempt will block admission until a separate decision is made. After the check, the initial ingestion environment gets deleted.

{#ai-supply2-artifacts}

**Artifact**

* Package with the source.
* Action monitoring during ingestion.
* Configuration of the initial check environment.
