# Creating an OIDC application in {{ org-full-name }} for integration with Cloud.ru

[Cloud.ru](https://cloud.ru/) is a Russian provider of cloud services, spanning IaaS, PaaS, AI/ML tools, and solutions for public, private, and hybrid cloud deployments, including support for infrastructure migration and operation. Cloud.ru supports [OpenID Connect](https://en.wikipedia.org/wiki/OpenID#OpenID_Connect_(OIDC)) (OIDC) authentication to provide secure SSO for your organization's users.

To authenticate your [organization's](../../../organization/concepts/organization.md) users to Cloud.ru with OpenID Connect SSO, create an [OIDC app](../../../organization/concepts/applications.md#oidc) in {{ org-full-name }} and configure it appropriately both in {{ org-full-name }} and Cloud.ru.

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

For the users of your organization to be able to access Cloud.ru:

1. [Create an app](#create-app).
1. [Set up the integration](#setup-integration).
1. [Make sure the application works correctly](#validate).

## Create an app {#create-app}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. In the top-right corner, click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** and in the window that opens:
        1. Select the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.oauth-title_uUs4x }}** single sign-on method.
        1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for your new app: `cloud-ru-oidc-app`.
        1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-folder_rANM4 }}** field, select the folder where you want to create an OAuth client for your app.
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
       --name cloud-ru-oauth-client \
       --scopes openid,email,profile
     ```

     Where:

     * `--name`: OAuth client name.
     * `--scopes`: User attributes available to Cloud.ru. The specified attributes are:
       * `openid`: User ID. Required attribute.
       * `email`: User email address.
       * `profile`: Additional user details, such as first name, last name, and avatar.

     Result:

     ```text
     id: ajeqqip130i1********
     name: cloud-ru-oauth-client
     folder_id: b1g500m2195v********
     status: ACTIVE
     ```

     Save the `id` field value: you will need it to create and configure your app.

  1. Create a secret for your OAuth client:

     ```bash
     yc iam oauth-client-secret create \
       --oauth-client-id <OAuth_client_ID>
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

     Save the `secret_value` field value: you will need it to configure Cloud.ru.

  1. Create an OIDC app:

     ```bash
     yc organization-manager idp application oauth application create \
       --organization-id <organization_ID> \
       --name cloud-ru-oidc-app \
       --description "OIDC application for integration with Cloud.ru" \
       --client-id <OAuth_client_ID> \
       --authorized-scopes openid,email,profile \
       --group-distribution-type none
     ```

     Where:

     * `--organization-id`: [ID of the organization](../../../organization/operations/organization-get-id.md) you want to create your OIDC app in. This is a required setting.
     * `--name`: OIDC app name. This is a required setting.
     * `--description`: OIDC app description. This is an optional setting.
     * `--client-id`: OAuth client ID you got in Step 2. This is a required setting.
     * `--authorized-scopes`: Specify the same attributes as when creating the OAuth client.
     * `--group-distribution-type`: Set to `none` as user groups are not provided to Cloud.ru.

     Result:

     ```text
     id: ek0o663g4rs2********
     name: cloud-ru-oidc-app
     organization_id: bpf2c65rqcl8********
     group_claims_settings:
       group_distribution_type: NONE
     client_grant:
       client_id: ajeqqip130i1********
       authorized_scopes:
         - openid
         - email
         - profile
     status: ACTIVE
     created_at: "2025-10-21T10:51:28.790866Z"
     updated_at: "2025-10-21T12:37:19.274522Z"
     ```

{% endlist %}

## Set up the integration {#setup-integration}

To configure Cloud.ru integration with the OIDC app you created in {{ org-full-name }}, complete the setup both in Cloud.ru and {{ org-full-name }}.

### Configure your OIDC application in {{ org-full-name }} {#setup-idp}

#### Get the application’s credentials {#get-credentials}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the OIDC app.
  1. On the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, expand the **{{ ui-key.yacloud_org.application.overview.idp_section_closed_text }}** section and copy the parameter values you need to specify in Cloud.ru:

        * `{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}`: Unique application ID.
        * `{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}`: URL with the configuration of all parameters required to set up the integration.
        * `{{ ui-key.yacloud_org.application.overview.oauth_field_auth_endpoint }}`: URL to which the service provider will redirect the user for authentication.
        * `{{ ui-key.yacloud_org.application.overview.oauth_field_token_endpoint }}`: URL to which the external application sends a request to obtain an ID token and access token.
        * `{{ ui-key.yacloud_org.application.overview.oauth_field_user_info_endpoint }}`: URL the external application can use to obtain user attributes.

  1. {% include [oidc-generate-secret](../../../_includes/organization/oidc-generate-secret.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Get information about your new OIDC application:

     ```bash
     yc organization-manager idp application oauth application get <app_ID>
     ```

     Where `<app_ID>` is your OIDC app ID you got when creating the app.

     This will return the application information, including the following:

     ```text
     id: ek0o663g4rs2********
     name: cloud-ru-oidc-app
     organization_id: bpf2c65rqcl8********
     client_grant:
       client_id: ajeqqip130i1********
       authorized_scopes:
         - openid
         - email
         - profile
     ```

     Save the `client_id` value: you will need it to configure Cloud.ru.

  1. Get the OpenID Connect Discovery configuration URL:

     ```bash
     yc organization-manager idp application oauth application get <app_ID> \
       --format json | jq -r '.client_grant.issuer_uri'
     ```

     The result will look as follows:

     ```text
     https://{{ auth-main-host }}/oauth/<OAuth_client_ID>
     ```

     Save this URL: this is the OpenID Connect Discovery URL you will need to configure Cloud.ru.

  1. Use the OAuth client secret that you saved when creating the app in the previous step. If you have not saved the secret, create a new one:

     ```bash
     yc iam oauth-client-secret create \
       --oauth-client-id <OAuth_client_ID>
     ```

     Save the `secret_value` from the command output: this is the client secret you will need to configure Cloud.ru.

{% endlist %}

### Set up the OIDC app in Cloud.ru {#setup-sp}

1. Log in to the Cloud.ru [console](https://console.cloud.ru/).
1. Navigate to the **Federations** tab in the **Administration** section.
1. Click **Create federation** and select the **OpenID** protocol type.
1. Enter the federation name and description.
1. Set the session duration.
    
    {% note info %}

    The maximum lifetime of an SSO session is from 30 minutes to 7 days. If there is no activity, the session is automatically terminated and re-authentication is required.

    {% endnote %}

1. Fill in the fields using the values of OIDC application settings in {{ org-full-name }}:

    1. **Auth URL**: **{{ ui-key.yacloud_org.application.overview.oauth_field_auth_endpoint }}** field value.
    1. **Userinfo URL**: **{{ ui-key.yacloud_org.application.overview.oauth_field_user_info_endpoint }}** field value.
    1. **Token URL**: **{{ ui-key.yacloud_org.application.overview.oauth_field_token_endpoint }}** field value.
    1. **Logout URL**: `end_session_endpoint` value from `{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}`.
    1. **Client ID**: **{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}** field value.
    1. **Client Secret**: **{{ ui-key.yacloud_org.application.overview.secret_section_title }}** section value.
    1. **JWKS URI**: `jwks_uri` value from `{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}`.

1. Click **Create**.
1. In the list of federations, find the new federation and copy its ID. Save this ID as you will need it later.

### Configure the redirect URI in {{ org-full-name }} {#setup-redirect}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the OIDC app.
  1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:

      1. In the **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** field, specify the authentication endpoint for your Cloud.ru instance formatted as follows:
      
          ```text
          https://id.cloud.ru/auth/system/idp/<Cloud.ru_federation_ID>/callback
          ```
          For example: `https://id.cloud.ru/auth/system/idp/5ca1bc33-7e8a-711a-b29a-a8a121eda1cd/callback`.

      1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Update your OAuth client by providing the redirect URI:

     ```bash
     yc iam oauth-client update \
       --id <OAuth_client_ID> \
       --redirect-uris "https://id.cloud.ru/auth/system/idp/<Cloud.ru_federation_ID>/callback"
     ```

     Where:
     
     * `<OAuth_client_ID>`: OAuth client ID you got when you created it.
     * `--redirect-uris`: Authentication endpoint for your Cloud.ru instance. For example: `https://id.cloud.ru/auth/system/idp/5ca1bc33-7e8a-711a-b29a-a8a121eda1cd/callback`.

     Result:

     ```text
     id: ajeiu3otac08********
     name: cloud-ru-oauth-client
     redirect_uris:
       - https://id.cloud.ru/auth/system/idp/5ca1bc33-7e8a-711a-b29a-a8a121eda1cd/callback
     scopes:
       - openid
       - email
       - profile
     folder_id: b1gkd6dks6i1********
     status: ACTIVE
     ```

{% endlist %}

### Add users {#add-users}

To enable your organization's users to authenticate to Cloud.ru using the {{ org-full-name }} OIDC application, you must explicitly add their accounts both to the application and to the Cloud.ru federation.

{% note info %}

Users and groups added to an OIDC application can be managed by a user with the `organization-manager.oidcApplications.userAdmin` [role](../../../organization/security/index.md#organization-manager-oidcApplications-userAdmin) or higher.

{% endnote %}

#### Add users to the {{ org-full-name }} OIDC application {#add-app-users}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the required app.
    1. Navigate to the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}** tab.
    1. Click ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
    1. In the window that opens, select the required user.
    1. Click **{{ ui-key.yacloud.common.add }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Get the [user ID](../../../organization/operations/users-get.md).

  1. To add a user to the application:
   
     1. See the description of the CLI command for adding users to an app:
   
        ```bash
        yc organization-manager idp application oauth application add-assignments --help
        ```
   
     1. Run this command:
   
        ```bash
        yc organization-manager idp application oauth application add-assignments \
          --id <app_ID> \
          --subject-id <user_ID>
        ```
   
        Where:
   
        * `--id`: OIDC app ID.
        * `--subject-id`: User ID.
   
        Result:
   
        ```text
        assignment_deltas:
          - action: ADD
            assignment:
              subject_id: ajetvnq2mil8********
        ```

{% endlist %}

{% note alert %}

Make sure the user's `email` attribute is specified and matches their account email address in the Cloud.ru federation.

{% endnote %}

#### Add users to the Cloud.ru federation {#add-cloudru-users}

1. Log in to the Cloud.ru [console](https://console.cloud.ru/).
1. Open the **Users** section and go to the **Federated users** tab.
1. In the top-right corner, click **Add federation user**.
1. Select the federation you want to add the user to.
1. Specify the user's email address.
1. Grant the user access permissions for projects and platforms.
1. Click **Add**.

## Make sure your application works correctly {#validate}

To make sure both your OIDC app and its integration with Cloud.ru work correctly, authenticate to Cloud.ru as one of the users you added to the app.

Proceed as follows:

1. In your browser, open the Cloud.ru [console](https://console.cloud.ru/) login page.
1. If you were logged in, log out.
1. On the login screen, click **SSO**.
1. In the dialog that appears, enter the ID of the federation you created and click **Log in**.
1. On the {{ yandex-cloud }} authentication page, enter the email address and user password.
1. Make sure you have successfully authenticated to Cloud.ru.
