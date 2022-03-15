# Authentication using Google Workspace

If you have an [identity federation](../../add-federation.md) you can use [Google Workspace](https://workspace.google.com/) to authenticate users in the organization.

Authentication setup consists of the following steps:

1. [Creating and configuring an SAML app in Google Workspace](#gworkspace-settings).

1. [Creating and configuring a federation in {{org-full-name}}](#yc-settings).

1. [Setting up a Single Sign-on System (SSO)](#sso-settings).

1. [Verifying authentication](#test-auth).

## Before you start {#before-you-begin}

To be able to use the instructions in this section, you will need a subscription to Google Workspace services and a verified domain for which you will configure the SAML app.

## Creating and configuring an SAML app in Google Workspace {#gworkspace-settings}

### Create an SAML application and download the certificate {#create-app}

The Identity Provider (IdP) is an SAML app in Google Workspace. Start creating your app and download the certificate:

1. Open [Google Workspace Admin Console](https://admin.google.com/).

1. In the left-hand panel, select **Mobile and web applications**.

1. Click **Add** → **Add a custom SAML app**.

1. Enter the name of the app, select the logo and click **Continue**.

1. In the step **Google IdP information**, the IdP server data is shown. You'll need this data when [configuring a federation in {{org-full-name}}](#yc-settings).

{% note alert %}

Don't close the page where you create an app in Google Workspace: you'll get necessary configuration data for the **Service provider information** step in [further steps](#add-link).

{% endnote %}

## Creating and configuring a federation in {{org-full-name}} {#yc-settings}

### Create a federation {#create-federation}

{% list tabs %}

- Management console

  1. Go to [{{org-full-name}}]({{link-org-main}}).

  1. In the left panel, select the [Federations]({{link-org-federations}}) ![icon-federation](../../../_assets/organization/icon-federation.png) section.

  1. Click **Create federation**.

  1. Enter a name for the federation. The name must be unique within the folder.

  1. Add a description if necessary.

  1. In the **Cookie lifetime** field, specify the period of time that must elapse before the browser asks the user to re-authenticate.

  1. In the **IdP Issuer** field, enter the link from the **Object ID** field on the Google Workspace **Google IdP information** page. Link format:

      ```
      https://accounts.google.com/o/saml2?idpid=<SAML app ID>
      ```

  1. In the **Link to the IdP login page** field, enter the link from the **SSO URL** field on the Google Workspace **Google IdP information** page. Link format:

      ```
      https://accounts.google.com/o/saml2/idp?idpid=<SAML app ID>
      ```

  1. Enable **Automatically create users** to add authenticated users to your organization automatically. If you don't enable this option, you will need to [add manually](../../add-account.md#add-user-sso) your federated users.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. See the description of the create federation command:

        ```
        yc organization-manager federation saml create --help
        ```

    1. Create a federation:

        ```bash
        yc organization-manager federation saml create --name my-federation \
            --organization-id <organization ID> \
            --auto-create-account-on-login \
            --cookie-max-age 12h \
            --issuer "https://accounts.google.com/o/saml2?idpid=<SAML app ID>" \
            --sso-binding POST \
            --sso-url "https://accounts.google.com/o/saml2/idp?idpid=<SAML app ID>"
        ```

        Where:

        * `name`: Federation name. The name must be unique within the folder.

        * `organization-id`: Your organization ID.

        * `auto-create-account-on-login`: A flag to enable the automatic creation of new cloud users following authentication on the IdP server.
          This option makes it easier to create users, but users created this way won't be able to do anything with cloud resources. Resources with roles assigned to the [system group](../../../iam/concepts/access-control/system-group.md) `allUsers` or `allAuthenticatedUsers` are the exception.

            If this option is disabled, users not added to the organization will not be able to log in to the management console, even if they authenticate on your server. This enables you to manage a list of users allowed to use {{ yandex-cloud }} resources.

        * `cookie-max-age`: Time that must elapse before the browser asks the user to re-authenticate.

        * `issuer`: IdP server ID to be used for authentication.

            Use the link from the **Object ID** field on the Google Workspace**Google IdP information** page. This is a link in the format:

            ```
            https://accounts.google.com/o/saml2?idpid=<SAML app ID>
            ```

        * `sso-url`: URL of the page that the browser redirects the user to for authentication.

            Use the link from the **SSO URL** field on the Google Workspace **Google IdP information** page. Link format:

            ```
            https://accounts.google.com/o/saml2/idp?idpid=<SAML app ID>
            ```

        * `sso-binding`: Specify the Single Sign-on binding type. Most Identity Providers support the `POST` binding type.

- API

    1. [Get the ID of the folder](../../../resource-manager/operations/folder/get-id.md) to create your federation in.

    1. Create a file with the request body (for example, `body.json`):

        ```json
        {
          "folderId": "<folder ID>",
          "name": "my-federation",
          "organizationId": "<organization ID>",
          "autoCreateAccountOnLogin": true,
          "cookieMaxAge":"43200s",
          "issuer": "https://accounts.google.com/o/saml2?idpid=<SAML app ID>",
          "ssoUrl": "https://accounts.google.com/o/saml2/idp?idpid=<SAML app ID>",
          "ssoBinding": "POST"
        }
        ```

        Where:

        * `folderId`: ID of the folder.

        * `name`: Federation name. The name must be unique within the folder.

        * `organizationId`: Organization ID.

        * `autoCreateAccountOnLogin`: A flag to activate the automatic creation of new cloud users after authenticating on the IdP server.
          This option makes it easier to create users, but users created this way won't be able to do anything with cloud resources. Resources with roles assigned to the [system group](../../../iam/concepts/access-control/system-group.md) `allUsers` or `allAuthenticatedUsers` are the exception.

            If this option is disabled, users not added to the organization will not be able to log in to the management console, even if they authenticate on your server. This enables you to manage a list of users allowed to use {{ yandex-cloud }} resources.

        * `cookieMaxAge`: Time that must elapse before the browser asks the user to re-authenticate.

        * `issuer`: IdP server ID to be used for authentication.

            Use the link from the **Object ID** field on the Google Workspace **Google IdP information** page. Link format:

            ```
            https://accounts.google.com/o/saml2?idpid=<SAML app ID>
            ```

        * `ssoUrl`: URL of the page that the browser redirects the user to for authentication.

            Use this as the destination when copying the link from the **SSO URL** field on the Google Workspace  **Google IdP information** page. Link format:

            ```
            https://accounts.google.com/o/saml2/idp?idpid=<SAML app ID>
            ```

        * `ssoBinding`: Specify the Single Sign-on binding type. Most Identity Providers support the `POST` binding type.

    1. {% include [include](../../../_includes/iam/create-federation-curl.md) %}

{% endlist %}

### Add certificates {#add-certificate}

When authenticating, {{org-name}} should be able to verify the IdP server certificate. To do this, download the certificate from the open Google Workspace **Google IdP information page** and add it to the created federation.

{% list tabs %}

- Management console

  1. In the left-hand panel, select [Federations]({{link-org-federations}}) ![icon-federation](../../../_assets/organization/icon-federation.png) section.

  1. Click the name of the federation to add a certificate to.

  1. At the bottom of the page, click **Add certificate**.

  1. Enter the certificate's name and description.

  1. Choose how to add the certificate:

      * To add a certificate as a file, click **Choose a file** and specify the path to it.

      * To paste the contents of a copied certificate, select the **Text** method and paste the contents.

  1. Click **Add**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View a description of the add certificate command:

      ```
      yc organization-manager federation saml certificate create --help
      ```

  1. Add a federation certificate by specifying the certificate file path:

      ```
      yc organization-manager federation saml certificate create --federation-id <federation ID> \
        --name "my-certificate" \
        --certificate-file certificate.pem
      ```

- API

  Use the [Create](../../api-ref/Certificate/create.md) method for the [Certificate](../../api-ref/Certificate/index.md):

  1. Generate the request body. In the `data` property, specify the contents of the certificate:

      ```json
      {
        "federationId": "<federation ID>",
        "name": "my-certificate",
        "data": "-----BEGIN CERTIFICATE..."
      }
      ```

  1. Send the add certificate request:

      ```bash
      $ export IAM_TOKEN=CggaATEVAgA...
      $ curl -X POST \
          -H "Content-Type: application/json" \
          -H "Authorization: Bearer ${IAM_TOKEN}" \
          -d '@body.json' \
          "https://organization-manager.api.cloud.yandex.net/organization-manager/v1/saml/certificates"
      ```

{% endlist %}

{% note tip %}

To ensure that authentication isn't interrupted when the certificate expires, we recommend adding several certificates to the federation: the current one and the ones that will be used after. If a certificate turns out to be invalid, {{ yandex-cloud }} will attempt to verify the signature with another certificate.

{% endnote %}

### Get a console login link {#get-link}

When you set up federation authentication, users can log in to the management console from a link containing the federation ID. You must specify the same link when configuring the authentication server.

Obtain and save this link:

1. Get the federation ID:

    1. In the left-hand panel, select [Federations]({{link-org-federations}}) ![icon-federation](../../../_assets/organization/icon-federation.png) section.

    1. Copy the ID of the federation you're configuring access for.

1. Generate a link using this ID:

    `{{ link-console-main }}/federations/<federation ID>`

## Setting up a Single Sign-on System (SSO) {#sso-settings}

### Add a link to log in to the console {#add-link}

Once you have created a federation and received a link to log in to the console, complete the creation of the SAML application in Google Workspace:

1. Go back to the SAML app creation page in the **Google IdP information** step and click **Continue**.

1. In the **Service provider information** step, specify information on {{ yandex-cloud }} acting as the service provider:

    * In the **ACS URL** and **Entity ID** fields, enter the previously obtained [console login link](#get-link).

    * Enable **Signed Response**.

1. Click **Continue**.

    {% note tip %}

    To enable the user to contact {{ yandex-cloud }} technical support from the [management console]({{ link-console-support }}), click **Add Mappings** at the step **Attribute mapping** and configure the transfer of attributes:
    * **Primary email**.
    * **First name**.
    * **Last name**.

    User attributes supported by {{ org-full-name }} services, are listed in [{#T}](#claims-mapping).

    {% endnote %}

1. To complete the creation of the app, click **Ready**.

### Add users {#add-users}

1. On the app page, under **User access**, click **Disabled for everyone**.

1. In the page that opens, select who can authenticate with this identity federation:

    * To enable access for all federation users, select **ON for everyone**.

    * To enable access for an individual organizational unit, select the unit from the list on the left and configure the service status for this unit. The child units inherit access settings from the parent units by default.

1. Click **Save**.

### Mapping user attributes {#claims-mapping}

| User data | Comments | Application Attributes |
| ------------------- | ----------- | ------------------- |
| Unique user ID | Required attribute. Using an email address is recommended. | **Name ID** field in service provider settings |
| Last name | Displayed in {{yandex-cloud}} services. | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname` |
| Name | Displayed in {{yandex-cloud}} services. | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname` |
| Full name | Displayed in {{yandex-cloud}} services.<br>Example: Ivan Ivanov | Attribute unavailable |
| Email | Used to send notifications from {{yandex-cloud}} services.<br>Example:&nbsp;`ivanov@example.com` | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress` |
| Phone | Used to send notifications from {{yandex-cloud}} services.<br>Example: +71234567890 | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/mobilephone` |
| Profile image | Displayed in {{yandex-cloud}} services. | Attribute unavailable |

> Attribute mapping example:
>
>![image](../../../_assets/organization/google-saml-mapping.png)

### Add users to your organization {#add-users}

If, when [creating a federation](#yc-settings), you did not enable **Automatically create users**, you can add federated users to an organization manually.

To do this, you will need user Name IDs. They are returned by the IdP server along with a response confirming successful authentication.

{% list tabs %}

- Management console

  1. [Log in]({{link-passport}}) to the organization's administrator account.

  1. Go to [{{org-full-name}}]({{link-org-main}}).

  1. Go to the left panel and select [Users]({{link-org-users}}) ![icon-users](../../../_assets/organization/icon-users.png).

  1. In the upper-right corner, click on the arrow next to the **Add user** button. Select **Add federated users**.

  1. Select the identity federation to add users from.

  1. List the Name IDs of users, separating them with line breaks.

  1. Click **Add**. This will give the users access to the organization.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View a description of the add user command:

      ```
      yc organization-manager federation saml add-user-accounts --help
      ```

  1. Add users by listing their Name IDs separated by a comma:

      ```
      yc organization-manager federation saml add-user-accounts --id <federation ID> \
        --name-ids=alice@example.com,bob@example.com,charlie@example.com
      ```

      Where:

      * `id`: Federation ID.

      * `name-ids`: User's Name IDs.

- API

  To add identity federation users to the cloud:

  1. Create a file with the request body (for example, `body.json`). In the request body, specify the array of Name IDs of users you want to add:

      ```json
      {
        "nameIds": [
          "alice@example.com",
          "bob@example.com",
          "charlie@example.com"
        ]
      }
      ```

  1. Send the request by specifying the Federation ID in the parameters:

      ```bash
      $ curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer <IAM token>" \
        -d '@body.json' \
        https://organization-manager.api.cloud.yandex.net/organization-manager/v1/saml/federations/<federation ID>:addUserAccounts
      ```

{% endlist %}

## Verifying authentication {#test-auth}

When you finish configuring the server, test that everything works:

1. Open your browser in guest or private browsing mode.

1. Follow the [console login link](#get-link) obtained earlier. The browser forwards you to the Google authentication page.

1. Enter your credentials and click **Sign in**.

Following successful authentication, the IdP server will redirect you back to the management console login link and then to the [management console]({{ link-console-main }}) home page. In the upper-right corner, you can see that you are logged in to the console as a federated user.

#### What's next {#what-is-next}

* [Assign roles to the new users](../../roles.md#add-role).

