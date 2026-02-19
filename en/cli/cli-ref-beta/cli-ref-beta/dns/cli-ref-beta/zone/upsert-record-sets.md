---
editable: false
noIndex: true
---

# yc beta dns zone upsert-record-sets

Method without strict control for changing zone state. Nothing happens if deleted record doesn't exist.
Deletes records that match all specified fields which allows to delete only specified records from a record set.

#### Command Usage

Syntax:

`yc beta dns zone upsert-record-sets <DNS-ZONE-ID>`

#### Flags

#|
||Flag | Description ||
|| `-r`, `--request-file` | `string`

Path to a request file. ||
|| `--example-json` | Generates a JSON template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-json > request.json
2. Edit the template: vim request.json
3. Run with template: yc beta compute instance create -r request.json ||
|| `--example-yaml` | Generates a YAML template of the request.
The template can be customized and used as input for the command.
Usage example:

1. Generate template: yc beta compute instance create --example-yaml > request.yaml
2. Edit the template: vim request.yaml
3. Run with template: yc beta compute instance create -r request.yaml ||
|| `--deletions` | `shorthand/json`

Delete only specified records from corresponding record sets.

Shorthand Syntax:

```hcl
[
  {
    data = string,...,
    description = string,
    name = string,
    ttl = integer,
    type = string
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "data": [
      "string", ...
    ],
    "description": "string",
    "name": "string",
    "ttl": "integer",
    "type": "string"
  }, ...
]
```

Fields:

```
data -> ([]string)
  Data of the record set.
description -> (string)
  Description of the record set.
name -> (string)
  Domain name.
ttl -> (integer)
  Time to live in seconds.
type -> (string)
  Record type.
``` ||
|| `--dns-zone-id` | `string`

ID of the DNS zone to upsert record sets to. To get a DNS zone ID, make a [DnsZoneService.List] request. ||
|| `--merges` | `shorthand/json`

Replace specified records or add new ones if no such record sets exists.

Shorthand Syntax:

```hcl
[
  {
    data = string,...,
    description = string,
    name = string,
    ttl = integer,
    type = string
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "data": [
      "string", ...
    ],
    "description": "string",
    "name": "string",
    "ttl": "integer",
    "type": "string"
  }, ...
]
```

Fields:

```
data -> ([]string)
  Data of the record set.
description -> (string)
  Description of the record set.
name -> (string)
  Domain name.
ttl -> (integer)
  Time to live in seconds.
type -> (string)
  Record type.
``` ||
|| `--replacements` | `shorthand/json`

Entirely replace specified record sets.

Shorthand Syntax:

```hcl
[
  {
    data = string,...,
    description = string,
    name = string,
    ttl = integer,
    type = string
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "data": [
      "string", ...
    ],
    "description": "string",
    "name": "string",
    "ttl": "integer",
    "type": "string"
  }, ...
]
```

Fields:

```
data -> ([]string)
  Data of the record set.
description -> (string)
  Description of the record set.
name -> (string)
  Domain name.
ttl -> (integer)
  Time to live in seconds.
type -> (string)
  Record type.
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