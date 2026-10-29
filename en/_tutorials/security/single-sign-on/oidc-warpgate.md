# Creating an OIDC application in {{ org-full-name }} for integration with Warpgate


[Warpgate](https://warpgate.null.page/) is an open-source [bastion host](*bastion-host) for secure access to internal services over SSH, HTTP, MySQL, PostgreSQL, Kubernetes, RDP, and VNC. Warpgate supports [OpenID Connect](https://en.wikipedia.org/wiki/OpenID#OpenID_Connect_(OIDC)) (OIDC) user authentication via external identity providers.

To enable your [organization’s](*organization) users to authenticate in Warpgate via OIDC, create an [OIDC application](../../../organization/concepts/applications/oidc.md) and set up Warpgate integration. In this tutorial, you will also configure [user group](*users-groups) provisioning to Warpgate and map the groups to access roles.

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

To provide your organization’s users with access to Warpgate:

1. [Create an OIDC app](#create-app).
1. [Create a user group and add users to it](#create-group).
1. [Set up the integration](#setup-integration).
1. [Make sure the application works correctly](#validate).

If you no longer need the resources you created, [delete them](#clear-out).

## Creating an OIDC app {#create-app}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. Click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** and in the window that opens:
      1. Select the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.oauth-title_uUs4x }}** single sign-on (SSO) method.
      1. {% include [org-oidc-app-select-web-type-step](../../../_tutorials/_tutorials_includes/org-oidc-app-select-web-type-step.md) %}
      1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify `warpgate-oidc-app`.
      1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-folder_rANM4 }}** field, select the folder where you want to create an OAuth client for your app.
      1. Optionally, enter a description in the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}**** field, e.g., `OIDC app for integration with Warpgate`.
      1. Click **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.
  1. In the new app, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** at the top right.
  1. In the **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.field-scopes_hEuar }}** field, select the `{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.oauth-scope-groups_iZoa5 }}` attribute and set it to `{{ ui-key.yacloud_org.organization.apps.field_group_assigned_amGdu }}`. In new OIDC apps, this attribute is off by default.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Create an OAuth client:

     ```bash
     yc iam oauth-client create \
       --name warpgate-oauth-client \
       --scopes openid,email,profile,groups \
       --profile-id web
     ```

     Where:

     * `--name`: OAuth client name.
     * `--scopes`: User attributes available to Warpgate. The specified attributes are:
       * `openid`: User ID. Required attribute.
       * `email`: User email address.
       * `profile`: Additional user details, such as first name, last name, and avatar.
       * `groups`: [User groups](../../../organization/concepts/groups.md) in the organization. You will need groups for mapping to Warpgate access roles.
     * {% include [org-oidc-app-select-web-type-legend-cli](../../../_tutorials/_tutorials_includes/org-oidc-app-select-web-type-legend-cli.md) %}

     Result:

     ```text
     id: ajeqqip130i1********
     name: warpgate-oauth-client
     folder_id: b1g500m2195v********
     authentication_methods:
       - client_secret_basic
       - client_secret_post
     status: ACTIVE
     profile_id: web
     pkce_required: true
     ```

     Save the `id` field value: you will need to create and configure your app.

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
       created_at: "2026-09-12T10:14:17.861652377Z"
     secret_value: yccs__939233b8ac********
     ```

     Save the `secret_value` field value: you will need it to configure Warpgate.

  1. Create an OIDC app:

     ```bash
     yc organization-manager idp application oauth application create \
       --organization-id <organization_ID> \
       --name warpgate-oidc-app \
       --description "OIDC app for integration with Warpgate" \
       --client-id <OAuth_client_ID> \
       --authorized-scopes openid,email,profile,groups \
       --group-distribution-type assigned-groups
     ```

     Where:

     * `--organization-id`: [ID of the organization](../../../organization/operations/organization-get-id.md) you want to create your OIDC app in. This is a required setting.
     * `--name`: OIDC app name. This is a required setting.
     * `--description`: OIDC app description. This is an optional setting.
     * `--client-id`: OAuth client ID you got in the previous step. This is a required setting.
     * `--authorized-scopes`: Specify the same attributes as when creating the OAuth client.
     * `--group-distribution-type`: Specify `assigned-groups` to provide to Warpgate only the groups added to the application.

     Result:

     ```text
     id: ek0o663g4rs2********
     name: warpgate-oidc-app
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
     created_at: "2026-09-12T10:51:28.790866Z"
     updated_at: "2026-09-12T12:37:19.274522Z"
     ```

     Save the ID of the new OIDC app.

{% endlist %}

## Create a user group and add users to it {#create-group}

Organize users who need the same Warpgate access level into an organization [group](../../../organization/concepts/groups.md). Then map the group name to a Warpgate access role.

### Create a group {#create-group-step}

Create a group named `warpgate-users`.

{% include [create-group-org](../../../_includes/organization/create-group-org.md) %}

### Add users to the group {#add-users-to-group}

Follow [this guide](../../../organization/operations/add-member-group.md) to add all users who need the same Warpgate access level into the `warpgate-users` group.

### Add the group to the OIDC app {#add-group-to-app}

For the `warpgate-users` group users to be able to sign in to Warpgate through your new OIDC application, and to provide the group in the `groups` attribute, explicitly add the group to the application.

{% note info %}

Users and groups added to an OIDC application can be managed by any user with the `organization-manager.oauthApplications.userAdmin` [role](../../../organization/security/index.md#organization-manager-oauthApplications-userAdmin) or higher.

{% endnote %}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, navigate to ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select `warpgate-oidc-app`.
  1. Navigate to the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}** tab.
  1. Click ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
  1. In the window that opens, select the `warpgate-users` group.
  1. Click **{{ ui-key.yacloud.common.add }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. [Get the ID](../../../organization/operations/group-get-id.md) of the `warpgate-users` group.
  1. Add the group to the app:

     ```bash
     yc organization-manager idp application oauth application add-assignments \
       --id <app_ID> \
       --subject-id <group_ID>
     ```

     Where:

     * `--id`: OIDC app ID.
     * `--subject-id`: `warpgate-users` group ID.

{% endlist %}

{% include [auth-policy-applications-tip](../../../_includes/organization/auth-policy-applications-tip.md) %}

## Set up the integration {#setup-integration}

To configure Warpgate integration with the new OIDC app, perform the setup both in {{ org-full-name }} and Warpgate.

### Get the OIDC app connection credentials {#get-credentials}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, navigate to ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select `warpgate-oidc-app`.
  1. Under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** on the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, expand the **{{ ui-key.yacloud_org.application.overview.idp_section_closed_text }}** section and save the Client ID value (**{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}**).
  1. {% include [oidc-generate-secret](../../../_includes/organization/oidc-generate-secret.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Get the new OIDC app info:

     ```bash
     yc organization-manager idp application oauth application get <app_ID>
     ```

     Save the `client_id` value from the `client_grant` section: this is the Client ID you will need to configure Warpgate.

  1. Use the OAuth client secret you saved when creating the app. If you have not saved the secret, create a new one:

     ```bash
     yc iam oauth-client-secret create \
       --oauth-client-id <OAuth_client_ID>
     ```

     Save the `secret_value` value: this is the Client Secret you will need to configure Warpgate.

{% endlist %}

For {{ org-full-name }}, the issuer URL is `https://{{ auth-main-host }}`. You will need it to configure Warpgate.

