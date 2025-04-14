# Possible errors {{ unified-agent-full-name }}

This section describes typical problems occurring when using {{ unified-agent-short-name }} and their solutions.

In case of an error, make sure you have the latest {{ unified-agent-short-name }} version installed. To install the latest agent version, follow [this guide](../../../monitoring/concepts/data-collection/unified-agent/installation.md#setup).

{{ unified-agent-short-name }} data retrieval and transmission errors fall under two categories:

* `ERROR agent/[plugin_id]...`: Errors that occur when retrieving metrics from the data source app. `plugin_id`: ID of the agent’s data retrieval [plugin](../../../monitoring/concepts/data-collection/unified-agent/inputs.md).

* `ERROR agent/output-yc_metrics...`: Errors that occur when sending metrics to {{ monitoring-name }}.

#### Message size [value] is greater than inflight limit [value], message dropped {#message-size-error}

The incoming message size exceeds the `inflight.limit` configured in the `flow_control` session buffer [settings](../../../monitoring/concepts/data-collection/unified-agent/services.md#flow_control). This error often occurs in `gRPC input`. 

Try increasing the `flow_control.inflight.limit` value.

If the error persists, contact [support]({{ link-console-support }}).

#### Timed out while bytes receiving {#time-out-error}

The data transfer has timed out.

Make sure your network connection is stable and try again.

If the error persists, contact [support]({{ link-console-support }}).

#### 500 Internal server error {#internal-error}

An internal server error occured, preventing request processing. Try again.

If the error persists, contact [support]({{ link-console-support }}).

#### SSL library returned error {#ssl-error}

Wrong [TLS certificate](../../../certificate-manager/concepts/index.md) or error when establishing a secure connection. Try again.

If the error persists, contact [support]({{ link-console-support }}).