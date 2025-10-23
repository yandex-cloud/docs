# Creating an OIDC application in {{ org-full-name }} for integration with Grafana Cloud

{% include [note-preview](../../../_includes/note-preview.md) %}

[Grafana Cloud](https://grafana.com/products/cloud/) is a managed cloud monitoring and observability platform that brings together Grafana, Prometheus, Loki, and other tools for data visualization and analysis. Grafana Cloud supports OpenID Connect (OIDC) authentication to provide secure SSO for your organization's users.

To authenticate your [organization's](../../../organization/concepts/organization.md) users to Grafana Cloud with [OpenID Connect](https://en.wikipedia.org/wiki/OpenID_Connect)-based SSO, create an [OIDC app](../../../organization/concepts/applications.md#oidc) in {{ org-name }} and configure it appropriately both in {{ org-name }} and Grafana Cloud.

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

To grant access to Grafana Cloud to your organization's users:

1. [Create a Grafana Cloud account](#grafana-account).
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

{% endlist %}

## Set up the integration {#setup-integration}

To integrate Grafana Cloud with the OIDC app you created in {{ org-name }}, complete the setup on the Grafana Cloud side and in {{ org-name }}.

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

{% endlist %}

#### Configure the redirect URI {#setup-redirect}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the OIDC app.
  1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:
      1. In the **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** field, specify the authentication endpoint for your Grafana Cloud instance formatted as follows:

        ```
        <Grafana_Cloud_instance_URL>/login/generic_oauth
        ```

        For example: `https://your-org.grafana.net/login/generic_oauth`.

      1. Click **{{ ui-key.yacloud.common.save }}**.

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

To permit your organization's users to authenticate in Grafana Cloud with {{ org-name }}'s OIDC app, you need to explicitly add these users and/or [user groups](../../../organization/concepts/groups.md) to the OIDC application.

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

{% endlist %}

## Make sure your application works correctly {#validate}

To make sure both your OIDC app and Grafana Cloud integration work correctly, authenticate to Grafana Cloud as one of the users you added to the app.

To do this:

1. In your browser, navigate to the address of your Grafana Cloud instance, e.g., `https://your-org.grafana.net`.
1. If you were logged in to Grafana Cloud, log out.
1. On the Grafana Cloud sign in page, click **Sign in with OpenID Connect**.
1. On the {{ yandex-cloud }} sign in page, enter the user email and password. The user or group they belong to must be added to the application.
1. Make sure you are logged in to Grafana Cloud.
