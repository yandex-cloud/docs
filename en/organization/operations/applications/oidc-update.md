---
title: How to update an OIDC application in {{ org-full-name }}
description: Follow this guide to update an OIDC application in {{ org-name }}.
---

# Updating an OIDC application in {{ org-full-name }}

{% include [note-preview](../../../_includes/note-preview.md) %}

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

## Update the app's basic settings {#update-basic-settings}

To update the [OIDC app's](../../concepts/applications.md#oidc) basic settings:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the OIDC application.
  1. On the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:

      1. Change the app's name in the **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.field-name_kxMrU }}** field. The name must be unique within the organization and follow the naming requirements:

          {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

      1. Change the app's description in the **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.field-description_fcXBi }}** field.
      1. Add new [labels](../../../resource-manager/concepts/labels.md) by clicking **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.field-labels_kc4MN }}** in the **{{ ui-key.yacloud.component.label-set.button_add-label }}** field. Click ![xmark](../../../_assets/console-icons/xmark.svg) to delete an existing label.
      1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Update the service provider configuration {#update-sp}

To update the service provider configuration in an OIDC app:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the OIDC application.
  1. {% include [oidc-app-update-sp-settings](../../../_includes/organization/oidc-app-update-sp-settings.md) %}

{% endlist %}

## Updating an app's secret {#update-secret}

There is no way you can view or update an app’s [secret](../../concepts/applications.md#oidc-secret). Instead, you can generate a new one:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the OIDC application.
  1. {% include [oidc-generate-secret](../../../_includes/organization/oidc-generate-secret.md) %}
  1. Remember to provide the new secret in the settings on the service provider side. If you need help, refer to your service provider's documentation or support team.

{% endlist %}

## Update the list of app users and groups {#users-and-groups}

Update the list of your [organization's](../../concepts/organization.md) users permitted to authenticate in an external app with an OIDC application:

{% include [oidc-app-update-users-groups](../../../_includes/organization/oidc-app-update-users-groups.md) %}

#### See also {#see-also}

* [{#T}](./oidc-create.md)
* [{#T}](./oidc-deactivate-remove.md)
* [{#T}](../add-account.md)
* [{#T}](../../concepts/applications.md#oidc)
* [{#T}](../manage-groups.md)