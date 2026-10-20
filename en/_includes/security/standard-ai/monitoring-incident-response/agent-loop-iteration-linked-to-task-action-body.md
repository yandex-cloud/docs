{#ai-mon-trace2-id}

Requirement ID: `AI-MON-TRACE2`

{#ai-mon-trace2-applicability}

**Scope**

This requirement applies if the system runs a multi-step agent loop.

{#ai-mon-trace2-requirement}

**Requirement**

For each iteration, the system must save the task and session IDs, step number, selected tool, parameters provided after editing, permission check, result or error code, and the decision to continue, stop, or request confirmation. If the orchestrator creates a plan or subgoal, the system must record their IDs and versions. The standard does not require storing the model’s hidden reasoning.

If using MCP, the `mcp_call`, `mcp_approval_request` and `mcp_approval_response` Responses items must be linked to the `mcp_hub.StartMcpSession`, `mcp_hub.ListMcpTools` and `mcp_hub.InvokeMcpTool` {{ at-name }} events and to the corresponding target system event. None of these records independently prove a side effect in the target system, and the {{ at-name }} reference contains no dedicated confirmation event.

If metrics are available, you can also record the time and resource usage for a step. Such a record must be linked to `AI-MON-TRACE1` but must not contain secrets, full regulated data, or unapproved content.

{#ai-mon-trace2-check}

**Check**

1. Run a multi-step workflow that includes one successful and one rejected tool call.
1. Use the unified task ID to restore the sequence of actions, current plan version, if any, authorization decision, error, and the stop condition.

You fail the compliance check if there is no iteration or the effect is not confirmed in the target system.

{#ai-mon-trace2-artifacts}

**Artifact**

* Trace of a multi-step workflow with a successful and rejected call.
* Task state machine version.
* Confirmation record.
* Target system event.
