Container invocation ends in one of the following cases:

* {{ serverless-containers-name }} processed an HTTP request within the specified timeout and returned an HTTP response consistent with the [container operation mode](../../serverless-containers/concepts/container.md#runtime). The timeout includes the container instance launch time.
* {{ serverless-containers-name }} failed to process an HTTP request within the specified timeout and returned a 504 error.
* There is an infrastructure or initialization error with details provided in the response body.
