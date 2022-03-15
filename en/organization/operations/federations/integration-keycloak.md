# Authentication using Keycloak

If you have an [identity federation](../../add-federation.md) you can use [Keycloak](https://www.keycloak.org/) to authenticate users in the organization.

Authentication setup consists of the following steps:

1. [Creating and configuring a federation in {{org-full-name}}](#yc-settings).

1. [Creating and configuring an SAML app in Keycloak](#keycloak-settings).

1. [Adding users to {{org-full-name}}](#add-users).

1. [Verifying authentication](#test-auth).

## Before you start {#before-you-begin}

To use the instructions in this section, you will need:​

1. Docker platform. If you don't have Docker installed, [install it](https://docs.docker.com/get-docker/). Make sure the Docker Engine is running.

1. [Keycloak](https://www.keycloak.org/) local IdP server. To install Keycloak, run the commands:

   ```bash
   git clone https://github.com/keycloak/keycloak-containers.git
   cd ./keycloak-containers/docker-compose-examples
   docker-compose -f keycloak-postgres.yml up
   ```

1. A valid certificate that is used for signing in the Keycloak service. To get it:

     1. Follow the link `http://localhost:8080/auth/realms/master/protocol/saml/descriptor`.

     1. Copy the contents of the tag `<ds:X509Certificate>...</ds:X509Certificate>`.

     1. Save the certificate as a text file with the `.cer` extension in the following format:

     ```
     -----BEGIN CERTIFICATE-----
     <X509Certificate value>
     -----END CERTIFICATE-----
     ```

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

  1. In the **IdP Issuer** field, insert the link:

      ```
      http://localhost:8080/auth/realms/master
      ```

  1. In the **Link to the IdP login page** field, insert the link:

      ```
      http://localhost:8080/auth/realms/master/protocol/saml
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
            --issuer "http://localhost:8080/auth/realms/master" \
            --sso-binding POST \
            --sso-url "http://localhost:8080/auth/realms/master/protocol/saml"       
       ```

        Where:

        * `name`: Federation name. The name must be unique within the folder.

        * `organization-id`: Your organization ID.

        * `auto-create-account-on-login`: A flag to enable the automatic creation of new cloud users following authentication on the IdP server.
          This option makes it easier to create users, but users created this way won't be able to do anything with cloud resources. Resources with roles assigned to the [system group](../../../iam/concepts/access-control/system-group.md) `allUsers` or `allAuthenticatedUsers` are the exception.

            If this option is disabled, users not added to the organization will not be able to log in to the management console, even if they authenticate on your IdP server. This enables you to manage a list of users allowed to use {{ yandex-cloud }} resources.

        * `cookie-max-age`: Time that must elapse before the browser asks the user to re-authenticate.

        * `issuer`: IdP server ID to be used for authentication.

        * `sso-url`: URL of the page that the browser redirects the user to for authentication.

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
          "issuer": "http://localhost:8080/auth/realms/master",
          "ssoUrl": "http://localhost:8080/auth/realms/master/protocol/saml",
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

        * `ssoUrl`: URL of the page that the browser redirects the user to for authentication.

        * `ssoBinding`: Specify the Single Sign-on binding type. Most Identity Providers support the `POST` binding type.

    1. {% include [include](../../../_includes/iam/create-federation-curl.md) %}

{% endlist %}

### Add certificates {#add-certificate}

When authenticating, {{org-name}} should be able to verify the IdP server certificate. To do this, add the certificate to the federation:

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

When you set up federation authentication, users can log in to the management console from a link containing the federation ID.

Get the link:

1. Copy the Federation ID:

    1. In the left-hand panel, select [Federations]({{link-org-federations}}) ![icon-federation](../../../_assets/organization/icon-federation.png) section.

    1. Copy the ID of the federation you're configuring access for.

1. Generate a link using this ID:

    `{{ link-console-main }}/federations/<federation ID>`

## Creating and configuring an SAML app in Keycloak {#keycloak-settings}

The Identity Provider (IdP) is an SAML app in Keycloak. To create and configure an SAML app:

1. Log in to [Keycloak administrator account](http://localhost:8080/auth/admin). To do this, specify:
    * **Username or email** : `admin`.
    * **Password** : `pa55w0rd`.

1. Enable the identity provider role mapping option and {{org-full-name}}:

    1. In the left-hand panel, select **Client Scopes**  →  **role_list**.

    1. Go to the **Mappers** tab and choose **role list**.

    1. Enable the **Single Role Attribute** option.

1. Create an SAML app:

    1. In the left-hand panel, select **Clients**. Click **Create**.

    1. In the **Client ID** field, enter the previously obtained [console login link](#get-link).

    1. In the **Client Protocol** field, select the **saml** option.

    1. Click **Save**.

1. Configure SAML app settings on the **Settings** tab:

    1. Enter the previously obtained [console login link](#get-link) in the fields:
        * **Valid Redirect URIs**.
        * **Base URL**.
        * **IDP Initiated SSO Relay State**.

    1. Enable options:
        * **Include AuthnStatement**.
        * **Sign Assertions**.
        * **Force POST Binding**.
        * **Front Channel Logout**.

    1. In the **Signature Algorithm** field, select **RSA_SHA256**.

    1. In the **SAML Signature Key Name** field, select **CERT_SUBJECT**.

    1. For **Name ID Format**, select the appropriate option from the list.

    1. Click **Save**.

1. Add users:

    1. In the left-hand panel, select **Users**.

    1. Click **Add user** and enter the user data.

    1. Click **Save**.

    1. On the **Credentials** tab, set a password and click **Set Password**.

## Adding users to {{org-full-name}} {#add-users}

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

1. Follow the [console login link](#yc-settings) obtained earlier. The browser forwards you to the Keycloak authentication page.

1. Enter your credentials and click **Sign in**.

Following successful authentication, the IdP server will redirect you back to the management console login link and then to the [management console]({{ link-console-main }}) home page. In the upper-right corner, you can see that you are logged in to the console as a federated user.

