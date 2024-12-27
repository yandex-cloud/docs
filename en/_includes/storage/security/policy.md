# Bucket policy

{% include [full-overview](./full-overview.md) %}

Bucket policies set permissions for actions with buckets, objects, and object groups.

A policy is triggered when a user makes a request to a resource. As a result, the request is either executed or rejected.

[Enabling public access](../../../storage/operations/buckets/bucket-availability.md) to bucket operations does not override the restrictions set in the access policies.

{% include [storage-note-empty-policy](../../../storage/_includes_service/storage-note-empty-policy.md) %}

You can set up a bucket policy in the management console or describe it in JSON format using a [special scheme](../../../storage/s3/api-ref/policy/scheme.md) to provide the settings through one of the software tools: the {{ yandex-cloud }} CLI, AWS CLI, {{ TF }}, or API. To learn more about policy management, see [this guide](../../../storage/operations/buckets/policy.md).


{% include [s3-with-policy-access](../s3-with-policy-access.md) %}


## Policy components {#elements}

A bucket policy consists of rules, a rule consisting of the following basic elements:

Resource

: Bucket, object in a bucket (`<bucket_name>/some/key`), or prefix (`<bucket_name>/some/path/*`), including an empty prefix to indicate all bucket objects (`<bucket_name>/*`). You can specify multiple resources in a rule.

  {% note info %}
  
  {% include [policy-bucket-objects](../policy-bucket-objects.md) %} 

  {% endnote %}

  If you describe a policy in JSON format, a resource must have the `arn:aws:s3:::` prefix, e.g., `arn:aws:s3:::<bucket_name>`.

  If the resource name contains `?`, `*`, or `$`, enclose each one of these characters in curly braces (`{}`) preceded with `$`. For example, a record mapped to a bucket named `my?bucket` will read `my${?}bucket`.

Action

: Operations with a resource that will be either denied or allowed by the rule. For more information, see [Actions](../../../storage/s3/api-ref/policy/actions.md).

Result

: Denies or allows the requested action. First, the request is checked against the `Deny` action filter. If there is a match, the request is rejected and no further checks are performed. If it meets the `Allow` action filter criteria, the request is allowed. If the request does not trigger any of the filters, it is rejected.

Principal

: Grantee of the requested permission.  This can be an {{ iam-short-name }} user, [federated user](../../../iam/concepts/federations.md), [service account](../../../iam/concepts/users/service-accounts.md), or an anonymous user.


Condition

