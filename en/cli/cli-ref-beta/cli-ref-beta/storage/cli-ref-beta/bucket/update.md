---
editable: false
noIndex: true
---

# yc beta storage bucket update

Updates the specified bucket.
In most cases, `storage.editor` role (see [documentation](/docs/storage/security/#storage-editor)) should be enough
to update a bucket, subject to its [policy](/docs/storage/concepts/policy).

#### Command Usage

Syntax:

`yc beta storage bucket update`

#### Flags

#|
||Flag | Description ||
|| `--acl` | `shorthand/json`

Access control list (ACL) of the bucket. For details, see documentation.

Shorthand Syntax:

```hcl
{
  grants = [
    {
      grant-type = GRANT_TYPE_ACCOUNT|GRANT_TYPE_ALL_AUTHENTICATED_USERS|GRANT_TYPE_ALL_USERS,
      grantee-id = string,
      permission = PERMISSION_FULL_CONTROL|PERMISSION_WRITE|PERMISSION_WRITE_ACP|PERMISSION_READ|PERMISSION_READ_ACP
    }, ...
  ]
}
```

JSON Syntax:

```json
{
  "grants": [
    {
      "grant-type": "GRANT_TYPE_ACCOUNT|GRANT_TYPE_ALL_AUTHENTICATED_USERS|GRANT_TYPE_ALL_USERS",
      "grantee-id": "string",
      "permission": "PERMISSION_FULL_CONTROL|PERMISSION_WRITE|PERMISSION_WRITE_ACP|PERMISSION_READ|PERMISSION_READ_ACP"
    }, ...
  ]
}
```

Fields:

```
grants -> ([]struct)
  List of permissions granted and the grantees.
  grant-type -> (struct)
    The grantee type for the grant.
  grantee-id -> (string)
    ID of the account who is a grantee. Required when the [grant_type] is 'GRANT_TYPE_ACCOUNT'.
  permission -> (struct)
    Permission granted by the grant.
``` ||
|| `--allowed-private-endpoints` | `shorthand/json`

requires permission s3:PutBucketAllowedPrivateEndpoints

Shorthand Syntax:

```hcl
{
  enabled = boolean,
  force-cloud-console-access = boolean,
  private-endpoints = string,...
}
```

JSON Syntax:

```json
{
  "enabled": "boolean",
  "force-cloud-console-access": "boolean",
  "private-endpoints": [
    "string", ...
  ]
}
```

Fields:

```
enabled -> (boolean)
  if true, private endpoints white list check is enabled even if private_endpoints list is empty
force-cloud-console-access -> (boolean)
  if true, cloud console will be able to access a bucket regardless of private_endpoints list
private-endpoints -> ([]string)
  white list of private endpoints bucket accessible from
``` ||
|| `--anonymous-access-flags` | `shorthand/json`

Flags for configuring public (anonymous) access to the bucket's content and settings. For details, see documentation.

Shorthand Syntax:

```hcl
{
  config-read = boolean,
  list = boolean,
  read = boolean
}
```

JSON Syntax:

```json
{
  "config-read": "boolean",
  "list": "boolean",
  "read": "boolean"
}
```

Fields:

```
config-read -> (boolean)
  Specifies whether public (anonymous) access to read documentation, documentation, and documentation settings of the bucket is enabled.
list -> (boolean)
  Specifies whether public (anonymous) access to the list of objects in the bucket is enabled.
read -> (boolean)
  Specifies whether public (anonymous) access to read objects in the bucket is enabled.
``` ||
|| `--cors` | `shorthand/json`

List of rules for cross-domain requests to objects in the bucket (cross-origin resource sharing, CORS). For details, see documentation.

Shorthand Syntax:

```hcl
[
  {
    allowed-headers = string,...,
    allowed-methods = [
      METHOD_GET|METHOD_HEAD|METHOD_POST|METHOD_PUT|METHOD_DELETE, ...
    ],
    allowed-origins = string,...,
    expose-headers = string,...,
    id = string,
    max-age-seconds = integer
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "allowed-headers": [
      "string", ...
    ],
    "allowed-methods": [
      "METHOD_GET|METHOD_HEAD|METHOD_POST|METHOD_PUT|METHOD_DELETE", ...
    ],
    "allowed-origins": [
      "string", ...
    ],
    "expose-headers": [
      "string", ...
    ],
    "id": "string",
    "max-age-seconds": "integer"
  }, ...
]
```

Fields:

```
allowed-headers -> ([]string)
  List of HTTP headers allowed by the CORS rule. When a client sends a CORS-preflight 'options' request with the 'Access-Control-Request-Headers' header (see documentation), the specified headers are checked against the list of the allowed headers. If there is a match, the specified headers that are allowed are listed in the 'Access-Control-Allow-Headers' header of the response. Each string in the list can contain at most one '*' wildcard character that matches 0 or more characters. For example, 'x-amz-*' value will allow all Amazon S3-compatible headers.
allowed-methods -> ([]struct)
  List of HTTP methods allowed by the CORS rule. When a client sends a CORS-preflight 'options' request with the 'Access-Control-Request-Method' header (see documentation), the specified method is checked against the list of the allowed methods. If there is a match, all the allowed methods are listed in the 'Access-Control-Allow-Methods' header of the response.
allowed-origins -> ([]string)
  List of request origins allowed by the CORS rule. Each string in the list can contain at most one '*' wildcard character that matches 0 or more characters. For example, 'http://*.example.com' value will allow requests originating from all subdomains of 'example.com'.
expose-headers -> ([]string)
  List of headers contained in responses to CORS requests that can be accessed by applications.
id -> (string)
  ID of the CORS rule.
max-age-seconds -> (integer)
  Time in seconds that a client can cache the response to a CORS-preflight request as identified by the object requested, the HTTP method, and the origin.
``` ||
|| `--default-storage-class` | `string`

Default storage class for objects in the bucket. Supported classes are standard storage ('STANDARD'), cold storage ('COLD', 'STANDARD_IA', 'NEARLINE' all synonyms), and ice storage ('ICE' and 'GLACIER' are synonyms). For details, see documentation. ||
|| `--disabled-statickey-auth` | An option to disable static key auth for a bucket. requires permission s3:UpdateBucketStaticKeyAuthSettings ||
|| `--encryption` | `shorthand/json`

Configuration for bucket's encryption. For details, see documentation

Shorthand Syntax:

```hcl
{
  rules = [
    {
      kms-master-key-id = string,
      sse-algorithm = string
    }, ...
  ]
}
```

JSON Syntax:

```json
{
  "rules": [
    {
      "kms-master-key-id": "string",
      "sse-algorithm": "string"
    }, ...
  ]
}
```

Fields:

```
rules -> ([]struct)
  Rules
  kms-master-key-id -> (string)
    KMS master key ID
  sse-algorithm -> (string)
    SSE algorithm
``` ||
|| `--lifecycle-rules` | `shorthand/json`

List of object lifecycle rules for the bucket. For details, see documentation.

Shorthand Syntax:

```hcl
[
  {
    abort-incomplete-multipart-upload = {
      days-after-expiration = integer
    },
    enabled = boolean,
    expiration = {
      date = timestamp,
      days = integer,
      expired-object-delete-marker = boolean
    },
    filter = {
      and-operator = {
        object-size-greater-than = integer,
        object-size-less-than = integer,
        prefix = string,
        tag = [
          {
            key = string,
            value = string
          }, ...
        ]
      },
      object-size-greater-than = integer,
      object-size-less-than = integer,
      prefix = string,
      tag = {
        key = string,
        value = string
      }
    },
    id = string,
    noncurrent-delete-markers = {
      noncurrent-days = integer
    },
    noncurrent-expiration = {
      noncurrent-days = integer
    },
    noncurrent-transitions = [
      {
        noncurrent-days = integer,
        storage-class = string
      }, ...
    ],
    transitions = [
      {
        date = timestamp,
        days = integer,
        storage-class = string
      }, ...
    ]
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "abort-incomplete-multipart-upload": {
      "days-after-expiration": "integer"
    },
    "enabled": "boolean",
    "expiration": {
      "date": "timestamp",
      "days": "integer",
      "expired-object-delete-marker": "boolean"
    },
    "filter": {
      "and-operator": {
        "object-size-greater-than": "integer",
        "object-size-less-than": "integer",
        "prefix": "string",
        "tag": [
          {
            "key": "string",
            "value": "string"
          }, ...
        ]
      },
      "object-size-greater-than": "integer",
      "object-size-less-than": "integer",
      "prefix": "string",
      "tag": {
        "key": "string",
        "value": "string"
      }
    },
    "id": "string",
    "noncurrent-delete-markers": {
      "noncurrent-days": "integer"
    },
    "noncurrent-expiration": {
      "noncurrent-days": "integer"
    },
    "noncurrent-transitions": [
      {
        "noncurrent-days": "integer",
        "storage-class": "string"
      }, ...
    ],
    "transitions": [
      {
        "date": "timestamp",
        "days": "integer",
        "storage-class": "string"
      }, ...
    ]
  }, ...
]
```

Fields:

```
abort-incomplete-multipart-upload -> (struct)
  Configuration for aborting incomplete documentation.
  days-after-expiration -> (integer)
    Time period, in number of days from the start of the multipart upload, after which the incomplete upload is aborted.
enabled -> (boolean)
  Indicates whether the rule is in effect.
expiration -> (struct)
  Expiration rule. The expiration of an object is described as follows. For the unversioned bucket ([Bucket.versioning] is 'VERSIONING_DISABLED'), the object is deleted and cannot be recovered. For the bucket with versioning enabled ([Bucket.versioning] is 'VERSIONING_ENABLED'), the current version of the object (if it exists and is not a delete marker) is retained as a non-current version, and a delete marker becomes the current version of the object. For the bucket with versioning suspended ([Bucket.versioning] is 'VERSIONING_SUSPENDED'), the current version of the object is retained as a non-current version if it is not a delete marker, or is removed otherwise, and a delete marker becomes the current version of the object.
  date -> (timestamp)
    Specific date of object expiration. The rule continues to apply even after the date has passed, i.e. any new objects created in the bucket expire immediately. Exactly one of [date], [days], and [expired_object_delete_marker] fields can be specified.
  days -> (integer)
    Time period, in number of days from the creation or modification of the object, after which an object expires. Exactly one of [days], [date], and [expired_object_delete_marker] fields can be specified.
  expired-object-delete-marker -> (boolean)
    Indicates whether a delete marker of an object with no non-current versions (referred to as an expired object delete marker) is removed at the object's expiration. Exactly one of [expired_object_delete_marker], [date], and [days] fields can be specified.
filter -> (struct)
  Filter that identifies the objects to which the rule applies. If not specified, the rule applies to all objects in the bucket.
  and-operator -> (struct)
    Apply a logical AND to all of the predicates configured inside the And operator.
    object-size-greater-than -> (integer)
      Size that the object must be greater.
    object-size-less-than -> (integer)
      Size that the object must be less than.
    prefix -> (string)
      Key prefix that the object must have in order for the rule to apply.
    tag -> ([]struct)
      Tags that the object's tag set must have for the rule to apply.
      key -> (string)
        Key of the bucket tag.
      value -> (string)
        Value of the bucket tag.
  object-size-greater-than -> (integer)
    Size that the object must be greater.
  object-size-less-than -> (integer)
    Size that the object must be less t.
  prefix -> (string)
    Key prefix that the object must have in order for the rule to apply.
  tag -> (struct)
    Tags that the object's tag set must have for the rule to apply.
    key -> (string)
      Key of the bucket tag.
    value -> (string)
      Value of the bucket tag.
id -> (string)
  ID of the rule. Provided by the client or generated at creation time.
noncurrent-delete-markers -> (struct)
  Expiration rule for non-current delete markers of an objects in a bucket with versioning enabled ([Bucket.versioning] is 'VERSIONING_ENABLED') or suspended ('VERSIONING_SUSPENDED'). Works in the same way as noncurrent_expiration rule, but only for delete markers. At expiration, the non-current delete marker of the object is deleted and cannot be recovered.
  noncurrent-days -> (integer)
    Time period, in number of days since the version of a delete marker was classified as non-current, after which the delete marker expires.
noncurrent-expiration -> (struct)
  Expiration rule for non-current versions of objects in a bucket with versioning enabled ([Bucket.versioning] is 'VERSIONING_ENABLED') or suspended ('VERSIONING_SUSPENDED'). At expiration, the non-current version of the object is deleted and cannot be recovered.
  noncurrent-days -> (integer)
    Time period, in number of days since the version of an object was classified as non-current, after which the version expires.
noncurrent-transitions -> ([]struct)
  List of transition rules for non-current versions of objects in a bucket with versioning enabled ([Bucket.versioning] is 'VERSIONING_ENABLED') or suspended ('VERSIONING_SUSPENDED'). At transition, the non-current version of the object is transitioned to the specified storage class.
  noncurrent-days -> (integer)
    Time period, in number of days since the version of an object was classified as non-current, after which the version is transitioned.
  storage-class -> (string)
    Storage class to which a non-current version of an object is transitioned from standard storage. The only supported class is cold storage ('COLD', 'STANDARD_IA', 'NEARLINE' all synonyms). Transitions from cold to standard storage and transitions to or from ice storage are not allowed.
transitions -> ([]struct)
  List of transition rules. The transition of an object is described as follows. For the unversioned bucket ([Bucket.versioning] is 'VERSIONING_DISABLED'), the object is transitioned to the specified storage class. For the bucket with versioning enabled ([Bucket.versioning] is 'VERSIONING_ENABLED') or suspended ('VERSIONING_SUSPENDED'), the current version of the object is transitioned to the specified storage class.
  date -> (timestamp)
    Specific date of object transition. The rule continues to apply even after the date has passed, i.e. any new objects created in the bucket are transitioned immediately. At most one of [date] and [days] fields can be specified.
  days -> (integer)
    Time period, in number of days from the creation or modification of the object, after which an object is transitioned. At most one of [days] and [date] fields can be specified.
  storage-class -> (string)
    Storage class to which an object is transitioned from standard storage. The only supported class is cold storage ('COLD', 'STANDARD_IA', 'NEARLINE' all synonyms). Transitions from cold to standard storage and transitions to or from ice storage are not allowed.
``` ||
|| `--max-size` | `int`

Maximum size of the bucket, in bytes. For details, see documentation. ||
|| `--name` | `string`

Name of the bucket to update. The name cannot be updated. To get the bucket name, make a [BucketService.List] request. ||
|| `--object-lock` | `shorthand/json`

Configuration for object lock on the bucket. For details about the concept, see documentation.

Shorthand Syntax:

```hcl
{
  default-retention = {
    mode = MODE_GOVERNANCE|MODE_COMPLIANCE,
    period = days=integer | years=integer
  },
  status = OBJECT_LOCK_STATUS_DISABLED|OBJECT_LOCK_STATUS_ENABLED
}
```

JSON Syntax:

```json
{
  "default-retention": {
    "mode": "MODE_GOVERNANCE|MODE_COMPLIANCE",
    "period": {
      "days": "integer",
      "years": "integer"
    }
  },
  "status": "OBJECT_LOCK_STATUS_DISABLED|OBJECT_LOCK_STATUS_ENABLED"
}
```

Fields:

```
default-retention -> (struct)
  Default retention
  mode -> (struct)
    Mode
  period -> (oneof<days|years>)
    Oneof period field
    days -> (integer)
      Number of days for locking
    years -> (integer)
      Number of years for locking
status -> (struct)
  Status
``` ||
|| `--policy` | `shorthand/json`

Bucket policies that set permissions for actions with the bucket, its objects, and groups of objects. For details, see documentation.

Shorthand Syntax:

```hcl
{}
```

JSON Syntax:

```json
{}
``` ||
|| `--tags` | `shorthand/json`

List of tags for the bucket. For details, see documentation.

Shorthand Syntax:

```hcl
[
  {
    key = string,
    value = string
  }, ...
]
```

JSON Syntax:

```json
[
  {
    "key": "string",
    "value": "string"
  }, ...
]
```

Fields:

```
key -> (string)
  Key of the bucket tag.
value -> (string)
  Value of the bucket tag.
``` ||
|| `--versioning` | `enum`

Bucket versioning status. For details, see documentation. Possible Values: 'versioning-disabled', 'versioning-enabled', 'versioning-suspended' ||
|| `--website-settings` | `shorthand/json`

Configuration for hosting a static website in the bucket. For details, see documentation.

Shorthand Syntax:

```hcl
{
  error = string,
  index = string,
  redirect-all-requests = {
    hostname = string,
    protocol = PROTOCOL_HTTP|PROTOCOL_HTTPS
  },
  routing-rules = [
    {
      condition = {
        http-error-code-returned-equals = string,
        key-prefix-equals = string
      },
      redirect = {
        hostname = string,
        http-redirect-code = string,
        protocol = PROTOCOL_HTTP|PROTOCOL_HTTPS,
        replace-key-prefix-with = string,
        replace-key-with = string
      }
    }, ...
  ]
}
```

JSON Syntax:

```json
{
  "error": "string",
  "index": "string",
  "redirect-all-requests": {
    "hostname": "string",
    "protocol": "PROTOCOL_HTTP|PROTOCOL_HTTPS"
  },
  "routing-rules": [
    {
      "condition": {
        "http-error-code-returned-equals": "string",
        "key-prefix-equals": "string"
      },
      "redirect": {
        "hostname": "string",
        "http-redirect-code": "string",
        "protocol": "PROTOCOL_HTTP|PROTOCOL_HTTPS",
        "replace-key-prefix-with": "string",
        "replace-key-with": "string"
      }
    }, ...
  ]
}
```

Fields:

```
error -> (string)
  Key of the error page object that is returned when an error occurs.
index -> (string)
  Key of the index page object that is returned when a response is made to the root of the website. Either [index] or [redirect_all_requests] must be specified in order for the bucket to host a static website. If specified, the index page object must be located in the root of the bucket.
redirect-all-requests -> (struct)
  Configuration for redirecting all requests sent to the website. Either [redirect_all_requests] or [index] must be specified in order for the bucket to host a static website. If [redirect_all_requests] is specified, it must be the only field in [Bucket.website_settings].
  hostname -> (string)
    Hostname of the redirect URI.
  protocol -> (struct)
    Scheme of the redirect URI.
routing-rules -> ([]struct)
  List of redirect rules.
  condition -> (struct)
    Redirect condition.
    http-error-code-returned-equals -> (string)
      HTTP status code (number only) that must match for the redirect to apply.
    key-prefix-equals -> (string)
      Prefix of the object key from which requests are redirected.
  redirect -> (struct)
    Redirect instructions.
    hostname -> (string)
      Hostname of the redirect URI.
    http-redirect-code -> (string)
      HTTP status code of the redirect response. Default value: '"301"'.
    protocol -> (struct)
      Scheme of the redirect URI.
    replace-key-prefix-with -> (string)
      Substitution for the prefix of the object key specified in [Condition.key_prefix_equals]. At most one of [replace_key_prefix_with] and [replace_key_with] can be specified.
    replace-key-with -> (string)
      New object key. At most one of [replace_key_with] and [replace_key_prefix_with] can be specified.
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