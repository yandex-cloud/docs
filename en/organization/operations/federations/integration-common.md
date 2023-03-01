# Authentication using an SAML-compatible identity federation

This is a generic guide to configure authentication in the cloud via an SAML-compatible identity federation. Use this guide if there is no guide for your identity federation.

To set up authentication:

1. [Create a federation in your organization](#create-federation).

1. [Add certificates to a federation](#add-certificate).

1. [Get a console login link](#get-link).

1. [Configure authentication on your server](#configure-sso).

1. [Configure user attribute mapping](#claims-mapping).

1. [Add users to your organization](#add-users).

1. [Test the authentication process](#test-auth).

## Before you start {#before-you-begin}

To use the instructions in this section, you will need a valid certificate to sign SAML messages on the Identity Provider's (IdP) server. If you don't have a valid SSL certificate, get one.

The subject name in the certificate must contain the FQDN of the Identity Provider (IdP) server, for example, `fs.contoso.com`, to prevent the browser from blocking the authentication page.

## Create a federation in your organization {#create-federation}

To create a federation:

{% list tabs %}

- Management console

   1. Go to [{{ org-full-name }}]({{ link-org-main }}).

   1. In the left panel, select [Federations]({{ link-org-federations }}) ![icon-federation](../../../_assets/organization/icon-federation.svg).

   1. Click **Create federation**.

   1. Enter a name for the federation. The name must be unique within the folder.

   1. Add a description if necessary.

   1. In the **Cookie lifetime** field, specify the period of time that must elapse before the browser asks the user to re-authenticate.

   1. In the **IdP Issuer** field, specify the IdP server ID to be used for authentication. The IdP server must send the same ID in its response to {{ org-name }} during user authentication.

      {% note info %}

      ID format depends on the type of IdP server you use (for example, Active Directory or Google Workspace).

      {% endnote %}

   1. In the **SSO method** field, choose **POST**.

   1. In the **Link to the IdP login page** field, specify the address of the page that the browser redirects the user to for authentication.

   1. Add an [identity provider certificate](#add-certificate) to the created federation.

   1. Enable **Automatically create users** to add authenticated users to your organization automatically. If you don't enable this option, you will need to [manually add](../../add-account.md#add-user-sso) your federated users.

   1. Configure the identity provider's server to transmit successful authentication information and user attributes to {{ yandex-cloud }}.

   User attributes supported by {{ org-full-name }} services are listed in [{#T}](#claims-mapping).

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
          --issuer "https://accounts.google.com/o/saml2?idpid=C03xolm0y" \
          --sso-binding POST \
          --sso-url "https://accounts.google.com/o/saml2/idp?idpid=C03xolm0y"
      ```

      Where:

      * `name`: Federation name. The name must be unique within the folder.
      * `organization-id`: Your organization ID.
      * `auto-create-account-on-login`: A flag to enable the automatic creation of new cloud users following authentication on the IdP server.
         
         This option makes it easier to create users, but users created this way won't be able to do anything with cloud resources. Exceptions are the resources that the `allUsers` or `allAuthenticatedUsers` [system group](../../../iam/concepts/access-control/system-group.md) roles are assigned to.

         If this option is disabled, users who aren't added to the organization can't log in to the management console, even if they authenticate with your server. In this case, you can manage a list of users allowed to use {{ yandex-cloud }} resources.
      * `cookie-max-age`: Time that must elapse before the browser asks the user to re-authenticate.
      * `issuer`: IdP server ID to be used for authentication. The IdP server also responds to {{org-name}} with this ID after the user is authenticated.
      * `sso-url`: URL of the page that the browser redirects the user to for authentication.
      * `sso-binding`: Specify the Single Sign-on binding type. Most Identity Providers support the `POST` binding type.

- API

   1. [Get the ID of the folder](../../../resource-manager/operations/folder/get-id.md) to create a federation in.
   1. Create a file with the request body (for example, `body.json`).

      ```json
      {
        "folderId": "<folder ID>",
        "name": "my-federation",
        "organizationId": "<organization ID>",
        "autoCreateAccountOnLogin": true,
        "cookieMaxAge":"43200s",
        "issuer": "https://accounts.google.com/o/saml2?idpid=C03xolm0y",
        "ssoUrl": "https://accounts.google.com/o/saml2/idp?idpid=C03xolm0y",
        "ssoBinding": "POST"
      }
      ```

      Where:

      * `folderId`: ID of the folder.
      * `name`: Federation name. The name must be unique within the folder.
      * `organizationId`: Organization ID.
      * `autoCreateAccountOnLogin`: A flag to activate the automatic creation of new cloud users after authenticating on the IdP server.
         This option makes it easier to create users, but users created this way won't be able to do anything with cloud resources. Exceptions are the resources that the `allUsers` or `allAuthenticatedUsers` [system group](../../../iam/concepts/access-control/system-group.md) roles are assigned to.

         If this option is disabled, users who aren't added to the organization can't log in to the management console, even if they authenticate with your server. In this case, you can manage a list of users allowed to use {{ yandex-cloud }} resources.
      * `cookieMaxAge`: Time that must elapse before the browser asks the user to re-authenticate.
      * `issuer`: IdP server ID to be used for authentication. The IdP server also responds to {{ org-name }} with this ID after the user is authenticated.
      * `ssoUrl`: URL of the page that the browser redirects the user to for authentication.
      * `ssoBinding`: Specify the Single Sign-on binding type. Most Identity Providers support the `POST` binding type.

   1. {% include [include](../../../_includes/iam/create-federation-curl.md) %}

- {{ TF }}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Specify the federation parameters in the configuration file:

      * `name`: Federation name. The name must be unique within the folder.
      * `description`: Federation description.
      * `organization_id`: Organization ID.
      * `labels`: A set of key/value label pairs assigned to the federation.
      * `issuer`: IdP server ID to be used for authentication. The IdP server also responds to {{ org-name }} with this ID after the user is authenticated.
      * `sso_binding`: Specify the Single Sign-on binding type. Most Identity Providers support the `POST` binding type.
      * `sso_url`: URL of the page that the browser redirects the user to for authentication.
      * `cookie_max_age`: Time, in seconds, before the browser asks the user to re-authenticate. The default value is `8 hours`.
      * `auto_create_account_on_login`: A flag to activate the automatic creation of new cloud users after authenticating on the IdP server.
         This option makes it easier to create users, but users created this way won't be able to do anything with cloud resources. Exceptions are the resources that the `allUsers` or `allAuthenticatedUsers` [system group](../../../iam/concepts/access-control/system-group.md) roles are assigned to.

         If this option is disabled, users who aren't added to the organization can't log in to the management console, even if they authenticate with your server. In this case, you can manage a list of users allowed to use {{ yandex-cloud }} resources.
      * `case_insensitive_name_ids`: A flag that indicates if usernames are case-insensitive.
         If the option is enabled, the IDs of federated users' names are case-insensitive.
      * `security_settings`: Federation security settings:
         * `encrypted_assertions`: Sign authentication requests.
            If this option is enabled, all authentication requests from {{ yandex-cloud }} will have a digital signature. You need to download and install a {{ yandex-cloud }} certificate.

      Example configuration file structure:

      ```
      resource "yandex_organizationmanager_saml_federation" federation {
       name            = "my-federation"
       organization_id = "<organization ID>"
       auto_create_account_on_login = "true"
       issuer          = "https://accounts.google.com/o/saml2?idpid=C03xolm0y" 
       sso_url         = "https://accounts.google.com/o/saml2/idp?idpid=C03xolm0y"
       sso_binding     = "POST"
       security_settings {
          encrypted_assertions = "true"
          }
      }
      ```

   1. Make sure that the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays the federation parameters. If there are errors in the configuration, {{ TF }} points them out.

   1. Create a federation.

      1. If the configuration doesn't contain any errors, run the command:

         ```
         terraform apply
         ```

      1. Confirm that you want to create the federation.

      This creates the federation in the specified organization. You can check that the federation is there and its settings are correct in the organization's [Federations]({{ link-org-federations }}) section.

{% endlist %}

## Specify certificates for the federation {#add-certificate}

When the identity provider (IdP) informs {{ org-full-name }} that a user has been authenticated, they sign the message with their certificate. To enable {{ org-name }} to verify this certificate, add it to the created federation.

To add a certificate to a federation:

{% list tabs %}

- Management console

   1. Get your identity provider certificate.

   {% note info %}

   To find out how to get a certificate, see the documentation or go to the support service of your identity provider.

   {% endnote %}

   1. Go to [{{ org-full-name }}]({{ link-org-main }}).

   1. In the left panel, select [Federations]({{ link-org-federations }}) ![icon-federation](../../../_assets/organization/icon-federation.svg).

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
      yc organization-manager federation saml certificate create --federation-name my-federation \
        --name "my-certificate" \
        --certificate-file test.pem
      ```

- API

   To add a certificate, use the [create](../../api-ref/Certificate/create.md) method for the [Certificate](../../api-ref/Certificate/index.md) resource:

   1. Create a request body by specifying the contents of the certificate's `data` property:

      ```json
      {
        "federationId": "<federation ID>",
        "name": "my-certificate",
        "data": "MII...=="
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

To ensure that authentication isn't interrupted when the certificate expires, we recommend adding several certificates to the federation: the current one and the ones that will be used after. If a certificate turns out to be invalid, {{ yandex-cloud }} will attempt to verify the signature with another certificate.

{% endnote %}

## Get a console login link {#get-link}

When you set up federation authentication, users can log in to the management console from a link containing the federation ID. The same link must be provided when configuring the authentication server.

Obtain and save this link:

1. Get the federation ID:

   1. Go to [{{ org-full-name }}]({{ link-org-main }}).

   1. In the left panel, select [Federations]({{ link-org-federations }}) ![icon-federation](../../../_assets/organization/icon-federation.svg).

   1. Copy the ID of the federation you're configuring access for.

1. Generate a link using this ID:

   `https://{{ auth-host }}/federations/<federation ID>`

## Configure authentication on your server {#configure-sso}

After you create a federation and obtain a management console login link, configure the Identity Provider (IdP) server. After each successful authentication, the server must send a relevant SAML message to the management console.

Example of an SAML message:
```xml
<samlp:Response ID="_bcdf7b6b-ea42-4191-8d5e-ebd4274acec6" Version="2.0" IssueInstant="2019-07-30T13:24:25.488Z"
 Destination="{{ link-console-main }}/federations/bfbrotp6l1b2avhe1spu" Consent="urn:oasis:names:tc:SAML:2.0:consent:unspecified"
  InResponseTo="19fb953133b313a86a001f2d387160e47f3e7aa0" xmlns:samlp="urn:oasis:names:tc:SAML:2.0:protocol">
  <Issuer xmlns="urn:oasis:names:tc:SAML:2.0:assertion">http://example.org/auth</Issuer>
  <samlp:Status>
    <samlp:StatusCode Value="urn:oasis:names:tc:SAML:2.0:status:Success" />
  </samlp:Status>
  <Assertion ID="_90cd8dcc-6105-4300-9ae4-f2c8c5aeb1e5" IssueInstant="2019-07-30T13:24:25.488Z"
   Version="2.0" xmlns="urn:oasis:names:tc:SAML:2.0:assertion">
    <Issuer>http://example.org/auth</Issuer>
    <ds:Signature xmlns:ds="http://www.w3.org/2000/09/xmldsig#">
      <ds:SignedInfo>
        <ds:CanonicalizationMethod Algorithm="http://www.w3.org/2001/10/xml-exc-c14n#" />
        <ds:SignatureMethod Algorithm="http://www.w3.org/2001/04/xmldsig-more#rsa-sha256" />
        <ds:Reference URI="#_90cd8dcc-6105-4300-9ae4-f2c8c5aeb1e5">
          <ds:Transforms>
            <ds:Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature" />
            <ds:Transform Algorithm="http://www.w3.org/2001/10/xml-exc-c14n#" />
          </ds:Transforms>
          <ds:DigestMethod Algorithm="http://www.w3.org/2001/04/xmlenc#sha256" />
          <ds:DigestValue>phUQR...</ds:DigestValue>
        </ds:Reference>
      </ds:SignedInfo>
      <ds:SignatureValue>VACd7O...</ds:SignatureValue>
      <KeyInfo xmlns="http://www.w3.org/2000/09/xmldsig#">
        <ds:X509Data>
          <ds:X509Certificate>MIIC7j...</ds:X509Certificate>
        </ds:X509Data>
      </KeyInfo>
    </ds:Signature>
    <Subject>
      <NameID>user@example.org</NameID>
      <SubjectConfirmation Method="urn:oasis:names:tc:SAML:2.0:cm:bearer">
        <SubjectConfirmationData InResponseTo="19fb953133b313a86a001f2d387160e47f3e7aa0" NotOnOrAfter="2019-07-30T13:29:25.488Z" Recipient="{{ link-console-main }}/federations/bfbrotp6l1b2avhe1spu" />
      </SubjectConfirmation>
    </Subject>
    <Conditions NotBefore="2019-07-30T13:24:25.482Z" NotOnOrAfter="2019-07-30T14:24:25.482Z">
      <AudienceRestriction>
        <Audience>{{ link-console-main }}/federations/bfbrotp6l1b2avhe1spu</Audience>
      </AudienceRestriction>
    </Conditions>
    <AttributeStatement>
      <Attribute Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress">
        <AttributeValue>user@example.org</AttributeValue>
      </Attribute>
      <Attribute Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname">
        <AttributeValue>First Name</AttributeValue>
      </Attribute>
      <Attribute Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname">
        <AttributeValue>Last Name</AttributeValue>
      </Attribute>
    </AttributeStatement>
  </Assertion>
</samlp:Response>
```

When setting up the message:

* Use the `Response` and the `SubjectConfirmationData` properties of the `InResponseTo` attribute to specify the ID from the SAML authentication request sent by {{ yandex-cloud }}.
* Enter the [console login link](#get-link) in the following elements:
   * In the `Destination` attribute of `Response`.
   * In the `Recipient` attribute of `SubjectConfirmationData`.
   * In `Audience`.
* Specify a unique user ID in the `NameID` element. We recommend using the User Principal Name (UPN) or email address.
* Specify the link to the IdP page in the `Issuer` element. The user was forwarded to this page for authentication).
* Enter a signed message in the `SignatureValue` element and the certificate it was signed with in the `KeyInfo` element.
* Please keep in mind that {{ yandex-cloud }} verifies that the response is received in the interval specified in the `Conditions` or the `SubjectConfirmationData` property attributes.
* For a user to be able to contact {{ yandex-cloud }} technical support from the [management console]({{ link-console-support }}), pass the user's name and email address in the `AttributeStatement` property. Email, first name, and last name are passed in separate `Attribute` elements. You can also pass the first name and last name together, for example:
   ```
   <Attribute Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name">
     <AttributeValue>John Doe</AttributeValue>
   </Attribute>
   ```

   In the `Name` attribute, you can specify a short attribute name, for example:
   ```
   <Attribute Name="name">
     <AttributeValue>John Doe</AttributeValue>
   </Attribute>
   ```

## Configure user attribute mapping {#claims-mapping}

After a user authenticates, the identity provider's server forwards to {{ yandex-cloud }} an SAML message with information about successful authentication and user attributes, such as ID, name, email address, and so on.

To correctly pass user information to {{ org-full-name }}, map SAML message attributes to the user's personal information stored on the identity provider's server.

| User data | Comment | SAML message elements |
------------------- | ----------- | ----------------------
| Unique user ID | Required attribute. We recommend using the User Principal Name (UPN) or email address. | `<NameID>` |
| Last name | Displayed in {{ yandex-cloud }} services. | `<Attribute>` with the<br>`Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname"` parameter |
| Name | Displayed in {{ yandex-cloud }} services. | `<Attribute>` with the<br>`Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname"` parameter |
| Full name | Displayed in {{ yandex-cloud }} services.<br>Example: John Smith | `<Attribute>` with the<br>`Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"` parameter |
| Email | Used to send notifications from {{ yandex-cloud }} services.<br>Example: `smith@example.com` | `<Attribute>` with the<br>`Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"` parameter |
| Phone | Used to send notifications from {{ yandex-cloud }} services.<br>Example: +71234567890 | `<Attribute>` with the<br>`Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/mobilephone"` parameter |
| Profile image | Displayed in {{ yandex-cloud }} services.<br>Images are transmitted in Base64 encoding. [Example](#avatar-example) | `<Attribute>` with the<br>`Name="thumbnailPhoto"` parameter |

### Sample Base64-encoded image {#avatar-example}

The profile image is transmitted in text format using [Base64]({{ link-base64 }}) encoding.

{% cut "Sample encoded image" %}

```
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
UYGmIgo9HwAAAABJRU5ErkJggg==
```

{% endcut %}

## Add users to your organization {#add-users}

If you did not enable the **Automatically create users** option when creating a federation, federated users must be manually added to your organization.

To do this, you need to know the Name IDs of the users that the Identity Provider Server (IdP) returns along with the successful authentication confirmation. This is usually the user's primary email address. If you don't know what the server returns as the Name ID, contact the administrator who configured authentication for your federation.

To add federation users to an organization:

{% list tabs %}

- Management console

   1. [Log in]({{ link-passport }}) to the organization's administrator account.

   1. Go to [{{ org-full-name }}]({{ link-org-main }}).

   1. In the left panel, select [Users]({{ link-org-users }}) ![icon-users](../../../_assets/organization/icon-users.svg).

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
      yc organization-manager federation saml add-user-accounts --name my-federation \
        --name-ids=alice@example.com,bob@example.com,charlie@example.com
      ```

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
      curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer <IAM token>" \
        -d '@body.json' \
        https://organization-manager.{{ api-host }}/organization-manager/v1/saml/federations/<federation ID>:addUserAccounts
      ```

{% endlist %}

## Test the authentication process {#test-auth}

When you finish configuring the server, check the authentication process:

1. Open the browser in guest or incognito mode to simulate being a new user.

1. Follow the [management console login link](#get-link) you obtained earlier. The browser forwards you to the authentication page.

1. Enter your authentication data. By default, you must enter the UPN and password. Then click **Sign in**.

1. On successful authentication, the server will redirect you back to the management console login link and then to the console's home page. In the upper-right corner, you can see that you are logged in to the console as a federated user.

#### What's next {#what-is-next}

* [Assign roles to the new users](../../../iam/operations/roles/grant.md#access-to-federated-user).
