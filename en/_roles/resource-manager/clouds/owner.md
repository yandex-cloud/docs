The `resource-manager.clouds.owner` role enables running any operations within the [cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud) and its child [resources](../../../resource-manager/concepts/resources-hierarchy.md).

It also allows you to manage linking the cloud to a [billing account](../../../billing/concepts/billing-account.md) (for that purpose, you also need permissions for that billing account). For more information on managing access to a billing account, see the [Yandex Cloud Billing documentation](../../../billing/security/index.md#billing-account).

By default, the users with this role get [notifications](../../../resource-manager/concepts/notify.md) on what happens to the cloud and its folders.

You can only assign this role for a cloud. Any user creating a cloud automatically gets such a role for the cloud.

This role includes the `admin` and `resource-manager.clouds.member` permissions.
