# Authentication using {{ microsoft-idp.ad-short }}

With an [identity federation](../../concepts/add-federation.md), you can set up Single Sign-On (SSO) and use {{ microsoft-idp.ad-full }} in conjunction with [{{ microsoft-idp.adfs-full }}]({{ link-adfs }}) ({{ microsoft-idp.adfs-abbreviated }}) for cloud authentication.

To configure SSO:

1. [Create a federation in your organization](#create-federation).

1. [Specify certificates for the federation](#add-certificate).

1. [Add users to your organization](#add-users).

1. [Test authentication](#test-auth).

## Getting started {#before-you-begin}

To follow the steps in this section, you will need:​

1. An operational {{ microsoft-idp.adfs-abbreviated }} farm.

    If you do not have the an {{ microsoft-idp.adfs-abbreviated }} farm configured yet, follow these steps to set one up:

    1. [Deploy and configure {{ microsoft-idp.ad-short }} Domain Services (AD DS)](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/deploy/install-active-directory-domain-services--level-100-) if you have not already done so. You must have AD AS to deploy {{ microsoft-idp.adfs-abbreviated }}.
    1. [Deploy and configure an {{ microsoft-idp.adfs-abbreviated }}](https://docs.microsoft.com/en-us/windows-server/identity/ad-fs/deployment/deploying-a-federation-server-farm) farm of one or more servers.


        {% note tip %}

        Add multiple servers to your {{ microsoft-idp.adfs-abbreviated }} farm for fault tolerance.

        In which case SSO will be available even if some of the servers go down.

        {% endnote %}

1. A valid SSL certificate for use in {{ microsoft-idp.adfs-abbreviated }}. If you do not have a valid certificate, get one.

    To prevent browsers from blocking the authentication page when using SSO, the certificate must satisfy the following requirements:

    * The certificate must be trusted by devices and users within the {{ microsoft-idp.ad-short }} forest.
    * The certificate's `Subject Name` property and `Alternative Name` extension must contain the {{ microsoft-idp.adfs-abbreviated }} farm's FQDN.

        {% include [get-adfs-farm-fqdn](../../../_includes/organization/get-adfs-farm-fqdn.md) %}

## Create a federation in your organization {#create-federation}

To create a federation:

{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  1. Go to [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. In the left-hand panel, select ![icon-federation](../../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.

  1. Click ![Circles3Plus](../../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.form.federation.action.create }}** in the top-right corner of the page.

  1. Give your federation a name. It must be unique within the folder.

  1. You can also add a description, if required.

  1. In the **{{ ui-key.yacloud_org.entity.federation.field.cookieMaxAge }}** field, specify the time before the browser asks the user to re-authenticate.

  1. In the **{{ ui-key.yacloud_org.entity.federation.field.issuer }}** field, specify a link in `http://<AD_FS_farm_FQDN>/adfs/services/trust` format.

     {% include [get-adfs-farm-fqdn](../../../_includes/organization/get-adfs-farm-fqdn.md) %}

  1. In the **{{ ui-key.yacloud_org.entity.federation.field.ssoBinding }}** field, choose **POST**.

  1. In the **{{ ui-key.yacloud_org.entity.federation.field.ssoUrl }}** field, specify a link in `https://<AD_FS_farm_FQDN>/adfs/ls/` format.

     {% include [ssourl_protocol](../../../_includes/organization/ssourl_protocol.md) %}

  1. Enable **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}** to add authenticated users to your organization automatically. If this option is disabled, the user will not be able to use {{ yandex-cloud }} until they are [added to the organization manually](../../operations/add-account.md#add-user-sso).

      {% include [fed-users-note](../../../_includes/organization/fed-users-note.md) %}

  1. {% include [encrypted-assertions-console](../../../_includes/organization/encrypted-assertions-console.md) %}

      {% include [download-saml-cert-when-creating-fed](../../../_includes/organization/download-saml-cert-when-creating-fed.md) %}

      {% include [setup-cert-for-idp](../../../_includes/organization/setup-cert-for-idp.md) %}

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
          --issuer "http://example.com/adfs/services/trust" \
          --sso-url "https://example.com/adfs/ls/" \
          --sso-binding POST \
          --encrypted-assertions \
          --force-authn
        ```

        Where:

        * `--name`: Federation name. It must be unique within the folder.
        * `--organization-id`: [Organization ID](../../operations/organization-get-id.md).
        * `--auto-create-account-on-login`: Option enabling the automatic creation of new cloud users after authentication using an identity provider (IdP).

            This option makes it easier to create users; however, users created this way will not be able to do anything with cloud resources. This does not apply to the resources for which roles are assigned to the `All users` or `All authenticated users` [public group](../../../iam/concepts/access-control/public-group.md).

            If this option is off, users not added to the organization will not be able to log in to the management console, even if they authenticate via an identity provider. In this case, you can manage a list of users allowed to use {{ yandex-cloud }} resources.

        * `--cookie-max-age`: Time before the browser asks the user to re-authenticate.
        * `--issuer`: ID of the identity provider that will be used for authentication.

            Specify a link in `http://<AD_FS_farm_FQDN>/adfs/services/trust` format.

            {% include [get-adfs-farm-fqdn](../../../_includes/organization/get-adfs-farm-fqdn.md) %}

        * `--sso-url`: URL of the page the browser has to redirect the user to for authentication.

            Specify a link in `https://<AD_FS_farm_FQDN>/adfs/ls/` format.

            {% include [ssourl_protocol](../../../_includes/organization/ssourl_protocol.md) %}

        * `--sso-binding`: Single sign-on binding type. Most identity providers support the `POST` binding type.

        * {% include [encrypted-assertions-cli](../../../_includes/organization/encrypted-assertions-cli.md) %}

            {% include [setup-cert-for-idp](../../../_includes/organization/setup-cert-for-idp.md) %}

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
        issuer          = "http://example.com/adfs/services/trust"
        sso_url         = "https://example.com/adfs/ls/"
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
      * `issuer`: Identity provider (IdP) ID that will be used for authentication.

          Specify a link in `http://<AD_FS_farm_FQDN>/adfs/services/trust` format.

          {% include [get-adfs-farm-fqdn](../../../_includes/organization/get-adfs-farm-fqdn.md) %}

      * `sso_binding`: Single sign-on binding type. Most identity providers support the `POST` binding type.
      * `sso_url`: URL of the page the browser has to redirect the user to for authentication.

          Specify a link in `https://<AD_FS_farm_FQDN>/adfs/ls/` format.

          {% include [ssourl_protocol](../../../_includes/organization/ssourl_protocol.md) %}

      * `cookie_max_age`: Time in seconds before the browser asks the user to re-authenticate. The default value is `8 hours`.
      * `auto_create_account_on_login`: Option enabling the automatic creation of new cloud users after authentication using an identity provider.

          This option makes it easier to create users; however, users created this way will not be able to do anything with cloud resources. This does not apply to the resources for which roles are assigned to the `All users` or `All authenticated users` [public group](../../../iam/concepts/access-control/public-group.md).

          If this option is off, users not added to the organization will not be able to log in to the management console, even if they authenticate via an identity provider. In this case, you can manage a list of users allowed to use {{ yandex-cloud }} resources.

      * `case_insensitive_name_ids`: Toggles username case sensitivity.
          If this option is enabled, the IDs of federated user names will be case-insensitive.
      * `security_settings`: Federation security settings:

          * {% include [encrypted-assertions-tf](../../../_includes/organization/encrypted-assertions-tf.md) %}

              {% include [setup-cert-for-idp](../../../_includes/organization/setup-cert-for-idp.md) %}

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
        "issuer": "http://example.com/adfs/services/trust",
        "ssoUrl": "https://example.com/adfs/ls/",
        "ssoBinding": "POST",
        "securitySettings": {
          "encryptedAssertions": true,
          "forceAuthn": true
        }
      }
      ```

      Where:

      * `name`: Federation name. It must be unique within the folder.
      * `organizationId`: [Organization ID](../../operations/organization-get-id.md).
      * `autoCreateAccountOnLogin`: Option enabling the automatic creation of new cloud users after authentication using an identity provider (IdP).

         This option makes it easier to create users; however, users created this way will not be able to do anything with cloud resources. This does not apply to the resources for which roles are assigned to the `All users` or `All authenticated users` [public group](../../../iam/concepts/access-control/public-group.md).

         If this option is off, users not added to the organization will not be able to log in to the management console, even if they authenticate via an identity provider. In this case, you can manage a list of users allowed to use {{ yandex-cloud }} resources.

      * `cookieMaxAge`: Time before the browser asks the user to re-authenticate.
      * `issuer`: ID of the identity provider that will be used for authentication.

          Specify a link in `http://<AD_FS_farm_FQDN>/adfs/services/trust` format.

          {% include [get-adfs-farm-fqdn](../../../_includes/organization/get-adfs-farm-fqdn.md) %}

      * `ssoUrl`: URL of the page the browser has to redirect the user to for authentication.

          Specify a link in `https://<AD_FS_farm_FQDN>/adfs/ls/` format.

          {% include [ssourl_protocol](../../../_includes/organization/ssourl_protocol.md) %}

      * `ssoBinding`: Single sign-on binding type. Most identity providers support the `POST` binding type.

      * {% include [encrypted-assertions-api](../../../_includes/organization/encrypted-assertions-api.md) %}

        {% include [setup-cert-for-idp](../../../_includes/organization/setup-cert-for-idp.md) %}

      * {% include [forceauthn-api-enable](../../../_includes/organization/forceauth-api-enable.md) %}

  1. {% include [include](../../../_includes/iam/create-federation-curl.md) %}

{% endlist %}

## Specify certificates for the federation {#add-certificate}

When the identity provider informs {{ org-full-name }} that a user has been authenticated, they sign the message with their certificate. To enable {{ org-name }} to verify this certificate, add it to your federation:

1. Get an {{ microsoft-idp.adfs-abbreviated }} farm certificate:

    {% list tabs group=instructions %}

    - MMC snap-in

        1. Connect to any server in the {{ microsoft-idp.adfs-abbreviated }} farm and open **Server Manager**.

        1. Open the {{ microsoft-idp.adfs-abbreviated }} management console: **Tools** → **AD FS Management**.

        1. In the window that opens, click **Services** → **Certificates** in the tree on the left.

        1. Right-click the certificate in the **Token-signing** section and select **View certificate**.

        1. In the window that opens, go to the **Details** tab.

        1. Click the **Copy to file** button.

        1. Click **Next**.

        1. Select the format **Base-64 encoded X.509 (.CER)** and click **Next**.

        1. Specify where to save the certificate and under what name, then click **Next**.

        1. Check the certificate export settings and click **Finish**.

    - PowerShell

        1. Connect to any server in the {{ microsoft-idp.adfs-abbreviated }} farm and open the PowerShell console.

        1. Get a `Token-Signing` certificate in Base64 format. To do this, run these commands, specifying the path you want to save the certificate at:

            {% include [adfs-cert-guide-powershell](../../../_includes/organization/adfs-cert-guide-powershell.md) %}

    {% endlist %}

1. Add the farm certificate to the federation:

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

      1. Send the request to add the certificate:

          ```bash
          export IAM_TOKEN=CggaAT********
          curl -X POST \
            -H "Content-Type: application/json" \
            -H "Authorization: Bearer ${IAM_TOKEN}" \
            -d '@body.json' \
            "https://organization-manager.{{ api-host }}/organization-manager/v1/saml/certificates"
          ```

    {% endlist %}

{% include [federation-certificates-note](../../../_includes/organization/federation-certificates-note.md) %}

Configure the {{ microsoft-idp.adfs-abbreviated }} farm to notify {{ yandex-cloud }} of every successful authentication and then redirect the user to the console. To set up a farm, you will need information about the federation you [created earlier](#create-federation).

{% note info %}

This setup guide is for Windows Server 2016; for other versions the steps may be different.

{% endnote %}

To configure a farm:

1. [Create a relying party trust](#configure-relying-party-trust).

1. [Configure Claims Mapping](#configure-claims-mapping).

### Create a relying party trust {#configure-relying-party-trust}

Create a _relying party trust_ so that {{ yandex-cloud }} can use {{ microsoft-idp.adfs-abbreviated }} for authentication:

1. Connect to any server in the {{ microsoft-idp.adfs-abbreviated }} farm and open **Server Manager**.

1. Open the {{ microsoft-idp.adfs-abbreviated }} management console: **Tools** → **AD FS Management**.

1. In the list of actions, select **Add Relying Party Trust**.

    The wizard window opens.

1. At the Welcome step, select **Claims aware** and click **Start**.

1. At the Select Data Source step, select **Enter data about the relying party manually** and click **Next**.

1. At the Specify Display Name step, enter a name, e.g., `{{ yandex-cloud }}` and click **Next**.

1. Skip the Configure Certificate step by clicking **Next**. You will configure certificates later.

1. At the Configure URL step, select **Enable support for the SAML 2.0 WebSSO** protocol and specify the ACS URL to redirect users to after successful authentication.

   {% cut "How to get a federation ID" %}

   {% include [get-federation-id](../../../_includes/organization/get-federation-id.md) %}

   {% endcut %}

   
   {% cut "How to get the federation ACS URL" %}

   {% include [get-acs-url](../../../_includes/organization/get-acs-url.md) %}

   {% endcut %}


   
   ![image](../../../_assets/iam/federations/specify-console-sso-link.png)


   Then click **Next**.

1. At the Configure Identifiers step, enter the same redirect URL as an identifier and click **Add**. Then click **Next**.

1. At the Choose Access Control Policy step, choose who can authenticate using this federation. By default, the **Permit for everyone** policy is selected enabling access for all users.

    You can choose a different policy. For example, to grant access to a specific group of users, select **Permit specific group** and click `<parameter>` to select the groups to get the access permission. [Read more about access control policies](https://docs.microsoft.com/en-us/windows-server/identity/ad-fs/operations/access-control-policies-in-ad-fs).

    ![image](../../../_assets/iam/federations/specify-access-policy-ad.png)

    After you select a policy, click **Next**.

1. At the Ready to Add Trust step, check the entered data and click **Close**.

1. {% include [adfs-postinstall-setup-additional-encryption-settings](../../../_includes/organization/adfs-postinstall-setup-additional-encryption-settings.md) %}

1. (Optional) If you enabled **{{ ui-key.yacloud_org.entity.federation.field.forceAuthn }}** when [creating the federation](#create-federation) in {{ org-full-name }}, enable forced authentication on the relying party trust side:

    ```powershell
    Set-AdfsRelyingPartyTrust `
        -TargetName "{{ yandex-cloud }}" `
        -AlwaysRequireAuthentication $true
    ```

### Configure Claims Mapping {#configure-claims-mapping}

When {{ microsoft-idp.adfs-abbreviated }} authenticates a user, it sends a SAML message to {{ yandex-cloud }} confirming successful authentication. The message must contain the `Name ID` that uniquely identifies the user and may also contain other user data, such as name, email, etc. For this you need to configure mapping between the user attributes and Outgoing Claim Types.

#### Review the list of data, attributes, and types of outgoing claims {#explore-claims-list}

User data | Comment | Outgoing Claim Type
------------------- | ----------- | -------------------
Unique user ID | Required attribute. We recommend using one of the unique and fixed {{ microsoft-idp.ad-short }} user attributes: **User-Principal-Name**, **Object-Sid**, **Object-Guid**, or an email address. | `Name ID`
List of groups the user belongs to. | This list is used for group mapping when authenticating the user in {{ yandex-cloud }}.<br><br>Use a `Token-Groups` family attribute.<br><br>Depending on the attribute you select, the group list format will vary.<br>For example, if using `Token-Groups - Unqualified Names`, short group names will be provided (e.g., `adfs_group`, `Domain Users`) that do not specify the domain.<br><br>For an example of how to configure group mapping, see [{#T}](./group-mapping/adfs.md). | `Group`
Last name | Displayed in {{ yandex-cloud }} services. We recommend using the **Surname** attribute.<br> Value length limit: {{ saml-limit-last-name }}. | `Surname`
Name | Displayed in {{ yandex-cloud }} services. We recommend using the **Given-Name** attribute.<br> Value length limit: {{ saml-limit-first-name }}. | `Given Name`
Full name | Displayed in {{ yandex-cloud }} services. Example: Ivan Ivanov.<br>We recommend using the **Display-Name** attribute.<br> Value length limit: {{ saml-limit-display-name }}. | `Name`
Email | Used to send notifications from {{ yandex-cloud }} services. Example: `ivanov@example.com`.<br>We recommend using the **E-Mail-Address** attribute.<br> Value length limit: {{ saml-limit-email }}. | `E-Mail Address`
Phone | Used to send notifications from {{ yandex-cloud }} services. Example: +71234567890.<br>We recommend using the `Telephone-Number` attribute.<br> Value length limit: {{ saml-limit-phone }}. | `phone`
Profile image | Displayed in {{ yandex-cloud }} services.<br>We recommend using the `thumbnailPhoto` attribute. [How to add a profile image](#add-avatar).<br> Value length limit: {{ saml-limit-thumbnail-photo }}. | `thumbnailPhoto`

#### Configure attribute and claim mappings {#do-claims-mapping}

{% note info %}

{{ yandex-cloud }} [limits the length of values for some attributes](#explore-claims-list) containing user data.

If a value exceeds the limit, its over-the-limit portion will be discarded.

There is an exception: the `thumbnailPhoto` attribute which stores the [user's avatar](#add-avatar). If the value of this attribute exceeds the limit, it will be discarded entirely, and the avatar will not be uploaded.

{% endnote %}

Configure mapping:

1. In the {{ microsoft-idp.adfs-abbreviated }} management console, under **Relying Party Trusts**, right-click the relying party trust created earlier and select **Edit Claim Issuance Policy**.

1. In the window that opens, click **Add Rule**.

1. Select **Send LDAP Attributes as Claims** and click **Next**.

1. On the next page, set up the data to send in the message:

    1. In the **Claim rule name** field, enter a name for the rule, e.g., `Claims mapping`.

    1. In the **Attribute Store** field, click **Active Directory**.

    1. Configure mapping for the mandatory `Name ID` claim by adding an entry to the **Mapping of LDAP attributes** list:

        1. Select the `Name ID` claim type in the **Outgoing Claim Type** column.
        1. Select the required attribute in the **LDAP Attribute** column.

            You can select either [one of the recommended attributes](#explore-claims-list) or another attribute. The selected attribute must be permanent and unique to ensure unambiguous user identification.

            {% note warning %}

            If user ID changes, the user will have to get a new federation account created and will lose access to previous settings and data in {{ yandex-cloud }}.

            {% endnote %}

    1. Similarly, configure mapping for the `Group` claim if you are using [user group mapping](../../concepts/add-federation.md#group-mapping).

    
    1. Similarly, configure mappings for the `Name` and `E-Mail Address` claims if you want the user to be able to contact {{ yandex-cloud }} support from the [management console]({{ link-console-support }}).


    1. (Optional) Similarly, configure mappings for other claims. The actual list of mappings depends on what [user data](#explore-claims-list) you need to deliver to the {{ yandex-cloud }} side after authentication.

        {% cut "How to save a user's avatar image to the `thumbnailPhoto` attribute" %} {#add-avatar}

        1. Prepare images to use as your avatar.

            Make sure the image meets the following requirements:

            * Maximum image file size: 100 KB.
            * Recommended image file size: up to 10 KB; recommended image size: up to 96×96 pixels.

        1. Start PowerShell.

        1. Connect the Active Directory Module for Windows PowerShell using this command:

            ```powershell
            Import-Module ActiveDirectory
            ```

        1. To add a profile image for a single user, run this command:

            ```powershell
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

                ```powershell
                Import-Csv <path_to_CSV_file> |%{Set-ADUser -Identity $_.AD_username -Replace @{thumbnailPhoto=([byte[]](Get-Content $_.Photo -Encoding byte))}}
                ```

        {% endcut %}

        If you need to configure mappings for `phone` and `thumbnailPhoto`, enter the names of these outgoing claim types manually in the **Outgoing Claim Type** field. You cannot select these types from the drop-down list:

        ![image](../../../_assets/iam/federations/specify-claims-mapping-ad.png)

1. Click **Finish**, then click **OK** to close the **Edit Claim Issuance Policy** window.

## Add users to your organization {#add-users}

If you did not enable the **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}** option when creating the federation, you will have to add federated users to your organization manually.

To do this, you need to know the user's name IDs returned by the identity provider together with the successful authentication response. These are usually the users' primary email addresses. If you do not know what the identity provider returns as the name ID, contact the administrator who had configured authentication for your federation.

{% include [auto-create-users](../../../_includes/organization/auto-create-users.md) %}

A user can be added by the organization administrator (the `organization-manager.admin` role) or owner (the `organization-manager.organizations.owner` role). To learn how to grant a role to a user, see the [Roles](../../security/index.md#admin) section.

{% include [console-user-access](../../../_includes/organization/console-user-access.md) %}

To add federation users to an organization:

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
      yc organization-manager federation saml add-user-accounts --name my-federation \
        --name-ids=alice@example.com,bob@example.com,charlie@example.com
      ```

- API {#api}

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

## Test authentication {#test-auth}

Now that you are done configuring SSO, test authentication:

1. Open the browser in guest or incognito mode for a clean new user simulation.

1. Follow the URL to log in to the management console:

   ```url
   {{ link-console-main }}/federations/<federation_ID>
   ```

   {% cut "How to get a federation ID" %}

   {% include [get-federation-id](../../../_includes/organization/get-federation-id.md) %}

   {% endcut %}

   The browser forwards you to the {{ microsoft-idp.adfs-abbreviated }} authentication page, which by default looks like this:

   ![image](../../../_assets/iam/federations/test-auth-with-ad-account.png)

1. Enter your authentication data. By default, you must enter the UPN and password. Then click **Sign in**.

1. On successful authentication, {{ microsoft-idp.adfs-abbreviated }} will redirect you to the ACS URL you specified in the {{ microsoft-idp.adfs-abbreviated }} relying party trust settings, and from there to the management console home page. In the top-right corner, you can see that you are logged in to the console under an {{ microsoft-idp.ad-short }} account.

## What's next {#what-is-next}

* [Assign roles to the new users](../../../iam/operations/roles/grant.md).
