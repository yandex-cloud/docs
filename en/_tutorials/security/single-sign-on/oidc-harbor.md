# Creating an OIDC application in {{ org-full-name }} for integration with Harbor

[Harbor](https://goharbor.io/) is an open-source registry of container development artifacts: container images, Helm charts, and other data types. Harbor supports authentication via [OpenID Connect](https://en.wikipedia.org/wiki/OpenID#OpenID_Connect_(OIDC)) (OIDC), allowing you to use an external identity provider for user single sign-on.

For the users of your [organization](../../../organization/concepts/organization.md) to sign in to Harbor using OpenID Connect, create an [OIDC application](../../../organization/concepts/applications.md#oidc) in {{ org-full-name }} and set up the integration both in {{ org-full-name }} and Harbor.

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

To grant access to Harbor to organization users:

1. [Create an app](#create-app).
1. [Set up the integration](#setup-integration).
1. [Make sure the application works correctly](#validate).

## Create an app {#create-app}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. In the top-right corner, click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** and in the window that opens:
        1. Select the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.oauth-title_uUs4x }}** single sign-on method.
        1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for your new app: `harbor-oidc-app`.
        1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-folder_rANM4 }}** field, select the folder where you want to create an OAuth client for your app.
        1. Optionally, in the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** field, enter a description for the new app.
        1. Optionally, add [labels](../../../resource-manager/concepts/labels.md):

            1. Click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
            1. Add a label in `key: value` format.
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
       --name harbor-oauth-client \
       --scopes openid,email,profile,groups
     ```

     Where:

     * `--name`: OAuth client name.
     * `--scopes`: User attributes available to Harbor. The specified attributes are:
       * `openid`: User ID. Required attribute.
       * `email`: User email address.
       * `profile`: Additional user details, such as first name, last name, and avatar.
       * `groups`: [User groups](../../../organization/concepts/groups.md) in the organization.

     Result:

     ```text
     id: ajeqqip130i1********
     name: harbor-oauth-client
     folder_id: b1g500m2195v********
     status: ACTIVE
     ```

     Save the `id` field value for when you need to create and configure your app.

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

     Save the `secret_value` field value for when you need to configure Harbor.

  1. Create an OIDC app:

     ```bash
     yc organization-manager idp application oauth application create \
       --organization-id <organization_ID> \
       --name harbor-oidc-app \
       --description "OIDC application for integration with Harbor" \
       --client-id <OAuth_client_ID> \
       --authorized-scopes openid,email,profile,groups \
       --group-distribution-type assigned-groups
     ```

     Where:

     * `--organization-id`: [ID of the organization](../../../organization/operations/organization-get-id.md) you want to create your OIDC app in. This is a required setting.
     * `--name`: OIDC app name. This is a required setting.
     * `--description`: OIDC app description. This is an optional setting.
     * `--client-id`: OAuth client ID you got in Step 2. This is a required setting.
     * `--authorized-scopes`: Specify the same attributes as when creating the OAuth client.
     * `--group-distribution-type`: Specify `assigned-groups` to provide to Harbor only the groups added to the application.

     Result:

     ```text
     id: ek0o663g4rs2********
     name: harbor-oidc-app
     organization_id: bpf2c65rqcl8********
     group_claims_settings:
       group_distribution_type: ASSIGNED_GROUPS
     client_grant:
       client_id: ajeqqip130i1********
       authorized_scopes:
         - openid
         - email
         - profile
         - groups
     status: ACTIVE
     created_at: "2025-10-21T10:51:28.790866Z"
     updated_at: "2025-10-21T12:37:19.274522Z"
     ```

{% endlist %}

## Set up the integration {#setup-integration}

To set up Harbor integration with the OIDC app you created in {{ org-full-name }}, follow the steps both in {{ org-full-name }} and Harbor.

Check that the Harbor URL (portal and registry) is accessible via HTTPS with a trusted certificate: this is required for correct OIDC redirects.

### Configure your OIDC application in {{ org-full-name }} {#setup-idp}

#### Get the application’s credentials {#get-credentials}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the OIDC app.
  1. On the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, expand the **{{ ui-key.yacloud_org.application.overview.idp_section_closed_text }}** section and copy the parameter values you need to set in Harbor:

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
     name: harbor-oidc-app
     organization_id: bpf2c65rqcl8********
     client_grant:
       client_id: ajeqqip130i1********
       authorized_scopes:
         - openid
         - email
         - profile
         - groups
     ```

     Save the `client_id` value: this is the client ID you need to configure Harbor.

  1. Get the OpenID Connect Discovery configuration URL:

     ```bash
     yc organization-manager idp application oauth application get <app_ID> \
       --format json | jq -r '.client_grant.issuer_uri'
     ```

     The result will look as follows:

     ```text
     https://{{ auth-main-host }}/oauth/<OAuth_client_ID>
     ```

     Save this URL to test OpenID Connect Discovery for availability. In the **OIDC Provider Endpoint** field in Harbor, specify the provider's base address: `https://{{ auth-main-host }}` (without the `/.well-known/openid-configuration` suffix).

  1. Use the OAuth client secret that you saved when creating the app in the previous step. If you have not saved the secret, create a new one:

     ```bash
     yc iam oauth-client-secret create \
       --oauth-client-id <OAuth_client_ID>
     ```

     Save the `secret_value` from the command output: this is the client secret you need to configure Harbor.

{% endlist %}

#### Configure the redirect URI {#setup-redirect}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the OIDC app.
  1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:
      1. In the **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** field, specify the endpoint in the following format:

         ```text
         https://<Harbor_domain>/c/oidc/callback
         ```

      1. In the **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.field-scopes_hEuar }}** field, check the `{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.oauth-scope-groups_iZoa5 }}` attribute and select `{{ ui-key.yacloud_org.organization.apps.field_group_assigned_amGdu }}`.

      1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Update your OAuth client by providing the redirect URI:

  ```bash
  yc iam oauth-client update \
    --id <OAuth_client_ID> \
    --redirect-uris "https://<Harbor_domain>/c/oidc/callback"
  ```

  Where:

  * `<OAuth_client_ID>`: OAuth client ID you got when you created it.
  * `--redirect-uris`: Harbor callback endpoint, e.g., `https://reg.example.com/c/oidc/callback`.

  Result:

  ```text
  id: ajeiu3otac08********
  name: harbor-oauth-client
  redirect_uris:
    - https://reg.example.com/c/oidc/callback
  scopes:
    - openid
    - email
    - profile
    - groups
  folder_id: b1gkd6dks6i1********
  status: ACTIVE
  ```

