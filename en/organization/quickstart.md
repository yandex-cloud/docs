# Getting started with {{ org-name }}

To get started, create an organization and add users to it.

_Organization_ is a workspace that combines different types of {{ yandex-cloud }} resources and users. [Learn more about organizations, resources, and users](../overview/roles-and-resources.md).

## Create an organization {#create}

1. [Log in]({{link-passport}}) to your Yandex account. If you do not have an account, [create]({{ support-passport-create }}) one.

1. Go to [{{org-full-name}}]({{link-org-main}}).

1. Read the {{yandex-cloud}} terms of use and click **{{ ui-key.yacloud_org.form.organization.select.action.enter }}**.

1. Enter your company name and description.

1. Click **{{ ui-key.yacloud_org.pages.create }}**.

After registering, you become the organization owner. You will be able to manage employee accounts, as well as connect and disable services.

## Add employees {#add-users}

To provide your employees with access to the organization's services, connect them using their Yandex accounts. If your company already uses a different account management system (such as Active Directory or Google Workspace), configure an identity federation so that your employees can use their work accounts to access {{yandex-cloud}} services.

### Connect employees with Yandex accounts {#add-ya-users}

If your employees have Yandex accounts (for example, `{{login-example}}`), they can use them to access the {{yandex-cloud}} services enabled in your organization.

To connect employees with Yandex accounts:

1. In the left-hand panel, select [{{ ui-key.yacloud_org.pages.users }}]({{link-org-users}}) ![icon-users](../_assets/console-icons/person.svg).

1. In the top-right corner, click **{{ ui-key.yacloud_org.page.users.action.invite-users }}**.

1. Enter the email addresses of the users you want to invite to the organization (e.g., `{{ login-example }}`).

   You can send invitations to any email address. Invited users will be able to select the appropriate Yandex account once they accept the invitation.


1. Click **{{ ui-key.yacloud_org.entity.invitation.action_send-invitation }}**.

The users will be connected to the organization upon accepting the invitation via the emailed link and selecting an account for log-in.

### Configure an identity federation {#add-federation}

An identity federation is a technology that allows you to implement a Single Sign-On (SSO) authentication scheme and use corporate accounts to log in to {{ org-full-name }}. In this case, your corporate account management system acts as an identity provider (IdP).

To configure your identity federation, follow these steps:

1. In the left-hand panel, select [{{ ui-key.yacloud_org.pages.federations }}]({{link-org-federations}}) ![icon-federation](../_assets/console-icons/vector-square.svg).

1. Click **{{ ui-key.yacloud_org.form.federation.action.create }}**.

1. Enter the federation name and description.

1. In the **{{ ui-key.yacloud_org.entity.federation.field.cookieMaxAge }}** field, specify the time before the browser asks the user to re-authenticate.

1. In the **{{ ui-key.yacloud_org.entity.federation.field.issuer }}** field, specify the IdP server ID to be used for authentication. The IdP server must send the same ID in its response to {{ org-name }} during user authentication.

   {% note info %}

   ID format depends on the type of IdP server you use (for example, Active Directory or Google Workspace).

   {% endnote %}

1. In the **{{ ui-key.yacloud_org.entity.federation.field.ssoBinding }}** field, choose **POST**.

1. In the **{{ ui-key.yacloud_org.entity.federation.field.ssoUrl }}** field, specify the address of the page that the browser redirects the user to for authentication.

1. Add an [identity provider certificate](#add-cert) to the created federation.

1. Enable **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}** to add authenticated users to your organization automatically.

   If you do not enable this option, you will need to [manually add](operations/add-account.md#add-user-sso) your federated users.

1. Configure the identity provider's server to transmit successful authentication information and user attributes to {{ yandex-cloud }}.

   User attributes supported by {{ org-full-name }} services are listed in identity federation setup guides for different identity providers:

   * [Active Directory](tutorials/federations/integration-adfs.md).
   * [Google Workspace](tutorials/federations/integration-gworkspace.md).
   * [Other SAML-compatible identity providers](tutorials/federations/integration-common.md).
