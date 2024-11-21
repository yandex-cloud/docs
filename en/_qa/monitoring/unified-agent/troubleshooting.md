# {{ unified-agent-full-name }} possible errors

This section describes typical problems that may arise when using {{ unified-agent-short-name }} and the relevant solutions.

If you encounter any errors, make sure you have the latest {{ unified-agent-short-name }} version installed. To install the latest agent version, follow [this guide](../../../monitoring/concepts/data-collection/unified-agent/installation.md#setup).

{{ unified-agent-short-name }} errors related to data retrieval and transmission fall under two categories:

* `ERROR agent/[plugin_id]...`: Errors when retrieving metrics from the data source app. `plugin_id`: ID of the [plugin](../../../monitoring/concepts/data-collection/unified-agent/inputs.md) the agent uses to retrieve data.

* `ERROR agent/output-yc_metrics...`: Errors when sending metrics to {{ monitoring-name }}.

#### Message size [value] is greater than inflight limit [value], message dropped {#message-size-error}

The incoming message size exceeds the `inflight.limit` configured in the `flow_control` session buffer [settings](../../../monitoring/concepts/data-collection/unified-agent/services.md#flow_control). This error often occurs in `gRPC input`. 

Try increasing the `flow_control.inflight.limit` value.

If the error persists, contact [support]({{ link-console-support }}).

#### Timed out while bytes receiving {#time-out-error}

The data transfer has timed out.

Make sure your network connection is stable and try again.

If the error persists, contact [support]({{ link-console-support }}).

#### 500 Internal server error {#internal-error}

The server got an internal error preventing proper processing of the request. Try again.

If the error persists, contact [support]({{ link-console-support }}).

#### SSL library returned error {#ssl-error}

Wrong [TLS certificate](../../../certificate-manager/concepts/index.md) or error establishing a secure connection. Try again.

If the error persists, contact [support]({{ link-console-support }}).