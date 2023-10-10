# Notifications from {{ yandex-cloud }}

{{ yandex-cloud }} technical support notifies you of events that affect all {{ yandex-cloud }} users or your account specifically. To additionally receive notifications about your resources, subscribe to **{{ ui-key.yacloud.iam.folder.switch_service-notifications }}** in your [cloud](../../resource-manager/operations/cloud/notify.md) or [folder](../../resource-manager/operations/folder/notify.md).

You can receive notifications for the entire cloud or individual folders. By default, notifications about upcoming maintenance and notifications from services in the cloud are sent to all cloud owners (users with the `resource-manager.clouds.owner` role). You can add cloud notification recipients in [Service notifications]({{ link-cloud-notifications }}).

By default, folder owners do not receive any notifications. However, users related to the folder parent resources are subscribed to folder notifications. You can add notification recipients in the [folder settings](../../resource-manager/operations/folder/notify.md).

{% note info %}

You can add users with a [Yandex account](../../iam/concepts/index.md#passport) as well as [federated users](../../iam/concepts/index.md#saml-federation). Federated users should specify their email address in their account settings.

{% endnote %}

**Cloud notifications** contain the following information:

* Cloud ID and name.
* Folder ID and name.
* Resource ID and name.

**Folder notifications** include information about the following resources:

* Virtual machines (VM ID).
* Virtual disks (disk ID).
* Database clusters (cluster ID):
  * PostgreSQL
  * MySQL
  * MongoDB
  * Redis
  * ClickHouse

## Planned maintenance

Some {{ yandex-cloud }} maintenance operations may affect the performance or availability of your resources. Technical support sends notification of such work 3 calendar days in advance by email, indicating:

* The date and time of maintenance.
* Category of maintenance.
* {{ yandex-cloud }} services affected.
* Description of relevant changes to the services.
* Tips on how to reduce the impact of maintenance on your resources (if possible).

## Infrastructure failure

If a failure in {{ yandex-cloud }} could affect the security or availability of your data, technical support notifies you by email as soon as the scope and impact of the problem are identified.

## Information security incident

If an event in the {{ yandex-cloud }} infrastructure causes your data to be compromised, technical support notifies you by email within 24 hours after the damage is detected. The email is sent to the cloud owner, the Data Protection Officer (DPO) if this role is assigned for your cloud, and the users added in [Service notifications]({{ link-cloud-notifications }}).
