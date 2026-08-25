---
title: How to create an OIDC application in {{ org-full-name }}
description: Follow this guide to create an OIDC application in {{ org-full-name }} to authenticate your organization’s users in external apps using OpenID Connect SSO.
---

# Creating an OIDC application in {{ org-full-name }}


To authenticate your [organization](../../concepts/organization.md)'s users to external apps using SSO based on [OpenID connect](https://en.wikipedia.org/wiki/OpenID#OpenID_Connect_(OIDC)) (OIDC), create an [OIDC application](../../concepts/applications/oidc.md) in {{ org-full-name }} and configure it appropriately both in {{ org-full-name }} and on your service provider's side.

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

{% include [oidc-app-types-ui-notice](../../../_includes/organization/oidc-app-types-ui-notice.md) %}

## Create an app {#create-app}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. In the top-right corner, click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** and in the window that opens:
      1. Select the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.oauth-title_uUs4x }}** single sign-on method.
      1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.section-app-type_mbu85 }}** field, select the [type](*oidc_app_type) of your new app:

          * [{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}](../../concepts/applications/oidc.md#oidc-web): Optimized for user authentication to external web applications with a server end (backend).
          * [{{ ui-key.yacloud_org.organization.apps.spa-title_1mhon }}](../../concepts/applications/oidc.md#oidc-single-page): Optimized for user authentication to external [SPA](https://en.wikipedia.org/wiki/Single-page_application) applications.
          * [{{ ui-key.yacloud_org.organization.apps.native-title_1VrmN }}](../../concepts/applications/oidc.md#oidc-native): Optimized for user authentication to external mobile or desktop applications.
      1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for your new app. The name must be unique within the organization and follow the naming requirements:

          {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

      1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-folder_rANM4 }}** field, select the folder where you want to create an OAuth client for your app.

          Every OIDC application requires an OAuth client, which is created and removed along with the app and is inherently linked to it.
      1. Optionally, in the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** field, enter a description for the new app.
      1. Optionally, add [labels](../../../resource-manager/concepts/labels.md):

          1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
          1. Add a label in `key: value` format.
          1. Press **Enter**.
      1. Click **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for creating an OAuth client:

      ```bash
      yc iam oauth-client create --help
      ```
  1. Define the OAuth client (OIDC application) [type](*oidc_app_type) you are creating. The choice of type depends on whether the service provider is able to securely store the application secret.
  
      {% note warning %}

      The OAuth client type is specified when creating one and cannot be changed later.

      {% endnote %}

  1. Create an OAuth client:

      ```bash
      yc iam oauth-client create \
        --name <OAuth_client_name> \
        --scopes <attribute>[,<attribute>] \
        --profile-id <OAuth_client_type>
      ```

      Where:

      * `--name`: OAuth client name.
      * `--scopes`: User attributes that will be available to the service provider. Specify one or more attributes, comma-separated, in `<attribute1>,<attribute2>` format. Possible attributes:

          * `openid`: User ID. Required attribute.
          * `profile`: Additional user details, such as first name, last name, and avatar.
          * `email`: User email address.
          * `groups`: [User groups](../../concepts/groups.md) in the organization.
      * `--profile-id`: OAuth client type. The possible values are:

          * `web`: [{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}](../../concepts/applications/oidc.md#oidc-web) type, optimized for user authentication to external web applications with a server end (backend).
          * `user-agent`: [{{ ui-key.yacloud_org.organization.apps.spa-title_1mhon }}](../../concepts/applications/oidc.md#oidc-single-page) type, optimized for user authentication to external [SPA](https://en.wikipedia.org/wiki/Single-page_application) applications.
          * `native`: [{{ ui-key.yacloud_org.organization.apps.native-title_1VrmN }}](../../concepts/applications/oidc.md#oidc-native) type, optimized for user authentication to external mobile or desktop applications.

      Result:

      {% include [oauth-client-cli-result](../../../_includes/organization/oauth-client-cli-result.md) %}

      Save the `id` field value for when you need to create and configure your app.
  1. If creating a `{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}` OAuth client, create a secret for your OAuth client:

      {% note info %}

      You cannot create a secret for the `{{ ui-key.yacloud_org.organization.apps.spa-title_1mhon }}` and `{{ ui-key.yacloud_org.organization.apps.native-title_1VrmN }}` OAuth client types.

      {% endnote %}
  
      ```bash
      yc iam oauth-client-secret create \
        --oauth-client-id <OAuth_client_ID>
      ```

      Result:

      ```text
      oauth_client_secret:
        id: ajedt5kmvp3u********
        oauth_client_id: ajejvqe2ahei********
        masked_secret: yccs__1db656e68e****
        created_at: "2026-07-16T09:24:10.547Z"
      secret_value: yccs__1db656e68e********
      ```

      Save the `secret_value` field value: you will need it to [configure your app](#setup-application) on the service provider side.
  1. See the description of the CLI command for creating an OIDC app:

      ```bash
      yc organization-manager idp application oauth application create --help
  1. Create an OIDC app:

      ```bash
      yc organization-manager idp application oauth application create \
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
      id: ek0op26034ug********
      name: oidc-app
      organization_id: bpf2c65rqcl8********
      group_claims_settings:
        group_distribution_type: ALL_GROUPS
      client_grant:
        client_id: ajejvqe2ahei********
        authorized_scopes:
          - openid
          - profile
          - groups
          - email
      status: ACTIVE
      created_at: "2026-07-16T08:22:45.446107Z"
      updated_at: "2026-07-16T08:22:46.489330Z"
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Describe the [OAuth client](../../concepts/applications/oidc.md) parameters in the {{ TF }} configuration file:

     ```hcl
     resource "yandex_iam_oauth_client" "example_oauth_client" {
       name      = "<OAuth_client_name>"
       folder_id = "<folder_ID>"
       scopes    = ["<attribute1>", "<attribute2>"]
     }
     ```

     Where:

     * `name`: OAuth client name.
     * `folder_id`: ID of the folder where you want to create your OAuth server.
     * `scopes`: User attributes that will be available to the service provider. Specify one or more attributes in square brackets. Possible attributes:
       * `openid`: User ID. Required attribute.
       * `profile`: Additional user details, such as first name, last name, and avatar.
       * `email`: User email address.
       * `groups`: User groups in the organization.

     For more on the properties of the `yandex_iam_oauth_client` resource, see [this provider guide]({{ tf-provider-resources-link }}/iam_oauth_client).

  1. In the {{ TF }} configuration file, describe the OAuth client [secret](../../concepts/applications/oidc.md#oidc-secret) parameters:

     ```hcl
     resource "yandex_iam_oauth_client_secret" "example_oauth_client_secret" {
       oauth_client_id = "<OAuth_client_ID>"
     }
     ```

     Where:

     * `oauth_client_id`: ID of the OAuth client for which you are creating the secret.

     For more on the properties of the `yandex_iam_oauth_client_secret` resource, see [this provider guide]({{ tf-provider-resources-link }}/iam_oauth_client_secret).

  1. Describe the [OIDC application](../../concepts/applications/oidc.md) parameters in the {{ TF }} configuration file:

     ```hcl
     resource "yandex_organizationmanager_idp_application_oauth_application" "example_oidc_app" {
       organization_id = "<organization_ID>"
       name            = "<application_name>"
       description     = "<application_description>"
       
       client_grant = {
         client_id         = "<OAuth_client_ID>"
         authorized_scopes = ["<attribute1>", "<attribute2>"]
       }
       
       group_claims_settings = {
         group_distribution_type = "ALL_GROUPS"
       }
       
       labels = {
         "<key1>" = "<value1>"
         "<key2>" = "<value2>"
       }
     }
     ```

     Where:

     * `organization_id`: [ID of the organization](../organization-get-id.md) you want to create your OIDC app in. This is a required setting.
     * `name`: OIDC app name. This is a required setting. The name must be unique within the organization and follow the naming requirements:

       {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}

     * `description`: OIDC app description. This is an optional setting.
     * `client_grant`: OAuth client connection settings:
       * `client_id`: OAuth client ID. This is a required setting.
       * `authorized_scopes`: Specify the same attributes as when creating the OAuth client.
     * `group_claims_settings`: Settings for sending user group claims to the service provider:
       * `group_distribution_type`: If you provided the `groups` attribute when creating the OAuth client, specify which user groups you want to go to the service provider. The possible values are:
         * `ALL_GROUPS`: Service provider will get all groups the user belongs to.
         * `ASSIGNED_GROUPS`: Of all the user's groups, the service provider will only get the ones explicitly specified.
         * `NONE`: Service provider will not get any of the groups the user belongs to.
     * `labels`: List of [labels](../../../resource-manager/concepts/labels.md). This is an optional setting.

     For more on the properties of the `yandex_organizationmanager_idp_application_oauth_application` resource, see [this provider guide]({{ tf-provider-resources-link }}/organizationmanager_idp_application_oauth_application).

  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create all the required resources. You can check the new resources and their settings in the [{{ cloud-center }} UI]({{ link-org-cloud-center }}) or using this [CLI](../../../cli/) command:

     ```bash
     yc organization-manager idp application oauth application list --organization-id <organization_ID>
     ```

- API {#api}

  1. To create an OAuth client, use the [OAuthClient.Create](../../../iam/api-ref/OAuthClient/create.md) REST API method for the [OAuthClient](../../../iam/api-ref/grpc/OAuthClient/index.md) resource or the [OAuthClientService/Create](../../../iam/api-ref/grpc/OAuthClient/create.md) gRPC API call.
  1. To create an OAuth client secret, use the [OAuthClientSecret.Create](../../../iam/api-ref/OAuthClientSecret/create.md) REST API method for the [OAuthClientSecret](../../../iam/api-ref/OAuthClientSecret/index.md) resource or the [OAuthClientSecretService/Create](../../../iam/api-ref/grpc/OAuthClientSecret/create.md) gRPC API call.
  1. To create an OIDC application, use the [Application.Create](../../idp/application/oauth/api-ref/Application/create.md) REST API method for the [Application](../../idp/application/oauth/api-ref/Application/index.md) resource or the [ApplicationService/Create](../../idp/application/oauth/api-ref/grpc/Application/create.md) gRPC API call.  

{% endlist %}

## Set up your application {#setup-application}

To integrate an external application with the OIDC application you created in {{ org-full-name }}, complete the setup both on the service provider side and in {{ org-full-name }}.

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
  1. On the service provider side, set up integration with the {{ org-full-name }} OIDC app by specifying the copied parameters and the new secret (for `{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}` apps). If you need help, refer to your service provider's documentation or support team.

- Configuration URL

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the OIDC app.
  1. On the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, copy the **{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}** field value.

      This URL exposes all configuration values required on the service provider side (except for the secret).
  1. {% include [oidc-generate-secret](../../../_includes/organization/oidc-generate-secret.md) %}
  1. If your service provider supports configuration URLs for app configuration, set up integration with the {{ org-full-name }} OIDC app on the service provider side by specifying the link and secret you copied (for `{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}` apps). If you need help, refer to your service provider's documentation or support team.

{% endlist %}

### Configure your OIDC application in {{ org-full-name }} {#setup-idp}

{% include [oidc-app-types-ui-notice](../../../_includes/organization/oidc-app-types-ui-notice.md) %}

Before configuring your OIDC application in {{ org-full-name }}, get the redirect URI address (addresses) from your service provider. Then, navigate to the OIDC application settings in {{ org-full-name }}:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the OIDC app.
  1. {% include [oidc-app-update-sp-settings](../../../_includes/organization/oidc-app-update-sp-settings.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for updating an OAuth client:

      ```bash
      yc iam oauth-client update --help
      ```

  1. Run this command:

      ```bash
      yc iam oauth-client update \
        --id <OAuth_client_ID> \
        --redirect-uris <address>[,<address>] \
        --auth-methods <secret_provisioning_method> \
        --pkce-required
      ```

      Where:

      * `--id`: OAuth client ID.
      * `--redirect-uris`: Specify the address or addresses you got from the service provider in `<address1>,<address2>` format.
      * `--auth-methods`: [Application secret provisioning methods](../../concepts/applications/oidc.md#secret-delivery). This parameter is only available for `{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}` OAuth clients. The possible values are:

          * `client_secret_basic`: Application secret is provided in the `Authorization: Basic` HTTP header.
          * `{{ ui-key.yacloud_org.application.overview.oauth_field_auth_method_client_secret_basic }}`: Application secret is provided in the body of the POST request.

          To allow your OIDC app to use both secret provisioning methods, specify both values separated by commas in `--auth-methods`.
          
          By default, when you create an OAuth client of the `{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}` type, both secret provisioning methods are enabled for it.
      * `--pkce-required`: Manages the use of [PKCE](../../concepts/applications/oidc.md#pkce) by the service provider:

          * To enable the PKCE requirement, provide `--pkce-required` in the command.
          * To disable the requirement to use PKCE (only for `{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}` OAuth clients), provide the `--pkce-required=false` parameter in the command.

              {% note info %}

              For a `{{ ui-key.yacloud_org.organization.apps.spa-title_1mhon }}` or `{{ ui-key.yacloud_org.organization.apps.native-title_1VrmN }}` OAuth client, you cannot disable the requirement to use PKCE.

              {% endnote %}

      Result:

      {% include [oauth-client-cli-result-redirect-uris](../../../_includes/organization/oauth-client-cli-result-redirect-uris.md) %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. In the {{ TF }} configuration file, specify the `redirect_uris` parameter for the `yandex_iam_oauth_client` resource:

     ```hcl
     resource "yandex_iam_oauth_client" "example_oauth_client" {
       name          = "<OAuth_client_name>"
       folder_id     = "<folder_ID>"

       ...

       redirect_uris = ["<address1>", "<address2>"]
     }
     ```

     Where:

     * `name`: OAuth client name.
     * `folder_id`: ID of the folder where you want to create your OAuth server.
     * `redirect_uris`: Specify the address or addresses you got from the service provider in square brackets.

     For more on the properties of the `yandex_iam_oauth_client` resource, see [this provider guide]({{ tf-provider-resources-link }}/iam_oauth_client).

  1. Apply the changes:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     You can check the updates of resources and their settings either in the [{{ cloud-center }} interface]({{ link-org-cloud-center }}) or using this [CLI](../../../cli/) command:

     ```bash
     yc iam oauth-client get <OAuth_client_ID>
     ```

- API {#api}

  Use the [OAuthClient.Update](../../../iam/api-ref/OAuthClient/update.md) REST API method for the [OAuthClient](../../../iam/api-ref/grpc/OAuthClient/index.md) resource or the [OAuthClientService/Update](../../../iam/api-ref/grpc/OAuthClient/update.md) gRPC API call.

{% endlist %}

### Configure users and groups {#users-and-groups}

For your organization's users to be able to authenticate in an external app with a {{ org-full-name }} OIDC application, you need to explicitly add these users and/or [user groups](../../concepts/groups.md) to this OIDC application:

{% note info %}

Users and groups added to an OIDC application can be managed by any user with the `organization-manager.oauthApplications.userAdmin` [role](../../security/index.md#organization-manager-oauthApplications-userAdmin) or higher.

{% endnote %}

{% include [oidc-app-update-users-groups](../../../_includes/organization/oidc-app-update-users-groups.md) %}

{% include [auth-policy-applications-tip](../../../_includes/organization/auth-policy-applications-tip.md) %}

## Make sure your application works correctly {#validate}

To make sure both your OIDC application and service provider integration work correctly, get authenticated in the external app as one of the users you added to the application.

#### Useful links {#see-also}

* [{#T}](./oidc-update.md)
* [{#T}](./oidc-deactivate-remove.md)
* [{#T}](../add-account.md)
* [{#T}](../../concepts/applications/oidc.md)
* [{#T}](../manage-groups.md)

[*oidc_app_type]: OIDC app type in {{ org-full-name }} (`{{ ui-key.yacloud_org.organization.apps.web-title_aeKTZ }}`, `{{ ui-key.yacloud_org.organization.apps.spa-title_1mhon }}`, and `{{ ui-key.yacloud_org.organization.apps.native-title_1VrmN }}`) determines whether you can use application secrets and some other settings. For more information, see [{#T}](../../concepts/applications/oidc.md#oidc-application-types).