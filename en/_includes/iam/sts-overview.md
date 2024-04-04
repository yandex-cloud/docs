# {{ sts-name }}

{% include [sts-preview](sts-preview.md) %}

_{{ sts-name }}_: {{ iam-name }} component to get _temporary access keys_ compatible with [AWS S3 API](../../storage/s3/index.md).

Temporary access keys as an authentication method are only supported in [{{ objstorage-full-name }}](../../storage/).

With temporary keys, you can set up granular access to {{ objstorage-name }} [buckets](../../storage/concepts/bucket.md) for multiple users with a single [service account](../../iam/concepts/users/service-accounts.md). The service account permissions must include all the permissions you want to grant using temporary keys.

A temporary access key is created based on a [static key](../../iam/concepts/authorization/access-key.md), but, unlike it, it has a limited lifetime and access permissions. Access permissions and lifetime are set for each temporary key individually.

The maximum key lifetime is 12 hours.

To set up access permissions for the key, you need an [access policy](../../storage/security/policy.md) in JSON format based on [this schema](../../storage/s3/api-ref/policy/scheme.md).

{% include [sts-sa-scope-note](sts-sa-scope-note.md) %}

{% include [sts-object-acl-note](sts-object-acl-note.md) %}

This means you can, for instance, provide different users with temporary permissions to read and write objects to different [prefixes (folders)](../../storage/concepts/object.md#folder) of the same bucket. To solve this task using static keys, you would need to create a dedicated service account for each user, while the number of service accounts in the cloud is [limited](../../iam/concepts/limits.md#iam-quotas).

A temporary key consists of the following parts:
* Key ID (same as the static key ID)
* Secret key
* Session token

To get a temporary access key using {{ sts-name }}, use the [AWS Command Line Interface (AWS CLI)](../..//storage/tools/aws-cli.md) or an HTTP API compatible with the [AWS STS API](https://docs.aws.amazon.com/STS/latest/APIReference/welcome.html).

For more information, see [{#T}](../../iam/operations/sa/create-sts-key.md).

{% note warning %}

You cannot revoke a temporary key. However, you can [delete](../../iam/operations/sa/delete-access-key.md) a static key used to issue a temporary one.

This will revoke permissions for all temporary access keys created based on the deleted static key.

{% endnote %}

### See also {#see-also}

* [{#T}](../../storage/security/overview.md)