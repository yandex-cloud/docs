{#ai-mon-trace1-id}

Requirement ID: `AI-MON-TRACE1`

{#ai-mon-trace1-requirement}

**Requirement**

The application must assign a correlation ID to the request. A general record contains a timestamp, a subject's verified identity or anonymized ID, a calling component's operational identity, a target resource or endpoint, model and configuration versions, RAG source IDs, input and output policy results, a technical outcome, an error code, and a duration.

For the agent, the following are additionally recorded: step, selected tool, authorization check, request for human confirmation, and backend result.

Platform request IDs are mapped to the application ID in the correlation card and are not considered identical to it.

Full prompts, responses, dialogs, and the model's hidden reasoning do not constitute a mandatory minimum and should not be collected solely for the sake of compliance. If the cloud service does not publish the required data-level event, the application must generate a record itself. {{ sf-name }} and {{ serverless-containers-name }} transmit request logs and `stdout`/`stderr` to {{ cloud-logging-name }} within the documented model: [{{ sf-name }} logs](../../../../functions/concepts/logs.md), [{{ serverless-containers-name }} logs](../../../../serverless-containers/concepts/logs.md).

{#ai-mon-trace1-check}

**Check**

Run a request that includes RAG and a test tool call, and reconstruct the path from input to result. The trace must show policy decisions and technical outcomes, but must not contain secrets or unapproved data. Individual negative test: a missing or incorrectly matched ID causes the coverage check to fail.

{#ai-mon-trace1-artifacts}

**Artifact**

* End-to-end trace from input to result.
* No secrets.
* Mapping of platform and application IDs.
