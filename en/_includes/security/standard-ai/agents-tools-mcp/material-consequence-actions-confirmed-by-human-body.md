{#ai-agent-hitl1-id}

Requirement ID: `AI-AGENT-HITL1`

{#ai-agent-hitl1-requirement}

**Requirement**

The organization must define actions that require approval by an authorized person, such as irreversible deletion, access changes, publication, payments, or sensitive data transmission. Prior to approval, the interface must display the purpose, object, critical parameters, and impact. Post-approval changes of parameters invalidate the approval.

The approval is single-use and tied to the exact action, resource, parameter hash, requesting subject and session, expiration time, and risk summary. Whenever possible, the approver should not have execution credentials. Reused approval, expired approval, and self-approval must be rejected.

{#ai-agent-hitl1-implementation}

**Implementation**

Approval cannot replace {{ iam-short-name }} or application-layer authorization. For low-risk or fully reversible actions, the organization may choose to automate execution and document this decision.

{#ai-agent-hitl1-check}

**Check**

Initiate a high-impact test action, change one parameter after approval, and repeat the request. The action without a valid approval must be rejected, and the trace must capture the subject and parameter version.

{#ai-agent-hitl1-artifacts}

**Artifact**

* Unconfirmed action test.
* Post-confirmation parameter change.
* Confirmation ID and hash.
* Target system event.
