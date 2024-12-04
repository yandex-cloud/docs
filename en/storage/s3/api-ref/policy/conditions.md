---
title: What {{ objstorage-full-name }} bucket access policy trigger conditions can be set in the S3 API
description: In this tutorial, you will learn what {{ objstorage-full-name }} bucket access policy trigger conditions can be set in the S3 API.
---

# Conditions

Conditions determine the cases in which the rule applies.

Condition key | Description
----- | -----
`aws:principaltype` | Indicates the type of entity the request was sent to.
`aws:referer` | Compares the request's Referer with the one specified in the policy.
`aws:securetransport` | Indicates whether the request was sent using SSL encryption.
`aws:sourceip` | Compares the IP address the request came from and the IP addresses of [reverse proxy servers](https://en.wikipedia.org/wiki/Reverse_proxy), e.g., the ones provided in the [X-Forwarded-For](https://en.wikipedia.org/wiki/X-Forwarded-For) header, with the IP addresses specified in the policy.<br/><br/>The condition is satisfied if at least one IP address matches those in the policy. For more information, see [Bucket access via a chain of reverse proxy servers](../../../concepts/policy.md#access-via-reverse-proxy).
`aws:useragent` | Compares the request's UserAgent with those specified in the policy.
`aws:userid` | Compares the user ID in {{ iam-short-name }} with the one specified in the policy.
`s3:authtype` | Restricts incoming requests to use a specific authentication method.
`s3:delimiter` | Sets the delimiter that user requests must contain.
`s3:max-keys` | Sets the maximum number of keys returned per [ListBucket](../bucket/list.md) request.
`s3:prefix` | Restricts access by key name prefix.
`s3:signatureage` | Sets the length of time that a signature is valid in an authenticated request.
`s3:signatureversion` | Identifies the version of AWS Signature for authenticated requests.
`s3:versionid` | Filters access by a specific object version.
`s3:x-amz-acl` | Requires the request to contain the `X-Amz-Acl` header with the specified ACL.
`s3:x-amz-content-sha256` | Prohibits unsigned content in a request.
`s3:x-amz-copy-source` | Restricts the copy source to a specific bucket, prefix, or object.
`s3:x-amz-grant-full-control` | Requires the request to contain the `X-Amz-Grant-Full-Control` (full access) header.
`s3:x-amz-grant-read` | Requires the request to contain the `X-Amz-Grant-Read` (read access) header.
`s3:x-amz-grant-read-acp` | Requires the request to contain the `X-Amz-Grant-Read` (ACL read access) header.
`s3:x-amz-grant-write` | Requires the request to contain the `X-Amz-Grant-Write` (write access) header.
`s3:x-amz-grant-write-acp` | Requires the request to contain the `X-Amz-Grant-Write` (ACL write access) header.
`s3:x-amz-metadata-directive` | Sets the forced choice of COPY or REPLACE behavior when copying objects.
`s3:x-amz-server-side-encryption` | Requires server-side encryption.
`s3:x-amz-server-side-encryption-aws-kms-key-id` | Requires a specific key for server-side encryption.
`s3:x-amz-storage-class` | Filters access by [storage class](../../../concepts/storage-class.md).
`s3:x-amz-website-redirect-location` | Filters access by a specific redirect location for websites configured as static websites.
`yc:private-endpoint-id` | Sets access via [{{ vpc-short-name }} service connections](../../../../vpc/concepts/private-endpoint.md). Contains a service connection ID.

{% include [conditions-combining-and](../../../../_includes/storage/conditions-combining-and.md) %}

{% cut "Examples of policies in which conditions are checked with the `AND` logic" %}

{% list tabs %}

- Multiple conditions in one rule

  ```json
  {
    "Version": "2012-10-17",
    "Statement": {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::sample-bucket/*",
      "Condition": {
        "Bool": {
          "aws:sourceip": "192.168.1.1"
        }
      },
      "Condition": {
        "Bool": {
          "aws:userid": "ajelcjkv67ar********"
        }
      }
    }
  }
  ```

- Multiple keys in one condition

  ```json
  {
    "Version": "2012-10-17",
    "Statement": {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::sample-bucket/*",
      "Condition": {
        "Bool": {
          "aws:sourceip": "192.168.1.1",
          "aws:userid": "ajelcjkv67ar********"
        }
      }
    }
  }
  ```

{% endlist %}

{% endcut %}

{% include [conditions-combining-or](../../../../_includes/storage/conditions-combining-or.md) %}

{% cut "Examples of policies in which conditions are checked with the `OR` logic" %}

```json
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Principal": "*",
    "Action": "s3:GetObject",
    "Resource": "arn:aws:s3:::sample-bucket/*",
    "Condition": {
      "Bool": {
        "aws:sourceip": [
          "192.168.1.1",
          "192.168.1.2"
        ]
      }
    }  
  }
}
```

{% endcut %}

## Condition operators {#condition-operators}

Condition operators are used to verify the conformity between the key value in the policy condition and the its value in the request context.

### Logical operators {#bool}

Logical operators allow you to you create conditions for comparing a key against a Boolean value of `true` or `false`.

Condition operator | Description
----- | -----
`Bool` | Matches the specified Boolean value.

### Date and time operators {#date}

Date and time operators let you create conditions for matching the key against the value of the date and time.

Condition operator | Description
----- | -----
`DateEquals` | Matches the specified date.
`DateGreaterThan` | The date and time value is greater than the one specified.
`DateGreaterThanEquals` | The date and time value is equal to or greater than the one specified.
`DateLessThan` | The date and time value is less than the one specified.
`DateLessThanEquals` | The date and time value is equal to or less than the one specified.
`DateNotEquals` | Does not match the specified date.

### IP address operators {#ip-address}

IP statements allow you to create conditions for matching the key against the host IP or a range of IP addresses in [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) format.

Condition operator | Description
----- | -----
`IPAddress` | A specific IP address or range of IP addresses.
`NotIPAddress` | All IP addresses except the specified IP address or range of IP addresses.

### Numeric operators {#numeric}

Numeric operators let you create conditions for matching the key against an integer or decimal numeric value.

Condition operator | Description
----- | -----
`NumericEquals` | The value is equal to the one specified.
`NumericGreaterThan` | The value is greater than the one specified.
`NumericGreaterThanEquals` | The value is greater than or equal to the one specified.
`NumericLessThan` | The value is less than the one specified.
`NumericLessThanEquals` | The value is less than or equal to the one specified.
`NumericNotEquals` | The value is not equal to the one specified.

### String operators {#string}

String operators allow creating conditions for comparing a key against a string value.

Condition operator | Description
----- | -----
`StringEquals` | Exact match, case sensitive.
`StringEqualsIgnoreCase` | Exact match, ignore case.
`StringLike` | Match value. You can use wildcards in values:<br/>- `*`: Multiple characters.<br/>- `?`: One character.
`StringNotEquals` | Negated match, case sensitive.
`StringNotEqualsIgnoreCase` | Negated match, ignore case.
`StringNotLike` | Negated match. You can use wildcards in values:<br/>- `*`: Multiple characters.<br/>- `?`: One character.

### IfExists operator {#ifexists}

You can append `IfExists` to any operator name (except [Null](#null)), e.g., `BoolIfExists`. Using this operator in the condition element means:

- If the policy key is present in the request context, process the key as specified in the policy.
- If the key is missing, the element will return `true`.

### Null operator {#null}

The `Null` operator returns `true` if a condition key is missing in the request at the time of authentication. If the key exists and its value is not null, the operator returns `false`.

{% include [the-s3-api-see-also-include](../../../../_includes/storage/the-s3-api-see-also-include.md) %}