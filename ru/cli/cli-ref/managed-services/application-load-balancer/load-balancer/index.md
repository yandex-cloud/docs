---
sourcePath: en/_cli-ref/cli-ref/managed-services/application-load-balancer/load-balancer/index.md
---
# yc application-load-balancer load-balancer

Manage application load balancer

#### Command Usage

Syntax: 

`yc application-load-balancer load-balancer <command>`

Aliases: 

- `lb`

#### Command Tree

- [yc application-load-balancer load-balancer get](get.md) — Show information about the specified load balancer
- [yc application-load-balancer load-balancer list](list.md) — List application load balancers
- [yc application-load-balancer load-balancer create](create.md) — Create an application load balancer
- [yc application-load-balancer load-balancer update](update.md) — Update the specified application load balancer
- [yc application-load-balancer load-balancer start](start.md) — Start the specified application load balancer
- [yc application-load-balancer load-balancer stop](stop.md) — Stop the specified application load balancer
- [yc application-load-balancer load-balancer delete](delete.md) — Delete the specified application load balancer
- [yc application-load-balancer load-balancer add-listener](add-listener.md) — Adds a listener to the specified application load balancer.
- [yc application-load-balancer load-balancer add-stream-listener](add-stream-listener.md) — Adds a Stream listener to the specified application load balancer.
- [yc application-load-balancer load-balancer update-listener](update-listener.md) — Updates http listener in the specified application load balancer.
- [yc application-load-balancer load-balancer update-stream-listener](update-stream-listener.md) — Updates Stream listener in the specified application load balancer.
- [yc application-load-balancer load-balancer remove-listener](remove-listener.md) — Removes the listener from the specified application load balancer.
- [yc application-load-balancer load-balancer remove-sni](remove-sni.md) — Removes sni match from application load balancer's listener.
- [yc application-load-balancer load-balancer add-sni](add-sni.md) — Adds HTTP sni match to application load balancer's listener.
- [yc application-load-balancer load-balancer add-stream-sni](add-stream-sni.md) — Adds Stream sni match to application load balancer's listener.
- [yc application-load-balancer load-balancer update-sni](update-sni.md) — Updates HTTP sni match of the application load balancer's listener.
- [yc application-load-balancer load-balancer update-stream-sni](update-stream-sni.md) — Updates Stream sni match of the application load balancer's listener.
- [yc application-load-balancer load-balancer list-operations](list-operations.md) — List operations for the specified application load balancer
- [yc application-load-balancer load-balancer disable-traffic](disable-traffic.md) — Disables traffic in specified zones for application load balancer.
- [yc application-load-balancer load-balancer enable-traffic](enable-traffic.md) — Enables traffic in specified zones for application load balancer.
- [yc application-load-balancer load-balancer add-location](add-location.md) — Adds locations to application load balancer.
- [yc application-load-balancer load-balancer remove-location](remove-location.md) — Removes locations from application load balancer.
- [yc application-load-balancer load-balancer target-states](target-states.md) — Shows states of targets in the target group and backend group for application load balancer.

#### Global Flags

| Flag | Description |
|----|----|
|`--profile`|<b>`string`</b><br/>Set the custom configuration file.|
|`--debug`|Debug logging.|
|`--debug-grpc`|Debug gRPC logging. Very verbose, used for debugging connection problems.|
|`--no-user-output`|Disable printing user intended output to stderr.|
|`--retry`|<b>`int`</b><br/>Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.<br/>Pass 0 to disable retries. Pass any negative value for infinite retries.<br/>Even infinite retries are capped with 2 minutes timeout.|
|`--cloud-id`|<b>`string`</b><br/>Set the ID of the cloud to use.|
|`--folder-id`|<b>`string`</b><br/>Set the ID of the folder to use.|
|`--folder-name`|<b>`string`</b><br/>Set the name of the folder to use (will be resolved to id).|
|`--endpoint`|<b>`string`</b><br/>Set the Cloud API endpoint (host:port).|
|`--token`|<b>`string`</b><br/>Set the OAuth token to use.|
|`--format`|<b>`string`</b><br/>Set the output format: text (default), yaml, json, json-rest.|
|`-h`,`--help`|Display help for the command.|
