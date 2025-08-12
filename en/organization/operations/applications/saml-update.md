---
title: How to update a SAML app in {{ org-full-name }}
description: Follow this guide to update a a SAML app in {{ org-name }}.
---

# Updating a SAML app in {{ org-full-name }}

{% include [note-preview](../../../_includes/note-preview.md) %}

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

## Update the app's basic settings {#update-basic-settings}

To update the [SAML app's basic settings](../../concepts/applications.md#saml):

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
  1. On the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:

      1. Change the app's name in the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-name_d22aF }}** field. The name must be unique within the organization and follow the naming requirements:

          {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

      1. Change the app's description in the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-description_cjpok }}** field.
      1. Add new [labels](../../../resource-manager/concepts/labels.md) by clicking **{{ ui-key.yacloud.component.label-set.button_add-label }}** in the **{{ ui-key.yacloud_org.organization.apps.SamlAppEditForm.field-labels_uT2D2 }}** field. Click ![xmark](../../../_assets/console-icons/xmark.svg) to delete an existing label.
      1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Update the service provider configuration {#update-sp}

To update the service provider configuration in a SAML app:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
  1. {% include [saml-app-update-sp-settings](../../../_includes/organization/saml-app-update-sp-settings.md) %}

{% endlist %}

## Update a digital signature verification key certificate {#update-cert}

{% include [saml-app-cert-intro-phrase](../../../_includes/organization/saml-app-cert-intro-phrase.md) %}

You can issue any number of new digital signature verification key certificates for the SAML app at any time. To do this:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
  1. Under **{{ ui-key.yacloud_org.application.overview.certificate_section_title }}**, click **{{ ui-key.yacloud_org.application.overview.certificate_action_manage_certs }}** on the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab and in the window that opens:

      1. Click **{{ ui-key.yacloud_org.cloud-components.manage-cert-dialog.action-generate-new-certificate }}**. This will create a new certificate which will appear in the list.
      1. To activate the new certificate, enable **{{ ui-key.yacloud_org.cloud-components.manage-cert-dialog.table.column-active }}** next to it.

          {% include [saml-app-cert-update-warn](../../../_includes/organization/saml-app-cert-update-warn.md) %}

      1. To download the new certificate, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) next to it and select ![arrow-down-to-line](../../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud.common.download }}**.
      1. To delete the certificate, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) next to it and select ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**, then confirm the deletion. You can only delete inactive certificates.
      1. Click **{{ ui-key.yacloud.common.close }}**.

{% endlist %}

## Update user and group attributes {#update-attributes}

To update the attributes {{ org-name }} will transmit to the service provider:

{% include [saml-app-update-assertions](../../../_includes/organization/saml-app-update-assertions.md) %}

## Update the list of app users and groups {#users-and-groups}

Update the list of your [organization's](../../concepts/organization.md) users permitted to authenticate in external app with a SAML application:

{% include [saml-app-update-users-groups](../../../_includes/organization/saml-app-update-users-groups.md) %}

#### See also {#see-also}

* [{#T}](./saml-create.md)
* [{#T}](./saml-deactivate-remove.md)
* [{#T}](../add-account.md)
* [{#T}](../../concepts/applications.md#saml)
* [{#T}](../manage-groups.md)