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

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for creating an OIDC app:

     ```bash
     yc organization-manager idp application oauth application create --help
     ```

  1. Create an OAuth client:

     ```bash
     yc iam oauth-client create \
       --name <OAuth_client_name> \
       --scopes <attribute>[,<attribute>]
     ```

     Where:

     * `--name`: OAuth client name.
     * `--scopes`: User attributes that will be available to the service provider. Specify one or more attributes, comma-separated, in `<attribute1>,<attribute2>` format. Possible attributes:
       * `openid`: User ID. Required attribute.
       * `profile`: Additional user details, such as first name, last name, and avatar.
       * `email`: User email address.
       * `address`: User home address.
       * `phone`: User phone number.
       * `groups`: [User groups](../../concepts/groups.md) in the organization.

     Result:

     ```text
     id: ajeqqip130i1********
     name: test-oauth-client
     folder_id: b1g500m2195v********
     status: ACTIVE
     ```

     Save the `id` field value: you will need it to create and configure your app.

  1. Create a secret for your OAuth client:

     ```bash
     yc iam oauth-client-secret create --oauth-client-id <OAuth_client_ID>
     ```

     Result:

     ```text
     oauth_client_secret:
       id: ajeq9jfrmc5t********
       oauth_client_id: ajeqqip130i1********
       masked_secret: yccs__939233b8ac****
       created_at: "2025-10-21T10:14:17.861652377Z"
     secret_value: yccs__939233b8ac********
     ```

     Save the `secret_value` field value: you will need it to [configure your app](#setup-application) on the service provider side.
  
  1. Create an OIDC app:

     ```bash
     yc iam organization-manager idp application oauth application create \
       --organization-id <organization_ID> \
       --name <application_name> \
       --description <application_description> \
       --client-id <OAuth_client_ID> \
       --authorized-scopes <attribute>[,<attribute>] \
       --group-distribution-type all-groups \
       --labels <key>=<value>[,<key>=<value>]
     ```

     Where:

     * `--organization-id`: [ID of the organization](../organization-get-id.md) you want to create your OIDC app in. This is a required setting.
     * `--name`: OIDC app name. This is a required setting. The name must be unique within the organization and follow the naming requirements:

       {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

     * `--description`: OIDC app description. This is an optional setting.
     * `--client-id`: OAuth client ID you got in Step 2. This is a required setting.
     * `--authorized-scopes`: Specify the same attributes as when creating the OAuth client.
     * `--group-distribution-type`: If you provided the `groups` attribute when creating the OAuth client, specify which user groups you want to go to the service provider. The possible values are:
       * `all-groups`: Service provider will get all groups the user belongs to.

          The maximum number of groups to change hands is 1,000. If the user belongs to more groups than this, only the first thousand will go to the service provider.
       * `assigned-groups`: Of all the user's groups, the service provider will only get the ones explicitly [specified](#users-and-groups).
       * `none`: Service provider will not get any of the groups the user belongs to.
     * `--labels`: List of [labels](../../../resource-manager/concepts/labels.md). This is an optional setting. You can specify one or more labels separated by commas in `<key1>=<value1>,<key2>=<value2>` format.

     Result:

     ```text     
     id: ek0o663g4rs2********
     name: oidc-app
     organization_id: bpf2c65rqcl8********
     group_claims_settings:
       group_distribution_type: NONE
     client_grant:
       client_id: ajeqqip130i1********
       authorized_scopes:
         - openid
     status: ACTIVE
     created_at: "2025-10-21T10:51:28.790866Z"
     updated_at: "2025-10-21T12:37:19.274522Z"
     ```

- API {#api}

  1. Use the [OAuthClient.Create](../../../iam/api-ref/OAuthClient/create.md) REST API method for the [OAuthClient](../../../iam/api-ref/grpc/OAuthClient/index.md) resource or the [OAuthClientService/Create](../../../iam/api-ref/grpc/OAuthClient/create.md) gRPC API call.
  1. Use the [OAuthClientSecret.Create](../../../iam/api-ref/OAuthClientSecret/create.md) REST API method for the [OAuthClientSecret](../../../iam/api-ref/OAuthClientSecret/index.md) resource or the [OAuthClientSecretService/Create](../../../iam/api-ref/grpc/OAuthClientSecret/create.md) gRPC API call.
  1. Use the [Application.Create](../../idp/application/oauth/api-ref/Application/create.md) REST API method for the [Application](../../idp/application/oauth/api-ref/Application/index.md) resource or the [ApplicationService/Create](../../idp/application/oauth/api-ref/grpc/Application/create.md) gRPC API call.  

{% endlist %}

## Set up your application {#setup-application}

To integrate an external application with the OIDC application you created in {{ org-name }}, complete the setup both on the service provider side and in {{ org-name }}.

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
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the OIDC app.
  1. {% include [oidc-app-update-sp-settings](../../../_includes/organization/oidc-app-update-sp-settings.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for setting up the OAuth client:

     ```bash
     yc iam oauth-client update --help
     ```

  1. Run this command:

     ```bash
     yc iam oauth-client update \
       --id <OAuth_client_ID> \
       --redirect-uris <address>[,<address>]
     ```

     Where:

     * `--id`: OAuth client ID.
     * `--redirect-uris`: Specify the address or addresses you got from the service provider in `<address1>,<address2>` format.

     Result:

     ```text
     id: ajeqqip130i1********
     name: test-oauth-client
     redirect_uris:
       - https://example.com
       - https://example.ru
     folder_id: b1g500m2195v********
     status: ACTIVE
     ```

- API {#api}

  Use the [OAuthClient.Update](../../../iam/api-ref/OAuthClient/update.md) REST API method for the [OAuthClient](../../../iam/api-ref/grpc/OAuthClient/index.md) resource or the [OAuthClientService/Update](../../../iam/api-ref/grpc/OAuthClient/update.md) gRPC API call.

{% endlist %}

### Configure users and groups {#users-and-groups}

For your organization's users to be able to authenticate in an external app with a {{ org-name }} OIDC application, you need to explicitly add these users and/or [user groups](../../concepts/groups.md) to this OIDC application:

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