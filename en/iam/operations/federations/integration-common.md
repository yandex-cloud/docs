# Authentication using an SAML-compatible identity federation

This is a generic guide to configure authentication in the cloud via an SAML-compatible identity federation. Use these instructions if there aren't any [ad-hoc instructions](../index.md#federations) for your identity federation.

To set up authentication:

1. [Create an identity federation in the cloud](#create-federation).
1. [Add certificates to the federation](#add-certificate).
1. [Get a console login link](#get-link).
1. [Configure authentication on your server](#configure-sso).
1. [Add users to the cloud](#add-users).
1. [Test the authentication process](#test-auth).

## Before you start {#before-you-begin}

To use the instructions in this section, you need:​

1. The [admin](../../concepts/access-control/roles.md#admin) or [resource-manager.clouds.owner](../../concepts/access-control/roles.md#owner) in the cloud that you want to set up SAML authentication for.

1. A valid certificate used to sign SAML messages on the Identity Provider (IdP) server. If you don't have a valid SSL certificate, get one.

    The subject name in the certificate must contain the FQDN of the Identity Provider (IdP) server, for example, `fs.contoso.com`, to prevent the browser from blocking the authentication page.

## Create a federation in the cloud {#create-federation}

To create a federation in {{ iam-short-name }}:

{% list tabs %}

- Management console

  1. Open the folder page in the [management console]({{ link-console-main }}).

  1. Select the **Federations** tab in the left menu.

  1. Click **Create federation**.

  1. Enter a name for the federation. The name must be unique within the folder.

  1. Add a description if necessary.

  1. In the **Cookie lifetime** field, specify the time before the browser asks the user to re-authenticate.

  1. In the **IdP Issuer** field, specify the IdP server ID to be used for authentication. The IdP server also responds to {{ iam-short-name }} with this ID after the user authenticates.

  1. In the **Link to the IdP login page** field, specify the address of the page that the browser redirects the user to for authentication.

  1. Enable **Automatically create users** to automatically add authenticated users to the cloud. This option simplifies the user setup, but users created this way are only assigned the `resource-manager.clouds.member` role by default: they can't do anything with cloud resources. Exceptions are the resources that the `allUsers` or `allAuthenticatedUsers` system group roles are assigned to.

      If this option is disabled, users who aren't added to the cloud can't log in to the management console, even if they authenticate with your server. In this case, you can manage the white list of users who are allowed to use {{ yandex-cloud }}.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. See the description of the create federation command:

        ```
        yc iam federation create --help
        ```

    1. Create a federation:

        ```
        yc iam federation create --name my-federation \
          --auto-create-account-on-login \
          --cookie-max-age 12h \
          --issuer "https://accounts.google.com/o/saml2?idpid=C03xolm0y" \
          --sso-binding POST \
          --sso-url "https://accounts.google.com/o/saml2/idp?idpid=C03xolm0y"
        ```

        Where:

        * `name`: Federation name. The name must be unique within the folder.

        * `auto-create-account-on-login`: Flag for automatically creating new users in the cloud after authenticating on the IdP server. This option simplifies the user setup, but users created this way are only assigned the `resource-manager.clouds.member` role by default: they can't do anything with cloud resources. Exceptions are the resources that the `allUsers` or `allAuthenticatedUsers` system group roles are assigned to.

            If this option is disabled, users who aren't added to the cloud can't log in to the management console, even if they authenticate with your server. In this case, you can manage the white list of users who are allowed to use {{ yandex-cloud }}.

        * `cookie-max-age`: Time before the browser asks the user to re-authenticate.

        * `issuer`: IdP server ID to be used for authentication. The IdP server also responds to {{ iam-short-name }} with this ID after the user authenticates.

        * `sso-url`: URL of the page that the browser redirects the user to for authentication.

        * `sso-binding`: Specify the Single Sign-on binding type. Most Identity Providers support the `POST` binding type.

- API

  1. [Get the ID of the folder](../../../resource-manager/operations/folder/get-id.md) to create your federation in.

  1. Create a file with the request body (for example, `body.json`):

      ```json
      {
        "folderId": "<folder ID>",
        "name": "my-federation",
        "autocreateUsers": true,
        "cookieMaxAge":"43200s",
        "issuer": "https://accounts.google.com/o/saml2?idpid=C03xolm0y",
        "ssoUrl": "https://accounts.google.com/o/saml2/idp?idpid=C03xolm0y",
        "ssoBinding": "POST"
      }
      ```

      Where:

      * `folderId`: ID of the folder.

      * `name`: Federation name. The name must be unique within the folder.

      * `autocreateUsers`: Flag for automatically creating new users in the cloud after authenticating on the IdP server. This option simplifies the user setup, but users created this way are only assigned the `resource-manager.clouds.member` role by default: they can't do anything with cloud resources. Exceptions are the resources that the `allUsers` or `allAuthenticatedUsers` system group roles are assigned to.

          If this option is disabled, users who aren't added to the cloud can't log in to the management console, even if they authenticate with your server. In this case, you can manage the white list of users who are allowed to use {{ yandex-cloud }}.

      * `cookieMaxAge`: Time before the browser asks the user to re-authenticate.

      * `issuer`: IdP server ID to be used for authentication. The IdP server also responds to {{ iam-short-name }} with this ID after the user authenticates.

      * `ssoUrl`: URL of the page that the browser redirects the user to for authentication.

      * `ssoBinding`: Specify the Single Sign-on binding type. Most Identity Providers support the `POST` binding type.

  1. {% include [include](../../../_includes/iam/create-federation-curl.md) %}

{% endlist %}

## Specify certificates for the identity federation {#add-certificate}

{% include [federation-sertificates-note](../../../_includes/iam/federation-sertificates-note.md) %}

{% include [federation-sertificates-add](../../../_includes/iam/federation-sertificates-add.md) %}

## Get a console login link {#get-link}

{% include [federation-login-link](../../../_includes/iam/federation-login-link.md) %}

## Configure authentication on your server {#configure-sso}

After you create a federation and obtain a management console login link, configure the Identity Provider (IdP) server. After each successful authentication, the server must send a relevant SAML message to the management console.

Example of an SAML message:

```xml
<samlp:Response ID="_bcdf7b6b-ea42-4191-8d5e-ebd4274acec6" Version="2.0" IssueInstant="2019-07-30T13:24:25.488Z"
 Destination="https://console.cloud.yandex.com/federations/bfbrotp6l1b2avhe1spu" Consent="urn:oasis:names:tc:SAML:2.0:consent:unspecified"
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
        <SubjectConfirmationData InResponseTo="19fb953133b313a86a001f2d387160e47f3e7aa0" NotOnOrAfter="2019-07-30T13:29:25.488Z" Recipient="https://console.cloud.yandex.com/federations/bfbrotp6l1b2avhe1spu" />
      </SubjectConfirmation>
    </Subject>
    <Conditions NotBefore="2019-07-30T13:24:25.482Z" NotOnOrAfter="2019-07-30T14:24:25.482Z">
      <AudienceRestriction>
        <Audience>https://console.cloud.yandex.com/federations/bfbrotp6l1b2avhe1spu</Audience>
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

* In the `InResponseTo` attribute of the  `Response` and `SubjectConfirmationData` elements, specify the ID from the SAML authentication request that {{ yandex-cloud }} sent.

* Enter the [console login link](#get-link) in the following elements:
  * In the `Destination` attribute of `Response`.
  * In the `Recipient` attribute of  `SubjectConfimirationData`.
  * In `Audience`.

* Specify a unique user ID in the `NameID` element. We recommend using the User Principal Name (UPN) or email address.

* Specify the link to the IdP page in the `Issuer` element. The user was forwarded to this page for authentication).

* Enter a signed message in the `SignatureValue` element and the certificate it was signed with in the `KeyInfo` element.

* Note that {{ yandex-cloud }} validates that the response was received in the interval specified in the attributes of the `Conditions` or `SubjectConfimirationsData` element.

* For the user to be able to contact {{ yandex-cloud }} technical support from the [management console](https://console.cloud.yandex.com/support), pass their email address and name in the `AttributeStatement` element. Email, first name, and last name are passed in separate `Attribute` elements. You can also pass the first name and last name together, for example:

    ```
    <Attribute Name="http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name">
      <AttributeValue>John Doe</AttributeValue>
    </Attribute>
    ```

    In the  `Name` attribute, you can specify a short attribute name, for example:

    ```
    <Attribute Name="name">
      <AttributeValue>John Doe</AttributeValue>
    </Attribute>
    ```

## Add users to the cloud {#add-users}

{% include [add-federated-users](../../../_includes/iam/add-federated-users.md) %}

## Test the authentication process {#test-auth}

When you finish configuring the server, check the authentication process:

1. Open the browser in guest or incognito mode to simulate being a new user.
1. Follow the [management console login link](#get-link) you obtained earlier. The browser forwards you to the authentication page.
1. Enter your authentication data. By default, you must enter the UPN and password. Then click **Sign in**.
1. On successful authentication, the server will redirect you back to the management console login link and then to the console's home page. In the upper-right corner, you can see that you are logged in to the console as a federated user.

#### What's next {#what-is-next}

* [Assign roles to the added users](../roles/grant.md#access-to-federated-user).