: Establishes the cases in which the rule will apply.

  {% note info %}

  The `aws:sourceip` condition supports a special procedure for [verifying reverse proxy server IP addresses](#access-via-reverse-proxy).

  {% endnote %}

  If multiple conditions are specified simultaneously for a rule or multiple keys are specified simultaneously within a single condition, then such conditions and keys will apply with the `AND` logic.
  
  If multiple values are specified simultaneously for one condition key, such values will apply with the `OR` logic.
  
  For more information, see [Conditions](../../../storage/s3/api-ref/policy/conditions.md).

## Bucket access via the management console {#console-access}

If a bucket has an access policy configured, access to the bucket via the {{ yandex-cloud }} management console is disabled by default. To enable bucket access, you need to add a rule in the `Statement` section to allow any requests to `<bucket_name>/*` or `<bucket_name>` from the management console.

Example of a rule for a specific {{ yandex-cloud }} user:

```json
{
  "Effect": "Allow",
  "Principal": {
    "CanonicalUser": "<user_ID>"
  },
  "Action": "*",
  "Resource": [
    "arn:aws:s3:::<bucket_name>/*",
    "arn:aws:s3:::<bucket_name>"
  ],
  "Condition": {
    "StringLike": {
      "aws:referer": "{{ link-console-main }}/folders/*/storage/buckets/your-bucket-name*"
    }
  }
}
```


{% cut "Example of using the console.cloud.yandex.* domain together with console.yandex.cloud" %}

If you are using the old domain (`console.cloud.yandex.*`) together with the new one (`console.yandex.cloud`), set the following policy rules:

```json
{
  "Effect": "Allow",
  "Principal": {
    "CanonicalUser": "<user_ID>"
  },
  "Action": "*",
  "Resource": [
    "arn:aws:s3:::<bucket_name>/*",
    "arn:aws:s3:::<bucket_name>"
  ],
  "Condition": {
    "StringLike": {
      "aws:referer": [
        "https://console.cloud.yandex.*/folders/*/storage/buckets/your-bucket-name*",
        "{{ link-console-main }}/folders/*/storage/buckets/your-bucket-name*"
      ]
    }
  }
}
```

{% endcut %}



You can retrieve the user ID by following [this guide](../../../iam/operations/users/get.md) in the {{ iam-full-name }} documentation.


## Bucket access via a chain of reverse proxy servers {#access-via-reverse-proxy}

For {{ objstorage-short-name }} to work with requests sent over a series of [reverse proxy servers](https://en.wikipedia.org/wiki/Reverse_proxy), the `aws:sourceip` [condition](../../../storage/s3/api-ref/policy/conditions.md) checks both the IP address the request came from and the IP addresses of reverse proxy servers, e.g., those provided in the [X-Forwarded-For](https://en.wikipedia.org/wiki/X-Forwarded-For) header.

First a request is checked against the `Deny` access policy rules. If at least one IP address meets the `Deny` rule criteria, the request is denied. No further checks are performed.

Then the request is checked against the `Allow` access policy rules. If at least one IP address meets the `Allow` rule criteria, the request is allowed.

{% cut "An example of bucket access configuration via a chain of reverse proxy servers" %}

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "the-allowing-rule",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "*",
      "Resource": "arn:aws:s3:::sample-bucket/*",
      "Condition": {
        "IpAddress": {
          "aws:sourceip": [
            "192.168.1.1",
            "192.168.1.2"
          ]
        }
      }
    },
    {
      "Sid": "the-denying-rule",
      "Effect": "Deny",
      "Principal": "*",
      "Action": "*",
      "Resource": "arn:aws:s3:::sample-bucket/*",
      "Condition": {
        "IpAddress": {
          "aws:sourceip": [
            "192.168.1.11",
            "192.168.1.12"
          ]
        }
      }
    }
  ]
}
```

If the bucket receives a request with the `X-Forwarded-For: 192.168.1.1, 192.168.1.2, 192.168.1.12` header, this request will be denied as its header has the IP address specified in the `Deny` rule.

If the bucket receives a request with the `X-Forwarded-For: 192.168.2.100, 192.168.2.1, 192.168.1.2` header, this request will be allowed as its header has no IP addresses specified in the `Deny` rule but contains the IP address specified in the `Allow` rule.

{% endcut %}

## Configuration examples {#config-examples}

* Rule that allows an anonymous user to read objects in the bucket over an encrypted connection:

  ```json
  {
    "Id": "epd4limdp3dg********",
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "f1qqoehl1q53********",
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::<bucket_name>/*",
        "Condition": {
          "Bool": {
            "aws:SecureTransport": "true"
          }
        }
      }
    ]
  }
  ```

* Rule that allows downloading objects only from a specified range of IP addresses:

  ```json
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::<bucket_name>/*",
        "Condition": {
          "IpAddress": {
            "aws:SourceIp": "100.101.102.128/30"
          }
        }
      }
    ]
  }
  ```

* Rule that prohibits downloading objects from the specified IP address:

  ```json
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": "*",
        "Action": "*",
        "Resource": "arn:aws:s3:::<bucket_name>/*"
      },
      {
        "Effect": "Deny",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::<bucket_name>/*",
        "Condition": {
          "IpAddress": {
            "aws:SourceIp": "100.101.102.103"
          }
        }
      }
    ]
  }
  ```

* Rule that provides different users with full access only to specific folders – each user to their own:

  ```json
  {
    "Version":"2012-10-17",
    "Statement":[
      {
        "Sid":"User1PermissionsResource",
        "Effect":"Allow",
        "Principal": {
          "CanonicalUser": "<user_ID>"
        },
        "Action": "*",
        "Resource":["arn:aws:s3:::<bucket_name>/user1path/*"]
      },
      {
        "Sid":"User1PermissionsPrefix",
        "Effect":"Allow",
        "Principal": {
            "CanonicalUser": "<user_ID>"
        },
        "Action": "s3:ListBucket",
        "Resource":["arn:aws:s3:::<bucket_name>"],
        "Condition": {
          "StringLike": {
            "s3:prefix": "user1path/*"
          }
        }
      },
      {
        "Sid":"User2PermissionsResource",
        "Effect":"Allow",
        "Principal": {
          "CanonicalUser": "<user_ID>"
        },
        "Action": "*",
        "Resource":["arn:aws:s3:::<bucket_name>/user2path/*"]
      },
      {
        "Sid":"User2PermissionsPrefix",
        "Effect":"Allow",
        "Principal": {
          "CanonicalUser": "<user_ID>"
        },
        "Action": "s3:ListBucket",
        "Resource":["arn:aws:s3:::<bucket_name>"],
        "Condition": {
          "StringLike": {
            "s3:prefix": "user2path/*"
          }
        }
      }
    ]
  }
  ```

* Rule that provides each user and service account with full access to a folder with the name matching the [user ID](../../../iam/operations/users/get.md) or [service account ID](../../../iam/operations/sa/get-id.md):

  ```json
  {
    "Version":"2012-10-17",
    "Statement":[
      {
        "Sid": "OwnDirPermissions",
        "Effect": "Allow",
        "Principal": "*",
        "Action": "*",
        "Resource": ["arn:aws:s3:::<bucket_name>/${aws:userid}/*"]
      }
    ]
  }
  ```

### See also {#see-also}

* [{#T}](../../../storage/operations/buckets/policy.md)
