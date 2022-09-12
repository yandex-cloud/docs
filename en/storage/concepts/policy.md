# Bucket policy

Bucket policies set permissions for actions with buckets, objects, and groups of objects.

A policy is triggered when a user makes a request to a resource. As a result, the request is either executed or rejected.

Access is verified at three levels: {{ iam-full-name }} service verification, the access policy, and the ACL permission list.

1. If a request passes the IAM check, the next step is the bucket policy check.
1. Bucket policy rules are checked in the following order:
   1. If the request meets at least one of the `Deny` rules, access is denied.
   1. If the request meets at least one of the `Allow` rules, access is allowed.
   1. If the request doesn't meet any of the rules, access is denied.
1. If the request failed the IAM or bucket policy check, access verification is performed based on an object's ACL.

The bucket policy consists of the following basic elements:
* Resource: A bucket (`arn:aws:s3:::samplebucket`), an object in the bucket (`arn:aws:s3:::samplebucket/some/key`), or a prefix (`arn:aws:s3:::samplebucket/some/path/*`).
* Action: A set of resource operations that the policy either prohibits or allows. For more information, see [Actions](../s3/api-ref/policy/actions.md).
* The result is denying or allowing the requested action. First, the request is checked against the `Deny` action filter. If matched, the request is rejected and no further checks are performed. If it meets the `Allow` action filter criteria, the request is allowed. If the request doesn't meet any of the filters, it's rejected.
* The principal is the recipient of the requested policy permission. This can be an {{ iam-short-name }} user, a federated user, a service account, or an anonymous user.
* A condition is specified for when a policy is in effect. For more information, see [Conditions](../s3/api-ref/policy/conditions.md).

A JSON-like language is used to describe policy rules.

To apply a policy to a bucket, see the [instruction](../operations/buckets/policy.md).

## Bucket access via the management console {#console-access}

If a bucket has an access policy configured, access to the bucket via the {{ yandex-cloud }} management console is disabled by default. To enable bucket access, you need to add a rule under the access policy `Statement` section to allow any requests to `<bucket name>/*` and `<bucket name>` resources via the management console.

Example rule for a specific {{ yandex-cloud }} user:

{% if product == "yandex-cloud" %}

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

{% endif %}

{% if product == "cloud-il" %}

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
      "aws:referer": "https://console.cloudil.co.il/folders/*/storage/buckets/your-bucket-name*"
    }
  }
}
```

{% endif %}

{% if audience != "internal" %}

You can retrieve the user ID by following [instructions](../../iam/operations/users/get.md) in the {{ iam-full-name }} documentation.

{% endif %}

## Sample configurations {#config-examples}

* A policy that allows an anonymous user to read objects in the `samplebucket` bucket over an encrypted connection:

   ```json
   {
     "Id": "epd4limdp3dgec7enpq5",
     "Version": "2012-10-17",
     "Statement": [
       {
         "Sid": "f1qqoehl1q53l06kqurs",
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

* A policy that only enables object download from a specified range of IP addresses:

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

* A policy that prohibits downloading objects from the specified IP address:

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

* A policy gives different users full access only to certain folders with each user being able to access their own:

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

* A policy gives each user and service account full access to the folder with the same name as the [user ID](../../iam/operations/users/get.md) or the [service account ID](../../iam/operations/sa/get-id.md):

  ```json
  {
    "Version":"2012-10-17",
    "Statement":[
      {
        "Sid":"OwnDirPermissions",
        "Effect":"Allow",
        "Principal": "*",
        "Action": "*",
        "Resource":["arn:aws:s3:::<bucket name>/${aws:userid}/*"]
      }
    ]
  }
  ```
