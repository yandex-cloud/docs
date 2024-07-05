# Authentication using Keycloak

With an [identity federation](../../concepts/add-federation.md), you can use [Keycloak](https://www.keycloak.org/) to authenticate users in an organization.

Authentication setup includes the following steps:

1. [Creating and setting up a federation in {{ org-full-name }}](#yc-settings).

1. [Creating and setting up a SAML application in Keycloak](#keycloak-settings).

1. [Adding users to {{ org-full-name }}](#add-users).

1. [Authentication](#test-auth).

## Getting started {#before-you-begin}

To follow the steps in this section, you will need:​

1. Docker. If you do not have Docker yet, [install it](https://docs.docker.com/get-docker/). Make sure Docker Engine is running.

1. [Keycloak](https://www.keycloak.org/) local IdP server. To install and start Keycloak, run these commands:

   {% list tabs %}

   - Keycloak 20 in developer mode

      ```bash
      docker run -p 8080:8080 -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=Pa55w0rd quay.io/keycloak/keycloak:latest start-dev
      ```

   - Keycloak 19

      ```bash
      git clone https://github.com/keycloak/keycloak-containers.git
      cd ./keycloak-containers/docker-compose-examples
      docker-compose -f keycloak-postgres.yml up
      ```

   {% endlist %}

   {% note info %}

   To enable employees on a corporate network or the internet to use Keycloak for authentication in your application, deploy the Keycloak IdP server on the network and set up a public address. Read more in the [Keycloak documentation](https://www.keycloak.org/server/hostname).

   {% endnote %}

1. Valid certificate used for signing in the Keycloak service. To get it:

   1. Log in to the Keycloak administrator account at:

      {% list tabs %}

      - Keycloak 17 or higher

         `http://keycloak.example.com:8080/admin`. Replace `Keycloak.example.com` with your local server address, e.g., `http://localhost:8080/admin`.

      - Keycloak 16 or lower

         `http://keycloak.example.com:8080/auth/admin`. Replace `keycloak.example.com` with your local server address, e.g., `http://localhost:8080/auth/admin`.

      {% endlist %}

      The default login parameters are as follows:
      * **User name or email**: `admin`.
      * **Password** : `Pa55w0rd`.

   1. In the **Realm Settings** section, select the **Keys** tab.

   1. In the **RS256** line, click **Certificate** and copy the certificate value.

   1. Save the certificate as a text file with the `.cer` extension in the following format:

      ```
      -----BEGIN CERTIFICATE-----
      <certificate_value>
      -----END CERTIFICATE-----
      ```

   You can also get the certificate through this direct link:

   {% list tabs %}

   - Keycloak 17 or higher

      `http://keycloak.example.com:8080/realms/master/protocol/saml/descriptor`. The certificate value is stored in the `<ds:X509Certificate>...</ds:X509Certificate>` tag.

   - Keycloak 16 or lower

      `http://keycloak.example.com:8080/auth/realms/master/protocol/saml/descriptor`. The certificate value is stored in the `<ds:X509Certificate>...</ds:X509Certificate>` tag.

   {% endlist %}

## Creating and setting up a federation in {{ org-full-name }} {#yc-settings}

### Create a federation {#create-federation}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to [{{ org-full-name }}]({{ link-org-main }}).

   1. In the left-hand panel, select [{{ ui-key.yacloud_org.pages.federations }}]({{ link-org-federations }}) ![icon-federation](../../../_assets/console-icons/vector-square.svg).

   1. Click **{{ ui-key.yacloud_org.form.federation.action.create }}**.

   1. Give your federation a name. It must be unique within the folder.

   1. You can also add a description, if required.

   1. In the **{{ ui-key.yacloud_org.entity.federation.field.cookieMaxAge }}** field, specify the time before the browser asks the user to re-authenticate.

   1. In the **{{ ui-key.yacloud_org.entity.federation.field.issuer }}** field, enter a link of the form:

      - Keycloak 17 or higher

         ```
         http://<host>:8080/realms/master
         ```

         If you set up a [public address](https://www.keycloak.org/server/hostname) for the IdP server, specify its URL, e.g.:

         ```
         {{ link-keycloak-example }}
         ```

      - Keycloak 16 or lower

         ```
         http://<host>:8080/realms/master
         ```

         If you set up a [public address](https://www.keycloak.org/server/hostname) for the IdP server, specify its URL, e.g.:

         ```
         {{ link-keycloak-example-old }}
         ```

   1. In the **{{ ui-key.yacloud_org.entity.federation.field.ssoUrl }}** field, enter a link of the form:

      - Keycloak 17 or higher

         ```
         http://<host>:8080/realms/master/protocol/saml
         ```

         If you set up a [public address](https://www.keycloak.org/server/hostname) for the IdP server, specify its URL, e.g.:

         ```
         {{ link-keycloak-example }}/protocol/saml
         ```

      - Keycloak 16 or lower

         ```
         http://<host>:8080/auth/realms/master/protocol/saml
         ```

         If you set up a [public address](https://www.keycloak.org/server/hostname) for the IdP server, specify its URL, e.g.:

         ```
         {{ link-keycloak-example-old }}/protocol/saml
         ```

      {% include [ssourl_protocol](../../../_includes/organization/ssourl_protocol.md) %}

   1. Enable **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}** to automatically add a new user to your organization after authentication. If this option is disabled, you will need to [manually add](../../operations/add-account.md#add-user-sso) your federated users.

      {% include [fed-users-note](../../../_includes/organization/fed-users-note.md) %}

   1. It you want all authentication requests from {{ yandex-cloud }} to contain a digital signature, enable the **{{ ui-key.yacloud_org.entity.federation.field.encryptedAssertions }}** option. To complete the configuration, download and [install](#signature) a {{ yandex-cloud }} certificate. You can download the certificate in the **{{ ui-key.yacloud_org.entity.federation.field.encryptedAssertions }}** field immediately after saving a federation.

   1. {% include [forceauthn-option-enable](../../../_includes/organization/forceauthn-option-enable.md) %}

   1. Click **{{ ui-key.yacloud_org.form.federation.create.action.create }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View the description of the create federation command:

      ```
      yc organization-manager federation saml create --help
      ```

   1. Create a federation:

      - Keycloak 17 or higher

         ```bash
         yc organization-manager federation saml create --name my-federation \
             --organization-id <organization_ID> \
             --auto-create-account-on-login \
             --encrypted-assertions \
             --cookie-max-age 12h \
             --issuer "http://<host>:8080/realms/master" \
             --sso-binding POST \
             --sso-url "http://<host>:8080/realms/master/protocol/saml" \
             --force-authn
         ```

      - Keycloak 16 or lower

         ```bash
         yc organization-manager federation saml create --name my-federation \
             --organization-id <organization_ID> \
             --auto-create-account-on-login \
             --encrypted-assertions \
             --cookie-max-age 12h \
             --issuer "http://<host>:8080/auth/realms/master" \
             --sso-url "http://<host>:8080/auth/realms/master/protocol/saml" \
             --sso-binding POST \
             --force-authn
         ```

         Where:

         * `--name`: Federation name. It must be unique within the folder.

         * `--organization-id`: Organization ID.

         * `--auto-create-account-on-login`: Flag to enable the automatic creation of new cloud users following authentication on the IdP server.
            This option makes it easier to create users; however, users created this way will not be able to do anything with cloud resources. This does not apply to the resources the `allUsers` or `allAuthenticatedUsers` [system group](../../../iam/concepts/access-control/system-group.md) roles are assigned to.

            If this option is disabled, users who are not added to the organization cannot log in to the management console, even if they authenticate with your IdP server. In this case, you can manage a list of users allowed to use {{ yandex-cloud }} resources.

         * `--encrypted-assertions`: Flag that enables a digital signature for authentication requests. To complete the configuration, download and [install](#signature) a {{ yandex-cloud }} certificate.

         * `--cookie-max-age`: Time before the browser asks the user to re-authenticate.

         * `--issuer`: ID of the IdP server to use for authentication:

            - Keycloak 17 or higher

               ```
               http://<host>:8080/realms/master
               ```

               If you set up a [public address](https://www.keycloak.org/server/hostname) for the IdP server, specify its URL, e.g.:

               ```
               {{ link-keycloak-example }}
               ```

            - Keycloak 16 or lower

               ```
               http://<host>:8080/realms/master
               ```

               If you set up a [public address](https://www.keycloak.org/server/hostname) for the IdP server, specify its URL, e.g.:

               ```
               {{ link-keycloak-example-old }}
               ```

         * `--sso-url`: URL of the page to which the browser should redirect the user for authentication:

            - Keycloak 17 or higher

               ```
               http://<host>:8080/realms/master/protocol/saml
               ```

               If you set up a [public address](https://www.keycloak.org/server/hostname) for the IdP server, specify its URL, e.g.:

               ```
               {{ link-keycloak-example }}/protocol/saml
               ```

            - Keycloak 16 or lower

               ```
               http://<host>:8080/auth/realms/master/protocol/saml
               ```

               If you set up a [public address](https://www.keycloak.org/server/hostname) for the IdP server, specify its URL, e.g.:

               ```
               {{ link-keycloak-example-old }}/protocol/saml
               ```

            {% include [ssourl_protocol](../../../_includes/organization/ssourl_protocol.md) %}

         * `--sso-binding`: Single sign-on binding type. Most identity providers support the `POST` binding type.

         * {% include [forceauthn-cli-enable](../../../_includes/organization/forceauth-cli-enable.md) %}

- API {#api}

   1. Create a file with the request body, e.g., `body.json`:

      - Keycloak 17 or higher

         ```json
         {
           "name": "my-federation",
           "organizationId": "<organization_ID>",
           "autoCreateAccountOnLogin": true,
           "cookieMaxAge":"43200s",
           "issuer": "http://<host>:8080/realms/master",
           "ssoUrl": "http://<host>:8080/realms/master/protocol/saml",
           "securitySettings": {
               "encryptedAssertions": true,
               "forceAuthn": true
           },
           "ssoBinding": "POST"
         }
         ```

      - Keycloak 16 or lower

         ```json
         {
           "name": "my-federation",
           "organizationId": "<organization_ID>",
           "autoCreateAccountOnLogin": true,
           "cookieMaxAge":"43200s",
           "issuer": "http://<host>:8080/auth/realms/master",
           "ssoUrl": "http://<host>:8080/auth/realms/master/protocol/saml",
           "securitySettings": {
             "encryptedAssertions": true,
             "forceAuthn": true
           },
           "ssoBinding": "POST"
         }
         ```

         Where:

         * `name`: Federation name. It must be unique within the folder.

         * `organizationId`: Organization ID.

         * `autoCreateAccountOnLogin`: Flag to activate the automatic creation of new cloud users after authenticating on the IdP server.
            This option makes it easier to create users; however, users created this way will not be able to do anything with cloud resources. This does not apply to the resources the `allUsers` or `allAuthenticatedUsers` [system group](../../../iam/concepts/access-control/system-group.md) roles are assigned to.

            If this option is disabled, users who are not added to the organization cannot log in to the management console, even if they authenticate with your IdP server. In this case, you can manage a list of users allowed to use {{ yandex-cloud }} resources.

         * `cookieMaxAge`: Time before the browser asks the user to re-authenticate.

         * `issuer`: ID of the IdP server to use for authentication:

            - Keycloak 17 or higher

               ```
               http://<host>:8080/realms/master
               ```

               If you set up a [public address](https://www.keycloak.org/server/hostname) for the IdP server, specify its URL, e.g.:

               ```
               {{ link-keycloak-example }}
               ```

            - Keycloak 16 or lower

               ```
               http://<host>:8080/realms/master
               ```

               If you set up a [public address](https://www.keycloak.org/server/hostname) for the IdP server, specify its URL, e.g.:

               ```
               {{ link-keycloak-example-old }}
               ```

         * `ssoUrl`: URL of the page the browser redirects the user to for authentication:

            - Keycloak 17 or higher

               ```
               http://<host>:8080/realms/master/protocol/saml
               ```

               If you set up a [public address](https://www.keycloak.org/server/hostname) for the IdP server, specify its URL, e.g.:

               ```
               {{ link-keycloak-example }}/protocol/saml
               ```

            - Keycloak 16 or lower

               ```
               http://<host>:8080/auth/realms/master/protocol/saml
               ```

               If you set up a [public address](https://www.keycloak.org/server/hostname) for the IdP server, specify its URL, e.g.:

               ```
               {{ link-keycloak-example-old }}/protocol/saml
               ```

            {% include [ssourl_protocol](../../../_includes/organization/ssourl_protocol.md) %}

         * `encryptedAssertions`: Flag that enables a digital signature for authentication requests. To complete the configuration, download and [install](#signature) a {{ yandex-cloud }} certificate.

         * {% include [forceauthn-api-enable](../../../_includes/organization/forceauth-api-enable.md) %}

         * `ssoBinding`: Single sign-on binding type. Most identity providers support the `POST` binding type.

   1. {% include [include](../../../_includes/iam/create-federation-curl.md) %}

- {{ TF }} {#tf}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   1. Specify the federation parameters in the configuration file:

      * `name`: Federation name. It must be unique within the folder.
      * `description`: Federation description.
      * `organization_id`: Organization ID.
      * `labels`: Set of key/value label pairs assigned to the federation.
      * `issuer`: ID of the IdP server to use for authentication:

         - Keycloak 17 or higher

            ```
            http://<host>:8080/realms/master
            ```

            If you set up a [public address](https://www.keycloak.org/server/hostname) for the IdP server, specify its ID, e.g.:

            ```
            {{ link-keycloak-example }}
            ```

         - Keycloak 16 or lower

            ```
            http://<host>:8080/realms/master
            ```

            If you set up a [public address](https://www.keycloak.org/server/hostname) for the IdP server, specify its ID, e.g.:

            ```
            {{ link-keycloak-example-old }}
            ```

      * `sso_binding`: Single sign-on binding type. Most identity providers support the `POST` binding type.
      * `sso_url`: URL of the page the browser redirects the user to for authentication:

         - Keycloak 17 or higher

            ```
            http://<host>:8080/realms/master/protocol/saml
            ```

            If you set up a [public address](https://www.keycloak.org/server/hostname) for the IdP server, specify its URL, e.g.:

            ```
            {{ link-keycloak-example }}/protocol/saml
            ```

         - Keycloak 16 or lower

            ```
            http://<host>:8080/auth/realms/master/protocol/saml
            ```

            If you set up a [public address](https://www.keycloak.org/server/hostname) for the IdP server, specify its URL, e.g.:

            ```
            {{ link-keycloak-example-old }}/protocol/saml
            ```

         {% include [ssourl_protocol](../../../_includes/organization/ssourl_protocol.md) %}

      * `cookie_max_age`: Time, in seconds, before the browser asks the user to re-authenticate. The default value is `8 hours`.
      * `auto_create_account_on_login`: Flag to activate the automatic creation of new cloud users after authenticating on the IdP server.
         This option makes it easier to create users; however, users created this way will not be able to do anything with cloud resources. This does not apply to the resources the `allUsers` or `allAuthenticatedUsers` [system group](../../../iam/concepts/access-control/system-group.md) roles are assigned to.

         If this option is disabled, users who are not added to the organization cannot log in to the management console, even if they authenticate with your server. In this case, you can manage a list of users allowed to use {{ yandex-cloud }} resources.
      * `case_insensitive_name_ids`: Flag that indicates whether usernames are case-insensitive.
         If the option is enabled, the IDs of federated user names will be case-insensitive.
      * `security_settings`: Federation security settings:
      * `encrypted_assertions`: Sign authentication requests.
         If this option is enabled, all authentication requests from {{ yandex-cloud }} will have a digital signature. You will need to download and install a {{ yandex-cloud }} certificate.

      {% cut "Here is a sample configuration file structure" %}

      - Keycloak 17 or higher

         ```
         resource "yandex_organizationmanager_saml_federation" federation {
         name            = "my-federation"
         organization_id = "<organization_ID>"
         auto_create_account_on_login = "true"
         issuer          = "http://<host>:8080/auth/realms/master"
         sso_url         = "http://<host>:8080/auth/realms/master/protocol/saml"
         sso_binding     = "POST"
         security_settings {
             encrypted_assertions = "true"
             }
         }
         ```

      - Keycloak 16 or lower

         ```
         resource "yandex_organizationmanager_saml_federation" federation {
         name            = "my-federation"
         organization_id = "<organization_ID>"
         auto_create_account_on_login = "true"
         issuer          = "http://<host>:8080/realms/master"
         sso_url         = "http://<host>:8080/realms/master/protocol/saml"
         sso_binding     = "POST"
         security_settings {
             encrypted_assertions = "true"
             }
         }
         ```

      {% endcut %}

   1. Make sure the configuration files are correct.

      1. In the command line, go to the folder where you created the configuration file.
      1. Run a check using this command:

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

   This will create a federation in the specified organization. You can check the new federation and its settings in the organization's [{{ ui-key.yacloud_org.pages.federations }}]({{ link-org-federations }}) section.

{% endlist %}

### Add certificates {#add-certificate}

While authenticating, the {{ org-name }} service should be able to verify the IdP server certificate. To enable this, add the certificate to the federation:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the left-hand panel, select [{{ ui-key.yacloud_org.pages.federations }}]({{ link-org-federations }}) ![icon-federation](../../../_assets/console-icons/vector-square.svg).

   1. Click the name of the federation to add a certificate to.

   1. At the bottom of the page, click **{{ ui-key.yacloud_org.entity.certificate.action.add }}**.

   1. Enter certificate name and description.

   1. Choose how to add a certificate:

      * To add a certificate as a file, click **{{ ui-key.yacloud_portal.component.file-input.button_choose }}** and specify the path to it.

      * To paste the contents of a copied certificate, select the **{{ ui-key.yacloud_org.component.form-file-upload.method.manual }}** method and paste the contents.

   1. Click **{{ ui-key.yacloud_org.actions.add }}**.

- CLI {#cli}

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

- API {#api}

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
      $ export IAM_TOKEN=CggaAT********
      $ curl -X POST \
          -H "Content-Type: application/json" \
          -H "Authorization: Bearer ${IAM_TOKEN}" \
          -d '@body.json' \
          "https://organization-manager.{{ api-host }}/organization-manager/v1/saml/certificates"
      ```

{% endlist %}

{% note tip %}

To make sure authentication is not interrupted when the certificate expires, we recommend adding multiple certificates to your federation, i.e., the current one and those to use afterwards. If one certificate goes invalid, {{ yandex-cloud }} will try another one to verify the signature.

{% endnote %}


## Creating and setting up a SAML application in Keycloak {#keycloak-settings}

A SAML application in Keycloak acts as an identity provider (IdP). To create and set up a SAML application:

1. Log in to the Keycloak administrator account at:

   {% list tabs %}

   - Keycloak 17 or higher

      `http://keycloak.example.com:8080/admin`. Replace `Keycloak.example.com` with your local server address, e.g., `http://localhost:8080/admin`.

   - Keycloak 16 or lower

      `http://keycloak.example.com:8080/auth/admin`. Replace `keycloak.example.com` with your local server address, e.g., `http://localhost:8080/auth/admin`.

   {% endlist %}

   The default login parameters are as follows:
   * **User name or email**: `admin`.
   * **Password**: `Pa55w0rd`.

1. Create a SAML application:

   {% list tabs %}

   - Keycloak 19 or higher

      1. In the left-hand panel, select **Clients**. Click **Create client**.

      1. In the **Client ID** field, enter the ACS URL to redirect users to after successful authentication.

         {% cut "How to get a federation ID" %}

         {% include [get-federation-id](../../../_includes/organization/get-federation-id.md) %}

         {% endcut %}

         
         {% cut "How to get the federation ACS URL" %}

         {% include [get-acs-url](../../../_includes/organization/get-acs-url.md) %}

         {% endcut %}


      1. In the **Client type** field, select **saml**.

      1. Click **Save**.

   - Keycloak 18 or lower

      1. In the left-hand panel, select **Clients**. Click **Create**.

      1. In the **Client ID** field, enter the ACS URL to redirect users to after successful authentication.

         {% cut "How to get a federation ID" %}

         {% include [get-federation-id](../../../_includes/organization/get-federation-id.md) %}

         {% endcut %}

         
         {% cut "How to get the federation ACS URL" %}

         {% include [get-acs-url](../../../_includes/organization/get-acs-url.md) %}

         {% endcut %}


      1. In the **Client Protocol** field, select **saml**.

      1. Click **Save**.

   {% endlist %}

1. Set up the SAML application parameters in the **Settings** tab:

   1. Specify the ACS redirect URL, in the following fields:

      {% list tabs %}

      - Keycloak 19 or higher

         * **Home URL**.
         * **Valid Redirect URIs**
         * **IDP Initiated SSO Relay State**

      - Keycloak 18 or lower

         * **Valid Redirect URIs**
         * **Base URL**
         * **IDP Initiated SSO Relay State**

      {% endlist %}

      
      {% cut "How to get the federation ACS URL" %}

      {% include [get-acs-url](../../../_includes/organization/get-acs-url.md) %}

      {% endcut %}


   1. Enable the following options:
      * **Include AuthnStatement**
      * **Sign Assertions**
      * **Force POST Binding**
      * **Front Channel Logout**

   1. In the **Signature Algorithm** field, select **RSA_SHA256**.

   1. In the **SAML Signature Key Name** field, select **CERT_SUBJECT**.

   1. Select the format you need from the list in the **Name ID Format** field. To make sure this format is provided regardless of the {{ org-full-name }} settings, enable the **Force Name ID format** option.

   1. Click **Save**.

1. If you enabled the **{{ ui-key.yacloud_org.entity.federation.field.encryptedAssertions }}** option when [creating a federation](#create-federation) in {{ org-full-name }}, set up digital signature verification in the SAML application:

   {% list tabs %}

   - Keycloak 19 or higher

      1. In the SAML application **Keys** tab, enable **Encrypt Assertions** and disable **Client Signature Required**.

      1. Select the **Import** method for **Client Signature Required**.

      1. In the **Archive Format** field, select **Certificate PEM**. (You might need to generate certificates first so that clicking **Import key** makes the **Certificate PEM** option available.)
         {#signature}
      1. Click **Browse** and select the certificate to use for signing authentication requests. The certificate is available on the {{ org-full-name }} federation information page in the **{{ ui-key.yacloud_org.entity.federation.field.encryptedAssertions }}** field.

      1. Click **Confirm**.

   - Keycloak 18 or lower

      1. In the SAML application settings, select **Encrypt Assertions** and **Client Signature Required** and save the application to update the available tabs.

      1. In the SAML application's **Keys** tab, locate the **Signing Key** and **Encryption Key** sections and click **Import**.

      1. In the **Archive Format** field, select **Certificate PEM**.
         {#signature}
      1. Click **Select file** and select the certificate to use for signing authentication requests. The certificate is available on the {{ org-full-name }} federation information page in the **{{ ui-key.yacloud_org.entity.federation.field.encryptedAssertions }}** field.

      1. Click **Import**.

   {% endlist %}

1. Add users:

   1. In the left-hand panel, select **Users**.

   1. Click **Add user** and specify user data.

   1. Click **Save**.

   1. In the **Credentials** tab, click **Set Password** and enter a password.

## Adding users to {{ org-full-name }} {#add-users}

If you did not enable the **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}** option when [creating a federation](#yc-settings), you will have to add federated users to your organization manually.

To do this, you will need user name IDs. They are returned by the IdP server together with a response confirming successful authentication.

{% include [auto-create-users](../../../_includes/organization/auto-create-users.md) %}

A user can be added by an organization administrator (the `organization-manager.admin` role) or owner (the `organization-manager.organizations.owner` role). To learn how to grant roles to a user, see [Roles](../../security/index.md#admin).

{% list tabs group=instructions %}

- Management console {#console}

   1. [Log in]({{ link-passport }}) as the organization administrator or owner.

   1. Go to [{{org-full-name}}]({{ link-org-main }}).

   1. In the left-hand panel, select [{{ ui-key.yacloud_org.pages.users }}]({{ link-org-users }}) ![icon-users](../../../_assets/console-icons/person.svg).

   1. In the top-right corner, click ![icon-users](../../../_assets/console-icons/chevron-down.svg) → **{{ ui-key.yacloud_org.page.users.action.add-federated-users }}**.

   1. Select the identity federation to add users from.

   1. List the name IDs of users, separating them with line breaks.

   1. Click **{{ ui-key.yacloud_org.actions.add }}**. This will give the users access to the organization.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the add user command:

      ```
      yc organization-manager federation saml add-user-accounts --help
      ```

   1. Add users by listing their name IDs separated by a comma:

      ```
      yc organization-manager federation saml add-user-accounts --id <federation_ID> \
        --name-ids=alice@example.com,bob@example.com,charlie@example.com
      ```

      Where:

      * `--id`: Federation ID.
      * `--name-ids`: Users' name IDs.

- API {#api}

   To add identity federation users to the cloud:

   1. Create a file with the request body, e.g., `body.json`. In the request body, specify the array of name IDs of users you want to add:

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
        https://organization-manager.{{ api-host }}/organization-manager/v1/saml/federations/<federation ID>:addUserAccounts
      ```

{% endlist %}

### Setting up user attribute mappings {#claims-mapping}

Following user authentication, the IdP server will send the user a SAML message via the browser containing:

* Information about successful authentication.

* User attributes such as a list of roles, the user's full name, and email address.

You can set up a mapping between the SAML message attributes and the personal data stored on the IdP server. To do this:

1. Enable the option for mapping the identity provider roles and {{ org-full-name }}:

   1. In the left-hand panel, select **Client Scopes** → **role_list**.

   1. Go to the **Mappers** tab and select **role list**.

   1. Enable the **Single Role Attribute** option.

1. Set up the attributes to provide to {{ yandex-cloud }}:

   {% list tabs %}

   - Keycloak 19 or higher

      1. In the left-hand panel, select **Client**, open your SAML application settings, and go to **role_list**.

      1. In the **Client Scopes** tab, select **optional** next to **role_list** and click the line with the same name as your client.

      1. In the window that opens, click **Add predefined mappers**.

      1. Select the attributes you need in the list and click **Add**. The following user attributes are available in Keycloak by default:
         * `X500 email`: Email address.
         * `X500 surname`: Last name.
         * `X500 givenName`: First name.
         * `role list`: List of roles.

      1. You can create additional user attributes such as a phone number. To do this, click **Add mappers** -> **By configuration** -> **User Property**, select **User Attribute** in the **Configure a new mapper** table, and set attribute parameters.

      1. Sync Keycloak attributes and {{ org-full-name }}: open an attribute and edit the **SAML Attribute Name** value. You can find the **SAML Attribute Name** values supported in {{ org-full-name }} below.

   - Keycloak 18 or lower

      1. In the left-hand panel, select **Clients** and open your SAML application's settings.

      1. In the **Mappers** tab, click **Add Builtins**.

      1. Select the desired attributes in the list and click **Add selected**. The following user attributes are available in Keycloak by default:
         * `X500 email`: Email address.
         * `X500 surname`: Last name.
         * `X500 givenName`: First name.
         * `role list`: List of roles.

      1. You can create additional user attributes such as a phone number. To do this, click **Create**, select **User Attribute** in the **Mapper Type** field, and set attribute parameters.

      1. Sync Keycloak attributes and {{ org-full-name }}: open an attribute and edit the **SAML Attribute Name** value. You can find the **SAML Attribute Name** values supported in {{ org-full-name }} below.

   {% endlist %}

1. If you created additional attributes, add them to user parameters:

   1. In the left-hand panel, select **Users**, open the user parameters, and go to the **Attributes** tab.

   1. In the **Key** field, enter the **Name** given to the additional attribute.

   1. In the **Value** field, enter the user data to include in the attribute.

      {% note info %}

      By default, the **Value** field is limited to 256 characters. Attributes may contain more characters, for example, a Base64-encoded profile image. To add such a value, change the field data type in the internal Keycloak storage in the `user_attribute` table.

      {% endnote %}

   1. Click **Add** and then click **Save**.

| User data | Comment | SAML Attribute Name |
------------------- | ----------- | -------------------
| Last name | Used for search in {{ yandex-cloud }} services.<br> Value length limit: {{ saml-limit-last-name }}. | `lastName` |
| Name | Used for search in {{ yandex-cloud }} services.<br> Value length limit: {{ saml-limit-first-name }}. | `firstName` |
| Full name | Displayed in {{ yandex-cloud }} services.<br> Value length limit: {{ saml-limit-display-name }}. | `name` |
| Email | Used to send notifications from {{ yandex-cloud }} services.<br>Example:&nbsp;`smith@example.com`.<br> Value length limit: {{ saml-limit-email }}. | `email` |
| Phone | Used to send notifications from {{yandex-cloud}} services.<br>Example: +71234567890.<br> Value length limit: {{ saml-limit-phone }}. | `phone` |
| Profile image | Displayed in {{ yandex-cloud }} services. The image must be provided in Base64 format.<br> Value length limit: {{ saml-limit-thumbnail-photo }}. | `thumbnailPhoto` |
| Group membership | Used for dynamic mapping of group members. | `member` |

{% note warning %}

The `thumbnailPhoto` attribute value exceeding the length limit is ignored. If the value of a different attribute exceeds the limit, the value part that goes beyond the limit is truncated.

{% endnote %}

> Attribute mapping example:
>
> ![image](../../../_assets/organization/keycloak-saml-mapping.png)

## Authentication {#test-auth}

When you finish setting up SSO, test that everything works properly:

1. Open your browser in guest or private browsing mode.

1. Follow the URL to log in to the management console:

   ```
   {{ link-console-main }}/federations/<federation_ID>
   ```

   {% cut "How to get a federation ID" %}

   {% include [get-federation-id](../../../_includes/organization/get-federation-id.md) %}

   {% endcut %}

   The browser will redirect you to the Keycloak authentication page.

1. Enter your credentials and click **Sign in**.

On successful authentication, the IdP server will redirect you to the ACS URL that you specified in the Keycloak settings, and then to the [management console]({{ link-console-main }}) home page. In the top-right corner, you will see being logged in to the console as a federated user.