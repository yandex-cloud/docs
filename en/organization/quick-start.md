# Getting started with {{ org-name }}

To get started, create an organization and add users to it.

## Create an organization {#create}

1. [Log in]({{link-passport}}) to your Yandex account. If you don't have an account, [create]({{ support-passport-create }}) one.

1. Go to [{{org-full-name}}]({{link-org-main}}).

1. Read the {{yandex-cloud}} terms of use and click **Log in**.

1. Enter your company name and description.

1. Click **Create organization**.

After registering, you become the organization owner. You'll be able to manage employee accounts, as well as connect and disable services.

## Add employees {#add-users}

To provide your employees with access to the organization's services, connect them using their Yandex accounts. If your company already uses a different account management system (such as Active Directory or Google Workspace), configure an identity federation so that your employees can use their work accounts to access {{yandex-cloud}} services.

### Connect employees with Yandex accounts {#add-ya-users}

If your employees have Yandex accounts (for example, `{{login-example}}`), they can use them to access the {{yandex-cloud}} services enabled in your organization.

To connect employees with Yandex accounts:

1. In the left panel, select [Users]({{link-org-users}}) ![icon-users](../_assets/organization/icon-users.svg).

1. In the top right-hand corner, click **Add user**.

1. Enter the email addresses of the Yandex users you want to invite to the organization (for example, `{{login-example}}`).


1. Click **Add**.

Users will be connected to the organization.

### Configure an identity federation {#add-federation}

Identity federation is a technology with which you can implement a single sign-on system (SSO) and use corporate accounts for authorization in {{org-full-name}}. In this case, your corporate account management system acts as an identity provider (IdP).

To configure your identity federation, follow these steps:

1. In the left panel, select [Federations]({{link-org-federations}}) ![icon-federation](../_assets/organization/icon-federation.svg).

1. Click **Create federation**.

1. Enter the federation name and description.

1. In the **Cookie lifetime** field, specify the period of time that must elapse before the browser asks the user to re-authenticate.

1. In the **IdP Issuer** field, specify the IdP server ID to be used for authentication. The IdP server must send the same ID in its response to {{org-name}} during user authentication.

   {% note info %}

   ID format depends on the type of IdP server you use (for example, Active Directory or Google Workspace).

   {% endnote %}

1. In the **SSO method** field, choose **POST**.

1. In the **Link to the IdP login page** field, specify the address of the page that the browser redirects the user to for authentication.

1. Add an [identity provider certificate](#add-cert) to the created federation.

1. Enable **Automatically create users** to add authenticated users to your organization automatically.

   If you don't enable this option, you will need to [manually add](add-account.md#add-user-sso) your federated users.

1. Configure the identity provider's server to transmit successful authentication information and user attributes to {{yandex-cloud}}.

   User attributes supported by {{org-full-name}} services are listed in identity federation setup guides for different identity providers:

   * [Active Directory](operations/federations/integration-adfs.md).
   * [Google Workspace](operations/federations/integration-gworkspace.md).
   * [Other SAML-compatible identity providers](operations/federations/integration-common.md).
