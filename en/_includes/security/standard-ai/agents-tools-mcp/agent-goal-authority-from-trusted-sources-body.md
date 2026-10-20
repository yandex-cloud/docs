{#ai-agent-goal1-id}

Requirement ID: `AI-AGENT-GOAL1`

{#ai-agent-goal1-requirement}

**Requirement**

The task objective, system policy, and allowed set of actions must come from a trusted configuration or a verified application solution. A user message, RAG chunk, tool response, or another agent's response must not expand authority, change the data owner, or lift a limitation. The objective is formed as a typed object from an authenticated server source; the initiator, objective and policy versions, and allowed capabilities are preserved.

The application must separate facts, suggestions, and control instructions. The change of the trusted objective is logged as a configuration change, not as a regular continuation of the dialog. Any change to the objective goes through a new authorization and confirmation and creates a new version.

{#ai-agent-goal1-check}

**Check**

Provide three synthetic instructions via the user, RAG, and tool to expand the objective or disable control. The agent can use the data as context but must not gain a new privilege. There must be no new action in the target system. Upon failure, the session is stopped, the affected delegation is revoked, the parsing or trust labels are corrected, and the test is repeated.

{#ai-agent-goal1-artifacts}

**Artifact**

* Test of target expansion via user, RAG, or tool.
* Target version and delegation.
* Confirmation that there is no call for the target system.
