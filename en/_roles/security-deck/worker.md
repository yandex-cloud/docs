The `security-deck.worker` role allows the user to view info on DSPM scan area, as well as info on KSPM and CSPM controlled resources in Security Deck.

Users with this role can:

* View the [organization](../../organization/concepts/organization.md) info, view the list of and info on [clouds](../../resource-manager/concepts/resources-hierarchy.md#cloud), [folders](../../resource-manager/concepts/resources-hierarchy.md#folder), and [buckets](../../storage/concepts/bucket.md) in the [scan area](../../security-deck/concepts/dspm.md#data-source) configured by the DSPM user, view data in buckets subject to scanning.
* View the list of clouds and folders and their info as controlled resources of a Security Deck [workspace](../../security-deck/concepts/workspace.md) for [KSPM](../../security-deck/concepts/kspm.md).
* View the list of Kubernetes clusters and info on them and their settings as controlled resources of a Security Deck workspace for KSPM.
* View the organization info, view the list of clouds and folders and their info as controlled resources of a Security Deck workspace for [CSPM](../../security-deck/concepts/cspm.md).

The role is issued to the [service account](../../iam/concepts/users/service-accounts.md) to perform the DSPM [scan](../../security-deck/concepts/dspm.md#scanning), KSPM or CSPM check. The role extends to an organization, cloud, folder, or bucket (if using [DSPM](../../security-deck/concepts/dspm.md)).

The role does not allow viewing data in [encrypted buckets](../../storage/concepts/encryption.md). To scan an encrypted bucket, additionally assign to the service account the `kms.keys.decrypter` [role](../../kms/security/index.md#kms-keys-encrypter) for the [encryption key](../../kms/security/index.md#kms-keys-encrypter) or for the folder, cloud, or organization this key resides in.

This role includes the `dspm.worker`, `kspm.worker`, and `cspm.worker` permissions.

{% note info %}

The role cannot guarantee access to a bucket with a Yandex Object Storage [access policy](../../storage/security/policy.md) applied.

{% endnote %}

