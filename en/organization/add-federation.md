# Configuring an identity federation

If your company has a user and access management system (for example, Active Directory or Google Workspace), you can use it to authorize employees in {{org-full-name}}. In this case, you don't need to create a new Yandex account for every company employee. They can get access to {{yandex-cloud}} services using their corporate accounts.

{% note warning %}

The {{org-full-name}} service is running in [Preview](../overview/concepts/launch-stages.md) mode. Managing organization services is unavailable.

{% endnote %}

Identity federation is a technology with which you can implement a single sign-on system (SSO) and use corporate accounts for authorization in {{org-name}}. In this case, your corporate account management system acts as an identity provider (IdP).

In {{org-name}}, you can create an identity federation with any credential management service (identity provider) that supports the [SAML]({{link-saml}}) protocol.

Information about user logins and passwords is stored by the identity provider. When a user logs in to {{org-name}}, they're directed to the identity provider (IdP) server for authentication. If authentication is successful, the user gets access to {{yandex-cloud}} services.

## Creating a federation {#create}

1. [Log in]({{link-passport}}) to the organization's administrator account.

1. Go to [{{org-full-name}}]({{link-org-main}}).

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

To learn more about configuring an identity federation for different identity providers, see the [Yandex Identity and Access Management](../iam/index.yaml) documentation:

* [Active Directory](../iam/operations/federations/integration-adfs.md).
* [Google Workspace](../iam/operations/federations/integration-gsuite.md).
* [Other SAML-compatible identity providers](../iam/operations/federations/integration-common.md).

## Adding a certificate {#add-cert}

When the identity provider (IdP) informs {{org-full-name}} that a user has been authenticated, they sign the message with their certificate. To enable {{org-name}} to verify this certificate, add it to the created federation.

1. Get your identity provider certificate.

    {% note info %}

    To find out how to get a certificate, see the documentation or go to the support service of your identity provider.

    {% endnote %}

1. Go to [{{org-full-name}}]({{link-org-main}}).

1. In the left panel, select [Federations]({{link-org-federations}}) ![icon-federation](../_assets/organization/icon-federation.png).

1. Click the name of the federation you need to add a certificate to.

1. At the bottom of the page, click **Add certificate**.

1. Enter the certificate's name and description.

1. Choose how to add the certificate:
    * To add a certificate as a file, click **Choose a file** and specify the path to it.
    * To paste the contents of a copied certificate, select the **Text** method and paste the contents.

1. Click **Add**.

{% note tip %}

Certificates have limited validity periods. Before the current certificate expires, we recommend adding a new certificate.

{% endnote %}

