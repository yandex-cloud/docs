---
title: How to create an OIDC application in {{ org-full-name }}
description: Follow this guide to create an OIDC application in {{ org-name }} to authenticate your organization’s users in external apps using OpenID Connect SSO.
---

# Creating an OIDC application in {{ org-full-name }}

{% include [note-preview](../../../_includes/note-preview.md) %}

To authenticate your [organization’s](../../concepts/organization.md) users in external apps using [OpenID Connect](https://en.wikipedia.org/wiki/OpenID#OpenID_Connect_(OIDC)) (OIDC) single sign-on, create an [OIDC application](../../concepts/applications.md#oidc) in {{ org-name }} and configure it appropriately both in {{ org-name }} and on your service provider’s side.

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

## Create an app {#create-app}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. In the top-right corner, click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** and in the window that opens:
      1. Select the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.oauth-title_uUs4x }}** single sign-on method.
      1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for your new app. The name must be unique within the organization and follow the naming requirements:

          {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

      1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-folder_rANM4 }}** field, select the folder where you want to create an OAuth client for your app.

          Every OIDC application requires an OAuth client, which is created and removed along with the app and is inherently linked to it.
      1. Optionally, in the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** field, enter a description for the new app.
      1. Optionally, add [labels](../../../resource-manager/concepts/labels.md):

          1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
          1. Enter a label in `key: value` format.
          1. Press **Enter**.
      1. Click **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

## Set up your application {#setup-application}

To integrate an external application with the OIDC application you created in {{ org-name }}, complete the setup on the service provider side and in {{ org-name }}.

### Set up integration on the service provider side {#setup-sp}

You can look up the values of integration settings to use on the service provider side on the app info page in the [{{ cloud-center }}]({{ link-org-cloud-center }}/apps) interface.

Depending on the options supported by your service provider, you can configure the required settings manually or automatically by specifying a configuration URL:

{% list tabs %}

- Manual setup

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, your OIDC app.
  1. On the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, expand the **{{ ui-key.yacloud_org.application.overview.idp_section_closed_text }}** section and copy the parameter values to use on the service provider side:

      {% include [oidc-app-sp-parameter-list](../../../_includes/organization/oidc-app-sp-parameter-list.md) %}

  1. {% include [oidc-generate-secret](../../../_includes/organization/oidc-generate-secret.md) %}
  1. On the service provider side, set up integration with your {{ org-name }} OIDC application by specifying the parameters you copied and the generated secret. If you need help, refer to your service provider's documentation or support team.

- Configuration URL

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the OIDC app.
  1. On the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, copy the **{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}** field value.

      This URL exposes all configuration values required on the service provider side (except for the secret).
  1. {% include [oidc-generate-secret](../../../_includes/organization/oidc-generate-secret.md) %}
  1. If your service provider supports using a configuration URL to configure the application, set up integration with your {{ org-name }} OIDC application on the service provider side by specifying the copied link and secret. If you need help, refer to your service provider's documentation or support team.

{% endlist %}

### Configure your OIDC application in {{ org-name }} {#setup-idp}

Before configuring your OIDC application in {{ org-name }}, get the redirect URI from your service provider. Then, navigate to the OIDC application settings in {{ org-name }}:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the OIDC app.
  1. {% include [oidc-app-update-sp-settings](../../../_includes/organization/oidc-app-update-sp-settings.md) %}

{% endlist %}

### Configure users and groups {#users-and-groups}

To permit your organization's users to authenticate in an external app with a {{ org-name }} OIDC application, you need to explicitly add these users and/or [user groups](../../concepts/groups.md) to this OIDC application:

{% note info %}

Users and groups added to an OIDC application can be managed by a user with the `organization-manager.oauthApplications.userAdmin` [role](../../security/index.md#organization-manager-oauthApplications-userAdmin) or higher.

{% endnote %}

{% include [oidc-app-update-users-groups](../../../_includes/organization/oidc-app-update-users-groups.md) %}

## Make sure your application works correctly {#validate}

To make sure both your OIDC application and service provider integration work correctly, get authenticated in the external app as one of the users you added to the application.

#### See also {#see-also}

* [{#T}](./oidc-update.md)
* [{#T}](./oidc-deactivate-remove.md)
* [{#T}](../add-account.md)
* [{#T}](../../concepts/applications.md#oidc)
* [{#T}](../manage-groups.md)