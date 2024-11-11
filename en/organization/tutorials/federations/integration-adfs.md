# Authentication using Active Directory

With an [identity federation](../../concepts/add-federation.md), you can use [Active Directory Federation Services]({{ link-adfs }}) (AD FS) for authentication in the cloud.

To set up authentication:

1. [Create a federation in your organization](#create-federation).

1. [Add certificates to a federation](#add-certificate).

1. [Configure authentication on the AD FS server](#configure-sso).

1. [Add users to your organization](#add-users).

1. [Test the authentication process](#test-auth).

## Getting started {#before-you-begin}

To follow the steps in this section, you will need:​

1. Working AD FS farm. If you did not configure AD FS on your server, [install and configure it now](https://docs.microsoft.com/en-us/windows-server/identity/ad-fs/deployment/deploying-a-federation-server-farm). To deploy AD FS, you also need to install and configure Active Directory Domain Services (AD DS).


    {% note tip %}

    We recommend that you include more than one server in the farm to ensure more reliable authentication.

    {% endnote %}

1. Valid certificate used for signing in the AD FS service. If you do not have a valid SSL certificate, get one.

    To prevent the browser from blocking the authentication page, make sure the subject name in the certificate contains the IdP server's FQDN, e.g., `fs.contoso.com`.

## Create a federation in your organization {#create-federation}

To create a federation:

{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  1. Go to [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. In the left-hand panel, select ![icon-federation](../../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.

  1. Click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.form.federation.action.create }}** in the top-right corner of the page. In the window that opens:

      1. Give your federation a name. It must be unique within the folder.

      1. You can also add a description, if required.

      1. In the **{{ ui-key.yacloud_org.entity.federation.field.cookieMaxAge }}** field, specify the time before the browser asks the user to re-authenticate.

      1. In the **{{ ui-key.yacloud_org.entity.federation.field.issuer }}** field, enter the link in `http://<ADFS>/adfs/services/trust` format, where `<ADFS>` is the FQDN of your AD FS server.

      1. In the **{{ ui-key.yacloud_org.entity.federation.field.ssoBinding }}** field, choose **POST**.

      1. In the **{{ ui-key.yacloud_org.entity.federation.field.ssoUrl }}** field, enter the link in `https://<ADFS>/adfs/ls/` format, where `<ADFS>` is the FQDN of your AD FS server.

          {% include [ssourl_protocol](../../../_includes/organization/ssourl_protocol.md) %}

      1. Enable **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}** to add authenticated users to your organization automatically. If you do not enable this option, you will need to [manually add](../../operations/add-account.md#add-user-sso) your federated users.

          {% include [fed-users-note](../../../_includes/organization/fed-users-note.md) %}

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

        ```bash
        yc organization-manager federation saml create --name my-federation \
            --organization-id <organization_ID> \
            --auto-create-account-on-login \
            --cookie-max-age 12h \
            --issuer "http://example.com/adfs/services/trust" \
            --sso-url "https://example.com/adfs/ls/" \
            --sso-binding POST \
            --force-authn
        ```

        Where:

        * `--name`: Federation name. It must be unique within the folder.
        * `--organization-id`: [Organization ID](../../operations/organization-get-id.md).
        * `--auto-create-account-on-login`: Flag enabling the automatic creation of new cloud users after authenticating on the IdP server.
        This option makes it easier to create users; however, users created this way will not be able to do anything with cloud resources. This does not apply to the resources for which roles are assigned to the `All users` or `All authenticated users` [public group](../../../iam/concepts/access-control/public-group.md).

            If this option is disabled, users who are not added to the organization cannot log in to the management console, even if they authenticate with your server. In this case, you can manage a list of users allowed to use {{ yandex-cloud }} resources.

        * `--cookie-max-age`: Time before the browser asks the user to re-authenticate.
        * `--issuer`: ID of the IdP server to use for authentication.

            Enter the link in `http://<ADFS>/adfs/services/trust` format, where `<ADFS>` is the FQDN of your AD FS server.

        * `--sso-url`: URL of the page the browser has to redirect the user to for authentication.

            Enter the link in `https://<ADFS>/adfs/ls/` format, where `<ADFS>` is the FQDN of your AD FS server.

            {% include [ssourl_protocol](../../../_includes/organization/ssourl_protocol.md) %}

        * `--sso-binding`: Specify the single sign-on binding type. Most identity providers support the `POST` binding type.

        * {% include [forceauthn-cli-enable](../../../_includes/organization/forceauth-cli-enable.md) %}

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Specify the federation parameters in the configuration file:

        * `name`: Federation name. It must be unique within the folder.
        * `description`: Federation description.
        * `organization_id`: [Organization ID](../../operations/organization-get-id.md). 
        * `labels`: Set of key/value label pairs assigned to the federation.
        * `issuer`: ID of the IdP server to use for authentication.

            Enter the link in `http://<ADFS>/adfs/services/trust` format, where `<ADFS>` is the FQDN of your AD FS server.

        * `sso_binding`: Specify the single sign-on binding type. Most identity providers support the `POST` binding type.
        * `sso_url`: URL of the page the browser has to redirect the user to for authentication.

            Enter the link in `https://<ADFS>/adfs/ls/` format, where `<ADFS>` is the FQDN of your AD FS server.

            {% include [ssourl_protocol](../../../_includes/organization/ssourl_protocol.md) %}

        * `cookie_max_age`: Time in seconds before the browser asks the user to re-authenticate. The default value is `8 hours`. 
        * `auto_create_account_on_login`: Flag enabling the automatic creation of new cloud users after authenticating on the IdP server.
        This option makes it easier to create users; however, users created this way will not be able to do anything with cloud resources. This does not apply to the resources for which roles are assigned to the `All users` or `All authenticated users` [public group](../../../iam/concepts/access-control/public-group.md).

            If this option is disabled, users who are not added to the organization cannot log in to the management console, even if they authenticate with your server. In this case, you can manage a list of users allowed to use {{ yandex-cloud }} resources.
        * `case_insensitive_name_ids`: Toggles username case sensitivity.
           If this option is enabled, the IDs of federated user names will be case-insensitive.
        * `security_settings`: Federation security settings:
          * `encrypted_assertions`: For signing authentication requests.
            If this option is enabled, all authentication requests from {{ yandex-cloud }} will have a digital signature. You will need to download and install a {{ yandex-cloud }} certificate.

     Here is an example of the configuration file structure:

     ```
     resource "yandex_organizationmanager_saml_federation" federation {
      name            = "my-federation"
      organization_id = "<organization_ID>"
      auto_create_account_on_login = "true"
      issuer          = "http://example.com/adfs/services/trust"
      sso_url         = "https://example.com/adfs/ls/"
      sso_binding     = "POST"
      security_settings {
         encrypted_assertions = "true"
         }
     }
     ```

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

- API {#api}

  1. Create a file with the request body, e.g., `body.json`:

      ```json
      {
        "name": "my-federation",
        "organizationId": "<organization_ID>",
        "autoCreateAccountOnLogin": true,
        "cookieMaxAge":"43200s",
        "issuer": "http://example.com/adfs/services/trust",
        "ssoUrl": "https://example.com/adfs/ls/",
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

          If this option is disabled, users who are not added to the organization cannot log in to the management console, even if they authenticate with your server. In this case, you can manage a list of users allowed to use {{ yandex-cloud }} resources.

      * `cookieMaxAge`: Time before the browser asks the user to re-authenticate.
      * `issuer`: ID of the IdP server to use for authentication.

          Enter the link in `http://<ADFS>/adfs/services/trust` format, where `<ADFS>` is the FQDN of your AD FS server.

      * `ssoUrl`: URL of the page the browser has to redirect the user to for authentication.

          Enter the link in `https://<ADFS>/adfs/ls/` format, where `<ADFS>` is the FQDN of your AD FS server.

          {% include [ssourl_protocol](../../../_includes/organization/ssourl_protocol.md) %}

      * `ssoBinding`: Specify the single sign-on binding type. Most identity providers support the `POST` binding type.

      * {% include [forceauthn-api-enable](../../../_includes/organization/forceauth-api-enable.md) %}

  1. {% include [include](../../../_includes/iam/create-federation-curl.md) %}

{% endlist %}

{% note info %}

To ensure correct ForceAuthn in IdP, change the IdP settings. To do this, open the `PowerShell` console on your AD FS server and run the following command:

```powershell
Get-AdfsRelyingPartyTrust -Name YC | Set-AdfsRelyingPartyTrust -AlwaysRequireAuthentication $true
```

{% endnote %}

## Add certificates to a federation {#add-certificate}

When the identity provider (IdP) informs {{ org-full-name }} that a user has been authenticated, they sign the message with their certificate. To enable {{ org-name }} to verify this certificate, add it to the created federation.

To get an AD FS certificate:

1. Log in to your AD FS server and open **Server Manager**.

1. Open the AD FS management console: **Tools** → **AD FS Management**.

1. In the window that opens, click **Services** → **Certificates** in the tree on the left.

1. Right-click the certificate in the **Token-signing** section and select **View certificate**.

1. In the window that opens, go to the **Details** tab.

1. Click the **Copy to file** button.

1. Click **Next**.

1. Select the format **Base-64 encoded X.509 (.CER)** and click **Next**.

1. Specify where to save the certificate and under what name, then click **Next**.

1. Check the certificate export settings and click **Finish**.

To add a certificate to a federation:

{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  {% include [add-cert-to-fed](../../../_includes/organization/add-cert-to-fed.md) %}

- CLI {#cli}

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

- API {#api}

  To add a certificate, use the [create](../../saml/api-ref/Certificate/create.md) method for the [Certificate](../../saml/api-ref/Certificate/index.md) resource:

  1. Create the request body by specifying the contents of the certificate's `data` property:

      ```json
      {
        "federationId": "<federation_ID>",
        "name": "my-certificate",
        "data": "MII...=="
      }
      ```

  1. Send the add certificate request:

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

{% note tip %}

To make sure authentication is not interrupted when the certificate expires, we recommend adding multiple certificates to your federation, i.e., the current one and those to use afterwards. If one certificate goes invalid, {{ yandex-cloud }} will try another one to verify the signature.

{% endnote %}


## Configure authentication on the AD FS server {#configure-sso}

After you set up the federation in {{ org-full-name }}, you can configure the AD FS server to notify the management console of each successful authentication session and redirect the user back to the management console.

This section offers guidelines written for Windows Server 2016 (different steps might be needed for other versions).

To set up authentication on the AD FS server:

1. [Create a relying party trust](#configure-relying-party-trust).

1. [Configure Claims Mapping](#configure-claims-mapping).

### Create a relying party trust {#configure-relying-party-trust}

AD FS requires a _relying party trust_ for each Service Provider (SP) that uses AD FS for authentication.

Create a relying party trust for the federation you created in the cloud:

1. Log in to your AD FS server and open **Server Manager**.

1. Open the AD FS management console: **Tools** → **AD FS Management**.

1. In the list of actions, select **Add Relying Party Trust**.

1. The wizard window opens. On the first page, select **Claims aware** and click **Start**.

1. Select **Enter data about the relying party manually** and click **Next**.

1. Enter a name, e.g., <q>{{ yandex-cloud }}</q> and click **Next**.

1. In the next step, you are asked to specify a certificate for signing tokens. This step is optional, so click **Next**.

1. In the _Configure URL_ step, select **Enable support for the SAML 2.0 WebSSO** protocol and specify the ACS URL to redirect users to after successful authentication.

   {% cut "How to get a federation ID" %}

   {% include [get-federation-id](../../../_includes/organization/get-federation-id.md) %}

   {% endcut %}


   {% cut "How to get the federation ACS URL" %}

   {% include [get-acs-url](../../../_includes/organization/get-acs-url.md) %}

   {% endcut %}



   ![image](../../../_assets/iam/federations/specify-console-sso-link.png)

   
   Then click **Next**.

1. On the next page, enter the same redirect URL as an identifier and click **Add**. Then click **Next**.

1. On the next page, you can choose who can authenticate using this federation. By default, the **Permit for everyone** policy is selected enabling access for all users.

    You can choose a different policy. For example, to grant access to a specific group of users, select **Permit specific group** and click `<parameter>` to select the groups to get the access permission. [Read more about access control policies](https://docs.microsoft.com/en-us/windows-server/identity/ad-fs/operations/access-control-policies-in-ad-fs).

    ![image](../../../_assets/iam/federations/specify-access-policy-ad.png)

1. Click **Next**.

1. On the **Ready to Add Trust** page, check the data entered and click **Close**.

### Configure Claims Mapping {#configure-claims-mapping}

When AD FS authenticates a user, it sends a SAML message to {{ yandex-cloud }} to confirm successful authentication. The message must contain the name ID that uniquely identifies the user and may also contain some other user data, such as the user's name or email address. Make sure to set up a mapping between the user attributes and Outgoing Claim Types. Types of personal data supported by {{ org-full-name }} are given below.

User data | Comment | Outgoing Claim Type
------------------- | ----------- | -------------------
Unique user ID | Required attribute. We recommend using one of the unique and fixed Active Directory user attributes: **User-Principal-Name**, **Object-Sid**, **Object-Guid**, or an email address. | Name ID 
Last name | Displayed in {{ yandex-cloud }} services. We recommend using the **Surname** attribute.<br> Value length limit: {{ saml-limit-last-name }}. | Surname
Name | Displayed in {{ yandex-cloud }} services. We recommend using the **Given-Name** attribute.<br> Value length limit: {{ saml-limit-first-name }}. | Given Name
Full name | Displayed in {{ yandex-cloud }} services. Example: John Smith.<br>We recommend using the **Display-Name** attribute.<br> Value length limit: {{ saml-limit-display-name }}. | Name
Email | Used to send notifications from {{ yandex-cloud }} services. Example: `smith@example.com`.<br>We recommend using the **E-Mail-Address** attribute.<br> Value length limit: {{ saml-limit-email }}. | E-Mail Address
Phone | Used to send notifications from {{ yandex-cloud }} services. Example: +71234567890.<br>We recommend using the `Telephone-Number` attribute.<br> Value length limit: {{ saml-limit-phone }}. | Type `phone` in the **Outgoing Claim Type** field.
Profile image | Displayed in {{ yandex-cloud }} services.<br>We recommend using the `thumbnailPhoto` attribute. [How to add a profile image](#add-avatar).<br> Value length limit: {{ saml-limit-thumbnail-photo }}. | Type `thumbnailPhoto` in the **Outgoing Claim Type** field.

{% note warning %}

For `Name ID`, use only the Active Directory user attributes that are unique and unlikely to change. If a federation user's `Name ID` changes, this user will have to get a new federation account created and will lose access to previous settings and data in {{ yandex-cloud }}.

The `thumbnailPhoto` attribute value exceeding the length limit is ignored. If the value of a different attribute exceeds the limit, the value part that goes beyond the limit is truncated.

{% endnote %}

To set up a mapping between the user data and Outgoing Claim Types:

1. In the AD FS management console under **Relying Party Trusts**, right-click on the relying party trust created earlier and select **Edit Claim Issuance Policy**.

1. In the window that opens, click **Add Rule**.

1. Select **Send LDAP Attributes as Claims** and click **Next**.

1. On the next page, set up the data to send in the message:

    1. In the **Claim rule name** field, enter a name for the rule, e.g., `Claims mapping`.

    1. In the **Attribute Store** field, click **Active Directory**.

    1. Specify what the server will return as the name ID to uniquely identify the user. To do this, add a line to the **Mapping of LDAP attributes** list:

        In the **LDAP Attribute** column, select an attribute for a unique and fixed user ID: **User-Principal-Name**, **Object-Sid**, **Object-Guid**, or **E-Mail-Addresses**.

        In the **Outgoing Claim Type** column, select **Name ID**.


    1. For a user to be able to contact {{ yandex-cloud }} technical support from the [management console]({{ link-console-support }}), add the user's email address (the **E-Mail Address** claim type) or name (the **Name** claim type).


    1. To provide the user's first and last name separately, add the **Given Name** and **Surname** claim types.
	
	  1. To add the user's phone number or [profile image](#add-avatar), enter the `phone` or `thumbnailPhoto` type, respectively, in the **Outgoing Claim Type** field.

       ![image](../../../_assets/iam/federations/specify-claims-mapping-ad.png)

1. Click **Finish**, then click **OK**to close the **Edit Claim Issuance Policy** window.


#### How to add a profile image to Active Directory {#add-avatar}

To add a user's profile image to Active Directory, write the image to the `thumbnailPhoto` attribute using PowerShell.

{% note info %}

The `thumbnailPhoto` attribute supports files of up to 100 KB. The recommended file size is up to 10 KB and the recommended image size is up to 96×96 pixels.

{% endnote %}

1. Start PowerShell.

1. Connect the Active Directory Module for Windows PowerShell with the command:

   ```
   Import-Module ActiveDirectory
   ```

1. To add a profile image for a single user, run the command:

   ```
   Set-ADUser <username> -Replace @{thumbnailPhoto=([byte[]](Get-Content "<path_to_image>" -Encoding byte))}
   ```

1. To bulk add profile images for multiple users:

   1. Create a CSV file with a list of usernames and image paths.
   
      Sample CSV file:
	  
      ```csv
      AD_username, Photo
      smith, C:\Photo\smith.jpg
      jones, C:\Photo\jones.jpg
      ```
	  
   1. Run this command:
   
      ```
      Import-Csv <path_to_CSV_file> |%{Set-ADUser -Identity $_.AD_username -Replace @{thumbnailPhoto=([byte[]](Get-Content $_.Photo -Encoding byte))}}
      ```
   
## Add users to your organization {#add-users}

If you did not enable the **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}** option when creating the federation, you will have to add federated users to your organization manually.

To do this, you need to know the user name IDs returned by the Identity Provider (IdP) server together with the successful authentication response. This is usually the user's primary email address. If you do not know what the server returns as the name ID, contact the administrator who configured authentication for your federation.

{% include [auto-create-users](../../../_includes/organization/auto-create-users.md) %}

A user can be added by the organization administrator (the `organization-manager.admin` role) or owner (the `organization-manager.organizations.owner` role). To learn how to grant roles to a user, see [Roles](../../security/index.md#admin).

To add federation users to an organization:

{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  {% include [add-users-to-fed](../../../_includes/organization/add-users-to-fed.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View a description of the add user command:

      ```
      yc organization-manager federation saml add-user-accounts --help
      ```

  1. Add users by listing their name IDs separated by a comma:

      ```
      yc organization-manager federation saml add-user-accounts --name my-federation \
        --name-ids=alice@example.com,bob@example.com,charlie@example.com
      ```

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
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer <IAM_token>" \
        --data '@body.json' \
        https://organization-manager.{{ api-host }}/organization-manager/v1/saml/federations/<federation_ID>:addUserAccounts
      ```

{% endlist %}

## Test the authentication process {#test-auth}

Now that you finished configuring authentication with Active Directory, test that it runs properly:

1. Open the browser in guest or incognito mode for a clean new user simulation.

1. Follow the URL to log in to the management console:

   ```
   {{ link-console-main }}/federations/<federation_ID>
   ```

   {% cut "How to get a federation ID" %}

   {% include [get-federation-id](../../../_includes/organization/get-federation-id.md) %}

   {% endcut %}

   The browser forwards you to the AD FS authentication page, which by default looks as follows:

   ![image](../../../_assets/iam/federations/test-auth-with-ad-account.png)

1. Enter your authentication data. By default, you must enter the UPN and password. Then click **Sign in**.

1. On successful authentication, the AD FS will redirect you to the ACS URL you specified in the server settings, and then to the management console home page. In the top-right corner, you can see that you are logged in to the console under an Active Directory account.

#### What's next {#what-is-next}

* [Assign roles to the new users](../../../iam/operations/roles/grant.md).
