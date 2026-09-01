# Creating an OIDC app in {{ org-full-name }} for integration with Time

[Time](https://time-messenger.ru/) is a corporate messenger with single sign-on support based on the [OpenID Connect](https://en.wikipedia.org/wiki/OpenID#OpenID_Connect_(OIDC)) (OIDC) standard.

For your [organization's](../../../organization/concepts/organization.md) users to be able to authenticate to Time via OpenID Connect SSO, create an [OIDC app](../../../organization/concepts/applications/oidc.md) in {{ org-full-name }} and configure it both in {{ org-full-name }} and Time.

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

To provide your organization's with access to Time:

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
        1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify a name for your new app: `time-oidc-app`.
        1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-folder_rANM4 }}** field, select the folder where you want to create an OAuth client for your app.
        1. Optionally, add a description and [labels](../../../resource-manager/concepts/labels.md) for the app.
        1. Click **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.create-app-submit_myxPn }}**.

{% endlist %}

## Set up the integration {#setup-integration}

To configure Time integration with the OIDC app you created in {{ org-full-name }}, complete the configuration both on the {{ org-full-name }} side and in Time.

### Get the application's credentials and create a secret for it {#get-credentials-secret}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, click ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select =`time-oidc-app`.
    1. On the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, copy the **{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}** setting value.
    1. {% include [oidc-generate-secret](../../../_includes/organization/oidc-generate-secret.md) %}

{% endlist %}

### Set up OIDC authentication in Time {#setup-sp}

1. Log in to the Time system console at `https://<instance_name>.time-messenger.ru/admin_console/authentication/openid`, where `<instance_name>` is the name of your Time instance.
1. Under **Authentication**:
   1. Select **OpenID Connect**.
   1. Under **Select provider**, select **OpenID connection (Other)**.
   1. Optionally, in the **Button name** field, enter the text that appears on the login button on the login page, e.g., `Via OIDC`.
   1. Optionally, select a color for the login page button.
   1. In the **Issuer link** field, enter the OpenID Connect provider's address: `https://auth.yandex.cloud`.
   1. In the **Client ID** field, enter the **{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}** value you copied from {{ org-full-name }}.
   1. In the **Client key** field, specify the application secret generated in {{ org-full-name }}.
1. Save the settings.

### Configure a redirect URI in {{ org-full-name }} {#setup-redirect}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, click ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select `time-oidc-app`.
    1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:
        1. In the **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** field, specify this callback address: `https://<instance_name>.time-messenger.ru/signup/openid/complete`, where `<instance_name>` is the name of the Time instance (subdomain at `time-messenger.ru`).
        1. {% include [org-oidc-app-disable-pkce](../../../_tutorials/_tutorials_includes/org-oidc-app-disable-pkce.md) %}
        1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Add users {#add-users}

To authenticate with Time, add the required users and/or [user groups](../../../organization/concepts/groups.md) to your {{ org-full-name }} OIDC application.

{% include [oidc-manage-users](../../../_includes/organization/oidc-manage-users.md) %}

To add users to a SAML application:

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, click ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and select `time-oidc-app`.
    1. Navigate to the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.assignments_kKzJS }}** tab.
    1. Click ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.organization.apps.AppAssignmentsPage.action_add-assignments }}**.
    1. In the window that opens, select the required users.
    1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

{% include [auth-policy-applications-tip](../../../_includes/organization/auth-policy-applications-tip.md) %}

## Make sure your application works correctly {#validate}

To ensure that your OIDC application and integration with Time are working correctly, log in to Time as one of the added users. Proceed as follows:

1. In your browser, open the login page of your Time instance: `https://<instance_name>.time-messenger.ru`.
1. Select login via OpenID Connect.
1. Authenticate in {{ yandex-cloud }} under a user account from your organization.
1. Make sure you have signed in to Time following a successful authentication.
