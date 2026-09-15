### Yandex Object Storage uses bucket policies {#bucket-access-policy}

#|
|| **kind** | **severity** | **ID** ||
|| manual | high | access.bucket-access-policy ||
|#

#### Description

**How this rule works:** This is a manual check. The rule automatically finds buckets that have no bucket policy configured at all. It flags these buckets for manual review — the administrator must decide whether a policy is needed based on the bucket's sensitivity and use case. The rule does not verify whether IAM roles alone provide sufficient access control.

{% note warning "**Manual verification**" %}

The rule finds buckets without any bucket policy. After looking through the list, mark the rule's status manually.

{% endnote %}

[Bucket policies](https://yandex.cloud/en/docs/storage/concepts/policy) describe who, and under what conditions, can perform operations on a bucket and the objects in it. Compared to IAM roles, bucket policies allow finer-grained rules — restrict access by source IP, HTTP referer, object prefix, or specific actions.

[Examples](https://yandex.cloud/en/docs/storage/concepts/policy#config-examples) of useful policies:

* allow downloading objects only from a specified IP range;
* block downloads from a specific IP;
* give each user full access only to a specific prefix in the bucket;
* give a service account access only to a folder named after its ID.

Buckets without any bucket policy rely entirely on IAM. That works, but loses the ability to express conditions like "downloads from the office network only" or "writes from CI/CD only".

See recommendations for context.

**Risks if the rule is not followed:** Without bucket policies, there is no way to enforce network-level or context-based access restrictions on Object Storage. A compromised IAM credential grants unrestricted access to the bucket from any location, and there is no deny layer to block access from untrusted IPs or to prevent accidental writes from unauthorized sources.

#### Instructions and solutions

For each bucket without a policy, decide whether one is needed:

1. If the bucket is internal and IAM roles already give the right access, no policy is required — confirm this in the manual verification.
2. If the bucket would benefit from extra conditions (IP restrictions, prefix-based access, deny rules), [configure a bucket policy](https://yandex.cloud/en/docs/storage/operations/buckets/policy) — start from one of the [policy examples](https://yandex.cloud/en/docs/storage/concepts/policy#config-examples) in the documentation.
3. After applying, verify that legitimate clients still work and that the cases the policy is meant to block are actually blocked.

{% note alert "**Attention**" %}

This control does not automatically check access when IAM roles are modified or when public access is specified via anonymous_access_flags. Manual verification is required.

{% endnote %}

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

In IAM, a bucket inherits the same access permissions as those of the folder and cloud where it is located. For more information, see [Inheritance of bucket access permissions by Yandex Cloud public groups](https://yandex.cloud/en/docs/storage/concepts/acl#inheritance). Therefore, we recommend that you only assign the minimum required roles to certain buckets or objects in Object Storage.

Bucket policies are used for additional data protection, for example, to restrict access to a bucket by IP, issue granular permissions to objects, and so on.

With ACLs, you can grant access to an object bypassing IAM verification and bucket policies. We recommend setting strict ACLs for buckets.

[Example of a secure Object Storage configuration: Terraform](https://github.com/yandex-cloud-examples/yc-s3-secure-bucket)
