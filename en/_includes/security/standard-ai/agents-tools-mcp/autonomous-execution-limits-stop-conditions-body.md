{#ai-agent2-id}

Requirement ID: `AI-AGENT2`

{#ai-agent2-requirement}

**Requirement**

The organization must assign a scenario owner and set limits on the number of steps, execution time, cost, concurrency, retries, and stop conditions. For each limit, you must specify its enforcement point and the safe state to fall back to if the counter fails or a dependent service becomes unavailable.

The agent must stop the loop in the event of a recurring error, lack of progress, policy violation, limit exhaustion, or task revocation.

It is the orchestrator that enforces counters outside the model; documented MCP tool limits must not serve as security controls. There must be a server-side stop state that, once set, prevents any further actions in the target system.

{#ai-agent2-implementation}

**Implementation**

The limit values depend on the risk and cost of the scenario and must be approved by the owner. [{{ monitoring-short-name }} alerts](../../../../monitoring/concepts/alerting/alert.md) and [{{ billing-name }} budgets](../../../../billing/operations/budgets.md) may detect some of the consequences, but alerting is not a substitute for limits and stop controls enforced within the orchestrator or runtime.

{#ai-agent2-check}

**Check**

Create a test with a looping tool response, recurring error, and exhaustion of one of the limits. The agent must stop execution within the specified boundary and take no further external actions. The reason for termination must be recorded, and the log or trace must show no subsequent calls to the target system.

{#ai-agent2-artifacts}

**Artifact**

* Cyclic response, recurring error, and limit exhaustion test.
* Policy version and counter configuration.
* Final reason for stopping.
