# Authentication using {{ microsoft-idp.entra-id-full }}

With an [identity federation](../../concepts/add-federation.md), you can use [{{ microsoft-idp.entra-id-full }}]({{ link-azure-ad }}) ({{ microsoft-idp.entra-id-short }}) to authenticate users within an organization.

Authentication setup includes the following steps:

1. [Creating and configuring a SAML application in Azure](#azure-settings).

1. [Creating and setting up a federation in {{ org-full-name }}](#yc-settings).

1. [Setting up single sign-on (SSO)](#sso-settings).

1. [Authentication](#test-auth).

## Getting started {#before-you-begin}

To follow the steps described in this section, you will need an Azure account with an active subscription.

## Creating and configuring a SAML application in Azure {#azure-settings}

### Create a SAML application and download a certificate {#create-app}

In Microsoft Azure, a SAML application acts as an identity provider (IdP). Create a SAML application and download a certificate:

1. Go to the [Azure portal](https://portal.azure.com/).

1. Under **Azure services**, select **{{ microsoft-idp.entra-id-full }}**.

1. In the left-hand panel, select **Enterprise Applications**.

1. Click **New application**.

1. On the **Browse {{ microsoft-idp.entra-full }} gallery** page, click **Create your own application**.

1. In the window that opens:

   1. Name the application.

   1. Select **Integrate any other application you don't find in the gallery (Non-gallery)**.

   1. Click **Create**.

1. On the **Browse** page that opens, use the left-hand panel to select **Single sign-on**.

1. Select the **SAML** single sign-on method.

1. On the **SAML-based sign-on** page, under **3. SAML signature certificate**, download the certificate (Base64). The IdP uses it to sign the user authenticated message.

Do not close the page, as you will need the IdP server data when [creating and setting up a federation](#yc-settings).

### Add users {#add-users}

Add users to the IdP server:

1. Go to the [Enterprise Applications](https://portal.azure.com/#blade/Microsoft_AAD_IAM/StartboardApplicationsMenuBlade/AllApps) page.

1. Select the SAML application created.

1. On the left-hand panel, select **Users and groups**.

1. Click **Add user or group**.

1. In the **Users** field, click **None Selected**.

1. In the window that opens, check users and click **Select**.

1. Click **Assign**.

## Creating and setting up a federation in {{ org-full-name }} {#yc-settings}

### Create a federation {#create-federation}

{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  1. Go to [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. In the left-hand panel, select ![icon-federation](../../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.

  1. Click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.form.federation.action.create }}** in the top-right corner of the page. In the window that opens:

      1. Give your federation a name. It must be unique within the folder.

      1. You can also add a description, if required.

      1. In the **{{ ui-key.yacloud_org.entity.federation.field.cookieMaxAge }}** field, specify the time before the browser asks the user to re-authenticate.

      1. In the **{{ ui-key.yacloud_org.entity.federation.field.issuer }}** field, insert the link from the **{{ microsoft-idp.entra-full }} ID** field on the **SAML-based sign-on** page in {{ microsoft-idp.entra-id-short }}. The link should have the following format:

          ```text
          https://sts.windows.net/<SAML_app_ID>/
          ```

      1. In the **{{ ui-key.yacloud_org.entity.federation.field.ssoUrl }}** field, insert the link from the **Login URL** field on the **SAML-based sign-on** page in {{ microsoft-idp.entra-id-short }}. The link should have the following format:

          ```text
          https://login.microsoftonline.com/<SAML_app_ID>/saml2
          ```

          {% include [ssourl_protocol](../../../_includes/organization/ssourl_protocol.md) %}

      1. Enable **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}** to automatically add users to your organization once they sign in. Otherwise, you will need to [manually add](../../operations/add-account.md#add-user-sso) your federated users.

          {% include [fed-users-note](../../../_includes/organization/fed-users-note.md) %}

      1. {% include [forceauthn-option-enable](../../../_includes/organization/forceauthn-option-enable.md) %}

      1. Click **{{ ui-key.yacloud_org.form.federation.create.action.create }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. View the description of the create federation command:

        ```bash
        yc organization-manager federation saml create --help
        ```

    1. Create a federation:

        ```bash
        yc organization-manager federation saml create --name my-federation \
          --organization-id <organization_ID> \
          --auto-create-account-on-login \
          --cookie-max-age 12h \
          --issuer "https://sts.windows.net/<SAML_app_ID>/" \
          --sso-url "https://login.microsoftonline.com/<SAML_app_ID>/saml2" \
          --sso-binding POST \
          --force-authn
        ```

        Where:

        * `--name`: Federation name. It must be unique within the folder.

        * `--organization-id`: [Organization ID](../../operations/organization-get-id.md).

        * `--auto-create-account-on-login`: Flag enabling the automatic creation of new cloud users after authenticating on the IdP server. 
        This option makes it easier to create users; however, users created this way will not be able to do anything with cloud resources. This does not apply to the resources for which roles are assigned to the `All users` or `All authenticated users` [public group](../../../iam/concepts/access-control/public-group.md).

            If this option is off, users not added to the organization will not be able to log in to the management console, even if they authenticate on your IdP server. In this case, you can manage a list of users allowed to use {{ yandex-cloud }} resources.

        * `--cookie-max-age`: Time before the browser asks the user to re-authenticate.

        * `--issuer`: ID of the IdP server to use for authentication.

            Use the link from the **{{ microsoft-idp.entra-full }} ID** field on the **SAML-based sign-on** page in {{ microsoft-idp.entra-id-short }}. The link should have the following format:
            ```text
            https://sts.windows.net/<SAML_app_ID>/
            ```

        * `--sso-url`: URL of the page the browser has to redirect the user to for authentication.

            Use the link from the **Login URL** field on the **SAML-based sign-on** page in {{ microsoft-idp.entra-id-short }}. The link should have the following format:

            ```text
            https://login.microsoftonline.com/<SAML_app_ID>/saml2
            ```

            {% include [ssourl_protocol](../../../_includes/organization/ssourl_protocol.md) %}

        * `--sso-binding`: Specify the single sign-on binding type. Most identity providers support the `POST` binding type.

        * {% include [forceauthn-cli-enable](../../../_includes/organization/forceauth-cli-enable.md) %}

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Specify the federation parameters in the configuration file.

      Here is an example of the configuration file structure:

      ```hcl
      resource "yandex_organizationmanager_saml_federation" federation {
        name            = "my-federation"
        organization_id = "<organization_ID>"
        auto_create_account_on_login = "true"
        issuer          = "https://sts.windows.net/<SAML_app_ID>/"
        sso_url         = "https://login.microsoftonline.com/<SAML_app_ID>/saml2"
        sso_binding     = "POST"
        security_settings {
          encrypted_assertions = "true"
          force_authn          = "true"
        }
      }
      ```

      Where:

      * `name`: Federation name. It must be unique within the folder.
      * `description`: Federation description.
      * `organization_id`: [Organization ID](../../operations/organization-get-id.md).
      * `labels`: Set of key/value label pairs assigned to the federation.
      * `issuer`: ID of the IdP server to use for authentication.

          Use the link from the **{{ microsoft-idp.entra-full }} ID** field on the **SAML-based sign-on** page in {{ microsoft-idp.entra-id-short }}. The link should have the following format:

          ```text
          https://sts.windows.net/<SAML_app_ID>/
          ```

      * `sso_binding`: Specify the single sign-on binding type. Most identity providers support the `POST` binding type.
      * `sso_url`: URL of the page the browser redirects the user to for authentication.

          Use the link from the **Login URL** field on the **SAML-based sign-on** page in {{ microsoft-idp.entra-id-short }}. The link should have the following format:

          ```text
          https://login.microsoftonline.com/<SAML_app_ID>/saml2
          ```

          {% include [ssourl_protocol](../../../_includes/organization/ssourl_protocol.md) %}

      * `cookie_max_age`: Time in seconds before the browser asks the user to re-authenticate. The default value is `8 hours`.
      * `auto_create_account_on_login`: Flag enabling the automatic creation of new cloud users after authenticating on the IdP server.
      This option makes it easier to create users; however, users created this way will not be able to do anything with cloud resources. This does not apply to the resources for which roles are assigned to the `All users` or `All authenticated users` [public group](../../../iam/concepts/access-control/public-group.md).

          If this option is off, users not added to the organization will not be able to log in to the management console, even if they authenticate on your server. In this case, you can manage a list of users allowed to use {{ yandex-cloud }} resources.

      * `case_insensitive_name_ids`: Toggles username case sensitivity.
          If this option is enabled, the IDs of federated user names will be case-insensitive.

      * `security_settings`: Federation security settings: 

          * {% include [encrypted-assertions-tf](../../../_includes/organization/encrypted-assertions-tf.md) %}

          * {% include [force-authn-tf](../../../_includes/organization/force-authn-tf.md) %}

      {% include [organizationmanager_saml_federation-tf](../../../_includes/organization/organizationmanager_saml_federation-tf.md) %}

  1. Make sure the configuration files are correct.

      1. In the command line, go to the folder where you created the configuration file.
      1. Run a check using this command:

          ```bash
          terraform plan
          ```

      If the configuration is described correctly, the terminal displays the federation parameters. If the configuration contains any errors, {{ TF }} will point them out.

  1. Create a federation.

      1. If the configuration does not contain any errors, run this command:

          ```bash
          terraform apply
          ```

      1. Confirm you want to create a federation.

      This will create a federation in the specified organization. You can check the new federation and its settings in the organization's [{{ ui-key.yacloud_org.pages.federations }}]({{ link-org-federations }}) section.

- API {#api}

    1. Create a file with the request body, e.g., `body.json`:

        ```json
        {
          "name": "my-federation",
          "organizationId": "<organization_ID>",
          "autoCreateAccountOnLogin": true,
          "cookieMaxAge":"43200s",
          "issuer": "https://sts.windows.net/<SAML_app_ID>/",
          "ssoUrl": "https://login.microsoftonline.com/<SAML_app_ID>/saml2",
          "ssoBinding": "POST",
          "securitySettings": {
            "forceAuthn": true
          }
        }
        ```

        Where:

        * `name`: Federation name. It must be unique within the folder.

        * `organizationId`: [Organization ID](../../operations/organization-get-id.md).

        * `autoCreateAccountOnLogin`: Flag enabling the automatic creation of new cloud users after authenticating on the IdP server. 
        This option makes it easier to create users; however, users created this way will not be able to do anything with cloud resources. This does not apply to the resources for which roles are assigned to the `All users` or `All authenticated users` [public group](../../../iam/concepts/access-control/public-group.md).

            If this option is off, users not added to the organization will not be able to log in to the management console, even if they authenticate on your IdP server. In this case, you can manage a list of users allowed to use {{ yandex-cloud }} resources.

        * `cookieMaxAge`: Time before the browser asks the user to re-authenticate.

        * `issuer`: ID of the IdP server to use for authentication.

            Use the link from the **{{ microsoft-idp.entra-full }} ID** field on the **SAML-based sign-on** page in {{ microsoft-idp.entra-id-short }}. The link should have the following format:

            ```text
            https://sts.windows.net/<SAML_app_ID>/
            ```

        * `ssoUrl`: URL of the page the browser has to redirect the user to for authentication.

            Use the link from the **Login URL** field on the **SAML-based sign-on** page in {{ microsoft-idp.entra-id-short }}. The link should have the following format:

            ```text
            https://login.microsoftonline.com/<SAML_app_ID>/saml2
            ```

            {% include [ssourl_protocol](../../../_includes/organization/ssourl_protocol.md) %}

        * `ssoBinding`: Specify the single sign-on binding type. Most identity providers support the `POST` binding type.

        * {% include [forceauthn-api-enable](../../../_includes/organization/forceauth-api-enable.md) %}

    1. {% include [include](../../../_includes/iam/create-federation-curl.md) %}

{% endlist %}

### Add certificates {#add-certificate}

While authenticating, the {{ org-name }} service should be able to verify the IdP server certificate. To enable this, add the [downloaded](#azure-settings) certificate to the federation:

{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  {% include [add-cert-to-fed](../../../_includes/organization/add-cert-to-fed.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View a description of the add certificate command:

      ```bash
      yc organization-manager federation saml certificate create --help
      ```

  1. Add a federation certificate by specifying the certificate file path:

      ```bash
      yc organization-manager federation saml certificate create \
        --federation-id <federation_ID> \
        --name "my-certificate" \
        --certificate-file certificate.cer
      ```

- API {#api}

  Use the [create](../../saml/api-ref/Certificate/create.md) method for the [Certificate](../../saml/api-ref/Certificate/index.md) resource:

  1. Create a request body. In the `data` property, specify the contents of the certificate:

      ```json
      {
        "federationId": "<federation_ID>",
        "name": "my-certificate",
        "data": "-----BEGIN CERTIFICATE..."
      }
      ```

  1. Send the request to add the certificate:

      ```bash
      export IAM_TOKEN=CggaAT********
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '@body.json' \
        "https://organization-manager.{{ api-host }}/organization-manager/v1/saml/certificates"
      ```

{% endlist %}

{% include [federation-certificates-note](../../../_includes/organization/federation-certificates-note.md) %}

## Setting up single sign-on (SSO) {#sso-settings}

### Specify the redirect URL {#add-link}

Once you have created a federation, complete the creation of the SAML application in Azure:

1. Open the **SAML-based sign-on** SAML application settings page.

1. Under **1. Basic SAML configuration**, specify information on {{ yandex-cloud }} acting as the service provider. To do this, in the **ID (entity)** and **Response URL (assertion consumer service URL)** fields, enter the ACS URL to redirect users to after successful authentication.


   {% cut "How to get the federation ACS URL" %}

   {% include [get-acs-url](../../../_includes/organization/get-acs-url.md) %}

   {% endcut %}


1. Click **Save**.

### Configure user attribute mapping {#claims-mapping}

{% note warning %}

It is mandatory to configure user attribute mapping.

{% endnote %}

Following user authentication, the IdP server will send a SAML message to {{ yandex-cloud }} containing:

* Information about successful authentication.

* User attributes, such as the name ID, name, and email address.

To configure mapping between SAML message attributes and personal data, on the **SAML-based sign-on** page under **2. User attributes & claims**, click **Edit**.

Types of personal data supported by {{ org-full-name }} for {{ microsoft-idp.entra-id-short }} are given below.

User data | Comment | Application Attributes
------------------- | ----------- | -------------------
Unique user ID (name ID) | Required attribute.<br> By default, {{ microsoft-idp.entra-id-short }} uses User Principal Name (UPN) in `<login>_<domain>#EXT#@<provider>.onmicrosoft.com` format as the attribute source. When manually adding users to a federation, this name ID format is not supported. We recommend changing the attribute source in {{ microsoft-idp.entra-id-short }}: choose email address, `user.mail`, instead of UPN, `user.userprincipalname`. | **Unique user ID** claim
Last name | Displayed in {{ yandex-cloud }} services.<br> Value length limit: {{ saml-limit-last-name }}. | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname`
Name | Displayed in {{ yandex-cloud }} services.<br> Value length limit: {{ saml-limit-first-name }}. | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname`
Full name | Displayed in {{ yandex-cloud }} services.<br>Example: `Ivan Ivanov`.<br> Value length limit: {{ saml-limit-display-name }}. | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name`
Email | Used to send notifications from {{ yandex-cloud }} services.<br>Example: `ivanov@example.com`.<br> Value length limit: {{ saml-limit-email }}. | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress`

{% note warning %}

If the attribute value exceeds the length limit, the value part that goes beyond the limit is truncated.

{% endnote %}

### Add users to your organization {#add-users-to-org}

If you did not enable the **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}** option when [creating the federation](#yc-settings), you will have to add federated users to your organization manually.

To do this, you will need user name IDs. They are returned by the IdP server together with a response confirming successful authentication.

{% include [auto-create-users](../../../_includes/organization/auto-create-users.md) %}

A user can be added by the organization administrator (the `organization-manager.admin` role) or owner (the `organization-manager.organizations.owner` role). To learn how to grant a role to a user, see [Roles](../../security/index.md#admin).

{% include [console-user-access](../../../_includes/organization/console-user-access.md) %}

{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  {% include [add-users-to-fed](../../../_includes/organization/add-users-to-fed.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View a description of the add user command:

      ```bash
      yc organization-manager federation saml add-user-accounts --help
      ```

  1. Add users by listing their name IDs separated by a comma:

      ```bash
      yc organization-manager federation saml add-user-accounts --id <federation_ID> \
        --name-ids=alice@example.com,bob@example.com,charlie@example.com
      ```

      Where:

      * `--id`: Federation ID.

      * `--name-ids`: Name IDs of users.

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
  1. Send the request by specifying the federation ID in the parameters:

      ```bash
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer <IAM_token>" \
        --data '@body.json' \
        https://organization-manager.{{ api-host }}/organization-manager/v1/saml/federations/<federation_ID>:addUserAccounts
      ```

{% endlist %}

## Authentication {#test-auth}

When you finish setting up SSO, test that everything works properly:

1. Open your browser in guest or private browsing mode.

1. Use this URL to log in to the management console:

   ```text
   {{ link-console-main }}/federations/<federation_ID>
   ```

   {% cut "How to get a federation ID" %}

   {% include [get-federation-id](../../../_includes/organization/get-federation-id.md) %}

   {% endcut %}

   The browser forwards you to the Microsoft authentication page.

1. Enter your credentials and click **Next**.

On successful authentication, the IdP server will redirect you to the ACS URL you specified in the {{ microsoft-idp.entra-id-short }} settings and then to the [management console]({{ link-console-main }}) home page. In the top-right corner, you will see being logged in to the console as a federated user.

#### What's next {#what-is-next}

* [Assign roles to the new users](../../security/index.md#add-role).
