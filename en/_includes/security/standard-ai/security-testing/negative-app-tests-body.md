A negative test specifically checks the stated limit. A set is selected based on applicable requirements and the profile, rather than being considered a universal program. This includes:

* API call without a role, with an unsuitable key scope, or from a different subject.
* Permitted and prohibited moderation categories and moderator error regarding `AI-CONTENT1`.
* Reading of an approved and external source by the loader, writing to an intermediate scope and to a third-party index via `AI-RAG-INGEST1`.
* Comparison of direct, group, and inherited permissions with the date and event of the unscheduled review via `AI-IAM5`.
* Accessing the target service bypassing {{ api-gw-name }} or the MCP Gateway.
* Network connection from a forbidden namespace or runtime environment.
* RAG search for a document from a different access area.
* Receiving a set with incorrect metadata, size, type, or sensitive field, and its transfer to quarantine or manual review via `AI-DATA-CHECK1`.
* Model output containing a prohibited command or object.
* Attempt to alter the agent's target via a RAG fragment or a tool result.
* Impersonation of a user, tenant, resource, or revoked session in agent delegation via `AI-IAM-COMPROMISE1`.
* Repetition of an inter-agent message, unknown schema version, or infinite loop.
* Successful and erroneous protective transformation, bypass attempt, and separation of duties via `AI-COMPLY-PII3`.
* Transferring an extra field to an external recipient.
* Reading a revoked secret considering the documented cache.
* Closing the old endpoint, key, and direct path after decommissioning, without deleting shared resources.

The test is performed using synthetic data and reversible actions. Without a dedicated written permission, you may not delete a production resource or key, read data belonging to another actual tenant, publish an external action, generate a load or financial spike, or test for failure by crashing a shared service.

If a safe negative test in the production environment is not feasible, it is conducted in an equivalent environment, and configuration alignment is verified separately. Lack of authorization for an active test does not equate to a successful result; instead, the untested part is recorded.
