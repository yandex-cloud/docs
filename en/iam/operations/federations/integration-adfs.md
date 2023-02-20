# Authentication using Active Directory

If you have an [identity federation](../../concepts/users/identity-federations.md), you can use [Active Directory Federation Services](https://docs.microsoft.com/en-us/windows-server/identity/active-directory-federation-services) (ADFS) to authenticate in the cloud.

To set up authentication:

1. [Create an identity federation in the cloud](#create-federation).
1. [Add certificates to the federation](#add-certificate).
1. [Get a console login link](#get-link).
1. [Configure authentication on the AD FS server](#configure-sso).
1. [Add users to the cloud](#add-users).
1. [Test the authentication process](#test-auth).

## Before you start {#before-you-begin}

To use the instructions in this section, you need:​

1. The [admin](../../concepts/access-control/roles.md#admin) or [resource-manager.clouds.owner](../../concepts/access-control/roles.md#owner) role in the cloud.

1. A working ADFS farm. If you didn't configure ADFS on your server, [install and configure it now](https://docs.microsoft.com/en-us/windows-server/identity/ad-fs/deployment/deploying-a-federation-server-farm). To deploy ADFS, you also need to install and configure Active Directory Domain Services (AD DS).

    {% if product == "cloud-il" %}If you don't have a Windows machine to deploy an ADFS server, you can [create a VM](../../../compute/quickstart/quick-create-windows.md) in {{ yandex-cloud }}.{% endif %}

    {% note tip %}

    We recommend that you include more than one server in the farm to ensure more reliable authentication.

    {% endnote %}

1. A valid certificate that is used for signing in the ADFS service. If you don't have a valid SSL certificate, get one.

    The subject name in the certificate must contain the FQDN of the Identity Provider (IdP) server, for example, `fs.contoso.com`, to prevent the browser from blocking the authentication page.

## Create a federation in the cloud {#create-federation}

{% list tabs %}

- Management console

  To create a federation in {{ iam-short-name }}:

  1. Open the folder page in the [management console]({{ link-console-main }}).

  1. Select the **Federations** tab in the left menu.

  1. Click **Create federation**.

  1. Enter a name for the federation. The name must be unique within the folder.

  1. Add a description if necessary.

  1. In the **Cookie lifetime** field, specify the time before the browser asks the user to re-authenticate.

  1. Enter the link in `https://<ADFS>/adfs/services/trust` format in the **IdP Issuer** field, where `<ADFS>` is the FQDN of your ADFS server.

  1. In the **SSO method** field, choose **POST**.

  1. In the **Link to the IdP login page** field, enter the link in `https://[ADFS]/adfs/ls/` format, where `<ADFS>` is the FQDN of your ADFS server.

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
          --issuer "http://example.com/adfs/services/trust" \
          --sso-binding POST \
          --sso-url "https://example.com/adfs/ls/"
        ```

        Where:

        * `name`: Federation name. The name must be unique within the folder.

        * `auto-create-account-on-login`: Flag for automatically creating new users in the cloud after authenticating on the IdP server. This option simplifies the user setup, but users created this way are only assigned the `resource-manager.clouds.member` role by default: they can't do anything with cloud resources. Exceptions are the resources that the `allUsers` or `allAuthenticatedUsers` system group roles are assigned to.

            If this option is disabled, users who aren't added to the cloud can't log in to the management console, even if they authenticate with your server. In this case, you can manage the white list of users who are allowed to use {{ yandex-cloud }}.

        * `cookie-max-age`: Time before the browser asks the user to re-authenticate.

        * `issuer`: IdP server ID to be used for authentication.

            Enter the link in `http://<ADFS>/adfs/services/trust` format, where `<ADFS>` is the FQDN of your ADFS server.

        * `sso-url`: URL of the page that the browser redirects the user to for authentication.

            Enter the link in `https://[ADFS]/adfs/ls/` format, where `<ADFS>` is the FQDN of your ADFS server.

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
        "issuer": "http://example.com/adfs/services/trust",
        "ssoUrl": "https://example.com/adfs/ls/",
        "ssoBinding": "POST"
      }
      ```

      Where:

      * `folderId`: ID of the folder.

      * `name`: Federation name. The name must be unique within the folder.

      * `autocreateUsers`: Flag for automatically creating new users in the cloud after authenticating on the IdP server. This option simplifies the user setup, but users created this way are only assigned the `resource-manager.clouds.member` role by default: they can't do anything with cloud resources. Exceptions are the resources that the `allUsers` or `allAuthenticatedUsers` system group roles are assigned to.

          If this option is disabled, users who aren't added to the cloud can't log in to the management console, even if they authenticate with your server. In this case, you can manage the white list of users who are allowed to use {{ yandex-cloud }}.

      * `cookieMaxAge`: Time before the browser asks the user to re-authenticate.

      * `issuer`: IdP server ID to be used for authentication.

          Enter the link in `http://<ADFS>/adfs/services/trust` format, where `<ADFS>` is the FQDN of your ADFS server.

      * `ssoUrl`: URL of the page that the browser redirects the user to for authentication.

          Enter the link in `https://[ADFS]/adfs/ls/` format, where `<ADFS>` is the FQDN of your ADFS server.

      * `ssoBinding`: Specify the Single Sign-on binding type. Most Identity Providers support the `POST` binding type.

  1. {% include [include](../../../_includes/iam/create-federation-curl.md) %}

{% endlist %}

## Specify certificates for the identity federation {#add-certificate}

{% include [federation-sertificates-note](../../../_includes/iam/federation-sertificates-note.md) %}

To get an ADFS certificate:

1. Log in to your ADFS server and open **Server Manager**.
1. Open the ADFS management console: **Tools** → **ADFS Management**.
1. In the window that opens, click **Services** → **Certificates** in the tree on the left.
1. Right-click the certificate in the **Token-signing** section and select **View certificate**.
1. In the window that opens, go to the **Details** tab.
1. Click the **Copy to file** button.
1. Click **Next**.
1. Select the format **Base-64 encoded X. 509 (.CER)** and click **Next**.
1. Specify where to save the certificate and under what name, then click **Next**.
1. Check the certificate export settings and click **Finish**.

{% include [federation-sertificates-add](../../../_includes/iam/federation-sertificates-add.md) %}

## Get a console login link {#get-link}

{% include [federation-login-link](../../../_includes/iam/federation-login-link.md) %}

## Configure authentication on the ADFS server {#configure-sso}

After you obtained your management console login link, you can configure the ADFS server to notify the management console of each successful authentication session and forward the user to the specified address to log in to the management console.

The instructions in this section are written for Windows Server 2016 (different steps might be needed for other versions).

To set up authentication on the ADFS server:

1. [Create a relying party trust](#configure-relying-party-trust)
1. [Configure Claims Mapping](#configure-claims-mapping)

### Create a relying party trust {#configure-relying-party-trust}

ADFS requires a _relying party trust_ for each Service Provider (SP) that uses ADFS for authentication.

Create a relying party trust for the federation you created in the cloud:

1. Log in to your ADFS server and open **Server Manager**.

1. Open the ADFS management console: **Tools** → **ADFS Management**.

1. In the list of actions, select **Add Relying Party Trust**.

1. The wizard window opens. On the first page, select **Claims aware** and click **Start**.

1. Select **Enter data about the relying party manually** and click **Next**.

1. Enter a name, like <q>{{ yandex-cloud }}</q>, and click **Next**.

1. In the next step, you are asked to specify a certificate for signing tokens. This step is optional, so click **Next**.

1. In the Configure URL step, select **Enable support for the SAML 2.0 WebSSO protocol** and specify the [console login link](#get-link) you obtained earlier. Then click **Next**.

    ![image](../../../_assets/iam/federations/specify-console-sso-link.png)

1. On the next page, enter the same [console login link](#get-link) as an identifier and click **Add**. Then click **Next**.

1. On the next page, you can choose who can authenticate using this federation. By default, the **Permit for everyone** policy is selected enabling access for all users.

    You can choose a different policy. For example, to grant access to a specific group of users, select **Permit specific group** and click on the word `<parameter>` to select the groups to allow access to. [Read more about access control policies](https://docs.microsoft.com/en-us/windows-server/identity/ad-fs/operations/access-control-policies-in-ad-fs).

    ![image](../../../_assets/iam/federations/specify-access-policy-ad.png)

1. Click **Next**.

1. On the **Ready to Add Trust** page, check the data entered and click **Close**.

### Configure Claims Mapping {#configure-claims-mapping}

When ADFS authenticates a user, it sends an SAML message to {{ yandex-cloud }} to confirm successful authentication. The `NameID` element in this message identifies the user authenticated. For this, you need to configure the user data to match the elements of the SAML message.

{% note warning %}

The `NameID` must be unique for every federation user. We recommend specifying the User Principal Name (UPN) or email address as the ID.

{% endnote %}

To configure mapping of user data to SAML message elements:

1. In the ADFS management console under **Relying Party Trusts**, right-click on the relying party trust created earlier and select **Edit Claim Issuance Policy**.
1. In the window that opens, click **Add Rule**.
1. Select **Send LDAP Attributes as Claims** and click **Next**.
1. On the next page, configure what to pass in the message fields:
    1. In the **Claim rule name** field, enter a name for the rule, like `Claims mapping`

    1. In the **Attribute Store** field, click `Active Directory`.

    1. Specify what the server will return as Name ID to uniquely identify the user. To do this, add a line to the **Mapping of LDAP attributes** list:

        Under **LDAP Attribute**, select `User-Principal-Name` or `E-Mail Addresses`.

        In **Outgoing Claim Type**, select `Name ID`.

    1. For users to be able to contact {{ yandex-cloud }} technical support from the [management console]({{ link-console-support }}), configure the server to pass an email address (`E-Mail Address` and the name of the user (`Name`):

        ![image](../../../_assets/iam/federations/specify-claims-mapping-ad.png)

        You can also pass the user's first and last name separately. For this, use the `Given Name` and `Surname` types instead of `Name`.
1. Click **Finish**, then click **OK**to close the **Edit Claim Issuance Policy** window.

## Add users to the cloud {#add-users}

{% include [add-federated-users](../../../_includes/iam/add-federated-users.md) %}

## Test the authentication process {#test-auth}

When you finish configuring authentication with Active Directory, test that it runs properly:

1. Open the browser in guest or incognito mode to simulate being a new user.

1. Follow the [management console login link](#get-link) you obtained earlier. The browser forwards you to the ADFS authentication page, which by default looks as follows:

    ![image](../../../_assets/iam/federations/test-auth-with-ad-account.png)

1. Enter your authentication data. By default, you must enter the UPN and password. Then click **Sign in**.

1. On successful authentication, ADFS redirects you back to the management console login link and then to the management console home page. In the upper-right corner, you can see that you are logged in to the console under an Active Directory account.

#### What's next {#what-is-next}

* [Assign roles to the added users](../roles/grant.md#access-to-federated-user).

