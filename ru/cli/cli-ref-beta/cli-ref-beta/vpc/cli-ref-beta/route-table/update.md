---
editable: false
noIndex: true
---

# yc beta vpc route-table update

Updates the specified route table.
Method starts an asynchronous operation that can be cancelled while it is in progress.

#### Command Usage

Syntax:

`yc beta vpc route-table update <ROUTE-TABLE-ID>`

#### Flags

#|
||Flag | Description ||
|| `--description` | `string`

Description of the route table. ||
|| `--labels` | `map<string><string>`

Resource labels as '' key:value '' pairs. ||
|| `--name` | `string`

Name of the route table. The name must be unique within the folder. ||
|| `--route-table-id` | `string`

ID of the RouteTable resource to update. ||
|| `--static-routes` | `shorthand/json`

List of static routes.

Shorthand Syntax:

```hcl
[
  {
    destination = destination-prefix=string,
    labels = {key=string, key=...},
    next-hop = gateway-id=string | next-hop-address=string
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "destination": {
      "destination-prefix": "string"
    },
    "labels": {
      "<key>": "string", ...
    },
    "next-hop": {
      "gateway-id": "string",
      "next-hop-address": "string"
    }
  }, ...
]
```

Fields:

```
labels -> (map[string,string])
  Resource labels as '' key:value '' pairs. Maximum of 64 per resource.
destination -> (oneof<destination-prefix>)
  Oneof destination field
  destination-prefix -> (string)
    Destination subnet in CIDR notation
next-hop -> (oneof<gateway-id|next-hop-address>)
  Oneof next-hop field
  next-hop-address -> (string)
    Next hop IP address
  gateway-id -> (string)
    Next hop gateway id
``` ||
|| `--async` | Display information about the operation in progress, without waiting for the operation to complete. ||
|#

#### Global Flags

#|
||Flag | Description ||
|| `--profile` | `string`

Set the custom profile. ||
|| `--region` | `string`

Set the region. ||
|| `--debug` | Debug logging. ||
|| `--debug-grpc` | Debug gRPC logging. Very verbose, used for debugging connection problems. ||
|| `--no-user-output` | Disable printing user intended output to stderr. ||
|| `--pager` | `string`

Set the custom pager. ||
|| `--format` | `string`

Set the output format: text, yaml, json, table, summary \|\| summary[name, instance.id, instance.disks[0].size]. ||
|| `--retry` | `int`

Enable gRPC retries. By default, retries are enabled with maximum 5 attempts.
Pass 0 to disable retries. Pass any negative value for infinite retries.
Even infinite retries are capped with 2 minutes timeout. ||
|| `--timeout` | `string`

Set the timeout. ||
|| `--token` | `string`

Set the IAM token to use. ||
|| `--impersonate-service-account-id` | `string`

Set the ID of the service account to impersonate. ||
|| `--no-browser` | Disable opening browser for authentication. ||
|| `--query` | `string`

Query to select values from the response using jq syntax ||
|| `-h`, `--help` | Display help for the command. ||
|#