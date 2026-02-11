# Creating an OIDC application in {{ org-full-name }} for integration with Grafana Cloud


[Grafana Cloud](https://grafana.com/products/cloud/) is a managed cloud monitoring and observability platform that brings together Grafana, Prometheus, Loki, and other tools for data visualization and analysis. Grafana Cloud supports [OpenID Connect](https://en.wikipedia.org/wiki/OpenID#OpenID_Connect_(OIDC)) (OIDC) authentication to provide secure SSO for your organization's users.

To authenticate your [organization's](../../../organization/concepts/organization.md) users to Grafana Cloud with OpenID Connect SSO, create an [OIDC app](../../../organization/concepts/applications.md#oidc) in {{ org-name }} and configure it appropriately both in {{ org-name }} and Grafana Cloud.

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

For the users of your organization to be able to access Grafana Cloud:

1. [Create a Grafana Cloud account](#grafana-account).
1. [Create an app](#create-app).
1. [Set up the integration](#setup-integration).
1. [Make sure the application works correctly](#validate).

## Create a Grafana Cloud account {#grafana-account}

If you do not have a Grafana Cloud account, create one:

1. Go to the [Grafana Cloud sign up page](https://grafana.com/auth/sign-up/).
1. Fill out the registration form:
    - Enter your email address.
    - Create a secure password.
1. Click **Create my account**.
1. Verify your new account by following the instructions sent to the email address you provided.
1. Select a name for your organization; this name will be part of your instance's URL, e.g., `your-org`.
1. Once logged in, make sure you have administrator permissions to configure OIDC in your Grafana Cloud organization.
1. Write down your Grafana Cloud instance’s URL, e.g., `https://your-org.grafana.net`, as you will need it to set up the integration.

{% note info %}

To configure OIDC in Grafana Cloud, you need organization administrator permissions. If you do not have the required permissions, contact your organization's administrator in Grafana Cloud.

{% endnote %}

## Create an app {#create-app}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. In the top-right corner, click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** and in the window that opens:
        1. Select the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.oauth-title_uUs4x }}** single sign-on method.
        1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for your new app: `grafana-cloud-oidc-app`.
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
       --name grafana-cloud-oauth-client \
       --scopes openid,email,profile
     ```

     Where:

     * `--name`: OAuth client name.
     * `--scopes`: User attributes that will be available to Grafana Cloud. The specified attributes are:
       * `openid`: User ID. Required attribute.
       * `email`: User email address.
       * `profile`: Additional user details, such as first name, last name, and avatar.

     Result:

     ```text
     id: ajeqqip130i1********
     name: grafana-cloud-oauth-client
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

     Save the `secret_value` field value: you will need it to configure your Grafana Cloud.
  
  1. Create an OIDC app:

     ```bash
     yc organization-manager idp application oauth application create \
       --organization-id <organization_ID> \
       --name grafana-cloud-oidc-app \
       --description "OIDC application for integration with Grafana Cloud" \
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
     * `--group-distribution-type`: Set to `none` as user groups are not provided to Grafana Cloud.

     Result:

     ```text
     id: ek0o663g4rs2********
     name: grafana-cloud-oidc-app
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

To integrate Grafana Cloud with the OIDC app you created in {{ org-name }}, complete the setup both on the Grafana Cloud side and in {{ org-name }}.

### Configure your OIDC application in {{ org-full-name }} {#setup-idp}

#### Get the application’s credentials {#get-credentials}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the OIDC app.
  1. On the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, expand the **{{ ui-key.yacloud_org.application.overview.idp_section_closed_text }}** section and copy the parameter values you need to specify in Grafana Cloud:

        * `{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}`: Unique application ID.
        * `{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}`: URL with the configuration of all parameters required to set up the integration.

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
     name: grafana-cloud-oidc-app
     organization_id: bpf2c65rqcl8********
     client_grant:
       client_id: ajeqqip130i1********
       authorized_scopes:
         - openid
         - email
         - profile
     ```

     Save the `client_id` value: this is the Client ID you will need to configure your Grafana Cloud.

  1. Get the OpenID Connect Discovery configuration URL:

     ```bash
     yc organization-manager idp application oauth application get <app_ID> \
       --format json | jq -r '.client_grant.issuer_uri'
     ```

     The result will look as follows:

     ```text
     https://{{ auth-main-host }}/oauth/<OAuth_client_ID>
     ```

     Save this URL: this is the OpenID Connect Discovery URL you will need to configure your Grafana Cloud.

  1. Use the OAuth client secret that you saved when creating the app in the previous step. If you have not saved the secret, create a new one:

     ```bash
     yc iam oauth-client-secret create \
       --oauth-client-id <OAuth_client_ID>
     ```

     Save the `secret_value` value from the command output: this is the Client Secret you will need to configure your Grafana Cloud.

{% endlist %}

#### Configure the redirect URI {#setup-redirect}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the OIDC app.
  1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:
      1. In the **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** field, specify the authentication endpoint for your Grafana Cloud instance formatted as follows:

        ```text
        <Grafana_Cloud_instance_URL>/login/generic_oauth
        ```

        For example: `https://your-org.grafana.net/login/generic_oauth`.

      1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Update your OAuth client by providing the redirect URI:

     ```bash
     yc iam oauth-client update \
       --id <OAuth_client_ID> \
       --redirect-uris "<Grafana_Cloud_instance_URL>/login/generic_oauth"
     ```

     Where:
     
     * `<OAuth_client_ID>`: OAuth client ID you got when you created it.
     * `--redirect-uris`: Authentication endpoint for your Grafana Cloud instance. For example: `https://your-org.grafana.net/login/generic_oauth`.

     Result:

     ```text
     id: ajeiu3otac08********
     name: grafana-cloud-oidc-app
     redirect_uris:
       - https://your-org.grafana.net/login/generic_oauth
     scopes:
       - openid
       - email
       - profile
     folder_id: b1gkd6dks6i1********
     status: ACTIVE
     ```

{% endlist %}

### Set up the OIDC application in Grafana Cloud {#setup-sp}

To configure OpenID Connect authentication in Grafana Cloud, in the left-hand panel, navigate to **Administration** and then to **Authentication**.
In the main window, select **Generic OAuth**.

In the Generic OAuth settings:

1. Under **Name**, specify `OpenID Connect`.
1. In the **Scopes** field, enter the following, one by one: `openid`, `email`, `profile`.
1. Under **Client ID**, specify the value you copied from the **{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}** field when setting up the OIDC application in {{ org-name }}.
1. In the **Client Secret** field, specify the value you copied from the **{{ ui-key.yacloud_org.application.overview.secret_section_title }}** section when setting up the OIDC application in {{ org-name }}.
1. Click **Enter OpenID Connect Discovery URL** and then, in the window that opens, specify the URL you copied from the **{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}** field when setting up the OIDC application in {{ org-name }}.
1. Enable **Allow sign up** to automatically create users on first sign-in.

### Add a user {#add-user}

For your organization's users to be able to authenticate in Grafana Cloud with {{ org-name }}'s OIDC app, you need to explicitly add these users and/or [user groups](../../../organization/concepts/groups.md) to the OIDC application.

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

To make sure both your OIDC app and Grafana Cloud integration work correctly, authenticate to Grafana Cloud as one of the users you added to the app.

To do so:

1. In your browser, navigate to the address of your Grafana Cloud instance, e.g., `https://your-org.grafana.net`.
1. If you were logged in to Grafana Cloud, log out.
1. On the Grafana Cloud sign in page, click **Sign in with OpenID Connect**.
1. On the {{ yandex-cloud }} sign in page, enter the user email and password. The user or group they belong to must be added to the application.
1. Make sure you are logged in to Grafana Cloud.
