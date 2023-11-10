# Setting up OmniAuth

With [OmniAuth](https://rubygems.org/gems/omniauth/), users can get authorized in {{ GL }} using credentials from other services.

To integrate an authentication provider for {{ GL }} via OmniAuth, [add your authentication provider](#add-provider) and specify its [parameters](#params).

## Adding an authentication provider {#add-provider}

1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
1. Click the cluster name and open the **{{ ui-key.yacloud.gitlab.title_omniauth }}** tab.
1. Click **{{ ui-key.yacloud.gitlab.button_setup-omniauth }}**.
1. To add an authentication provider, click **Add**.
1. Select a type and specify the [authentication provider parameters](#params).
1. Click **{{ ui-key.yacloud.common.create }}**.

For more information about working with OmniAuth in {{ GL }}, see the [{{ GL }} documentation]({{ gl.docs }}/ee/integration/omniauth.html).

## Authentication provider parameters {#params}

Some parameters are common to all providers:

* **Allow single sign on**: Allow using SSO. If set to `true`, when a user who has not singed up with {{ GL }} is being authorized through OmniAuth, an account is automatically created for them in {{ GL }}.
* **Auto link users by email**: Map the username in OmniAuth to that in {{ GL }} if they have the same email address linked.
* **Block auto-created users**: Switch automatically created accounts to the [Pending approval]({{ gl.docs }}/ee/administration/moderate_users.html#users-pending-approval) status until they are approved by an administrator.
* **External provider**: Set the _external_ attribute for the provider. Users authorized through this provider will be treated as [external]({{ gl.docs }}/ee/user/admin_area/external_users.html) and will have no access to [internal projects]({{ gl.docs }}/ee/user/public_access.html#internal-projects-and-groups).
* **Auto link LDAP user**: Create an LDAP entity for automatically created accounts. Only applies to instances with an LDAP provider connected.

Other parameters depend on the selected provider type.

### Bitbucket Cloud {#bitbucket}

{% include [omniauth-common](../../_includes/managed-gitlab/omniauth-common.md) %}

For information on how to obtain an app ID and secret key, see the [guide on setting up a provider]({{ gl.docs }}/ee/integration/bitbucket.html#bitbucket-omniauth-provider).

### Github Enterprise {#gitlab-ee}

{% include [omniauth-common](../../_includes/managed-gitlab/omniauth-common.md) %}
* **URL**: Link to the GitHub repository.

For information on how to obtain an app ID and secret key, see the [guide on setting up a provider]({{ gl.docs }}/ee/integration/github.html).

### {{ GL }} self-managed {#gitlab-self}

{% include [omniauth-common](../../_includes/managed-gitlab/omniauth-common.md) %}
* **Site**: Link to the {{ GL }} repository.

For information on how to obtain an app ID and secret key, see the [guide on setting up a provider]({{ gl.docs }}/ee/integration/gitlab.html).

### Google OAuth 2.0 {#google}

{% include [omniauth-common](../../_includes/managed-gitlab/omniauth-common.md) %}

For information on how to obtain an app ID and secret key, see [how to set up a provider]({{ gl.docs }}/ee/integration/google.html#configure-the-google-cloud-resource-manager).

### Keycloak {#keycloak}

{% note info %}

To work with {{ GL }}, the Keycloak server should use HTTPS.

{% endnote %}

* **Label**: Name of the authentication provider. You can set any name.
* **Issuer**: Authorization source URL, such as `https://keycloak.example.com/realms/myrealm`.
* **Client ID**: Client ID received when setting up Keycloak.
* **Client secret**: Client secret key received when setting up Keycloak.
* **Site**: Link to the {{ GL }} repository.

### LDAP {#ldap}

{% note warning %}

Before setting up LDAP integration, make sure the users on the LDAP server cannot:

* Change the `mail`, `email`, and `userPrincipalName` attributes. Users with privileges like this can potentially access any account on the {{ GL }} server.
* Have a shared email address. LDAP users with a shared email address can use the same account in {{ GL }}.

{% endnote %}

* **Name**: Username displayed in LDAP.
* **Label**: LDAP server name. You can set any name.
* **Host**: LDAP server IP or domain name.
* **DB_PORT**: LDAP server connection port.
* **Username ID**: User ID in LDAP.
* **Encryption**: Traffic encryption method.
* **Base**: Name of the LDAP folder that stores user accounts.

For information on how to configure the LDAP server to work with {{ GL }}, see the [{{ GL }} documentation]({{ gl.docs }}/ee/administration/auth/ldap/#configure-ldap).

### Microsoft Azure Active Directory {#azure-ad}

* **Label**: Name of the authentication provider. You can set any name.
* **Client ID**: Client ID received when registering an application.
* **Client Secret**: Client secret key received when registering an application.
* **Tenant ID**: Tenant ID received when registering an application.

For information on how to register an application on the Azure side, see the [{{ GL }} documentation]({{ gl.docs }}/ee/integration/azure.html#register-an-azure-application).

### Microsoft Azure OAuth 2 {#azure-oauth}

* **Label**: Name of the authentication provider. You can set any name.
* **Client ID**: Client ID received when registering an application.
* **Client Secret**: Client secret key received when registering an application.
* **Tenant ID**: Tenant ID received when registering an application.

For information on how to register an application on the Azure side, see the [{{ GL }} documentation]({{ gl.docs }}/ee/integration/azure.html#register-an-azure-application).

### SAML {#saml}

* **Label**: Name of the authentication provider. You can set any name.
* **Assertion consumer service URL**: HTTPS endpoint of the {{ GL }} instance. To create this URL, add `/users/auth/saml/callback` to your {{ GL }} instance URL, such as `https://example.gitlab.yandexcloud.net/users/auth/saml/callback`.
* **IDP certificate fingerprint**: SHA1 fingerprint of a public certificate key, e.g., `90:CC:16:F0:8D:...`. Issued when configuring the IdP.
* **IDP SSO target URL**: URL of the IdP. Issued when configuring the IdP.
* **Issuer**: Unique ID of the application where user authentication will be performed, such as `https://example.gitlab.yandexcloud.net`.
* **Name identifier format**: Format of the name identifier. Issued when configuring the IdP.

For information on how to configure SAML on the IdP side, see the [{{ GL }} documentation]({{ gl.docs }}/ee/integration/saml.html#configure-saml-on-your-idp).
