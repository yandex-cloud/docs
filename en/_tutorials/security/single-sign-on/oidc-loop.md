# Creating an OIDC app in {{ org-full-name }} for integration with Loop

[Loop](https://loop.ru/) is a corporate messenger with single sign-on support based on the [OpenID Connect](https://en.wikipedia.org/wiki/OpenID#OpenID_Connect_(OIDC)) (OIDC) standard.

For your [organization's](../../../organization/concepts/organization.md) users to be able to authenticate to Loop via OpenID Connect SSO, create an [OIDC app](../../../organization/concepts/applications/oidc.md) in {{ org-full-name }} and configure it both in {{ org-full-name }} and Loop.

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

To provide your organization's users with to Loop:

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
        1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for your new app: `loop-oidc-app`.
        1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-folder_rANM4 }}** field, select the folder where you want to create an OAuth client for your app.
        1. Optionally, add a description and [labels](../../../resource-manager/concepts/labels.md) for the app.
        1. Click **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

## Set up the integration {#setup-integration}

To configure Loop integration with the OIDC app you created in {{ org-full-name }}, complete the configuration both on the {{ org-full-name }} side and in Loop.

### Get the application's credentials and create the application's secret {#get-credentials-secret}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, click ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the `loop-oidc-app` app.
    1. On the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, copy the **{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}** setting value.
    1. {% include [oidc-generate-secret](../../../_includes/organization/oidc-generate-secret.md) %}

{% endlist %}

### Set up OIDC authentication in Loop {#setup-sp}

1. Log in to the Loop system console at `https://<instance_name>.loop.ru/admin_console/authentication/openid`, where `<instance_name>` is the name of your Loop instance.
1. Under **Authentication**:
   1. Select **OpenID Connect**.
   1. Under **Select provider**, select **OpenID connection (Other)**.
   1. Optionally, in the **Button name** field, enter the text that will appear on the login button on the login page, e.g., `Via OIDC`.
   1. Optionally, select the color of the login page button.
   1. In the **Issuer link** field, enter the OpenID Connect provider's address: `https://auth.yandex.cloud`.
   1. Set the **Client ID** field, enter the **{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}** you copied from {{ org-full-name }}.
   1. In the **Client key** field, specify the application secret generated in {{ org-full-name }}.
1. Save the settings.

### Configure a redirect URI in {{ org-full-name }} {#setup-redirect}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, click ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the `loop-oidc-app` app.
    1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:
        1. In the **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** field, specify the callback address: `https://<instance_name>.loop.ru/signup/openid/complete`, where `<instance_name>` is the name of the Loop instance (subdomain at `loop.ru`).
        1. {% include [org-oidc-app-disable-pkce](../../../_tutorials/_tutorials_includes/org-oidc-app-disable-pkce.md) %}
        1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Add users {#add-users}

To authenticate with Loop, add the required users and/or [user groups](../../../organization/concepts/groups.md) to your {{ org-full-name }} OIDC application.

{% include [oidc-manage-users](../../../_includes/organization/oidc-manage-users.md) %}

To add users to a SAML application:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, click ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select the `loop-oidc-app` app.
    1. Navigate to the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}** tab.
    1. Click ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
    1. In the window that opens, select the required users.
    1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [auth-policy-applications-tip](../../../_includes/organization/auth-policy-applications-tip.md) %}

## Make sure your application works correctly {#validate}

To ensure that your OIDC application and integration with Loop are working correctly, log in to Loop as one of the added users. Proceed as follows:

1. In your browser, open the login page of your Loop instance: `https://<instance_name>.loop.ru`.
1. Select login via OpenID Connect.
1. Authenticate in {{ yandex-cloud }} under a user account from your organization.
1. Make sure you have signed in to Loop following a successful authentication.
