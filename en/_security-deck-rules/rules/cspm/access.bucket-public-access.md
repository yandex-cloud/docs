### No public access to the Object Storage bucket {#bucket-public-access}

#|
|| **kind** | **severity** | **ID** ||
|| manual | medium | access.bucket-public-access ||
|#

#### Description

{% note warning "**Manual check**" %}

Make sure that the found buckets actually require public access. Please change the status manually.

{% endnote %}

{% note alert "**Attention**" %}

This control does not automatically check access when IAM roles are modified or when public access is specified via anonymous_access_flags. Manual verification is required.

{% endnote %}

It is recommended to assign minimum roles for a bucket using IAM and supplementing or itemizing them using a bucket policy (for example, to restrict access to the bucket by IP, grant granular permissions for objects, and so on).

Access to Object Storage resources is verified at three levels:

* [IAM verification](https://yandex.cloud/en/docs/iam/concepts)
* [Bucket policy](https://yandex.cloud/en/docs/storage/concepts/policy)
* [Access Control Lists (ACLs)](https://yandex.cloud/en/docs/storage/concepts/acl)

**Verification procedure:**

1. If a request passes the IAM check, the next step is the bucket policy check.
2. Bucket policy rules are checked in the following order:
   1. If the request meets at least one of the Deny rules, access is denied.
   2. If the request meets at least one of the Allow rules, access will be allowed.
   3. If the request does not meet any of the rules, access will be denied.
3. If the request fails the IAM or bucket policy check, access verification is performed based on an object's ACL.

In IAM, a bucket inherits the same access permissions as those of the folder and cloud where it is located. For more information, see Inheritance of bucket access permissions by [Yandex Cloud public groups](https://yandex.cloud/en/docs/storage/concepts/acl#inheritance). Therefore, we recommend that you only assign the minimum required roles to certain buckets or objects in Object Storage.

Bucket policies are used for additional data protection, for example, to restrict access to a bucket by IP, issue granular permissions to objects, and so on.

With ACLs, you can grant access to an object bypassing IAM verification and bucket policies. We recommend setting strict ACLs for buckets.

Example of a secure Object Storage configuration: [Terraform](https://github.com/yandex-cloud-examples/yc-s3-secure-bucket)

#### Guides and solutions

Guides and solutions to use:

* It is recommended to assign minimum roles for a bucket using IAM and supplementing or itemizing them using a bucket policy (for example, to restrict access to the bucket by IP, grant granular permissions for objects, and so on).
* If public access is required, it is recommended to use {{ dspm-name }} to monitor the presence of sensitive data in buckets.