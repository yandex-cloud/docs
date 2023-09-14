# Bucket policy

Bucket policies set permissions for actions with buckets, objects, and object groups.

A policy is triggered when a user makes a request to a resource. As a result, the request is either executed or rejected.

Access is verified at three levels: whether the action is allowed by the [user role](../security/index.md) ({{ iam-name }} service verification: {{ iam-short-name }}), access policy, and [ACL permission list](acl.md).

1. If a request passes the {{ iam-short-name }} check, the next step is the bucket policy check.
1. Bucket policy rules are checked in the following order:
   1. If the request meets at least one of the `Deny` rules, access is denied.
   1. If the request meets at least one of the `Allow` rules, access is allowed.
   1. If the request does not meet any of the rules, access is denied.
1. If the request fails the {{ iam-short-name }} or bucket policy check, access verification is performed based on an object's ACL.

{% include [storage-note-empty-policy](../_includes_service/storage-note-empty-policy.md) %}

You can set up the bucket policy in the management console or describe it in JSON format using a [special scheme](../s3/api-ref/policy/scheme.md) to provide the settings through one of the software tools: the {{ yandex-cloud }} CLI, AWS CLI, {{ TF }}, or API. To learn more about policy management, see [this guide](../operations/buckets/policy.md).

## Policy components {#elements}

A bucket policy consists of rules, while a rule consists of the following basic elements:

Resource

: Bucket, a bucket object (`<bucket name>/some/key`), or a prefix (`<bucket name>/some/path/*`), including an empty prefix to indicate all objects in the bucket (`<bucket name>/*`). You can specify multiple resources in a rule.

  {% note info %}

  {% include [policy-bucket-objects](../../_includes/storage/policy-bucket-objects.md) %}

  {% endnote %}

  If you describe a policy in JSON format, a resource should have the `arn:aws:s3:::` prefix, such as `arn:aws:s3:::<bucket name>`.

Action

: Set of resource operations the rule either prohibits or allows. For more information, see [Actions](../s3/api-ref/policy/actions.md).

Result

: Denying or allowing the requested action. First, the request is checked against the `Deny` action filter. If matched, the request is rejected and no further checks are performed. If it meets the `Allow` action filter criteria, the request is allowed. If the request does not meet any of the filters, it is rejected.

Principal

: Recipient of the requested permission. This can be an {{ iam-short-name }} user, a federated user, a service account, or an anonymous user.

Condition

: Item determining whether a rule is effective. For more information, see [Conditions](../s3/api-ref/policy/conditions.md).

## Bucket access via the management console {#console-access}

If a bucket has an access policy configured, access to the bucket via the {{ yandex-cloud }} management console is disabled by default. To enable bucket access, you need to add a rule under the `Statement` access policy section to allow any requests to `<bucket name>/*` and `<bucket name>` resources via the management console.

Example rule for a specific {{ yandex-cloud }} user:


```json
{
  "Effect": "Allow",
  "Principal": {
    "CanonicalUser": "<user ID>"
  },
  "Action": "*",
  "Resource": [
    "arn:aws:s3:::<bucket name>/*",
    "arn:aws:s3:::<bucket name>"
  ],
  "Condition": {
    "StringLike": {
      "aws:referer": "https://console.cloud.yandex.*/folders/*/storage/buckets/your-bucket-name*"
    }
  }
}
```




You can retrieve the user ID by following [this guide](../../iam/operations/users/get.md) in the {{ iam-full-name }} documentation.


## Sample configurations {#config-examples}

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
        "Resource": "arn:aws:s3:::<bucket name>/*",
        "Condition": {
          "Bool": {
            "aws:SecureTransport": "true"
          }
        }
      }
    ]
  }
  ```

* Rule that only allows objects to be downloaded from a specified range of IP addresses:

  ```json
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::<bucket name>/*",
        "Condition": {
          "IpAddress": {
            "aws:SourceIp": "100.101.102.128/30"
          }
        }
      }
    ]
  }
  ```

* Rule that prohibits objects to be downloaded from the specified IP address:

  ```json
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": "*",
        "Action": "*",
        "Resource": "arn:aws:s3:::<bucket name>/*"
      },
      {
        "Effect": "Deny",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::<bucket name>/*",
        "Condition": {
          "IpAddress": {
            "aws:SourceIp": "100.101.102.103"
          }
        }
      }
    ]
  }
  ```

* Rule that provides different users with full access only to certain folders, with each user being able to access their own:

  ```json
  {
    "Version":"2012-10-17",
    "Statement":[
      {
        "Sid":"User1PermissionsResource",
        "Effect":"Allow",
        "Principal": {
          "CanonicalUser": "<user ID>"
        },
        "Action": "*",
        "Resource":["arn:aws:s3:::<bucket name>/user1path/*"]
      },
      {
        "Sid":"User1PermissionsPrefix",
        "Effect":"Allow",
        "Principal": {
            "CanonicalUser": "<user ID>"
        },
        "Action": "s3:ListBucket",
        "Resource":["arn:aws:s3:::<bucket name>"],
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
          "CanonicalUser": "<user ID>"
        },
        "Action": "*",
        "Resource":["arn:aws:s3:::<bucket name>/user2path/*"]
      },
      {
        "Sid":"User2PermissionsPrefix",
        "Effect":"Allow",
        "Principal": {
          "CanonicalUser": "<user ID>"
        },
        "Action": "s3:ListBucket",
        "Resource":["arn:aws:s3:::<bucket name>"],
        "Condition": {
          "StringLike": {
            "s3:prefix": "user2path/*"
          }
        }
      }
    ]
  }
  ```

* Rule that provides each user and service account with full access to a folder with the name equal to the [user ID](../../iam/operations/users/get.md) or [service account ID](../../iam/operations/sa/get-id.md):

   ```json
   {
     "Version":"2012-10-17",
     "Statement":[
       {
         "Sid": "OwnDirPermissions",
         "Effect": "Allow",
         "Principal": "*",
         "Action": "*",
         "Resource": ["arn:aws:s3:::<bucket name>/${aws:userid}/*"]
       }
     ]
   }
   ```
