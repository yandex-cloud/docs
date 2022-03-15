# Authentication using Azure Active Directory

If you have an [identity federation](../../add-federation.md), you can use [Azure Active Directory]({{link-azure-ad}}) (hereinafter Azure AD) to authenticate users in the cloud.

Authentication setup consists of the following steps:

1. [Creating and configuring an SAML app in Azure AD](#azure-settings).

1. [Creating and configuring a federation in {{org-full-name}}](#yc-settings).

1. [Setting up a Single Sign-on System (SSO)](#sso-settings).

1. [Verifying authentication](#test-auth).

## Before you start {#before-you-begin}

To use the instructions in this section, you will need an Azure account with an active subscription.

## Creating and configuring an SAML app in Azure AD {#azure-settings}

### Create an SAML application and download the certificate {#create-app}

The Identity Provider (IdP) is an SAML application in Azure AD. Start creating your app and download the certificate:

1. Go to the [Azure AD portal](https://portal.azure.com/).

1. In **Azure Services**, select **Azure Active Directory**.

1. On the left-hand panel, select **Enterprise Applications**.

1. Click **New application**.

1. On the **Browse Azure AD Gallery** page, click **Create your own application**.

1. In the window that opens:

   1. Name the application.

   1. Select **Integrate any other application you don't find in the gallery (Non-gallery)**.

   1. Click **Create**.

1. On the resulting **Browse** page, use the left-hand panel to select **Single sign-on**.

1. Select the **SAML** single sign-on method.

1. On the **SAML-based sign-on** page, in Section **3. SAML Signature Certificate**, download the certificate (Base64). The certificate is necessary for the identity provider to sign a message that the user has authenticated.

Do not close the page: you'll need the IdP server data when [creating and configuring a federation](#yc-settings).

### Add users {#add-users}

Add users to the IdP server:

1. Go to the [Enterprise Applications](https://portal.azure.com/#blade/Microsoft_AAD_IAM/StartboardApplicationsMenuBlade/AllApps) page.

1. Select the SAML application created.

1. On the left-hand panel, select **Users and groups**.

1. Click **Add user or group**.

1. In the **Users** field, click **None Selected**.

1. In the resulting window, check users and click **Select**.

1. Click **Assign**.

## Creating and configuring a federation in {{org-full-name}} {#yc-settings}

### Create a federation {#create-federation}

{% list tabs %}

- Management console

  1. Go to [{{org-full-name}}]({{link-org-main}}).

  1. In the left-hand panel, select [Federations]({{link-org-federations}}) ![icon-federation](../../../_assets/organization/icon-federation.png) section.

  1. Click **Create federation**.

  1. Enter a name for the federation. The name must be unique within the folder.

  1. Add a description if necessary.

  1. In the **Cookie lifetime** field, specify the period of time that must elapse before the browser asks the user to re-authenticate.

  1. In the **IdP Issuer** field, insert the link from the **Azure AD ID** field on the Azure AD **SAML-based sign-on** page. Link format:

      ```
      https://sts.windows.net/<SAML application ID>/
      ```

  1. In the **Link to the IdP login page** field, copy the link from the **Login URL** field on the Azure AD  **SAML-based sign-on** page. Link format:

      ```
      https://login.microsoftonline.com/<SAML application ID>/saml2
      ```

  1. Enable **Automatically create users** to add authenticated users to your organization automatically. If this option is disabled, you will need to [manually add](../../add-account.md#add-user-sso) your federated users.

  1. Click **Create federation**.

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
            --issuer "https://sts.windows.net/<SAML app ID>/" \
            --sso-binding POST \
            --sso-url "https://login.microsoftonline.com/<SAML app ID>/saml2"
        ```

        Where:

        * `name`: Federation name. The name must be unique within the folder.

        * `organization-id`: Your organization ID.

        * `auto-create-account-on-login`: A flag to enable the automatic creation of new cloud users following authentication on the IdP server.
          This option makes it easier to create users, but users created this way won't be able to do anything with cloud resources. Resources with roles assigned to the [system group](../../../iam/concepts/access-control/system-group.md) `allUsers` or `allAuthenticatedUsers` are the exception.

            If this option is disabled, users not added to the organization will not be able to log in to the management console, even if they authenticate on your IdP server. This enables you to manage a list of users allowed to use {{ yandex-cloud }} resources.

        * `cookie-max-age`: Time that must elapse before the browser asks the user to re-authenticate.

        * `issuer`: IdP server ID to be used for authentication.

            Use the link from the **Azure AD ID** field on the Azure AD **SAML-based sign-on** page. Link format:

            ```
            https://sts.windows.net/<SAML application ID>/
            ```

        * `sso-url`: URL of the page that the browser redirects the user to for authentication.

            Use the link from the **Login URL** field on the Azure AD **SAML-based sign-on** page. Link format:

            ```
            https://login.microsoftonline.com/<SAML application ID>/saml2
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
          "issuer": "https://sts.windows.net/<SAML app ID>/",
          "ssoUrl": "https://login.microsoftonline.com/<SAML app ID>/saml2",
          "ssoBinding": "POST"
        }
        ```

        Where:

        * `folderId`: ID of the folder.

        * `name`: Federation name. The name must be unique within the folder.

        * `organizationId`: Organization ID.

        * `autoCreateAccountOnLogin`: A flag to activate the automatic creation of new cloud users after authenticating on the IdP server.
          This option makes it easier to create users, but users created this way won't be able to do anything with cloud resources. Resources with roles assigned to the [system group](../../../iam/concepts/access-control/system-group.md) `allUsers` or `allAuthenticatedUsers` are the exception.

            If this option is disabled, users not added to the organization will not be able to log in to the management console, even if they authenticate on your IdP server. This enables you to manage a list of users allowed to use {{ yandex-cloud }} resources.

        * `cookieMaxAge`: Time that must elapse before the browser asks the user to re-authenticate.

        * `issuer`: IdP server ID to be used for authentication.

            Use the link from the **Azure AD ID** field on the Azure AD **SAML-based sign-on** page. Link format:

            ```
            https://sts.windows.net/<SAML application ID>/
            ```

        * `ssoUrl`: URL of the page that the browser redirects the user to for authentication.

            Use the link from the **Login URL** field on the Azure AD **SAML-based sign-on** page. Link format:

            ```
            https://login.microsoftonline.com/<SAML application ID>/saml2
            ```

        * `ssoBinding`: Specify the Single Sign-on binding type. Most Identity Providers support the `POST` binding type.

    1. {% include [include](../../../_includes/iam/create-federation-curl.md) %}

{% endlist %}

### Add certificates {#add-certificate}

When authenticating, {{org-name}} should be able to verify the IdP server certificate. To do this, add the [downloaded](#azure-settings) certificate to the federation:

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
      yc organization-manager federation saml certificate create \
        --federation-id <federation ID> \
        --name "my-certificate" \
        --certificate-file certificate.cer
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

When you set up federation authentication, users can log in to the management console from a link containing the federation ID. You need to provide the same link when [setting up a single sign-on system (SSO)](#sso-settings).

Get the link:

1. Copy the Federation ID:

    1. In the left-hand panel, select [Federations]({{link-org-federations}}) ![icon-federation](../../../_assets/organization/icon-federation.png) section.

    1. Copy the ID of the federation you're configuring access for.

1. Generate a link using this ID:

    `{{ link-console-main }}/federations/<federation ID>`

## Setting up a Single Sign-on System (SSO) {#sso-settings}

### Add a link to log in to the console {#add-link}

Once you create a federation and receive a link to log in to the console, finalize the SAML application in Azure AD:

1. Open the **SAML-based sign-on** SAML application settings page.

1. In Section **1. Basic SAML configuration**, specify information on {{ yandex-cloud }} acting as the service provider.

   To do this, in the **ID (entity)** and the **Response URL (assertion consumer service URL)** fields, enter the [console login link](#get-link) you obtained earlier.

1. Click **Save**.

### Configure user attribute mapping {#claims-mapping}

Following user authentication, the IdP server will send an SAML message to {{ yandex-cloud }} containing:

* Information about successful authentication.

* User attributes, such as the Name ID, name, and email address.

You can set up a mapping between the SAML message attributes and the personal data stored on the IdP server. To do this, on the **SAML-based sign-on** page in Section **2. User Attributes & Claims**, click **Edit**.

The types of personal data supported by {{ org-full-name }} for Azure AD are listed below.

| User data | Comments | Application Attributes |
| ------------------- | ----------- | ------------------- |
| Unique user ID (Name ID) | Required attribute.<br> By default, Azure AD uses User Principal Name (UPN) in `<login>_<domain>#EXT#@<supplier>.onmicrosoft.com` format as the attribute source. When adding users to the federation manually, this Name ID format is not supported. We recommend changing the attribute source in Azure AD, replacing UPN `user.userprincipalname` with an email address `user.mail`. | **Unique user ID (ID)** claim |
| Last name | Displayed in {{yandex-cloud}} services. | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname` |
| Name | Displayed in {{yandex-cloud}} services. | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname` |
| Full name | Displayed in {{yandex-cloud}} services.<br>Example: `Ivan Ivanov` | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name` |
| Email | Used to send notifications from {{yandex-cloud}} services.<br>Example:&nbsp;`ivanov@example.com` | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress` |

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

When you finished configuring the SSO, test that everything works:

1. Open your browser in guest or private browsing mode.

1. Follow the [console login link](#yc-settings) obtained earlier. The browser should redirect you to the Microsoft authentication page.

1. Enter your credentials and click **Next**.

Following successful authentication, the IdP server will redirect you back to the management console login link and then to the [management console]({{ link-console-main }}) home page. In the upper-right corner, you can see that you are logged in to the console as a federated user.

#### What's next {#what-is-next}

* [Assign roles to the new users](../../roles.md#add-role).