### Configure a redirect URI {#setup-redirect}

Warpgate uses the following address format: `https://<warpgate_domain>/_warpgate/api/sso/return`, where `<warpgate_domain>` is the [external domain](https://warpgate.null.page/sso/#external-host) of your Warpgate instance specified in the `external_host` parameter of the configuration file.

For example, if `external_host: warpgate.example.com`, the redirect URI will look like this:

```text
https://warpgate.example.com/_warpgate/api/sso/return
```

{% note info %}

By default, Warpgate generates a redirect URI with `@` (`/@warpgate/api/sso/return`). {{ org-full-name }} does not support this symbol. For Warpgate to replace the `@warpgate` prefix with `_warpgate`, specify `return_url_prefix: _` in the Warpgate SSO provider configuration.

{% endnote %}

Specify the resulting address in the OAuth client settings:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, navigate to ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select `warpgate-oidc-app`.
  1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. In the **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** field, specify:

     ```text
     https://<warpgate_domain>/_warpgate/api/sso/return
     ```

  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Update your OAuth client by providing the redirect URI:

  ```bash
  yc iam oauth-client update \
    --id <OAuth_client_ID> \
    --redirect-uris "https://<warpgate_domain>/_warpgate/api/sso/return"
  ```

{% endlist %}

{% note warning %}

The redirect URI in {{ org-full-name }} and that in Warpgate must fully match, including the scheme, domain, and path.

{% endnote %}

### Create an access role in Warpgate {#setup-warpgate-role}

On the Warpgate side, create an [access role](https://warpgate.null.page/roles/#access-roles) that will be assigned to users successfully authenticated through {{ org-full-name }}:

1. Log in to Warpgate using an administrator account.
1. In the menu, go **Config** → **Access roles**.
1. Click **Add a role**.
1. Enter a name for the role, e.g., `user`, and save the changes.

In the next step, specify this role in the `role_mappings` parameter of the Warpgate configuration file.

### Configure an SSO provider in the Warpgate configuration file {#setup-warpgate-sso}

{% note info %}

For more information about setting up SSO for Warpgate, see [this official Warpgate guide](https://warpgate.null.page/sso/).

{% endnote %}

Open the Warpgate configuration file (`warpgate.yaml`) and add a `custom` type SSO provider to it:

```yaml
sso_providers:
- name: idh
  auto_create_users: true
  return_url_prefix: _
  return_url_domain: external_host
  label: SSO with Identity Hub
  provider:
    type: custom
    client_id: <OIDC_app_client_id>
    client_secret: <OIDC_app_secret>
    issuer_url: https://{{ auth-main-host }}
    scopes: ["openid", "profile", "email", "groups"]
    roles_claim: groups
    role_mappings:
      'warpgate-users': 'user'
external_host: <warpgate_domain>
```

Where:

* `name`: Provider ID.
* `auto_create_users: true`: Warpgate automatically creates accounts for users who authenticate through {{ org-full-name }} for the first time. The username is taken from the `preferred_username` attribute, or from the `email` attribute if there is no `preferred_username`.
* `return_url_prefix: _`: Replaces `@` with `_` in the redirect URI because {{ org-full-name }} does not support `@` in this address.
* `return_url_domain: external_host`: Warpgate generates the redirect URI based on the domain from `external_host`.
* `label`: Login button label on the Warpgate authentication page.
* `provider`: OIDC provider settings:
  * `type: custom`: Integration type for a custom OIDC-compliant identity provider; in this case, {{ org-full-name }}.
  * `client_id` and `client_secret`: Client ID and OIDC app secret you got [earlier](#get-credentials).
  * `issuer_url`: {{ org-full-name }} issuer URL, `https://{{ auth-main-host }}`.
  * `scopes`: User attributes Warpgate requests from {{ org-full-name }}. These must match the attributes specified when configuring the OIDC application.
  * `roles_claim: groups`: ID token attribute with the user’s groups. The `groups` value matches the standard {{ org-full-name }} group attribute.
  * `role_mappings`: Mapping between {{ org-full-name }} groups and Warpgate access roles. In our example, the `warpgate-users` group is mapped to the `user` role [created earlier](#setup-warpgate-role). Warpgate syncs only the roles specified in this parameter without touching the user’s other roles.
* `external_host`: External domain of the Warpgate instance, e.g., `warpgate.example.com`. It must match the domain specified in the Redirect URI field of the OIDC application.

Save the configuration file and restart Warpgate to apply the changes.

## Make sure your application works correctly {#validate}

1. Log out of Warpgate if already logged in.
1. Open the Warpgate login page at your instance URL, e.g., `https://warpgate.example.com`.
1. Click the login button of the same name as the `label` parameter value.
1. On the {{ yandex-cloud }} authentication page, log in as a user belonging to the `warpgate-users` group.
1. Make sure that after successful authentication the browser returns to Warpgate, and the user gets access to the interface with the `user` role.
1. You can look up the **Users** section in Warpgate to make sure the new user got the expected role.

## How to delete the resources you created {#clear-out}

To stop paying for the {{ org-full-name }} resources you created, [delete](../../../organization/operations/applications/oidc-deactivate-remove.md#delete) the OIDC app.

[Delete](../../../organization/operations/delete-group.md) the new `warpgate-users` group too if you need to.

[*bastion-host]: {% include [bastion-host-popup](../../../_popups/bastion-host.md) %}

[*organization]: {% include [organization-definition](../../../_popups/identity-hub/organization-definition.md) %}

[*users-groups]: {% include [users-groups](../../../_popups/identity-hub/users-groups.md) %}
