# Handler script for Bash function calls

A _request handler script_ is called to handle each invocation of a function in Bash. When creating a function version, you must specify the entry point, i.e., the extension file name, e.g., `handler.sh`.

The runtime delivers the request body in [JSON](../../concepts/function-invoke.md#request) format to the script via `stdin`.

The script stores service information in these environment variables:

* `REQUEST_ID`: Request ID.
* `FUNCTION_NAME`: Function ID.
* `FUNCTION_VERSION`: Function version ID.

After processing, the function returns the `stdout` contents in [JSON](../../concepts/function-invoke.md#response) format.

## Examples {#examples}

The following function outputs the request structure and environment variables to both the [execution log](logging.md) and function response:

```shell script
#!/bin/bash
set -e

RESPONSE=$(cat | jq -sc '.[0] // {}' | jq -c '{statusCode:200, body:{env:env, request:.}}')
echo $RESPONSE >&2
echo $RESPONSE | jq -c '.body |= tostring' # make sure 'body' is a string, not a json node
```
