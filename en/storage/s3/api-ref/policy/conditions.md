# Conditions

| Condition | Description |
----- | -----
| `aws:principaltype` | Indicates the type of entity the request was sent to. |
| `aws:referer` | Compares the request's Referer with the one specified in the policy. |
| `aws:securetransport` | Indicates whether the request was sent using SSL encryption. |
| `aws:sourceip` | Compares the request's IP address with those specified in the policy. |
| `aws:useragent` | Compares the request's UserAgent with those specified in the policy. |
| `aws:userid` | Compares the user ID in {{ iam-short-name }} with the one specified in the policy. |
| `s3:authtype` | Restricts incoming requests to use a specific authentication method. |
| `s3:delimiter` | Sets the delimiter that user requests must contain. |
| `s3:max-keys` | Sets the maximum number of keys returned per [ListBucket](../bucket/list.md) request. |
| `s3:prefix` | Restricts access by key name prefix. |
| `s3:signatureage` | Sets the length of time that a signature is valid in an authenticated request. |
| `s3:signatureversion` | Identifies the version of AWS Signature for authenticated requests. |
| `s3:versionid` | Filters access by a specific object version. |
| `s3:x-amz-acl` | Requires the `X-Amz-Acl` request header with the ACL specified. |
| `s3:x-amz-content-sha256` | Prohibits unsigned content in a request. |
| `s3:x-amz-copy-source` | Restricts the copy source to a specific bucket, prefix, or object. |
| `s3:x-amz-grant-full-control` | Requires the request to include the `X-Amz-Grant-Full-Control` (full control) header. |
| `s3:x-amz-grant-read` | Requires the request to include the `X-Amz-Grant-Read` (read access) header. |
| `s3:x-amz-grant-read-acp` | Requires the request to include the `X-Amz-Grant-Read` (read permissions for the ACL) header. |
| `s3:x-amz-grant-write` | Requires the request to include the `X-Amz-Grant-Write` (write access) header. |
| `s3:x-amz-grant-write-acp` | Requires the request to include the `X-Amz-Grant-Write` (write permissions for the ACL) header. |
| `s3:x-amz-metadata-directive` | Sets the forced choice of COPY or REPLACE behavior when copying objects. |
| `s3:x-amz-server-side-encryption` | Requires server-side encryption. |
| `s3:x-amz-server-side-encryption-aws-kms-key-id` | Requires a specific key for server-side encryption. |
| `s3:x-amz-storage-class` | Filters access by [storage class](../../../concepts/storage-class.md). |
| `s3:x-amz-website-redirect-location` | Filters access by a specific redirect location for websites that are configured as static websites. |

## Condition operators {#condition-operators}

Condition operators are used to match the condition key and value in the policy against values in the request context.

### Logical operators {#bool}

Logical operators let you create conditions for matching the key against the Boolean value of `true` or `false`.

| Condition operator | Description |
----- | -----
| `Bool` | Matches the specified Boolean value. |

### Date and time operators {#date}

Date and time operators let you create conditions for matching the key against the value of the date and time.

| Condition operator | Description |
----- | -----
| `DateEquals` | Matches the specified date. |
| `DateGreaterThan` | The date and time value is greater than the one specified. |
| `DateGreaterThanEquals` | The date and time value is equal to or greater than the one specified. |
| `DateLessThan` | The date and time value is less than the one specified. |
| `DateLessThanEquals` | The date and time value is equal to or less than the one specified. |
| `DateNotEquals` | Doesn't match the specified date. |

### IP address operators {#ip-address}

Date and time operators let you create conditions for matching the key against the host IP or a range of IP addresses in [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) format.

| Condition operator | Description |
----- | -----
| `IPAddress` | A specific IP address or range of IP addresses. |
| `NotIPAddress` | All IP addresses except the specified IP address or range of IP addresses. |

### Numeric operators {#numeric}

Numeric operators let you create conditions for matching the key against an integer or decimal numeric value.

| Condition operator | Description |
----- | -----
| `NumericEquals` | The value is equal to the one specified. |
| `NumericGreaterThan` | The value is greater than the one specified. |
| `NumericGreaterThanEquals` | The value is greater than or equal to the one specified. |
| `NumericLessThan` | The value is less than the one specified. |
| `NumericLessThanEquals` | The value is less than or equal to the one specified. |
| `NumericNotEquals` | The value is not equal to the one specified. |

### String operators {#string}

String operators let you create conditions for matching the key against a string value.

| Condition operator | Description |
----- | -----
| `StringEquals` | Exact match, case sensitive. |
| `StringEqualsIgnoreCase` | Exact match, ignore case. |
| `StringLike` | Match value. You can use wildcards in values:<br/>- `*` – Multiple characters.<br/>-`?` – One character. |
| `StringNotEquals` | Negated match, case sensitive. |
| `StringNotEqualsIgnoreCase` | Negated match, ignore case. |
| `StringNotLike` | Negated match. You can use wildcards in values:<br/>- `*` – Multiple characters.<br/>-`?` – One character. |

### IfExists operator {#ifexists}

You can add `IfExists` to the end of any operator name (except the [Null](#null) condition). For example, `BoolIfExists`.  Using this operator in the condition element means:

- If the policy key is present in the request context, process the key as specified in the policy.
- If the key is missing, evaluate the condition element as `true`.

### Null operator {#null}

The result of a `Null` operator is `true` if a condition key is not present in the request at the time of authorization. If the key exists and its value is not null, then `false`.
