# Handler script for Bash function request

A _request handler_ is a script that runs to handle each Bash function call. When creating a function version, you should specify the entry point: the name of a file with an extension (for example, `handler.sh`).

With the `stdin` standard input stream, the body of a request in [JSON](../../concepts/function-invoke.md#request) format.

The service information is specified in the script using environment variables:

* `REQUEST_ID`: ID of the request being handled.
* `FUNCTION_NAME`: Function ID.
* `FUNCTION_VERSION`: Function version ID.

When handled, the function returns the contents of the `stdout` standard output stream in [JSON](../../concepts/function-invoke.md#response) format.

## Examples {#examples}

The following function outputs the request structure and environment variables to both the [execution log](logging.md) and function response:

```shell script
#!/bin/bash
set -e

RESPONSE=$(cat | jq -sc '.[0] // {}' | jq -c '{statusCode:200, body:{env:env, request:.}}')
echo $RESPONSE >&2
echo $RESPONSE | jq -c '.body |= tostring' # make sure 'body' is a string, not a json node
```
