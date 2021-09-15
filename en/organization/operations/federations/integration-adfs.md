# Authentication using Active Directory

If you have an [identity federation](../../add-federation.md), you can use [Active Directory Federation Services](https://docs.microsoft.com/en-us/windows-server/identity/active-directory-federation-services) (ADFS) to authenticate in the cloud.

To set up authentication:

1. [Create a federation in your organization](#create-federation).
1. [Add certificates to the federation](#add-certificate).
1. [Get a console login link](#get-link).
1. [Configure authentication on the AD FS server](#configure-sso).
1. [Add users to your organization](#add-users).
1. [Test the authentication process](#test-auth).

## Before you start {#before-you-begin}

To use the instructions in this section, you need:​

1. A working ADFS farm. If you didn't configure ADFS on your server, [install and configure it now](https://docs.microsoft.com/en-us/windows-server/identity/ad-fs/deployment/deploying-a-federation-server-farm). To deploy ADFS, you also need to install and configure Active Directory Domain Services (AD DS).

    If you don't have a Windows machine to deploy an ADFS server, you can [create a VM](../../../compute/quickstart/quick-create-windows.md) in {{ yandex-cloud }}.

    {% note tip %}

    We recommend that you include more than one server in the farm to ensure more reliable authentication.

    {% endnote %}

1. A valid certificate that is used for signing in the ADFS service. If you don't have a valid SSL certificate, get one.

    The subject name in the certificate must contain the FQDN of the Identity Provider (IdP) server, for example, `fs.contoso.com`, to prevent the browser from blocking the authentication page.

## Create a federation in your organization {#create-federation}

{% list tabs %}

- Management console

  To create a federation:
  1. Go to [{{org-full-name}}]({{link-org-main}}).
  1. In the left panel, select the [Federations]({{link-org-federations}}) ![icon-federation](../../../_assets/organization/icon-federation.png) section.
  1. Click **Create federation**.
  1. Enter a name for the federation. The name must be unique within the folder.
  1. Add a description if necessary.
  1. In the **Cookie lifetime** field, specify the period of time during which the browser won't ask the user to re-authenticate.
  1. Enter the link in `http://<ADFS>/adfs/services/trust` format in the **IdP Issuer** field, where `<ADFS>` is the FQDN of your ADFS server.
  1. In the **SSO method** field, choose **POST**.
  1. Use the **Link to the IdP login page** field to specify a link in the following format: `https://<ADFS>/adfs/ls/`, where `<ADFS>` is your ADFS server's FQDN.
  1. Enable **Automatically create users** to add authenticated users to your organization automatically. If you don't enable this option, you will need to [add manually](../../add-account.md#add-user-sso) your federated users.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. See the description of the create federation command:

        ```
        yc organization-manager federation saml create --help
        ```

    1. Create a federation:

        ```
        yc organization-manager federation saml create --name my-federation \
          --auto-create-account-on-login \
          --cookie-max-age 12h \
          --issuer "http://example.com/adfs/services/trust" \
          --sso-binding POST \
          --sso-url "https://example.com/adfs/ls/"
        ```

        Where:

        * `name`: Federation name. The name must be unique within the folder.

        * `auto-create-account-on-login`: Flag for automatically creating new users in the cloud after authenticating on the IdP server. This option simplifies user setup but users created this way are only assigned the ` resource-manager.clouds.member`  role by default and they are not able to do anything with cloud resources. Exceptions are the resources that the `allUsers` or `allAuthenticatedUsers` system group roles are assigned to.

            If this option is disabled, users who aren't added to the cloud can't log in to the management console, even if they authenticate with your server. This enables you to manage a white list of users allowed to use {{ yandex-cloud }} resources.

        * `cookie-max-age`: Time before the browser asks the user to re-authenticate.

        * `issuer`: IdP server ID to be used for authentication.

            Enter the link in `http://<ADFS>/adfs/services/trust` format, where `<ADFS>` is the FQDN of your ADFS server.

        * `sso-url`: URL of the page that the browser redirects the user to for authentication.

            Enter a link in the following format: `https://<ADFS>/adfs/ls/`, where `<ADFS>` is your AD FS server's FQDN.

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

      * `autocreateUsers`: Flag for automatically creating new users in the cloud after authenticating on the IdP server. This option simplifies user setup but users created this way are only assigned the ` resource-manager.clouds.member`  role by default and they are not able to do anything with cloud resources. Exceptions are the resources that the `allUsers` or `allAuthenticatedUsers` system group roles are assigned to.

          If this option is disabled, users who aren't added to the cloud can't log in to the management console, even if they authenticate with your server. This enables you to manage a white list of users allowed to use{{ yandex-cloud }} resources.

      * `cookieMaxAge`: Time before the browser asks the user to re-authenticate.

      * `issuer`: IdP server ID to be used for authentication.

          Enter the link in `http://<ADFS>/adfs/services/trust` format, where `<ADFS>` is the FQDN of your ADFS server.

      * `ssoUrl`: URL of the page that the browser redirects the user to for authentication.

          Enter a link in the following format: `https://<ADFS>/adfs/ls/`, where `<ADFS>` is your AD FS server's FQDN.

      * `ssoBinding`: Specify the Single Sign-on binding type. Most Identity Providers support the `POST` binding type.

  1. {% include [create-federation-curl](../../../_includes/iam/create-federation-curl.md) %}

{% endlist %}

## Specify certificates for the federation {#add-certificate}

When the identity provider (IdP) informs {{org-full-name}} that a user has been authenticated, they sign the message with their certificate. To enable {{org-name}} to verify this certificate, add it to the created federation.

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

To add a certificate to a federation:

{% list tabs %}

- Management console
  1. Go to [{{org-full-name}}]({{link-org-main}}).
  1. In the left panel, select the [Federations]({{link-org-federations}}) ![icon-federation](../../../_assets/organization/icon-federation.png) section.
  1. Click the name of the federation you need to add a certificate to.
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

  To add the certificate, use the [create](../../../organization/api-ref/grpc/certificate_service.md#Create) method for the [Certificate](../../../organization/api-ref/grpc/certificate_service.md) resource:

  1. Create a request body by specifying the contents of the certificate's `data` property:

      ```json
      {
        "federationId": "<federation ID>",
        "name": "my-certificate",
        "data": "MII...=="
      }
      ```

  2. Send the add certificate request:

      ```bash
      $ export IAM_TOKEN=CggaATEVAgA...
      $ curl -X POST \
          -H "Content-Type: application/json" \
          -H "Authorization: Bearer ${IAM_TOKEN}" \
          -d '@body.json' \
          "https://organization-manager.api.cloud.yandex.net/organization-manager/v1/saml/certificates"
      ```

{% endlist %}

## Get a console login link {#get-link}

When you set up federation authentication, users can log in to the management console from a link containing the federation ID. You must specify the same link when configuring the authentication server.

Obtain and save this link:

1. Get the federation ID:
    1. Go to [{{org-full-name}}]({{link-org-main}}).
    1. In the left panel, select the [Federations]({{link-org-federations}}) ![icon-federation](../../../_assets/organization/icon-federation.png) section.
    1. Copy the ID of the federation you're configuring access for.

2. Generate a link using this ID:

    `https://console.cloud.yandex.com/federations/<federation ID>`

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

1. Enter a name, like <q>Yandex.Cloud</q>, and click **Next**.

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

When ADFS authenticates a user, it sends an SAML message to {{ yandex-cloud }}  to confirm successful authentication. This message's `NameID`  element should identify the user that has been authenticated. For this, you need to configure the user data to match the elements of the SAML message. Types of personal data supported by {{ org-full-name }} are given below.

| User data | Comments | Outgoing Claim Type |
| ------------------- | ----------- | ------------------- |
| Unique user ID | Required attribute. We recommend using the User Principal Name (UPN) or email address. | Name Identifier |
| Last name | Displayed in {{yandex-cloud}} services. | Surname |
| Name | Displayed in {{yandex-cloud}} services. | Given Name |
| Full name | Displayed in {{yandex-cloud}} services.<br>Example: Ivan Ivanov | Name |
| Mail | Used to send notifications from {{yandex-cloud}} services.<br>Example:&nbsp;`ivanov@example.com` | E-Mail Address |
| Phone | Used to send notifications from {{yandex-cloud}} services.<br>Example: +71234567890 | Add a new attribute identified as<br>`http://schemas.xmlsoap.org/ws/2005/05/identity/claims/mobilephone`.<br> See [AD FS Documentation]({{ link-adfs-add-claim }}) |
| Profile image | Displayed in {{yandex-cloud}} services.<br>Images are transmitted in Base64 encoding. [Example](#avatar-example) | Add a new attribute with `thumbnailPhoto` as ID.<br>See [AD FS Documentation]({{ link-adfs-add-claim }}) |

{% note warning %}

The `NameID` must be unique for every federation user. We recommend specifying the User Principal Name (UPN) or email address as the ID.

{% endnote %}

To configure mapping of user data to SAML message elements:

1. In the ADFS management console under **Relying Party Trusts**, right-click on the relying party trust created earlier and select **Edit Claim Issuance Policy**.

1. In the window that opens, click **Add Rule**.

1. Select **Send LDAP Attributes as Claims** and click **Next**.

1. On the next page, configure what to pass in the message fields:

    1. Use the **Claim rule name** field to enter a name for the rule, such as `Claims mapping`

    1. In the **Attribute Store** field, click `Active Directory`.

    1. Specify what the server will return as Name ID to uniquely identify the user. To do this, add a line to the **Mapping of LDAP attributes** list:

        Under **LDAP Attribute**, select `User-Principal-Name` or `E-Mail Addresses`.

        In **Outgoing Claim Type**, select `Name ID`.

    1. For a user to be able to contact {{ yandex-cloud }} technical support from the [management console](https://console.cloud.yandex.com/support), configure the server to pass the email address (`E-Mail Address` and the user name (`Name`):

        ![image](../../../_assets/iam/federations/specify-claims-mapping-ad.png)

        You can also pass the user's first and last name separately. For this, use the `Given Name` and `Surname` types instead of `Name`.

1. Click **Finish**, then click **OK** to close the **Edit Claim Issuance Policy** window.

#### Sample Base64-encoded image {#avatar-example}

The profile image is transmitted in text format using [Base64 encoding]({{link-base64}}).

{% cut "Encoded image example" %}

```
iVBORw0KGgoAAAANSUhEUgAAACoAAAAqCAYAAADFw8lbAAAABmJLR0QA/wD/AP+gvaeTAAAACXBI
WXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH5QMRDiIqU8/IRwAACMFJREFUWMO1mWuMXVUVx39rn3un
dF609DEpFj6ofQw0GEbtDNGCIBRKKk6w2kSJsU2EgNKKUQK1JhpJMfgByyOoRPQDmFTSZpAmCBgr
ktgpSGugZQpEElpLYVqmzExnGJi79/LD3vuefc6dQdB6kjP7nDPn8d//tdZ/rbWv8H/aNm5Ttq6V
+vn1D2qzc5wPdDnlPBQH7AK23/8NmfxP75NTBWzzNuW2BNhND2ubs8yzjpVO+ZYqy1ShvkP4w9Ds
Vs65Y428+cQ/lZUfk1MP9Cd/Un54af6KH+zUTmu5zlqucY7ZNYs4hzgFdeDKQAPYmTPQNZ9l1YVn
yeOPvaKsWiSnFuiWXbraWb5uHV3OssA6mq0Fa8E6Pzrnj1X9MRoAJ+9xDi5YCgvncv8Vi+TanS8r
qxfLhwN61x5lQ7dw525tU+UKVT6vjs84ZZlzJVDhuBYB2hys0wRkGCMABea2w4pzwSlPO7jyqiVy
MsVhPgBx527t10cFRgR+L3AdwjIRqO/4kfJ5OpKbPTJLOEdhsla/tALl8CMHdSlA34C+P6Nb+1WA
e0S4AXIWNGWnzF7ConVQq+XHLtkj4PrXFRbOg08tzv1XPb6rejvl0b4BbWR0a3/de/4K3KBa8hPJ
3x8ZTZmrTyrxSy2BrIMNo1XomJX7bvLNP/QN6KbeTpma0a39eiuwBYog6h/S/EPWQs2BrSVjLbCo
MDHhn69fC8BJXMIprOqG06rTul9HJT27e4+icDawJWVyOqnQ4JdGgMy7wYlhGDwOx9+CY0PYsTGk
WsWs6Pb3qvOsiebvMAaaZ/iJTBPlZxeA3tgt3L1Hb9WSKcvMRrE2wMg4vDEIr74Gr7+Rfyz4YZZl
TDjHaSMnobUluEEaxQIzmxqSQBnpYGUKwlaXMWoJqFEYnYAn/wLj7wSdtJBl/p6om8GHJVonBl1k
Mvp8tZIHaOrnyXakMgVrCxugaz5kBva+CPsH8pmLhA+XJCtYpqqKZgap1YI0lSZ+2oxcV6fYXv/S
OWILQO99RrumwiiSg33uBXjhRe9X0UICiPF+JwlT4Rkj8J5CU83mukkymdmtDQymzvoUQB3ofc8q
CpdQSm9p4AyPwIGDOciUmQiSBHTdlzPU2aL0xHuthdntxW9q6sPK44XMdP2nBYEeCVGcmjEC/uOf
p5cAMf45Y/LMZML/m2fSZG2SAGwx5c5q86aPO8mxg70NKdQISyI4I4lZBUZHvfwYk+9puhTC9QA2
M4wj/FotXQvP5Fc1W8xacWyqQFO1CDTZ1SmDBdMHoGdAoxkQOPKmB6Elk6fBEZjdIMqO/fdwRII5
Pn6bXo3B65Lk7xG82WNyKLo2IDhRxupAH9irrO8SRJilQX40kZAsg6ODwfeSmTj17AXN3Occl+y7
U94GkLv8PZf+SFutY5643FXie1WgvSXUC1oMTvWIawbG60DXdwm/2aftqjQrxYiMwn58qJTPQzgn
0brSGN5O2e25WZm0zBc3RTUVxvZWn3qjUtRrFf/el776CT/F1PQXiBQKmjrYyUmYeM/7U5o44j0O
7t/9UzlejrP+O4QVm3UxWiz9IhFOoaW5WPFLMTk9Gd9VB5oJlzf4ZkAyPOazR5blDKYpT2D7dGpt
LV8x0dxaBDpZg7YWXz1FrS5lxScagIpwaZnNeHwyABUpAk1y+ss9Nyv9d+SfWf59xRhmqbLOhSJE
SxYDaE4YLbGJCP2FCv93z2smQZpMuBhNlRk4+Y4HWsmgEpitZPl5tcqxCLLru/5Tz/xMcI4+TVuP
tLlTz6YxXgxc2qZ4dxpfd76MPLBXc0ZFmGkgK6c2gjaOnPSAY9Xj0mk7Bh/fnPc31tJ8/k36yczQ
p8oZLgSSMclzwcQd83wgqeaRHktAxQfm+i4pAG0RxSCNpq8YGB2DrJLLlknTYMZ2LtJsSSeXVzK+
5xwX1+Wl1GmWVeOsBaEs1MbKTmAofb4ShL4jvU+LSYCxCc9oqU3ACLx6iHWLlnAtShZrUREQ11gT
pM86hblzihNQLfjwwYYu1ECXiZV6GOM+PhGEPfO+GfdKxV97Z4KqKlmchCNvj6cr3VThvKUwY0Yh
IIttDuy+71ktMopwRaSx3O0NDftAqqdPTWpQBWuxxmBUAxnOtyWpKpQbv9Pboeu8IpvSKI27blgu
RaACn5uucT4x6tlLM1UMspqv1psASwhGTRlyoFkiPQqzTofeK30TKMlEyuR/e7nsK/jojhc1Azqm
E+zRcc8opVY2y+Ddd+ssWZHc/JosLMTROs/iuUugNlkC1+gi/ypfqJRbD02kxwhMTIagiIVI1FmT
20sVW2dG6y6BAgvmQudiWDA/tBxJkBWaxWLE72wECvOmLIR9WmWyVgSath6tLaFPhxnOYSsVsjln
wEc6oGM+dMzxASMmr7LS7JZGe1o6Kmy5e49yY3fRRw9Nt2rmwppQqouieeFcrcBlF8LQMKa9DebM
gkrVS5nJPPXWQZaUd4X2RhvbclU2beyRw2VGTW+nDAKbGnog8f6paZshSYUf7qlWYUGHL9cgrIKU
wBR8Uadyyfr29MYeuT1ZVsqB9g0ovZ1yO3A1aVshcHzYsyMSimZJWpDYjqS9kikxVCxcClWZNi5s
3AtcBLCxZ5qF3ACWRw7qMoG/idBmBPoPwtGhxiW/tDcS8QpgTEgCUkwMmcmP4/1p82gMO4FbNnTL
gfdb+zQAvZ0eyheXyn6EswT2xMK23onGrGXya1pSiriuFKnTsq560+9X+KXCWoXWDd3yBeDAh/6x
IS5LP/aKPnj4GF/b81IxZ0e3SEFnwQ3KDGaG8SzjqDH83WQ8tOliefS/XYZvWNIJIFm1SK556pD2
HXiNh8ffLU6p0Nfk2qkoqsoJVR5S5Rc/XiUD6Q8T/8s27Yrzk68ql31UuGWHnvnWCM8Dc0j7+Hzf
b4R7s4wnjOHYnV+W0fiO72xTfr721PxC9IHe8s3fagasAS4BjDE8DzxnDP+47xoZn+5HsFO5/Rtd
UYGmIgo9HwAAAABJRU5ErkJggg==
```

{% endcut %}

## Add users to your organization {#add-users}

If you did not enable the **Automatically create users** option when creating a federation, federated users must be manually added to your organization.

To do this, you need to know the Name IDs of the users that the Identity Provider Server (IdP) returns along with the successful authentication confirmation. This is usually the user's primary email address. If you don't know what the server returns as the Name ID, contact the administrator who configured authentication for your federation.

To add federation users to an organization:

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
      $ curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer <IAM token>" \
        -d '@body.json' \
        https://organization-manager.api.cloud.yandex.net/organization-manager/v1/saml/federations/<federation ID>:addUserAccounts
      ```

{% endlist %}

## Test the authentication process {#test-auth}

When you finish configuring authentication with Active Directory, test that it runs properly:

1. Open the browser in guest or incognito mode to simulate being a new user.

1. Follow the [management console login link](#get-link) you obtained earlier. The browser forwards you to the ADFS authentication page, which by default looks as follows:

    ![image](../../../_assets/iam/federations/test-auth-with-ad-account.png)

1. Enter your authentication data. By default, you must enter the UPN and password. Then click **Sign in**.

1. On successful authentication, ADFS redirects you back to the management console login link and then to the management console home page. In the upper-right corner, you can see that you are logged in to the console under an Active Directory account.

#### What's next {#what-is-next}

* [Assign roles to the new users](../../../iam/operations/roles/grant.md#access-to-federated-user).

