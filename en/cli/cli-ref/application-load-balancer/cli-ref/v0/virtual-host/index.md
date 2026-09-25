---
editable: false
canonical: https://yandex.cloud/en/docs/cli/cli-ref/application-load-balancer/cli-ref/v0/virtual-host/
---

# yc application-load-balancer v0 virtual-host

Manage http router virtual host

#### Command Usage

Syntax:

`yc application-load-balancer v0 virtual-host <command>`

Aliases:

- `vh`

#### Command Tree

- [yc application-load-balancer v0 virtual-host append-grpc-route](append-grpc-route.md) — Appends grpc route to the specified virtual host of the http router

- [yc application-load-balancer v0 virtual-host append-http-route](append-http-route.md) — Appends http route to the specified virtual host of the http router

- [yc application-load-balancer v0 virtual-host create](create.md) — Create an virtual host for the http router

- [yc application-load-balancer v0 virtual-host delete](delete.md) — Delete the specified virtual host of the http router

- [yc application-load-balancer v0 virtual-host get](get.md) — Show information about the specified virtual host

- [yc application-load-balancer v0 virtual-host insert-grpc-route](insert-grpc-route.md) — Inserts gRPC route into the specified virtual host of the HTTP router

- [yc application-load-balancer v0 virtual-host insert-http-route](insert-http-route.md) — Inserts HTTP route into the specified virtual host of the HTTP router

- [yc application-load-balancer v0 virtual-host list](list.md) — List http router virtual hosts

- [yc application-load-balancer v0 virtual-host prepend-grpc-route](prepend-grpc-route.md) — Prepends grpc route to the specified virtual host of the http router

- [yc application-load-balancer v0 virtual-host prepend-http-route](prepend-http-route.md) — Prepends http route to the specified virtual host of the http router

- [yc application-load-balancer v0 virtual-host remove-grpc-route](remove-grpc-route.md) — Removes grpc route from the specified virtual host of the http router

- [yc application-load-balancer v0 virtual-host remove-http-route](remove-http-route.md) — Removes http route from the specified virtual host of the http router

- [yc application-load-balancer v0 virtual-host update](update.md) — Update the specified virtual host

- [yc application-load-balancer v0 virtual-host update-grpc-route](update-grpc-route.md) — Updates grpc route in the specified virtual host of the http router

- [yc application-load-balancer v0 virtual-host update-http-route](update-http-route.md) — Updates http route in the specified virtual host of the http router

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--no-pager` | Do not pipe help output through a pager. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `--print-metadata` | Print operation metadata along with result. ||
|| `--syntax` | `string`

Choose syntax option. ||
|| `--cli-auto-prompt` | `string[="on"]`

Enable interactive auto-prompt mode. Values: on, partial, off. Bare --cli-auto-prompt is equivalent to --cli-auto-prompt=on. ||
|| `--no-cli-auto-prompt` | Disable interactive auto-prompt mode (overrides --cli-auto-prompt, env and profile). ||
|| `-h`, `--help` | Display help for the command. ||
|#