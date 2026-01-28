---
editable: false
sourcePath: en/_cli-ref/cli-ref/application-load-balancer/cli-ref/load-balancer/index.md
---

# yc application-load-balancer load-balancer

Manage application load balancer

#### Command Usage

Syntax:

`yc application-load-balancer load-balancer <command>`

Aliases:

- `lb`

#### Command Tree

- [yc application-load-balancer load-balancer add-listener](add-listener.md) — Adds a listener to the specified application load balancer.

- [yc application-load-balancer load-balancer add-location](add-location.md) — Adds locations to application load balancer.

- [yc application-load-balancer load-balancer add-sni](add-sni.md) — Adds HTTP sni match to application load balancer's listener.

- [yc application-load-balancer load-balancer add-stream-listener](add-stream-listener.md) — Adds a Stream listener to the specified application load balancer.

- [yc application-load-balancer load-balancer add-stream-sni](add-stream-sni.md) — Adds Stream sni match to application load balancer's listener.

- [yc application-load-balancer load-balancer autoscale](autoscale.md) — Modify scaling settings of the application load balancer.

- [yc application-load-balancer load-balancer cancel-zonal-shift](cancel-zonal-shift.md) — Cancel zonal shift the specified load balancer

- [yc application-load-balancer load-balancer create](create.md) — Create an application load balancer

- [yc application-load-balancer load-balancer delete](delete.md) — Delete the specified application load balancer

- [yc application-load-balancer load-balancer disable-traffic](disable-traffic.md) — Disables traffic in specified zones for application load balancer.

- [yc application-load-balancer load-balancer disable-zones](disable-zones.md) — Disable traffic routing in zones for the specified load balancer

- [yc application-load-balancer load-balancer enable-traffic](enable-traffic.md) — Enables traffic in specified zones for application load balancer.

- [yc application-load-balancer load-balancer enable-zones](enable-zones.md) — Enable traffic routing in zones for the specified load balancer

- [yc application-load-balancer load-balancer get](get.md) — Show information about the specified load balancer

- [yc application-load-balancer load-balancer list](list.md) — List application load balancers

- [yc application-load-balancer load-balancer list-operations](list-operations.md) — List operations for the specified application load balancer

- [yc application-load-balancer load-balancer logging](logging.md) — Manage cloud logging settings of the load balancer.

- [yc application-load-balancer load-balancer remove-listener](remove-listener.md) — Removes the listener from the specified application load balancer.

- [yc application-load-balancer load-balancer remove-location](remove-location.md) — Removes locations from application load balancer.

- [yc application-load-balancer load-balancer remove-sni](remove-sni.md) — Removes sni match from application load balancer's listener.

- [yc application-load-balancer load-balancer start](start.md) — Start the specified application load balancer

- [yc application-load-balancer load-balancer start-zonal-shift](start-zonal-shift.md) — Start zonal shift the specified load balancer

- [yc application-load-balancer load-balancer stop](stop.md) — Stop the specified application load balancer

- [yc application-load-balancer load-balancer target-states](target-states.md) — Shows states of targets in the target group and backend group for application load balancer.

- [yc application-load-balancer load-balancer update](update.md) — Update the specified application load balancer

- [yc application-load-balancer load-balancer update-listener](update-listener.md) — Updates http listener in the specified application load balancer.

- [yc application-load-balancer load-balancer update-sni](update-sni.md) — Updates HTTP sni match of the application load balancer's listener.

- [yc application-load-balancer load-balancer update-stream-listener](update-stream-listener.md) — Updates Stream listener in the specified application load balancer.

- [yc application-load-balancer load-balancer update-stream-sni](update-stream-sni.md) — Updates Stream sni match of the application load balancer's listener.

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom configuration file. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--cloud-id` | `string`

Set the ID of the cloud to use. ||
|| `--folder-id` | `string`

Set the ID of the folder to use. ||
|| `--folder-name` | `string`

Set the name of the folder to use (will be resolved to id). ||
|| `--endpoint` | `string`

Set the Cloud API endpoint (host:port). ||
|| `--token` | `string`

Set the OAuth token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--format` | `string`

Set the output format: text (default), yaml, json, json-rest. ||
|| `--jq` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#