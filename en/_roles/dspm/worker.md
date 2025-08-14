The `dspm.worker` role enables viewing info on an [organization](../../organization/concepts/organization.md), viewing the list of [clouds](../../resource-manager/concepts/resources-hierarchy.md#cloud), [folders](../../resource-manager/concepts/resources-hierarchy.md#cloud), and [buckets](../../storage/concepts/bucket.md) in a [scan zone](../../resource-manager/concepts/resources-hierarchy.md#cloud) specified by the user and info on them, as well as viewing data in buckets being scanned.

The role is granted to the [service account](../../iam/concepts/users/service-accounts.md) that will be used to perform [scans](../../iam/concepts/users/service-accounts.md) for an organization, cloud, folder, or bucket.

The role does not enable viewing data in [encrypted buckets](../../storage/concepts/encryption.md). To scan an encrypted bucket, additionally grant the `kms.keys.decrypter` [role](../../kms/security/index.md#kms-keys-encrypter) to your service account either for the [encryption key](../../kms/security/index.md#kms-keys-encrypter) at hand or for the folder, cloud, or organization hosting this key.

{% note info %}

The role cannot guarantee access to a bucket if it has a Yandex Object Storage [access policy](../../storage/security/policy.md) applied to it.

{% endnote %}

