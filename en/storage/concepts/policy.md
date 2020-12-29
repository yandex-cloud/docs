# Bucket Policy

Bucket policies set permissions for actions with buckets, objects, and groups of objects.

A policy is triggered when a user makes a request to a resource. As a result, the request is either executed or rejected.

Access is verified at three levels: IAM service checks, bucket policy, and access control list (ACL).

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

## Sample configurations

* The following policy gives an anonymous user access to read `samplebucket` bucket objects provided that a connection is encrypted.

```json
{
  "Id": "epd4limdp3dgec7enpq5"
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "f1qqoehl1q53l06kqurs",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::samplebucket/*",
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "true"
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
      "Resource": "arn:aws:s3:::samplebucket/*"
    },
    {
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::samplebucket/*",
      "Condition": {
        "IpAddress": {
          "aws:SourceIp": "100.101.102.103"
        }
      }
    }
  ]
}
```

* A policy that indicates separate access to bucket resources for different users:

```json
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"User1Permissions",
      "Effect":"Allow",
      "Principal": {
        "CanonicalUser": "ajeanexampleusername"
      },
      "Action": "*",
      "Resource":["arn:aws:s3:::common-bucket/user1path/*"]
    },
    {
      "Sid":"User2Permissions",
      "Effect":"Allow",
      "Principal": {
        "CanonicalUser": "ajesomeotherusername"
      },
      "Action": "*",
      "Resource":["arn:aws:s3:::common-bucket/user2path/*"]
    }
  ]
}
```