# Creating an OIDC application in {{ org-full-name }} for integration with 1C:Enterprise


{% include [note-preview](../../../_includes/note-preview.md) %}

[1C:Enterprise](https://scloud.ru/1s-predpriyatie/) is a development platform for 1C accounting and business automation applications. It supports [OpenID Connect](https://{{ lang }}.wikipedia.org/wiki/OpenID) (OIDC) authentication to provide secure SSO for your organization's users.

To authenticate your [organization's](../../../organization/concepts/organization.md) users to 1C:Enterprise with [OpenID Connect](https://en.wikipedia.org/wiki/OpenID_Connect) SSO, create an [OIDC app](../../../organization/concepts/applications.md#oidc) in {{ org-full-name }} and configure it appropriately both in {{ org-name }} and 1C:Enterprise.

{% include [oidc-app-admin-role](../../../_includes/organization/oidc-app-admin-role.md) %}

For the users of your organization to be able to access 1C:Enterprise:

1. [Create an app](#create-app).
1. [Set up the integration](#setup-integration).
1. [Make sure the application works correctly](#validate).


## Getting started {#before-you-begin}

To complete this tutorial, you may need a valid [1C:ITS agreement](https://its.1c.ru/db/aboutitsnew) to access the extended documentation.


## Create an app {#create-app}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

    1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
    1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}**.
    1. In the top-right corner, click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.action.applications.components.create-app }}** and in the window that opens:
        1. Select the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.oauth-title_uUs4x }}** single sign-on method.
        1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-name_1VbM1 }}** field, specify `enterprise-1c-oidc-app`.
        1. In the **{{ ui-key.yacloud_org.organization.apps.AppCreateForm.field-folder_rANM4 }}** field, select the folder where you want to create an OAuth client for your app.
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
       --name enterprise-1c-oauth-client \
       --scopes openid,email,profile
     ```

     Where:

     * `--name`: OAuth client name.
     * `--scopes`: User attributes available to 1C:Enterprise. The specified attributes are:
       * `openid`: User ID. Required attribute.
       * `email`: User email address.
       * `profile`: Additional user details, such as first name, last name, and avatar.

     Result:

     ```text
     id: ajeqqip130i1********
     name: enterprise-1c-oauth-client
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

     Save the `secret_value` field value: you will need it to configure your 1C:Enterprise.
  
  1. Create an OIDC app:

     ```bash
     yc organization-manager idp application oauth application create \
       --organization-id <organization_ID> \
       --name enterprise-1c-oidc-app \
       --description "OIDC application for integration with 1C:Enterprise" \
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
     * `--group-distribution-type`: Set to `none` as user groups are not provided to 1C:Enterprise.

     Result:

     ```text
     id: ek0o663g4rs2********
     name: enterprise-1c-oidc-app
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

Set up the 1C:Enterprise integration with the OIDC app you created in {{ org-name }}.


### Configure your OIDC application in {{ org-full-name }} {#setup-idp}

#### Get the application’s credentials {#get-credentials}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the OIDC app.
  1. On the **{{ ui-key.yacloud_org.organization.apps.AppPageLayout.overview_b5LJQ }}** tab, under **{{ ui-key.yacloud_org.application.overview.idp_section_title }}**, expand the **{{ ui-key.yacloud_org.application.overview.idp_section_closed_text }}** section and copy the parameter values you need to specify in 1C:Enterprise:

        * `{{ ui-key.yacloud_org.application.overview.oauth_field_client_id }}`: Unique application ID.
        * `{{ ui-key.yacloud_org.application.overview.oauth_field_open_id }}`: URL with the configuration of all parameters required to set up the integration.

  1. {% include [oidc-generate-secret](../../../_includes/organization/oidc-generate-secret.md) %}

