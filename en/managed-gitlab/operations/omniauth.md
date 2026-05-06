# Setting up OmniAuth

With [OmniAuth](https://rubygems.org/gems/omniauth/), users can sign in to {{ GL }} using credentials from other services.

To integrate an authentication provider for {{ GL }} via OmniAuth, [add your provider](#add-provider) and specify its [settings](#params).

## Adding an authentication provider {#add-provider}

1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-gitlab }}**.
1. Click the instance name and select the **{{ ui-key.yacloud.gitlab.title_omniauth }}** tab.
1. Click **{{ ui-key.yacloud.gitlab.button_setup-omniauth }}**.
1. To add an authentication provider, click **Add**.
1. Select a type and specify the [authentication provider settings](#params).
1. Click **{{ ui-key.yacloud.common.create }}**.

For more information about using OmniAuth in {{ GL }}, see [this {{ GL }} article]({{ gl.docs }}/ee/integration/omniauth.html).

## Authentication provider settings {#params}

Some settings are shared across all providers:

* **Allow single sign on**: Enables SSO. If you set it to `true`, {{ GL }} automatically creates an account for a user signing in through OmniAuth who does not yet have a {{ GL }} account.
* **Auto link users by email**: Maps the username in OmniAuth to that in {{ GL }} if both share the same email address.
* **Block auto-created users**: Automatically marks the created accounts as [Pending approval]({{ gl.docs }}/ee/administration/moderate_users.html#users-pending-approval) until approved by an administrator.
* **External provider**: Sets the _external_ attribute for the provider. Users authenticated through this provider will be treated as [external]({{ gl.docs }}/ee/user/admin_area/external_users.html) and will have no access to [internal projects]({{ gl.docs }}/ee/user/public_access.html#internal-projects-and-groups).
* **Auto link LDAP user**: Creates an LDAP entity for automatically created accounts. This setting only applies to instances with an LDAP provider.

Other settings depend on the provider type you select.

### Bitbucket Cloud {#bitbucket}

{% include [omniauth-common](../../_includes/managed-gitlab/omniauth-common.md) %}

You can learn how to obtain an app ID and secret key in [this guide]({{ gl.docs }}/ee/integration/bitbucket.html#bitbucket-omniauth-provider) on setting up a provider.

### Github Enterprise {#gitlab-ee}

{% include [omniauth-common](../../_includes/managed-gitlab/omniauth-common.md) %}
* **URL**: Link to the GitHub repository.

You can learn how to obtain an app ID and secret key in [this guide]({{ gl.docs }}/ee/integration/github.html) on setting up a provider.

### {{ GL }} self-managed {#gitlab-self}

{% include [omniauth-common](../../_includes/managed-gitlab/omniauth-common.md) %}
* **Site**: Link to the {{ GL }} repository.

You can learn how to obtain an app ID and secret key in [this guide]({{ gl.docs }}/ee/integration/gitlab.html) on setting up a provider.

### Google OAuth 2.0 {#google}

{% include [omniauth-common](../../_includes/managed-gitlab/omniauth-common.md) %}

You can learn how to obtain an app ID and secret key in [this guide]({{ gl.docs }}/ee/integration/google.html#configure-the-google-cloud-resource-manager) on setting up a provider.

### Keycloak {#keycloak}

{% note info %}

To work with {{ GL }}, make sure your Keycloak server uses HTTPS.

{% endnote %}

* **Label**: Name of the authentication provider. You can set any name.
* **Issuer**: Authentication source URL, such as `https://keycloak.example.com/realms/myrealm`.
* **Client ID**: Client ID obtained when configuring Keycloak.
* **Client Secret**: Client secret key obtained when configuring Keycloak.
* **Site**: Link to the {{ GL }} repository.

### LDAP {#ldap}

{% note warning %}

Before setting up LDAP integration, make sure users on the LDAP server cannot:

* Change the `mail`, `email`, and `userPrincipalName` attributes. Users with these privileges could potentially access any account on the {{ GL }} server.
* Have a shared email address. LDAP users with a shared email address can use the same account in {{ GL }}.

{% endnote %}

* **Name**: Displayed user name in LDAP. It may not include spaces or punctuation marks.
* **Label**: LDAP server name. You can set any name.
* **Host**: LDAP server IP address or domain name.
* **Port**: LDAP server connection port.
* **Username ID**: User ID in LDAP.
* **Encryption**: Traffic encryption method.
* **Base**: Name of the LDAP directory that stores user accounts.
* **Bind DN**: Unique distinguished name (DN) of a user in LDAP. This is an optional setting.
* **User Filter**: LDAP user filter in [RFC-4515](https://www.rfc-editor.org/rfc/rfc4515.html) format. This is an optional setting.

To learn how to configure an LDAP server to work with {{ GL }}, see [this {{ GL }} guide]({{ gl.docs }}/ee/administration/auth/ldap/#configure-ldap).

### {{ microsoft-idp.entra-id-full }} {#azure-ad}

* **Label**: Name of the authentication provider. You can set any name.
* **Client ID**: Client ID obtained when registering the application.
* **Client Secret**: Client secret key obtained when registering the application.
* **Tenant ID**: Tenant ID obtained when registering the application.

To learn how to register an application on the Azure side, see [this {{ GL }} article]({{ gl.docs }}/ee/integration/azure.html#register-an-azure-application).

### Microsoft Azure OAuth 2 {#azure-oauth}

* **Label**: Name of the authentication provider. You can set any name.
* **Client ID**: Client ID obtained when registering the application.
* **Client Secret**: Client secret key obtained when registering the application.
* **Tenant ID**: Tenant ID obtained when registering the application.

To learn how to register an application on the Azure side, see [this {{ GL }} article]({{ gl.docs }}/ee/integration/azure.html#register-an-azure-application).

### SAML {#saml}

* **Label**: Name of the authentication provider. You can set any name.
* **Assertion consumer service URL**: HTTPS endpoint of the {{ GL }} instance. To create this URL, add `/users/auth/saml/callback` to your {{ GL }} instance URL, such as `https://example.gitlab.yandexcloud.net/users/auth/saml/callback`.
* **IDP certificate fingerprint**: SHA1 fingerprint of a public certificate key, e.g., `90:CC:16:F0:8D:...`. It is issued when configuring the IdP.
* **IDP SSO target URL**: IdP URL. It is issued when configuring the IdP.
* **Issuer**: Unique ID of the application where user authentication will be performed, such as `https://example.gitlab.yandexcloud.net`.
* **Name identifier format**: Name ID format. It is issued when configuring the IdP.

To learn how to configure SAML on the IdP side, see [this {{ GL }} article]({{ gl.docs }}/ee/integration/saml.html#configure-saml-on-your-idp).

### Yandex ID {#yandex-id}

* **Label**: Name of the authentication provider. You can set any name.
* **Client ID**: Client ID obtained when registering the application.
* **Client Secret**: Client secret key obtained when registering the application.
* **Site**: Link to the {{ GL }} repository.

To learn how to register an application on the IdP side, see [this {{ yandex-oauth }} article](https://yandex.ru/dev/id/doc/en/register-client). When registering an app, allow access to the user's email address. If selecting web services as the platform, use the **Redirect URI** field to specify a URL in the following format:

```text
https://<{{ GL }}_instance_address>/users/auth/Yandex/callback
```

URL example:

```text
https://my-domain.gitlab.yandexcloud.net/users/auth/Yandex/callback
```

{% note warning %}

When integrating with Yandex ID, any user with a Yandex account can log in to your instance. To prevent access by unauthorized users, [set](#params) **Allow single sign on** and **Block auto-created users** to **true**. This allows {{ GL }} to automatically create new users, while blocking them on first sign-in.

{% endnote %}

### Yandex 360 {#yandex-360}

Yandex 360 uses [Yandex ID](#yandex-id) or [LDAP](#ldap) as authentication providers. To allow Yandex 360 users to log into your {{ GL }} instance, [add](#add-provider) and configure one of these providers in OmniAuth.

{% note warning %}

When using Yandex ID, the user's membership in a Yandex 360 organization is not verified during authentication. Any user with a Yandex account can log in to your {{ GL }} instance. To prevent access by unauthorized users, [set](#params) **Allow single sign on** and **Block auto-created users** to **true**. This allows {{ GL }} to automatically create new users, while blocking them on first sign-in.

{% endnote %}