{% endlist %}

### Set up Harbor {#setup-sp}

On the Harbor side, you should act under the system administrator account.

#### Install Harbor

1. If you do not have the Harbor registry yet, install it on your VM: install Docker Engine version `20.10.10` or higher and the `docker compose` plugin in advance. To learn how to install Docker on Ubuntu, see [this official Docker guide](https://docs.docker.com/engine/install/ubuntu/).
1. Connect to the VM via SSH, navigate to the unpacked Harbor installer directory, and make sure that Docker and `docker compose` are available:

   ```bash
   docker --version
   docker compose version
   ```

1. Create a configuration file from a template:

   ```bash
   cp harbor.yml.tmpl harbor.yml
   ```

1. Open `harbor.yml` and set the required parameters:

   * `hostname`: VM FQDN for access to Harbor. We recommend to use a domain name for OIDC.
   * `harbor_admin_password`: Harbor administrator password.
   * `database.password`: Harbor local database password.
   * `https` section parameters (`port`, `certificate`, `private_key`): Specify the paths to the certificate and key for access to Harbor via TLS.

   For more information on the file parameters, see this Harbor guide: [Configure the Harbor YML File](https://goharbor.io/docs/main/install-config/configure-yml-file/).

1. Configure external TLS for Harbor:

   Specify the path to the certificate in `harbor.yml`. Detailed guide: [Configure HTTPS Access to Harbor](https://goharbor.io/docs/main/install-config/configure-https/).

1. Optionally, enable internal TLS between Harbor components via the `internal_tls` section in `harbor.yml`.

   This step is recommended for production installations with increased internal traffic protection requirements. For more information, see the following: [Configure Internal TLS communication between Harbor Component](https://goharbor.io/docs/main/install-config/configure-internal-tls/).

1. Run Harbor installation from the installer directory:

   ```bash
   sudo ./install.sh
   ```

   For more information, see the following: [Run the Installer Script](https://goharbor.io/docs/main/install-config/run-installer-script/).

1. Log in to the Harbor web interface using an administrator account.

#### Set up authentication

{% note info %}

To switch Harbor to **OIDC** mode, there must be no user accounts in the Harbor database other than the built-in administrator account (this rule remains in effect after the first administrator sign-in: it is enough to have no other local users). For more information, see [this Harbor OIDC guide](https://goharbor.io/docs/latest/administration/configure-authentication/oidc-auth/).

{% endnote %}

Before configuring OIDC, make sure the web interface is accessible via HTTPS. This is a mandatory condition: Harbor uses a callback URL of this format: `https://<Harbor_domain>/c/oidc/callback`.

1. Open the **Administration** section and go to **Configuration**.
1. Open the **Authentication** tab.
1. In the **Auth Mode** field, select **OIDC**.
1. Fill in the OIDC provider fields:

    * **OIDC Provider Name**: Any login button name, e.g., `{{ org-full-name }}`.
    * **OIDC Provider Endpoint**: OIDC provider's base address: `https://{{ auth-main-host }}`. If you copy the value from the **{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}** field, remove the `/.well-known/openid-configuration` suffix from it.
    * **OIDC Client ID**: **{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}** value.
    * **OIDC Client Secret**: Previously saved OAuth client secret.
    * **OIDC Scope**: Specify separated by commas, `openid,profile,email,groups`.
    * **Verify Certificate**: Leave enabled if the identity provider certificate is trusted for Harbor.

1. If you plan to transfer groups from {{ org-full-name }} to Harbor:

    * Under **Group Claim Name**, specify `groups`.
    * If necessary, set **OIDC Admin Group** and **OIDC Group Filter** as per [this Harbor guide](https://goharbor.io/docs/latest/administration/configure-authentication/oidc-auth/).

1. Optionally, enable **Automatic onboarding** if you do not want to specify your Harbor username manually the first time you log in. In the **Username Claim** field, enter the ID token claim you want to use as a login (`preferred_username` is recommended; you can also use `email`. Align the selected value with the attributes returned by {{ org-full-name }}).

1. Make sure the **Redirect URI** value at the bottom of the page matches the one you specified in the OIDC application in {{ org-full-name }} (`https://<Harbor_domain>/c/oidc/callback`).

1. Click **Test OIDC Server** and make sure the test runs without errors.

1. Click **Save**.

For more information on OIDC mode fields and limitations, see [this official Harbor guide](https://goharbor.io/docs/latest/administration/configure-authentication/oidc-auth/).

### Add a user {#add-user}

For the organization users to sign in to Harbor through the {{ org-full-name }} OIDC app, explicitly add the users and/or [user groups](../../../organization/concepts/groups.md) to the app.

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

To test the OIDC app and its integration with Harbor, sign in to Harbor as the user you added to the app.

Follow these steps:

1. In your browser, navigate to your Harbor instance address, e.g., `https://<Harbor_domain>`.
1. If already signed in, sign out of your account.
1. On the login page, click the OIDC login button (the text matches the value of the **OIDC Provider Name** field in Harbor).
1. On the {{ yandex-cloud }} authentication page, enter the user's email and password. The user or group they belong to must be added to the application.
1. Make sure you have successfully signed in to Harbor.
1. Optionally, open the Harbor user's profile to check the user's group memberships, if group transfer has been configured.
