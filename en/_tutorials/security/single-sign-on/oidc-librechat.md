# Creating an OIDC application in {{ org-full-name }} for integration with LibreChat

[LibreChat](https://www.librechat.ai/) is a free open-source platform that provides an easy way to work with large language models, AI agents, and MCP servers and can be deployed in your own infrastructure. LibreChat supports [OpenID Connect](https://en.wikipedia.org/wiki/OpenID#OpenID_Connect_(OIDC)) (OIDC) authentication to provide secure SSO for your organization's users.

For your [organization's](../../../organization/concepts/organization.md) users to be able to authenticate to LibreChat via OpenID Connect SSO, create an [OIDC app](../../../organization/concepts/applications/oidc.md) in {{ org-full-name }} and configure it both in {{ org-full-name }} and LibreChat.

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

To provide your organization's users with access to LibreChat:

1. [Create an app](#create-app).
1. [Set up the integration](#setup-integration).
1. [Add users](#add-users).
1. [Make sure the application works correctly](#validate).

## Create an app {#create-app}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. In the top-right corner, click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** and in the window that opens:
        1. Select the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.oauth-title_uUs4x }}** single sign-on method.
        1. {% include [org-oidc-app-select-web-type-step](../../../_tutorials/_tutorials_includes/org-oidc-app-select-web-type-step.md) %}
        1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for your new app: `librechat-oidc-app`.
        1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-folder_rANM4 }}** field, select the folder where you want to create an OAuth client for your app.
        1. Optionally, add a description and [labels](../../../resource-manager/concepts/labels.md) for the app.
        1. Click **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

## Set up the integration {#setup-integration}

To configure LibreChat integration with the OIDC app you created in {{ org-full-name }}, complete the configuration both on the {{ org-full-name }} side and in LibreChat.

### Get the application's credentials and create the application's secret {#get-credentials-secret}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, navigate to ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select `librechat-oidc-app`.
    1. On the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, copy the **{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}** field value.
    1. {% include [oidc-generate-secret](../../../_includes/organization/oidc-generate-secret.md) %}

{% endlist %}

### Configure advanced OIDC app settings in {{ org-full-name }} {#setup-redirect}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, navigate to ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select `librechat-oidc-app`.
    1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:

        1. Set the **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** field to `https://<server_address>/oauth/openid/callback`, where `<server_address>` is the public IP address or domain name of your LibreChat instance.

            {% note info %}

            In the {{ org-full-name }} OIDC app settings, the `Redirect URI` value only supports the `https://` scheme, so your LibreChat instance must be accessible over `https`.

            {% endnote %}

        1. Under **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.field-scopes_hEuar }}**, enable **{{ ui-key.yacloud_org.organization.apps.OauthAppEditForm.oauth-scope-groups_iZoa5 }}**.
        1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### Set up OIDC authentication in LibreChat {#setup-sp}

1. On the host running your LibreChat instance, set the following environment variables in the instance runtime environment to configure LibreChat integration with the OIDC application:

    * Variables defining the main integration settings:

        Variable name | Value
        --- | ---
        `OPENID_CLIENT_ID` | **{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}** field value obtained [earlier](#get-credentials-secret) from the {{ yandex-cloud }} OIDC app settings
        `OPENID_CLIENT_SECRET` | OIDC app secret generated [earlier](#get-credentials-secret)
        `OPENID_ISSUER` | `"https://auth.yandex.cloud/"`
        `OPENID_SESSION_SECRET` | Additional secret used to secure sessions.</br></br>Generate a strong secret of at least 32 characters.
        `OPENID_SCOPE` | `"openid profile email groups"`
        `OPENID_CALLBACK_URL` | `"/oauth/openid/callback"`
        `OPENID_USERNAME_CLAIM` | `"preferred_username"`
        `OPENID_NAME_CLAIM` | `"name"`
        `OPENID_EMAIL_CLAIM` | `"email"`
        `OPENID_USE_PKCE` | `true`
        `OPENID_BUTTON_LABEL` | `"Login with {{ org-full-name }}"`
        `OPENID_AUTO_REDIRECT` | `false`
    * Variables defining advanced settings for user group synchronization:

        Variable name | Value
        --- | ---
        `OPENID_ROLE_SYNC_ENABLED` | `true`
        `OPENID_ROLE_SYNC_API_ENABLED` | `false`
        `OPENID_ROLE_SYNC_SOURCE` | `"id"`
        `OPENID_ROLE_SYNC_CLAIM` | `"groups"`
        `OPENID_ROLE_SYNC_ROLE_PRIORITY` | List of group names in {{ org-full-name }} to synchronize with.</br></br>Here is an example: `"librechat-admins,librechat-users"`.
        `OPENID_ROLE_SYNC_FALLBACK_ROLE` | Default user group.</br></br>Here is an example: `"librechat-users"`.
1. Restart your LibreChat instance in the runtime environment with the specified environment variables.

## Add users {#add-users}

To enable users to authenticate in LibreChat:

1. In {{ org-full-name }}, [create](../../../organization/operations/create-group.md) a [user group](../../../organization/concepts/groups.md) under one of the names specified [earlier](#setup-sp) in the `OPENID_ROLE_SYNC_ROLE_PRIORITY` environment variable, e.g., `librechat-users`.
1. [Add](../../../organization/operations/add-member-group.md) a user to the `librechat-users` group.
1. Add the `librechat-users` group to the {{ org-full-name }} OIDC app:

    {% include [oidc-manage-users](../../../_includes/organization/oidc-manage-users.md) %}

    {% list tabs group=instructions %}

    - {{ cloud-center }} UI {#cloud-center}

        1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
        1. In the left-hand panel, navigate to ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select `librechat-oidc-app`.
        1. Navigate to the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}** tab.
        1. Click ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
        1. In the window that opens, navigate to the **{{ ui-key.yacloud_org.common.resource-acl.label_groups_mQQ4T }}** tab and select `librechat-users`.
        1. Click **{{ ui-key.yacloud.common.add }}**.

    {% endlist %}

{% include [auth-policy-applications-tip](../../../_includes/organization/auth-policy-applications-tip.md) %}

## Make sure your application works correctly {#validate}

To ensure that your OIDC application and integration with LibreChat are working correctly, log in to LibreChat as one of the users added to the `librechat-users` group. Follow these steps:

1. In your browser, open the LibreChat instance login page.
1. Select login via {{ org-full-name }}.
1. Authenticate in {{ yandex-cloud }} as a user of your organization.
1. After authenticating successfully, make sure you are logged in to LibreChat and your authorized user belongs to the same group, `librechat-users`, in both LibreChat and {{ org-full-name }}.
