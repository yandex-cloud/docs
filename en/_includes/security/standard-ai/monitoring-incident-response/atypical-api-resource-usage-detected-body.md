{#ai-mon-anomaly2-id}

Requirement ID: `AI-MON-ANOMALY2`

{#ai-mon-anomaly2-requirement}

**Requirement**

The organization must define observable signs of abuse for its scenario: spikes in model or tool calls, unusual spending, repeated policy denials, changes in outbound traffic volume, resource exhaustion, atypical GPU activity, or sudden changes in errors and latency. For each signal, the following are defined: source, observation window, channel, and expected action.

For the agent layer, these are additionally monitored: data extraction and tool decisions, MCP sessions, and tool runtime.

For each rule, the following are recorded: exact metric or event, resource labels, query and threshold, purpose, and owner.

{#ai-mon-anomaly2-implementation}

**Implementation**

{{ monitoring-full-name }} allows you to build queries and alerts based on available metrics; an [alert](../../../../monitoring/concepts/alerting/alert.md) evaluates the condition and sends a notification but does not stop the payload by itself. [{{ billing-name }} budgets](../../../../billing/operations/budgets.md) can supplement cost control but do not show the number and nature of model calls.

{{ ycdr-full-name }} is at the Preview stage; you can access the section in {{ sd-name }} after your request for access is approved. You can use the service as an additional source provided there is access, a separate collector is deployed for the cloud, and the required signal is actually coming in via the documented TLS path. For conditions and architecture, see [this {{ ycdr-name }} guide](../../../../ycdr/concepts/index.md).

The `ycdr.admin` family of service roles is the only documented one for {{ ycdr-name }}; it is not assigned broader than required.

{#ai-mon-anomaly2-check}

**Check**

For each rule, generate a safe test signal and confirm the alert trigger, delivery to the correct channel, and logging of the responsible party's action. Threshold values and frequency are approved by the organization; the standard does not set any universal numbers. The alert must reach the owner together with the resource and correlation IDs. A separate negative test confirms that a missing or disabled alert route is detected.

{#ai-mon-anomaly2-artifacts}

**Artifact**

* Alert configuration.
* Delivery test.
* Logging of the responsible party's action.
* Dashboard and alert IDs.
* Event timeline.
* Response ticket.
