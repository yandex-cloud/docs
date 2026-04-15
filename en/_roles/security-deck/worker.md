The `security-deck.worker` role allows the user to view info on {{ dspm-name }} scan area, as well as info on {{ kspm-name }} and {{ cspm-name }} controlled resources in {{ sd-name }}.

Users with this role can:

* View the [organization](../../organization/concepts/organization.md) info, view the list of and info on [clouds](../../resource-manager/concepts/resources-hierarchy.md#cloud), [folders](../../resource-manager/concepts/resources-hierarchy.md#folder), and [buckets](../../storage/concepts/bucket.md) in the [scan area](../../security-deck/concepts/dspm.md#data-source) configured by the {{ dspm-name }} user, view data in buckets subject to scanning.
* View the list of clouds and folders and their info as controlled resources of a {{ sd-name }} [workspace](../../security-deck/concepts/workspace.md) for [{{ kspm-name }}](../../security-deck/concepts/kspm.md).
* View the list of {{ k8s }} clusters and info on them and their settings as controlled resources of a {{ sd-name }} workspace for {{ kspm-name }}.
* View the organization info, view the list of clouds and folders and their info as controlled resources of a {{ sd-name }} workspace for [{{ cspm-name }}](../../security-deck/concepts/cspm.md).

The role is issued to the [service account](../../iam/concepts/users/service-accounts.md) to perform the {{ dspm-name }} [scan](../../security-deck/concepts/dspm.md#scanning), {{ kspm-name }} or {{ cspm-name }} check. The role extends to an organization, cloud, folder, or bucket (if using [{{ dspm-name }}](../../security-deck/concepts/dspm.md)).

The role does not allow viewing data in [encrypted buckets](../../storage/concepts/encryption.md). To scan an encrypted bucket, additionally assign to the service account the `kms.keys.decrypter` [role](../../kms/security/index.md#kms-keys-encrypter) for the [encryption key](../../kms/security/index.md#kms-keys-encrypter) or for the folder, cloud, or organization this key resides in.

This role includes the `dspm.worker`, `kspm.worker`, and `cspm.worker` permissions.

{% note info %}

The role cannot guarantee access to a bucket with a {{ objstorage-full-name }} [access policy](../../storage/security/policy.md) applied.

{% endnote %}

