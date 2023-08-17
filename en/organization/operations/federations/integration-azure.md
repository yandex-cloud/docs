# Authentication using Azure Active Directory

With an [identity federation](../../add-federation.md), you can use [Azure Active Directory (Azure AD)]({{ link-azure-ad }}) to authenticate users in an organization.

Setting up authentication includes the following steps:

1. [Creating and setting up a SAML application in Azure AD](#azure-settings).

1. [Creating and setting up a federation in {{ org-full-name }}](#yc-settings).

1. [Setting up Single Sign-On (SSO)](#sso-settings).

1. [Authentication](#test-auth).

## Getting started {#before-you-begin}

To follow the steps described in this section, you will need an Azure account with an active subscription.

## Creating and setting up a SAML application in Azure AD {#azure-settings}

### Create a SAML application and download a certificate {#create-app}

A SAML application in Azure AD acts as an identity provider (IdP). Create a SAML application and download a certificate:

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

1. Use the **SAML-based sign-on** page, Section **3. SAML Signature Certificate** to download the certificate (base64). The IdP uses it to sign a message saying that a user has been authenticated.

Do not close the page, as you will need the IdP server data when [creating and setting up a federation](#yc-settings).

### Add users {#add-users}

Add users to the IdP server:

1. Go to the [Enterprise Applications](https://portal.azure.com/#blade/Microsoft_AAD_IAM/StartboardApplicationsMenuBlade/AllApps) page.

1. Select the SAML application created.

1. On the left-hand panel, select **Users and groups**.

1. Click **Add user or group**.

1. In the **Users** field, click **None Selected**.

1. In the resulting window, check users and click **Select**.

1. Click **Assign**.

## Creating and setting up a federation in {{ org-full-name }} {#yc-settings}

### Create a federation {#create-federation}

{% list tabs %}

- Management console

   1. Go to [{{ org-full-name }}]({{ link-org-main }}).

   1. In the left-hand panel, select [Federations]({{ link-org-federations }}) ![icon-federation](../../../_assets/organization/icon-federation.svg).

   1. Click **Create federation**.

   1. Give your federation a name. It must be unique within the folder.

   1. You can also add a description, if required.

   1. In the **Cookie lifetime** field, specify the period of time that must elapse before the browser asks the user to re-authenticate.

   1. In the **IdP Issuer** field, insert the link from the **Azure AD ID** field on the **Azure AD SAML-based sign-on** page. The link should have the following format:

      ```
      https://sts.windows.net/<SAML application ID>/
      ```

   1. In the **Link to the IdP login page** field, copy the link from the **Login URL** field on the Azure AD **SAML-based sign-on** page. The link should have the following format:

      ```
      https://login.microsoftonline.com/<SAML application ID>/saml2
      ```

      {% include [ssourl_protocol](../../../_includes/organization/ssourl_protocol.md) %}

   1. Enable **Automatically create users** to add authenticated users to your organization automatically. If this option is disabled, you will need to [manually add](../../add-account.md#add-user-sso) your federated users.

      {% include [fed-users-note](../../../_includes/organization/fed-users-note.md) %}

   1. {% include [forceauthn-option-enable](../../../_includes/organization/forceauthn-option-enable.md) %}

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
          --issuer "https://sts.windows.net/<SAML application ID>/" \
          --sso-binding POST \
          --sso-url "https://login.microsoftonline.com/<SAML application ID>/saml2" \
          --force-authn
      ```

      Where:

      * `name`: Federation name. It must be unique within the folder.

      * `organization-id`: Your organization ID.

      * `auto-create-account-on-login`: Flag to enable the automatic creation of new cloud users following authentication on the IdP server.

         This option makes it easier to create users; however, users created this way will not be able to do anything with cloud resources. This does not apply to the resources the `allUsers` or `allAuthenticatedUsers` [system group](../../../iam/concepts/access-control/system-group.md) roles are assigned to.

         If this option is disabled, users who are not added to the organization cannot log in to the management console, even if they authenticate with your IdP server. In this case, you can manage a list of users allowed to use {{ yandex-cloud }} resources.

      * `cookie-max-age`: Time that must elapse before the browser asks the user to re-authenticate.

      * `issuer`: IdP server ID to be used for authentication.

         Use the link from the **Azure AD ID** field on the Azure AD **SAML-based sign-on** page. The link should have the following format:
         ```
         https://sts.windows.net/<SAML application ID>/
         ```

      * `sso-url`: URL of the page that the browser redirects the user to for authentication.

         Use the link from the **Login URL** field on the Azure AD **SAML-based sign-on** page. The link should have the following format:

         ```
         https://login.microsoftonline.com/<SAML application ID>/saml2
         ```

         {% include [ssourl_protocol](../../../_includes/organization/ssourl_protocol.md) %}

      * `sso-binding`: Specify the Single Sign-on binding type. Most Identity Providers support the `POST` binding type.

      * {% include [forceauthn-cli-enable](../../../_includes/organization/forceauth-cli-enable.md) %}

- API

   1. Create a file with the request body, e.g., `body.json`:

      ```json
      {
        "name": "my-federation",
        "organizationId": "<organization ID>",
        "autoCreateAccountOnLogin": true,
        "cookieMaxAge":"43200s",
        "issuer": "https://sts.windows.net/<SAML application ID>/",
        "ssoUrl": "https://login.microsoftonline.com/<SAML application ID>/saml2",
        "ssoBinding": "POST",
        "securitySettings": {
          "forceAuthn": true
        }
      }
      ```

      Where:

      * `name`: Federation name. It must be unique within the folder.

      * `organizationId`: Organization ID.

      * `autoCreateAccountOnLogin`: Flag to activate the automatic creation of new cloud users after authenticating on the IdP server.
         This option makes it easier to create users; however, users created this way will not be able to do anything with cloud resources. This does not apply to the resources the `allUsers` or `allAuthenticatedUsers` [system group](../../../iam/concepts/access-control/system-group.md) roles are assigned to.

         If this option is disabled, users who are not added to the organization cannot log in to the management console, even if they authenticate with your IdP server. In this case, you can manage a list of users allowed to use {{ yandex-cloud }} resources.

      * `cookieMaxAge`: Time that must elapse before the browser asks the user to re-authenticate.

      * `issuer`: IdP server ID to be used for authentication.

         Use the link from the **Azure AD ID** field on the Azure AD **SAML-based sign-on** page. The link should have the following format:

         ```
         https://sts.windows.net/<SAML application ID>/
         ```

      * `ssoUrl`: URL of the page the browser redirects the user to for authentication.

         Use the link from the **Login URL** field on the Azure AD **SAML-based sign-on** page. The link should have the following format:

         ```
         https://login.microsoftonline.com/<SAML application ID>/saml2
         ```

         {% include [ssourl_protocol](../../../_includes/organization/ssourl_protocol.md) %}

      * `ssoBinding`: Specify the Single Sign-on binding type. Most Identity Providers support the `POST` binding type.

      * {% include [forceauthn-api-enable](../../../_includes/organization/forceauth-api-enable.md) %}

   1. {% include [include](../../../_includes/iam/create-federation-curl.md) %}

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Specify the federation parameters in the configuration file:

      * `name`: Federation name. It must be unique within the folder.
      * `description`: Federation description.
      * `organization_id`: Organization ID.
      * `labels`: Set of key/value label pairs assigned to the federation.
      * `issuer`: IdP server ID to be used for authentication.

         Use the link from the **Azure AD ID** field on the Azure AD **SAML-based sign-on** page. The link should have the following format:

         ```
         https://sts.windows.net/<SAML application ID>/
         ```

      * `sso_binding`: Specify the Single Sign-on binding type. Most Identity Providers support the `POST` binding type.
      * `sso_url`: URL of the page the browser redirects the user to for authentication.

         Use the link from the **Login URL** field on the Azure AD **SAML-based sign-on** page. The link should have the following format:

         ```
         https://login.microsoftonline.com/<SAML application ID>/saml2
         ```

         {% include [ssourl_protocol](../../../_includes/organization/ssourl_protocol.md) %}

      * `cookie_max_age`: Time, in seconds, before the browser asks the user to re-authenticate. The default value is `8 hours`.
      * `auto_create_account_on_login`: Flag to activate the automatic creation of new cloud users after authenticating on the IdP server.
         This option makes it easier to create users; however, users created this way will not be able to do anything with cloud resources. This does not apply to the resources the `allUsers` or `allAuthenticatedUsers` [system group](../../../iam/concepts/access-control/system-group.md) roles are assigned to.

         If this option is disabled, users who are not added to the organization cannot log in to the management console, even if they authenticate with your server. In this case, you can manage a list of users allowed to use {{ yandex-cloud }} resources.
      * `case_insensitive_name_ids`: Flag that indicates whether usernames are case-insensitive.
         If the option is enabled, the IDs of federated user names are case-insensitive.
      * `security_settings`: Federation security settings:
         * `encrypted_assertions`: Sign authentication requests.
            If this option is enabled, all authentication requests from {{ yandex-cloud }} will have a digital signature. You need to download and install a {{ yandex-cloud }} certificate.

      Example of the configuration file structure:

      ```
      resource "yandex_organizationmanager_saml_federation" federation {
       name            = "my-federation"
       organization_id = "<organization ID>"
       auto_create_account_on_login = "true"
       issuer          = "https://sts.windows.net/<SAML application ID>/"
       sso_url         = "https://login.microsoftonline.com/<SAML application ID>/saml2"
       sso_binding     = "POST"
       security_settings {
          encrypted_assertions = "true"
          }
      }
      ```

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays the federation parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Create a federation.

      1. If the configuration does not contain any errors, run this command:

         ```
         terraform apply
         ```

      1. Confirm you want to create a federation.

      This creates the federation in the specified organization. You can check that the federation is there and its settings are correct in the organization's [Federations]({{ link-org-federations }}) section.

{% endlist %}

### Add certificates {#add-certificate}

While authenticating, the {{ org-name }} service should be able to verify the IdP server certificate. To enable this, add the [downloaded](#azure-settings) certificate to the federation:

{% list tabs %}

- Management console

   1. In the left-hand panel, select [Federations]({{ link-org-federations }}) ![icon-federation](../../../_assets/organization/icon-federation.svg).

   1. Click the name of the federation to add a certificate to.

   1. At the bottom of the page, click **Add certificate**.

   1. Enter the certificate name and description.

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
        --federation-id <federation_ID> \
        --name "my-certificate" \
        --certificate-file certificate.cer
      ```

- API

   Use the [create](../../api-ref/Certificate/create.md) method for the [Certificate](../../api-ref/Certificate/index.md) resource:

   1. Generate the request body. In the `data` property, specify the contents of the certificate:

      ```json
      {
        "federationId": "<federation_ID>",
        "name": "my-certificate",
        "data": "-----BEGIN CERTIFICATE..."
      }
      ```

   1. Send the add certificate request:

      ```bash
      export IAM_TOKEN=CggaATEVAgA...
      curl -X POST \
          -H "Content-Type: application/json" \
          -H "Authorization: Bearer ${IAM_TOKEN}" \
          -d '@body.json' \
          "https://organization-manager.{{ api-host }}/organization-manager/v1/saml/certificates"
      ```

{% endlist %}

{% note tip %}

To ensure the authentication is not interrupted when the certificate expires, we recommend adding multiple certificates to the federation, i.e. both the current one and those to use afterwards. If a certificate turns out to be invalid, {{ yandex-cloud }} will attempt to verify the signature with another certificate.

{% endnote %}


## Setting up Single Sign-On (SSO) {#sso-settings}

### Specify the redirect URL {#add-link}

Once you have created a federation, complete the creation of the SAML application in Azure AD:

1. Open the **SAML-based sign-on** SAML application settings page.

1. In Section **1. Basic SAML** configuration, specify information on {{ yandex-cloud }} acting as the service provider. To do this, in the **ID (entity)** and **Response URL (assertion consumer service URL)** fields, enter the URL to redirect users to after successful authentication:

   ```
   https://{{ auth-host }}/federations/<federation_ID>
   ```

   {% cut "How to get a federation ID" %}

   {% include [get-federation-id](../../../_includes/organization/get-federation-id.md) %}

   {% endcut %}

1. Click **Save**.

### Configure user attribute mapping {#claims-mapping}

Following user authentication, the IdP server will send an SAML message to {{ yandex-cloud }} containing:

* Information about successful authentication.

* User attributes, such as the Name ID, name, and email address.

You can set up a mapping between the SAML message attributes and the personal data stored on the IdP server. To do this, on the **SAML-based sign-on** page in Section **2. User** Attributes & Claims, click **Edit**.

The types of personal data supported by {{ org-full-name }} for Azure AD are listed below.

| User data | Comment | Application Attributes |
------------------- | ----------- | -------------------
| Unique user ID (Name ID) | Required attribute.<br> By default, Azure AD uses User Principal Name (UPN) in `<login>_<domain>#EXT#@<supplier>.onmicrosoft.com` format as the attribute source. When manually adding users to a federation, this Name ID format is not supported. We recommend changing the attribute source in Azure AD, replacing UPN `user.userprincipalname` with an email address `user.mail`. | **Unique user ID (ID)** claim |
| Last name | Displayed in {{ yandex-cloud }} services.<br> Value length limit: {{ saml-limit-last-name }}. | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname` |
| Name | Displayed in {{ yandex-cloud }} services.<br> Value length limit: {{ saml-limit-first-name }}. | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname` |
| Full name | Displayed in {{ yandex-cloud }} services.<br>Example: `John Smith`.<br> Value length limit: {{ saml-limit-display-name }}. | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name` |
| Email | Used to send notifications from {{ yandex-cloud }} services.<br>Example:&nbsp;`smith@example.com`.<br> Value length limit: {{ saml-limit-email }}. | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress` |

{% note warning %}

If the attribute value exceeds the length limit, the value part that goes beyond the limit is truncated.

{% endnote %}

### Add users to your organization {#add-users-to-org}

If you did not enable the **Automatically create users** option when [creating a federation](#yc-settings), you will have to add federated users to your organization manually.

To do this, you will need user Name IDs. They are returned by the IdP server along with a response confirming successful authentication.

{% include [auto-create-users](../../../_includes/organization/auto-create-users.md) %}

A user can be added by an organization administrator (the `organization-manager.admin` role) or owner (the `organization-manager.organizations.owner` role). For information on assigning roles to users, see [Roles](../../roles.md#admin).

{% list tabs %}

- Management console

   1. [Log in to an account]({{ link-passport }}) that belongs to an organization administrator or owner.

   1. Go to [{{ org-full-name }}]({{ link-org-main }}).

   1. In the left-hand panel, select [Users]({{ link-org-users }}) ![icon-users](../../../_assets/organization/icon-users.svg).

   1. In the top right corner, click ![icon-users](../../../_assets/datalens/arrow-down.svg) → **Add federated users**.

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
      yc organization-manager federation saml add-user-accounts --id <federation_ID> \
        --name-ids=alice@example.com,bob@example.com,charlie@example.com
      ```

      Where:

      * `id`: Federation ID.

      * `name-ids`: User name IDs.

- API

   To add identity federation users to the cloud:

   1. Create a file with the request body, e.g., `body.json`. In the request body, specify the array of Name IDs of users you want to add:

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
      curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer <IAM token>" \
        -d '@body.json' \
        https://organization-manager.{{ api-host }}/organization-manager/v1/saml/federations/<federation_ID>:addUserAccounts
      ```

{% endlist %}

## Authentication {#test-auth}

When you finish setting up SSO, test that everything works properly:

1. Open your browser in guest or private browsing mode.

1. Follow the URL to log in to the management console:

   ```
   https://{{ console-host }}/federations/<federation_ID>
   ```

   {% cut "How to get a federation ID" %}

   {% include [get-federation-id](../../../_includes/organization/get-federation-id.md) %}

   {% endcut %}

   The browser forwards you to the Microsoft authentication page.

1. Enter your credentials and click **Next**.

On successful authentication, the IdP server will redirect you to the `https://{{ auth-host }}/federations/<federation_ID>` URL that you specified in the Azure AD settings, and then to the [management console]({{ link-console-main }}) home page. In the top-right corner, you will be able to see you are logged in to the console as a federated user.

#### What's next {#what-is-next}

* [Assign roles to the new users](../../roles.md#add-role).
