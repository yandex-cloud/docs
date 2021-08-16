# Getting started

To get started, create an organization and add users to it.

{% note warning %}

The {{org-full-name}} service is running in [Preview](../overview/concepts/launch-stages.md) mode. Managing organization services is unavailable.

{% endnote %}

## Create an organization {#create}

1. [Log in]({{link-passport}}) to your Yandex account. If you don't have an account yet, [create](https://yandex.com/support/passport/authorization/registration.html) one.
1. Go to [{{org-full-name}}]({{link-org-main}}).
1. Read the {{yandex-cloud}} terms of use and click **Log in**.
1. Enter your company name and description.
1. Click **Create organization**.

After registering, you become the organization owner. You'll be able to manage employee accounts, as well as connect and disable services.

## Add employees {#add-users}

To provide your employees with access to the organization's services, connect them using their Yandex accounts. If your company already uses a different account management system (such as Active Directory or Google Workspace), configure an identity federation so that your employees can use their work accounts to access {{yandex-cloud}} services.

### Connect employees with Yandex accounts {#add-ya-users}

If your employees have Yandex accounts (for example, `{{login-example}}`), they can use them to access {{yandex-cloud}} services enabled in your organization.

To connect employees with Yandex accounts:

1. Go to the left panel and select [Users]({{link-org-users}}) ![icon-users](../_assets/organization/icon-users.png).
1. In the upper-right corner, click **Add user**.
1. Enter the email addresses of the Yandex users you want to invite to the organization (for example, `{{login-example}}`).
1. Click **Add**.

This will give the users access to the organization.

### Configure an identity federation {#add-federation}

Identity federation is a technology with which you can implement a single sign-on system (SSO) and use corporate accounts for authorization in {{org-full-name}}. In this case, your corporate account management system acts as an identity provider (IdP).

To configure your identity federation, follow these steps:

1. In the left panel, select [Federations]({{link-org-federations}}) ![icon-federation](../_assets/organization/icon-federation.png).

1. Click **Create federation**.

1. Enter the federation name and description.

1. In the **Cookie lifetime** field, specify the period of time during which the browser won't ask the user to re-authenticate.

1. In the **IdP Issuer** field, specify the IdP server ID to be used for authentication. The IdP server must send the same ID in its response to {{org-name}} during user authentication.

    {% note info %}

    ID format depends on the type of IdP server you use (for example, Active Directory or Google Workspace).

    {% endnote %}

1. In the **SSO method** field, choose **POST**.

1. In the **Link to the IdP login page** field, specify the address of the page where the browser redirects the user for authentication.

1. Add the [identity provider certificate](#add-cert) to the created federation.

All users who log in to {{org-full-name}} through the identity federation using their work accounts are automatically added to the list of the organization's users.

