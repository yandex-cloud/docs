# Notifications from {{ yandex-cloud }}

{{ yandex-cloud }} technical support notifies you of events that affect all {{ yandex-cloud }} users or your account specifically. To additionally receive notifications about your resources, [subscribe](../../resource-manager/operations/index.md) to **Incident notifications**.

You can receive notifications for the entire cloud or individual folders. By default, all cloud owners (users with the ``resource-manager.clouds.owner`` role) are notified of incidents in the cloud. You can add cloud notification recipients in [Incident notifications]({{ link-cloud-notifications }}).

Folder owners do not receive any notifications by default. You can add notification recipients in the [folder settings](../../resource-manager/operations/folder/notify.md).

{% note info %}

You can add users with a [Yandex account](../../iam/concepts/index.md#passport) and [federated users](../../iam/concepts/index.md#saml-federation). Federated users should specify their email address in their account settings.

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

* Date and time of maintenance.
* Category of maintenance.
* {{ yandex-cloud }} services affected.
* Description of relevant changes to the services.
* Tips on how to reduce the impact of maintenance on your resources (if possible).

## Infrastructure failure

If a failure in {{ yandex-cloud }} could affect the security or availability of your data, technical support notifies you by email as soon as the scope and impact of the problem are identified.

## Information security incident

If an event in the {{ yandex-cloud }} infrastructure causes your data to be compromised, technical support notifies you by email within 24 hours after the damage is detected. The email is sent to the cloud owner, the Data Protection Officer (DPO) if this role is assigned for your cloud, and the users added in [Incident notifications]({{ link-cloud-notifications }}).

