---
title: How to create a SAML application in {{ org-full-name }}
description: Follow this guide to create a SAML application in {{ org-name }} to authenticate your organization's users to external apps using SAML-based single sign-on (SSO).
---

# Creating a SAML application in {{ org-full-name }}

{% include [note-preview](../../../_includes/note-preview.md) %}

To authenticate your [organization](../../concepts/organization.md)'s users to external apps using [SAML](https://en.wikipedia.org/wiki/Security_Assertion_Markup_Language)-based SSO, create a [SAML application](../../concepts/applications.md#saml) in {{ org-name }} and configure it appropriately both in {{ org-name }} and on your service provider side.

{% include [saml-app-admin-role](../../../_includes/organization/saml-app-admin-role.md) %}

## Create an app {#create-app}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. In the top-right corner, click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** and in the window that opens:
      1. Select the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.saml-title_kyofk }}** single sign-on method.
      1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for your new app. The name must be unique within the organization and follow these naming requirements:

          {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

      1. Optionally, in the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** field, enter a description for the new app.
      1. Optionally, add [labels](../../../resource-manager/concepts/labels.md):

          1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
          1. Enter a label in `key: value` format.
          1. Press **Enter**.
      1. Click **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

## Set up your application {#setup-application}

To integrate an external application with the created SAML application in {{ org-name }}, complete the setup on the service provider side and in {{ org-name }}.

### Set up integration on the service provider side {#setup-sp}

You can look up the values of integration settings to use on the service provider side on the app info page in the [{{ cloud-center }} interface]({{ link-org-cloud-center }}/apps).

Depending on the options supported by your service provider, you can set the required settings manually or automatically by uploading a metadata file or specifying a metadata URL:

{% list tabs %}

- Manual setup

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
  1. On the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, copy the parameter values to use on the service provider side:

      {% include [saml-app-sp-parameter-list](../../../_includes/organization/saml-app-sp-parameter-list.md) %}

  1. Download the app certificate under **{{ ui-key.yacloud_org.application.overview.certificate_section_title }}** by clicking **{{ ui-key.yacloud_org.application.overview.certificate_action_download_cert }}**.
  1. On the service provider side, set up integration with your {{ org-name }} SAML application by pasting the copied parameters and adding the certificate you downloaded. If you need help, refer to your service provider's documentation or support team.

- Metadata file

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
  1. On the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, click **{{ ui-key.yacloud_org.application.overview.idp_section_download_metadata_action }}**.

      The downloaded [XML](https://en.wikipedia.org/wiki/XML) file contains the values of all the required settings and a certificate to verify the signature of SAML responses. Upload the file to your service provider’s platform if the provider supports using metadata files to configure the application. If you need help, refer to your service provider's documentation or support team.

- Metadata URL

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
  1. On the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, copy the **{{ ui-key.yacloud_org.application.overview.saml_field_metadata }}** field value.

      Follow the link to get values for all the required settings and a certificate to verify the signature of SAML responses. Specify the link in the settings on the service provider side if the provider supports using a metadata URL to configure the application. If you need help, refer to your service provider's documentation or support team.

{% endlist %}

### Set up the SAML application in {{ org-name }} {#setup-idp}

Before configuring your SAML application in {{ org-name }}, get the required setting values from your service provider. Then, navigate to the SAML application settings in {{ org-name }}.

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the SAML app.
  1. {% include [saml-app-update-sp-settings](../../../_includes/organization/saml-app-update-sp-settings.md) %}

{% endlist %}

### Configure user and group attributes {#setup-attributes}

You can configure the attributes {{ org-name }} will transmit to the service provider:

{% include [saml-app-update-assertions](../../../_includes/organization/saml-app-update-assertions.md) %}

### Configure users and groups {#users-and-groups}

To permit your organization's users to authenticate in external app with {{ org-name }}'s SAML application, you need to explicitly add these users and/or [user groups](../../concepts/groups.md) to the SAML application:

{% note info %}

Users and groups added to a SAML application can be managed by a user with the `organization-manager.samlApplications.userAdmin` [role](../../security/index.md#organization-manager-samlApplications-userAdmin) or higher.

{% endnote %}

{% include [saml-app-update-users-groups](../../../_includes/organization/saml-app-update-users-groups.md) %}

## Make sure your application works correctly {#validate}

To make sure both your SAML application and service provider integration work correctly, authenticate to the external app as one of the users you added to the application.

#### See also {#see-also}

* [{#T}](./saml-update.md)
* [{#T}](./saml-deactivate-remove.md)
* [{#T}](../add-account.md)
* [{#T}](../../concepts/applications.md#saml)
* [{#T}](../manage-groups.md)