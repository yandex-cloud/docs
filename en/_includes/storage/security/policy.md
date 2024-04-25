# Bucket policy

{% include [full-overview](./full-overview.md) %}

Bucket policies set permissions for actions with buckets, objects, and object groups.

A policy is triggered when a user makes a request to a resource. As a result, the request is either executed or rejected.

[Enabling public access](../../../storage/operations/buckets/bucket-availability.md) to bucket operations does not override the restrictions set in the access policies.

{% include [storage-note-empty-policy](../../../storage/_includes_service/storage-note-empty-policy.md) %}

You can set up a bucket policy in the management console or describe it in JSON format using a [special scheme](../../../storage/s3/api-ref/policy/scheme.md) to provide the settings through one of the software tools: the {{ yandex-cloud }} CLI, AWS CLI, {{ TF }}, or API. To learn more about policy management, see [this guide](../../../storage/operations/buckets/policy.md).

## Policy components {#elements}

A bucket policy consists of rules, a rule consisting of the following basic elements:

Resource

: A bucket, bucket object (`<bucket_name>/some/key`), or prefix (`<bucket_name>/some/path/*`), including an empty prefix to indicate all objects in a bucket (`<bucket_name>/*`). You can specify multiple resources in a rule.

{% note info %}

{% include [policy-bucket-objects](../policy-bucket-objects.md) %}

{% endnote %}

If you describe a policy in JSON format, a resource should have the `arn:aws:s3:::` prefix, e.g., `arn:aws:s3:::<bucket_name>`.

If the resource name contains `?`, `*`, or `$`, enclose each instance of these characters in curly braces `{}` and precede them with `$`. For example, a record corresponding to a bucket named `my?bucket` will read `my${?}bucket`.

Action

: A set of operations with a resource that will be either prohibited or allowed by the rule. For more information, see [Actions](../../../storage/s3/api-ref/policy/actions.md).

Result

: Denying or allowing the requested action. First, the request is checked against the `Deny` action filter. If there is a match, the request is rejected and no further checks are performed. If it meets the `Allow` action filter criteria, the request is allowed. If the request does not trigger any of the filters, it is rejected.

Principal

Principal: Recipient of the requested permission. This can be an {{ iam-short-name }} user, a federated user, a service account, or an anonymous user.

Condition

: Defines the cases in which a rule will apply. For more information, see [Conditions](../../../storage/s3/api-ref/policy/conditions.md).

## Bucket access via the management console {#console-access}

If a bucket has an access policy configured, access to the bucket via the {{ yandex-cloud }} management console is disabled by default. To enable bucket access, you need to add a rule under the `Statement` access policy section to allow any requests to `<bucket_name>/*` and `<bucket_name>` resources via the management console.

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


{% cut "Example for sharing the console.cloud.yandex.* and console.yandex.cloud domains" %}

If you are using the old `console.cloud.yandex.*` domain in conjunction with the new `console.yandex.cloud` domain, set the following policy rules:

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
