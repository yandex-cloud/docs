# Creating an OIDC application in {{ org-full-name }} for integration with Grafana OSS

[Grafana Open Source Software (OSS)](https://grafana.com/oss/) is a free open-source data monitoring and visualization platform you can deploy on your own infrastructure. Grafana OSS supports [OpenID Connect](https://en.wikipedia.org/wiki/OpenID#OpenID_Connect_(OIDC)) (OIDC) authentication to provide secure SSO for your organization's users.

To authenticate your [organization's](../../../organization/concepts/organization.md) users to Grafana OSS with OpenID Connect SSO, create an [OIDC app](../../../organization/concepts/applications.md#oidc) in {{ org-name }} and configure it appropriately both in {{ org-name }} and Grafana OSS.

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

For the users of your organization to be able to access Grafana OSS:

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
        1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for your new app: `grafana-oss-oidc-app`.
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
       --name grafana-oss-oauth-client \
       --scopes openid,email,profile,groups
     ```

     Where:

     * `--name`: OAuth client name.
     * `--scopes`: User attributes that will be available to Grafana OSS. The specified attributes are:
       * `openid`: User ID. Required attribute.
       * `email`: User email address.
       * `profile`: Additional user details, such as first name, last name, and avatar.
       * `groups`: [User groups](../../../organization/concepts/groups.md) in the organization.

     Result:

     ```text
     id: ajeqqip130i1********
     name: grafana-oss-oauth-client
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

     Save the `secret_value` field value: you will need it to configure Grafana OSS.
  
  1. Create an OIDC app:

     ```bash
     yc organization-manager idp application oauth application create \
       --organization-id <organization_ID> \
       --name grafana-oss-oidc-app \
       --description "OIDC application for integration with Grafana OSS" \
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
     * `--group-distribution-type`: Specify `assigned-groups` to only provide groups added to the application to Grafana OSS.

     Result:

     ```text
     id: ek0o663g4rs2********
     name: grafana-oss-oidc-app
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

To integrate Grafana OSS with the OIDC app you created in {{ org-name }}, complete the setup both on the Grafana OSS side and in {{ org-name }}.

### Configure your OIDC application in {{ org-full-name }} {#setup-idp}

#### Get the application’s credentials {#get-credentials}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the OIDC app.
  1. On the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, expand the **{{ ui-key.yacloud_org.application.overview.idp_section_closed_text }}** section and copy the parameter values you need to specify in Grafana OSS:

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
     name: grafana-oss-oidc-app
     organization_id: bpf2c65rqcl8********
     client_grant:
       client_id: ajeqqip130i1********
       authorized_scopes:
         - openid
         - email
         - profile
         - groups
     ```

     Save the `client_id` value: this is the Client ID you will need to configure your Grafana OSS.

  1. Get the OpenID Connect Discovery configuration URL:

     ```bash
     yc organization-manager idp application oauth application get <app_ID> \
       --format json | jq -r '.client_grant.issuer_uri'
     ```

     The result will look as follows:

     ```text
     https://{{ auth-main-host }}/oauth/<OAuth_client_ID>
     ```

     Save this URL: this is the OpenID Connect Discovery URL you will need to configure your Grafana OSS.

  1. Use the OAuth client secret that you saved when creating the app in the previous step. If you have not saved the secret, create a new one:

     ```bash
     yc iam oauth-client-secret create \
       --oauth-client-id <OAuth_client_ID>
     ```

     Save the `secret_value` from the command output: this is the Client Secret you will need to configure your Grafana OSS.

{% endlist %}

#### Configure the redirect URI {#setup-redirect}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the OIDC app.
  1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:
      1. In the **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** field, specify the authentication endpoint for your Grafana OSS instance formatted as follows:

         ```text
         <Grafana_OSS_instance_URL>/login/generic_oauth
         ```

      1. In the **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.field-scopes_hEuar }}** field, check the `{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.oauth-scope-groups_iZoa5 }}` attribute and select `{{ ui-key.yacloud_org.field-data.attributes.update_dialog.field_group_assigned }}`.

      1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Update your OAuth client by providing the redirect URI:

  ```bash
  yc iam oauth-client update \
    --id <OAuth_client_ID> \
    --redirect-uris "<Grafana_OSS_instance_URL>/login/generic_oauth"
  ```

  Where:
  
  * `<OAuth_client_ID>`: OAuth client ID you got when you created it.
  * `--redirect-uris`: Authentication endpoint for your Grafana OSS instance, e.g., `https://your-domain/login/generic_oauth`.

  Result:

  ```text
  id: ajeiu3otac08********
  name: grafana-oss-oidc-app
  redirect_uris:
    - https://your-domain/login/generic_oauth
  scopes:
    - openid
    - email
    - profile
    - groups
  folder_id: b1gkd6dks6i1********
  status: ACTIVE
  ```

{% endlist %}

### Set up the OIDC application in Grafana OSS {#setup-sp}

To configure OpenID Connect authentication in Grafana OSS, in the left-hand panel, navigate to **Administration** and then to **Authentication**. In the main window, select **Generic OAuth**.

In the Generic OAuth settings:

1. Under **Display name**, specify `OpenID Connect`.
1. Under **Client ID**, specify the value you copied from the **{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}** field when setting up the OIDC application in {{ org-name }}.
1. In the **Client Secret** field, specify the value you copied from the **{{ ui-key.yacloud_org.application.overview.secret_section_title }}** section when setting up the OIDC application in {{ org-name }}.
1. In the **Scopes** field, enter the following, one by one: `openid`, `email`, `profile`, `groups`.
1. Click **Enter OpenID Connect Discovery URL** and then, in the window that opens, specify the URL you copied from the **{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}** field when setting up the OIDC application in {{ org-name }}.
1. Enable **Allow sign up** to automatically create users on first sign-in.

#### Configure role mapping {#role-mapping}

{% note info %}

Grafana OSS uses JMESPath expressions for role mapping. See [this Grafana guide for examples of using JMESPath expressions](https://grafana.com/docs/grafana/latest/setup-grafana/configure-access/configure-authentication/generic-oauth/#role-mapping-examples).

{% endnote %}

1. Expand the **User mapping** section.
1. In the **Role attribute path** field, enter the JMESPath expression for role mapping.

If you need to map the `Editor` role to a user in the `grafana-users` group, enter the following expression in the **Role attribute path** field:

```text
contains(groups[*], 'grafana-users') && 'Editor' || 'Viewer'
```

The expression means the user will get the `Editor` role if they belong to the `grafana-users` group, and the `Viewer` role otherwise.

#### Configure the redirect URI in Grafana OSS {#setup-redirect-grafana}

The redirect URI you previously specified in {{ org-full-name }} must match the URI that Grafana OSS sends to {{ org-full-name }}.

To do so:

1. Open the [Grafana configuration file](https://grafana.com/docs/grafana/latest/setup-grafana/configure-grafana/#configuration-file-location).
1. In the `[server]` section, set:

   ```text
   root_url = https://your-domain
   ```

1. [Restart](https://grafana.com/docs/grafana/latest/setup-grafana/start-restart-grafana/) Grafana OSS.

### Add a user {#add-user}

For your organization's users to be able to authenticate in Grafana OSS with {{ org-name }}'s OIDC app, you need to explicitly add these users and/or [user groups](../../../organization/concepts/groups.md) to the OIDC application.

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

To make sure both your OIDC app and Grafana OSS integration work correctly, authenticate to Grafana OSS as one of the users you added to the app.

To do so:

1. In your browser, navigate to the address of your Grafana OSS instance, e.g., `https://your-domain`.
1. If you were logged in to Grafana OSS, log out.
1. On the Grafana OSS sign in page, click **Sign in with OpenID Connect**.
1. On the {{ yandex-cloud }} sign in page, enter the user email and password. The user or group they belong to must be added to the application.
1. Make sure you are logged in to Grafana OSS.
1. If you have configured role mapping, go to the user profile in Grafana OSS and make sure the appropriate role is displayed under Organizations.