- CLI {#cli}

  1. Get information about your new OIDC application:

     ```bash
     yc organization-manager idp application oauth application get <app_ID>
     ```

     Where `<app_ID>` is your OIDC app ID you got when creating the app.

     This will return the application information, including the following:

     ```text
     id: ek0o663g4rs2********
     name: enterprise-1c-oidc-app
     organization_id: bpf2c65rqcl8********
     client_grant:
       client_id: ajeqqip130i1********
       authorized_scopes:
         - openid
         - email
         - profile
     ```

     Save the `client_id` value: this is the OIDC app ID you will need to configure your 1C:Enterprise.

  1. Get the OpenID Connect Discovery configuration URL:

     ```bash
     yc organization-manager idp application oauth application get <app_ID> \
       --format json | jq -r '.client_grant.issuer_uri'
     ```

     The result will look as follows:

     ```text
     https://{{ auth-main-host }}/oauth/<OAuth_client_ID>
     ```

     Save this URL: this is the OpenID Connect Discovery URL you will need to configure your 1C:Enterprise.

  1. Use the OAuth client secret that you saved when creating the app in the previous step. If you have not saved the secret, create a new one:

     ```bash
     yc iam oauth-client-secret create \
       --oauth-client-id <OAuth_client_ID>
     ```

     Save the `secret_value` from the command output: this is the app secret you will need to configure your 1C:Enterprise.

{% endlist %}


#### Configure the redirect URI {#setup-redirect}

{% list tabs group=instructions %}

- {{ cloud-center }} UI {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. In the left-hand panel, select ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** and then, the OIDC app.
  1. At the top right, click ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}** and in the window that opens:
      1. In the **{{ ui-key.yacloud_org.application.overview.oauth_field_redirect_uri }}** field, specify the 1C infobase URL for OIDC app response processing, formatted as follows:

        ```text
        <1C_infobase_publication_domain>/<application_name>/authform.html
        ```

        For example, `https://your.company.ru/your-app/authform.html`.

      1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  1. Update your OIDC app by providing the redirect URI:

     ```bash
     yc organization-manager idp application oauth application update <app_ID> \
       --redirect-uris "<1C_infobase_publication_domain>/<application_name>/authform.html"
     ```

     Where:
     
     * `<app_ID>`: OIDC app ID you got when creating the app.
     * `--redirect-uris`: 1C infobase URL for OIDC app response processing. For example, `https://your.company.ru/your-app/authform.html`.

     Result:

     ```text
     id: ek0o663g4rs2********
     name: grafana-cloud-oidc-app
     organization_id: bpf2c65rqcl8********
     redirect_uris:
       - https://your.company.ru/your-app/authform.html
     ```

{% endlist %}


### Configure your OIDC application in 1C:Enterprise {#setup-sp}

To configure OpenID Connect authentication in 1C:Enterprise, set up the infobase publication configuration, restart [Apache HTTP Server](https://httpd.apache.org/), and enable OIDC authentication.

The location of the configuration file depends on your specific 1C:Enterprise setup. For example, it may be located at this path: `/var/www/<app_name>/default.vrd`.

1. Open the configuration file and add the `openidconnect` section within `point`:

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <point xmlns="http://v8.1c.ru/8.2/virtual-resource-system"
    ...
            <openidconnect>
                    <providers>
                  <![CDATA[[
                    {
                    "name": "identity-hub",
                    "title": "Identity Hub",
                    "discovery": "https://{{ auth-main-host }}/.well-known/openid-configuration",
                    "authenticationClaimName": "preferred_username",
                    "authenticationUserPropertyName": "email",
                    "clientconfig": {
                          "authority": "https://{{ auth-main-host }}",
                          "client_id": "<app_ID>",
                          "client_secret" : "<app_secret>",
                          "redirect_uri": "https://<1C_infobase_publication_domain>/<application_name>/authform.html",
                          "response_type": "code",
                          "scope": "openid email profile",
                          "filterProtocolClaims": true,
                          "loadUserInfo": false
                          }
                    }
                    ]]]>
                    </providers>
                    <allowStandardAuthentication>true</allowStandardAuthentication>
            </openidconnect>
    ...
    </point>
    ```

    Where:

    * `authenticationUserPropertyName`: User attribute for authentication. In this example, it is `email`, the email address.
    * `client_id`: Unique OIDC app ID you got [earlier](#get-credentials).
    * `client_secret`: Generated OIDC app secret you got [earlier](#get-credentials).
    * `redirect_uri`: 1C infobase URL for OIDC app response processing.

1. Restart the Apache HTTP Server:

    ```bash
    systemctl restart apache2
    ```

1. Go to 1C Configurator and enable **OpenID Connect authentication** for each user you need. Make sure the user's profile indicates the attribute mapped to the `authenticationUserPropertyName` configuration parameter.


## Make sure your application works correctly {#validate}

To make sure both your OIDC app and 1C:Enterprise integration work correctly, authenticate to 1C:Enterprise as one of the users for whom you have enabled the OIDC authentication.

To do this:

1. In your browser, navigate to the address of your 1C:Enterprise instance, e.g., `https://your.company.ru`.
1. If you were logged in to 1C:Enterprise, log out.
1. On the 1C:Enterprise authentication page, click **Log in**.
1. On the {{ yandex-cloud }} authentication page, enter the email address and user password.
1. Make sure you are logged in to 1C:Enterprise.