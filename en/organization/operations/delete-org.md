---
title: Deleting an organization in {{ org-full-name }}
description: In this tutorial, you will learn how to delete an organization in {{ org-full-name }}.
---

# Deleting an organization

To delete a {{ yandex-360 }} organization, follow [this {{ yandex-360 }} guide](https://yandex.ru/support/yandex-360/business/admin/ru/organization/delete-organization).

{% note info %}

To delete an organization, a user needs the `organization-manager.organizations.owner` role. For information on assigning roles to users, see [Roles](../security/index.md#add-role).

Before deleting an organization:
1. [Delete](../../resource-manager/operations/cloud/delete.md) all clouds from the organization or [move](../../resource-manager/operations/cloud/change-organization.md) them to another organization.
1. [Delete](../../billing/operations/delete-account.md) all billing accounts linked to the organization.

{% endnote %}

To delete an organization:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ cloud-center }}]({{ cloud-center-link }}) with an administrator or organization owner account.

      On the {{ cloud-center }} home page that opens, you can view general info about your organization.

      {% include [switch-org-note](../../_includes/organization/switch-org-note.md) %}

  1. To delete your current organization, click ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_org.dashboard.organization.action.delete-button }}** in the box with its name in the center of the screen.

  1. In the window that opens:
  
     1. Specify when you want the organization to be deleted. Select one of the suggested periods or `Delete now`. The default organization deletion delay is seven days.
     1. Enter the organization name to confirm its deletion. 

  1. Click **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}

After deleting an organization, you will no longer be able to use the {{ yandex-cloud }} resources created in that organization.

## Resolving an error when deleting an organization {#troubleshooting}

If the following error appears when deleting an organization, it means there are still clouds within the organization that prevent you from deleting it:

```text
Service 'resource-manager.cloud' has banned deletion operation with reason: Organization `<organization_ID>` has cloud(s)
```

To fix this error:

1. [Delete](../../resource-manager/operations/cloud/delete.md) all clouds from the organization or [move](../../resource-manager/operations/cloud/change-organization.md) them to another organization.
1. If you have selected cloud deletion, wait for it to complete. By default, the cloud deletion period is 7 days. After this period ends, permanent deletion may take up to 72 hours.
1. Retry the organization deletion.

If any billing accounts are linked to the organization, you must also [delete](../../billing/operations/delete-account.md) them.

If any other issues arise, submit a request to [support]({{ link-console-support }}).
