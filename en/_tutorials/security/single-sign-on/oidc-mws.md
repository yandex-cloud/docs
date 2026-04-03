# Creating an OIDC application in {{ org-full-name }} for integration with MWS


[MTS Web Services (MWS)](https://mws.ru/) is an ecosystem of services and platform solutions for building and managing IT infrastructure. MWS supports [OpenID Connect](https://en.wikipedia.org/wiki/OpenID#OpenID_Connect_(OIDC)) (OIDC) authentication to provide secure SSO for your organization's users.

To authenticate your [organization's](../../../organization/concepts/organization.md) users to MWS with OpenID Connect SSO, create an [OIDC app](../../../organization/concepts/applications.md#oidc) in {{ org-full-name }} and configure it appropriately both in {{ org-full-name }} and MWS.

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

For your organization's users to be able to access MWS:

1. [Create an account in MWS](#mws-account).
1. [Create an app](#create-app).
1. [Set up the integration](#setup-integration).
1. [Make sure the application works correctly](#validate).

## Create an account in MWS {#mws-account}

If you do not have an MWS account, create one:

1. On the [MWS console login page](https://console.mws.ru/), click **Log in via MTS ID**.
1. Create a MTS ID account:
    * Enter your phone number. The number will be linked to the account and cannot be replaced later.
    * Enter the confirmation code from the text message.
1. Create an MWS account:
    * Enter the email that will be linked to your MWS account.
    * Click **Next**.
    * Confirm your registration by clicking the **Confirm email** link in the message.
    * Accept the terms of the user agreement and click **Log in to console**.
1. In the menu on the left, navigate to **Organization**, then **About organization**.
1. Save your MWS organization ID, e.g., `organization-test`; you will need it to configure the integration.

## Create an app {#create-app}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. In the top-right corner, click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** and in the window that opens:
        1. Select the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.oauth-title_uUs4x }}** single sign-on method.
        1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for your new app: `mws-oidc-app`.
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
       --name mws-oauth-client \
       --scopes openid,email,profile
     ```

     Where:

     * `--name`: OAuth client name.
     * `--scopes`: User attributes available to MWS. The specified attributes are:
       * `openid`: User ID. Required attribute.
       * `email`: User email address.
       * `profile`: Additional user details, such as first name, last name, and avatar.

     Result:

     ```text
     id: ajeqqip130i1********
     name: mws-oauth-client
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

     Save the value of the `secret_value` field: you will need it to configure MWS.
  
  1. Create an OIDC app:

     ```bash
     yc organization-manager idp application oauth application create \
       --organization-id <organization_ID> \
       --name mws-oidc-app \
       --description "OIDC application for integration with MWS" \
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
     * `--group-distribution-type`: Set to `none` as user groups are not provided to MWS.

     Result:

     ```text
     id: ek0o663g4rs2********
     name: mws-oidc-app
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

To configure MWS integration with the OIDC app you created in {{ org-full-name }}, complete the configuration both on the MWS side and in {{ org-full-name }}.

### Get the application’s credentials {#get-credentials}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the OIDC app.
  1. On the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, expand the **{{ ui-key.yacloud_org.application.overview.idp_section_closed_text }}** section and copy the **{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}** value you need to set on the MWS side.
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
     name: mws-oidc-app
     organization_id: bpf2c65rqcl8********
     client_grant:
       client_id: ajeqqip130i1********
       authorized_scopes:
         - openid
         - email
         - profile
     ```

     Save the `client_id` value: you will need to configure your MWS.

  1. Use the OAuth client secret that you saved when creating the app in the previous step. If you have not saved the secret, create a new one:

     ```bash
     yc iam oauth-client-secret create \
       --oauth-client-id <OAuth_client_ID>
     ```

     Save the `secret_value` from the command output: this is the client secret that you will need to configure your MWS.

{% endlist %}

### Set up the application in MWS {#setup-sp}

To set up OIDC authentication in MWS, create and configure an [identity federation](https://mws.ru/docs/cloud-platform/org-rm/general/federation-overview.html), and then set up an OIDC client on the MWS side.

#### Set up your federation {#setup-federation}

1. Log in to [your organization's console](https://org.mws.ru).
1. In the left-hand panel, select **Federations**.
1. Click **Create**.
1. Set up your federation:
    1. Give your federation a name. Save the organization ID, e.g., `organization-test`; you will need it to configure the integration.
    1. Optionally, select the roles that will be assigned to users authorized through the federation.

        {% note info %}

        For more details on configuring roles for federated users, see the [MWS guide](https://mws.ru/docs/cloud-platform/org-rm/general/federation-roles.html).

        {% endnote %}

    1. Specify the session lifetime after which the user will need to re-authenticate.
    1. Optionally, provide a description for the federation.
1. Click **Create**.

#### Configure the OIDC client {#setup-provider}

1. After creating the federation, click **Add IdP**.
1. Optionally, enter a description for the provider.
1. Click **Next**.
1. In the **Issuer** field, enter `https://{{ auth-main-host }}`, then click **Upload**. The configuration will be populated automatically.
1. In the **Client ID** field, enter the value previously copied from the **{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}** field.
1. In the **Client Secret** field, enter the previously generated application secret.
1. Under **Data retrieval method**, select **Token Endpoint and UserInfo Endpoint**, then click **Next**.
1. Next to the `mws.subject` attribute, in the **IdP** field, enter `preferred_username` and click **Next**.
1. Check the configuration and click **Create**.
1. After completing the setup, select the added IdP again in the **Federations** section, then save the provider ID, e.g., `-testprov`; you will need it to configure the integration.

### Configure the redirect URI {#setup-redirect}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the OIDC app.
  1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:
      1. In the **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** field, specify the authentication endpoint for your MWS federation in this format:

          ```text
          https://auth.mws.ru/api/iam/v1/organizations/<organization_ID>/userFederations/<created_federation_id>/providers/<provider_id>/login-callback
          ```

          Here is an example: 

          ```text
          https://auth.mws.ru/api/iam/v1/organizations/organization-test/userFederations/federation-test/providers/-testprov/login-callback
          ```

      1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Update your OAuth client by providing the redirect URI:

  ```bash
  yc iam oauth-client update \
    --id <OAuth_client_ID> \
    --redirect-uris "https://auth.mws.ru/api/iam/v1/organizations/<organization_ID>/userFederations/<created_federation_id>/providers/<provider_id>/login-callback"
  ```

  Where:
  
  * `<OAuth_client_ID>`: OAuth client ID you got when you created it.
  * `--redirect-uris`: The authentication endpoint for your MWS federation. Here is an example: 

     ```text
     https://auth.mws.ru/api/iam/v1/organizations/organization-test/userFederations/federation-test/providers/-testprov/login-callback
     ```

  Result:

  ```text
  id: ajeiu3otac08********
  name: mws-oidc-app
  redirect_uris:
    - https://auth.mws.ru/api/iam/v1/organizations/organization-test/userFederations/federation-test/providers/-testprov/login-callback
  scopes:
    - openid
    - email
    - profile
  folder_id: b1gkd6dks6i1********
  status: ACTIVE
  ```

{% endlist %}

### Add a user {#add-user}

For your organization's users to be able to authenticate in MWS with {{ org-full-name }}'s OIDC app, you need to explicitly add these users and/or [user groups](../../../organization/concepts/groups.md) to the OIDC application.

{% note info %}

Users and groups added to an OIDC application can be managed by a user with the `organization-manager.oidcApplications.userAdmin` [role](../../../organization/security/index.md#organization-manager-oidcApplications-userAdmin) or higher.

{% endnote %}

Add a user to the application:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the required app.
    1. Navigate to the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}** tab.
    1. Click ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
    1. In the window that opens, select the required user or user group.
    1. Click **{{ ui-key.yacloud.common.add }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Get the [user ID](../../../organization/operations/users-get.md) or [user group ID](../../../organization/operations/group-get-id.md).

  1. To add a user or user group to the app:
   
     1. See the description of the CLI command for adding users to an app:
   
        ```bash
        yc organization-manager idp application oauth application add-assignments --help
        ```
   
     1. Run this command:
   
        ```bash
        yc organization-manager idp application oauth application add-assignments \
          --id <app_ID> \
          --subject-id <user_or_group_ID>
        ```
   
        Where:
   
        * `--id`: OIDC app ID.
        * `--subject-id`: User or user group ID.
   
        Result:
   
        ```text
        assignment_deltas:
          - action: ADD
            assignment:
              subject_id: ajetvnq2mil8********
        ```

{% endlist %}

## Make sure your application works correctly {#validate}

To make sure both your OIDC app and MWS integration work correctly, authenticate to MWS as one of the users you added to the app.

Proceed as follows:

1. In your browser, navigate to [your organization's console](https://org.mws.ru).
1. In the left-hand panel, select **Federations**.
1. Select the IdP you added earlier.
1. On the provider's page, copy the **Sign In URL** from the **Main** section. This is the link for logging into the MWS console as a federated user.
1. Log out of your MWS profile.
1. Paste the link you copied into your browser address bar and follow it.
1. On the {{ yandex-cloud }} authentication page, enter the user email and password. The user or group they belong to must be added to the application.
1. Read and accept the terms of use, then click **Next**.
1. Make sure you have successfully authenticated to MWS.