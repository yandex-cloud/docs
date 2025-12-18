# How to call cloud functions asynchronously


## Case description {#case-description}

* Implementing an asynchronous call of a cloud function.
* Closing the connection and yielding a response immediately without waiting for the cloud function to complete.
* Keeping a function running for longer than 10 minutes.

## Solution {#case-resolution}

{{ sf-name }} does not support direct asynchronous calls: as long as a {{ serverless-containers-name }} container or cloud function is running, it cannot return an HTTP response. Then, execution stops as soon as the container or function sends a response.

However, you can implement this workflow using {{ api-gw-name }} and {{ yds-name }} as a workaround.

1. Create an {{ api-gw-name }} gateway to act as a webhook handler, and [connect it to a {{ yds-name }} data stream](../../../api-gateway/concepts/extensions/datastreams.md).
1. Configure a [data stream trigger](../../../functions/concepts/trigger/data-streams-trigger.md) that will call your container or cloud function.

In this setup, the {{ api-gw-name }} gateway will immediately return an `HTTP 200 OK` response, while the container or function will process the request asynchronously.

{% note warning %}

Note that code execution inside a {{ serverless-containers-name }} container or cloud function, even when triggered via a stream trigger, cannot exceed 10 minutes. For more information, see [this guide](../../../serverless-containers/concepts/limits.md).

{% endnote %}

If your workload can be split into multiple stages, you can build an asynchronous pipeline, when the first call performs its computation and then triggers the next stage by writing to the same {{ yds-name }} data stream. Keep in mind, however, that subsequent calls may run on different container or function instances.