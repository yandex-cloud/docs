### No public access to the Object Storage bucket {#bucket-public-access}

#|
|| **kind** | **severity** | **ID** ||
|| manual | medium | access.bucket-public-access ||
|#

#### Description

**How this rule works:** This rule finds buckets that look publicly accessible — confirm whether each found bucket really should be public, then mark the rule's status manually. The rule does not catch all ways of granting public access — for example, IAM role changes and `anonymous_access_flags` are not detected automatically.

A bucket in [Object Storage](https://yandex.cloud/en/docs/storage/) becomes publicly accessible when one of the following is configured: an IAM role granted to a system [public group](https://yandex.cloud/en/docs/iam/concepts/access-control/public-group) (`All users` / `All authenticated users`), an `allUsers` / `allAuthenticatedUsers` entry in the [bucket or object ACL](https://yandex.cloud/en/docs/storage/concepts/acl), a [bucket policy](https://yandex.cloud/en/docs/storage/concepts/policy) that allows access without authentication, or anonymous access enabled on the bucket itself.

**Risks if the rule is not followed:** Public access on a bucket that is not meant to be public is one of the most frequent root causes of data leaks in cloud infrastructure — sensitive files, backups, and configuration data can be read or downloaded by anyone on the internet.

#### Instructions and solutions

For each bucket from the list:

* If public access is not needed, remove it: revoke roles granted to public groups, remove `allUsers` / `allAuthenticatedUsers` from the bucket and object ACL, edit or delete the bucket policy, disable `anonymous_access_flags`.
* If the bucket really has to be public (for example, hosting a static website), document this and grant the narrowest access possible — read-only, only on the prefixes that should be exposed.
* For one-off sharing of individual objects from a non-public bucket, use [pre-signed URLs](https://yandex.cloud/en/docs/storage/concepts/pre-signed-urls) instead of opening the whole bucket.
* For buckets that contain or might contain sensitive data, use [DSPM](https://yandex.cloud/en/docs/security-deck/concepts/dspm) of Security Deck to monitor what is stored there.
