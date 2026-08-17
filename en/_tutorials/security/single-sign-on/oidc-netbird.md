# Creating an OIDC app in {{ org-full-name }} for integration with NetBird


[NetBird](https://netbird.io/) is a platform for establishing secure access to network resources. NetBird supports [OpenID Connect](https://en.wikipedia.org/wiki/OpenID#OpenID_Connect_(OIDC)) authentication (OIDC) for the users of your organization to use single sign-on via {{ org-full-name }}.

In this tutorial, you will create an OIDC app and [user pool](../../../organization/concepts/user-pools.md) in {{ org-full-name }}, get a `Client ID`, app secret, and [configuration URL](../../../organization/concepts/applications/oidc.md#oidc-sp-setup), and then configure an external OIDC provider in NetBird Dashboard.

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

To give access to NetBird to the users of your organization:

1. [Get your cloud ready](#before-begin).
1. [Create an OIDC app](#create-app).
1. [Create a user pool and add users to it](#create-userpool).
1. [Set up the integration](#setup-integration).
1. [Make sure the application works correctly](#validate).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of infrastructure support includes a fee for using the [OIDC app](../../../organization/concepts/applications/oidc.md) (see [{{ org-full-name }} pricing](../../../organization/pricing.md)).

### Getting started {#check-to-begin}

Make sure that:

* You have access to [{{ org-full-name }}]({{ link-org-cloud-center }}) with permissions to create OIDC apps and user pools.
* Self-hosted NetBird is deployed, with administrator access to NetBird Dashboard.
* Public URL of NetBird Dashboard is known, e.g., `https://netbird.example.com`.
* Users to log in to NetBird have been added to the organization or local accounts have been [created](../../../organization/operations/add-account.md#local-users) for them in the user pool.

{% note info %}

The examples below use the following NetBird address: `https://netbird.example.com`. Replace it with the address of your NetBird instance.

{% endnote %}

## Creating an OIDC app {#create-app}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
  1. Click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** and in the window that opens:
      1. Select the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.oauth-title_uUs4x }}** single sign-on (SSO) method.
      1. {% include [org-oidc-app-select-web-type-step](../../../_tutorials/_tutorials_includes/org-oidc-app-select-web-type-step.md) %}
      1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify `netbird-oidc-app`.
      1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-folder_rANM4 }}** field, select the folder where you want to create an OAuth client for your app.
      1. Optionally, enter a description in the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-description_kzkNB }}** field, e.g., `OIDC app for integration with NetBird`.
      1. Click **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Create an OAuth client:

     ```bash
     yc iam oauth-client create \
       --name netbird-oauth-client \
       --profile-id web
     ```

     Where:
     
     * `--name`: OAuth client name.
     * {% include [org-oidc-app-select-web-type-legend-cli](../../../_tutorials/_tutorials_includes/org-oidc-app-select-web-type-legend-cli.md) %}

     Result:

     ```text
     id: aje9rrbpcndp********
     name: netbird-oauth-client
     folder_id: b1g07hj5r6i4********
     authentication_methods:
       - client_secret_basic
       - client_secret_post
     status: ACTIVE
     profile_id: web
     pkce_required: true
     ```

     Where `id` is the new OAuth client ID. Save its value for later to create an OIDC application and secret.

  1. Create a secret for your OAuth client:

     ```bash
     yc iam oauth-client-secret create \
       --oauth-client-id <OAuth_client_ID>
     ```

     Result:

     ```text
     oauth_client_secret:
       id: ajeedld61h87********
       oauth_client_id: aje9rrbpcndp********
       masked_secret: yccs__ecf960********
       created_at: "2026-06-11T17:22:20.955Z"
     secret_value: yccs__ecf9609df********
     ```

     Where `secret_value` is the secret for your OAuth client. Save its value for later to configure NetBird.

  1. Create an OIDC app:

     ```bash
     yc organization-manager idp application oauth application create \
       --organization-id <organization_ID> \
       --name netbird-oidc-app \
       --description "OIDC app for integration with NetBird" \
       --client-id <OAuth_client_ID> \
       --group-distribution-type none
     ```

     Where:

     * `--organization-id`: [ID of the organization](../../../organization/operations/organization-get-id.md) you want to create your OIDC app in.
     * `--client-id`: OAuth client ID created in the previous step.
     * `--group-distribution-type`: `none` because user groups are not transferred in the basic NetBird integration scenario.

     Result:

     ```text
     id: ek0o663g4rs2********
     name: netbird-oidc-app
     organization_id: bpf2c65rqcl8********
     group_claims_settings:
       group_distribution_type: NONE
     client_grant:
       client_id: ajeqqip130i1********
     status: ACTIVE
     created_at: "2025-10-21T10:51:28.790866Z"
     updated_at: "2025-10-21T12:37:19.274522Z"
     ```

     Save the ID of the new OIDC app.

{% endlist %}

### Configure user OIDC attributes {#setup-scopes}

NetBird typically uses standard [attributes](../../../organization/concepts/applications/oidc.md#oidc-attributes) (scopes):

**Minimum required set**: `openid, email, profile`.

Possible attributes:

* `openid`: User ID. Required attribute.
* `profile`: Additional user information: first name, last name, avatar.
* `email`: User email address.
* `address`: User home address.
* `phone`: User phone number.
* `groups`: [User groups](../../../organization/concepts/groups.md) in the organization.

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, navigate to ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select `netbird-oidc-app`.
  1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. In the **{{ ui-key.yacloud_org.application.overview.oauth_field_scopes }}** field, specify the recommended set of scopes: `openid, profile, email`.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Update your OAuth client to specify the recommended set of scopes:

     ```bash
     yc iam oauth-client update \
       --id <OAuth_client_ID> \
       --scopes openid,profile,email
     ```

     Where:

     * `--id`: ID of the OAuth client you created earlier.
     * `--scopes`: User attributes available to NetBird: This example shows the recommended set of attributes:
       * `openid`: User ID. Required attribute.
       * `profile`: Additional user information: first name, last name, avatar.
       * `email`: User email address.

  1. Update the OIDC app with the same attributes:

     ```bash
     yc organization-manager idp application oauth application update \
       --id <app_ID> \
       --authorized-scopes openid,profile,email
     ```

     Where:

     * `--id`: ID of the OIDC app you created earlier.
     * `--authorized-scopes`: Attributes that were specified when updating the OAuth client.

{% endlist %}

## Create a user pool and add users to it {#create-userpool}

A {{ org-full-name }} [user pool](../../../organization/concepts/user-pools.md) is what determines who can authenticate to the application. This guide uses local users. If a suitable pool already exists, use it and proceed to the next section.

### Create a user pool {#create-userpool-step}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}**.
  1. In the top-right corner of the page, click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.organization.userpools.action_create-userpool }}**.
  1. Specify a name for the pool, e.g., `netbird-users`, and provide an optional description. The name must be unique within the organization and follow these naming requirements:
     
     {% include [group-name-format](../../../_includes/organization/group-name-format.md) %}
     
  1. In the **{{ ui-key.yacloud_org.form.userpool.caption.domain }}** field, specify the default [domain](../../../organization/concepts/domains.md) for the users of the pool. This domain will be used if no other domains are linked to the pool.
  1. Optionally, add labels to organize your resources:
     
     * Click **{{ ui-key.yacloud.common.add }}**.
     * Enter a label in `<key>: <value>` format.
     * Press **Enter**.
     
  1. Optionally, in the **{{ ui-key.yacloud_org.form.userpool.caption.settings-data }}** field, select the user settings available for editing on the [My account](../../../organization/concepts/my-account.md) portal. By default, password management is allowed.
  1. In the **{{ ui-key.yacloud_org.form.userpool.caption.session-lifetime }}** field, specify a time period for user [sessions](../../../organization/concepts/sessions.md) to remain active before requiring reauthentication in {{ org-full-name }}.
  1. Click **{{ ui-key.yacloud_org.form.userpool.create.action.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Create a user pool:

     ```bash
     yc organization-manager idp userpool create \
       --organization-id <organization_ID> \
       --userpool-name netbird-users \
       --description "User pool for logging into NetBird" \
       --default-subdomain <default_domain>
     ```

     Where `--default-subdomain` is the domain that will be used for user logins if no other domains are linked to the pool.

     Save the ID of the new user pool.

{% endlist %}

### Add users to the pool {#add-users-to-pool}

Add to the pool all users who need access to NetBird. The pool supports two types of users:

* *{{ org-full-name }} local users*. These users are [created](../../../organization/operations/add-account.md#local-users) and managed within {{ org-full-name }}. Suitable for employees and service accounts not requiring an external IdP. You can add such users manually, via an invitation, or from the organization user list.
* *Users with a [Yandex account](../../../iam/concepts/users/accounts.md#passport)*. These users log in using Yandex ID. Suitable if the organization relies on Yandex accounts for access.

### Add users or groups to the OIDC app {#add-users-to-app}

To allow the pool users to log in to NetBird via the new OIDC app, explicitly add particular users or user groups to it.

{% note info %}

Users and groups added to an OIDC application can be managed by any user with the `organization-manager.oauthApplications.userAdmin` [role](../../../organization/security/index.md#organization-manager-oauthApplications-userAdmin) or higher.

{% endnote %}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, navigate to ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select `netbird-oidc-app`.
  1. Navigate to the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}** tab.
  1. Click ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
  1. In the window that opens, select users or user groups, e.g., the new `netbird-users` pool or Yandex ID users.
  1. Click **{{ ui-key.yacloud.common.add }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Get the [user ID](../../../organization/operations/users-get.md) or [user group ID](../../../organization/operations/group-get-id.md).
  1. Add a user or group to the application:

     ```bash
     yc organization-manager idp application oauth application add-assignments \
       --id <app_ID> \
       --subject-id <user_or_group_ID>
     ```

{% endlist %}

{% include [auth-policy-applications-tip](../../../_includes/organization/auth-policy-applications-tip.md) %}

## Set up the integration {#setup-integration}

To configure NetBird integration with the new OIDC app, perform the setup both in {{ org-full-name }} and NetBird.

### Get the OIDC app connection credentials {#get-credentials}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, navigate to ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select `netbird-oidc-app`.
  1. Under **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** on the **{{ ui-key.yacloud_org.application.overview.idp_section_title }}** tab, expand the **{{ ui-key.yacloud_org.application.overview.idp_section_closed_text }}** section and save the following:

      * `{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}`: Client ID.
      * `{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}`: URL OpenID Connect Discovery.

  1. {% include [oidc-generate-secret](../../../_includes/organization/oidc-generate-secret.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Get the app info:

     ```bash
     yc organization-manager idp application oauth application get <app_ID>
     ```

     Save the `client_id` value from the `client_grant` section.

  1. Get an issuer URL:

     ```bash
     yc organization-manager idp application oauth application get <app_ID> \
       --format json | jq -r '.client_grant.issuer_uri'
     ```

     Save this value. NetBird normally uses an issuer URL and gets the necessary endpoints automatically through discovery. If your NetBird version expects a discovery URL, use the value from the **{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}** field in the {{ cloud-center }} interface.

     For {{ org-full-name }}, the issuer URL is `https://auth.yandex.cloud`. The discovery endpoint is available at `https://auth.yandex.cloud/.well-known/openid-configuration`.

  1. If no secret was saved earlier, create a new one:

     ```bash
     yc iam oauth-client-secret create \
       --oauth-client-id <OAuth_client_ID>
     ```

     Save `secret_value`.

{% endlist %}

### Configure a redirect URI {#setup-redirect}

NetBird uses a callback URL to complete OIDC authentication. Its typical format is:

```text
https://<NetBird_domain>/oauth2/callback
```

Here is an example:

```text
https://netbird.example.com/oauth2/callback
```

Specify this address in the OAuth client settings. If NetBird shows a callback URL in the provider's setup interface, use exactly this value.

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, navigate to ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select `netbird-oidc-app`.
  1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. In the **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** field, specify:

     ```text
     https://<NetBird_domain>/oauth2/callback
     ```

  1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Update your OAuth client by providing the redirect URI:

  ```bash
  yc iam oauth-client update \
    --id <OAuth_client_ID> \
    --redirect-uris "https://<NetBird_domain>/oauth2/callback"
  ```

{% endlist %}

{% note warning %}

The redirect URI in {{ org-full-name }} must exactly match the callback URL used by NetBird: they must have the same scheme, domain, path, and trailing slash (`/`) if any.

{% endnote %}

### Configure an external OIDC provider in NetBird Dashboard {#setup-netbird}

{% note info %}

For more information on setting up external identity providers in NetBird, see [this official NetBird guide](https://docs.netbird.io/selfhosted/identity-providers/generic-oidc).

{% endnote %}

1. Open NetBird Dashboard at your instance's address, e.g., `https://netbird.example.com`, and log in under an administrator account.
1. Navigate to **Settings** → **Identity Providers**.
1. Click **Add Identity Provider** or a similar button in your NetBird version.
1. Select provider type, **OpenID Connect** or **Generic OIDC**.
1. Specify the connection parameters:

   * **Name**: For example, `Yandex Cloud Identity Hub`.
   * **Client ID**: `client_id` value issued by {{ org-full-name }}.
   * **Client Secret**: OIDC app secret.
   * **Issuer URL** or **Authority**: Issuer URL issued by {{ org-full-name }}.

1. If NetBird displays a callback URL, make sure it matches the value specified in the OIDC app's redirect URI.
1. Save the settings.
1. If you have several providers configured in NetBird, make the new provider the default one if needed.
1. Restart NetBird services for the changes to take effect. For example, for Docker Compose:

   ```bash
   docker compose down
   docker compose up -d
   ```

{% note info %}

Depending on your NetBird version, the names of sections and fields may slightly differ. If your interface does not allow you to specify individual endpoints, it is enough to specify the issuer URL: NetBird will get `authorization_endpoint`, `token_endpoint`, `userinfo_endpoint`, and `jwks_uri` automatically.

{% endnote %}

## Make sure your application works correctly {#validate}

1. Log out of NetBird Dashboard if already logged in.
1. Open the NetBird login page.
1. Click the sign in button via the configured OIDC provider, e.g., **Continue with Yandex Cloud**.
1. On the {{ yandex-cloud }} authentication page, log in as a user who:

   * Has been added to the user pool.
   * Has been added to the OIDC app either directly or via a group.

1. Make sure that after successful authentication the browser returns to NetBird, and the user gets access to the Dashboard.
1. If NetBird displays the user profile, check that you are logged in under the account you expected and that the email address is correct.

## Possible errors {#troubleshooting}

### `redirect_uri mismatch` {#redirect-uri-mismatch}

Cause: NetBird's callback URL does not match the OAuth client's redirect URI.

What to check:

* NetBird and {{ org-full-name }} use the same URL.
* `https` scheme, domain, `/oauth2/callback` path, and trailing `/`, if any, are the same.

### `invalid_client` {#invalid-client}

Cause: Incorrect Client ID or Client Secret specified in NetBird.

What to check:

* NetBird uses the correct `client_id` of the new OIDC app.
* The secret was saved correctly and was not replaced with a new one without updating the NetBird settings.

### `invalid_scope` {#invalid-scope}

Cause: NetBird is requesting scopes the application is not allowed to use.

What to check:

* `openid`, `email`, `profile` are allowed in OAuth client and OIDC app.
* NetBird does not specify additional scopes that are not configured in {{ org-full-name }}.

If the error persists, start with a minimum set of scopes, `openid profile email`, and then add more as needed.

### User cannot log in {#user-cannot-login}

What to check:

* The user is added to the user pool.
* The user is activated.
* The user or the user's group is added to the OIDC app.
* If NetBird uses the `email` claim, the user's email address is provided.

### NetBird does not accept the token {#token-rejected}

What to check:

* The token's `issuer` value matches the issuer URL specified in NetBird.
* The `aud` value matches the app's client ID.
* NetBird's management service can access the provider's JWKS endpoint.
* NetBird uses the correct user claim: `sub`.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created, [delete](../../../organization/operations/applications/oidc-deactivate-remove.md#delete) the OIDC app.
