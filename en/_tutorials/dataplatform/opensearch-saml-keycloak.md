You can use [{{ keycloak }}](https://www.keycloak.org/) to [authenticate users](../../managed-opensearch/operations/saml-authentication.md) working with {{ OS }} Dashboards in a {{ mos-name }} cluster.

To set up authentication:

1. [Configure an identity provider](#configure-idp).
1. [Set up SSO for the cluster](#configure-sso).
1. [Configure roles for SSO](#map-roles).
1. [Test SSO](#test-sso).

{% note info %}

This tutorial was tested for {{ OS }} 2.8 and {{ keycloak }} 24.0 clusters.

{% endnote %}

## Getting started {#before-you-begin}

1. Make sure you can [access {{ OS }} Dashboards](../../managed-opensearch/operations/connect.md#dashboards) using the `admin` user credentials.

    In this tutorial, we will use the following URL to access the {{ OS }} Dashboards web interface:

    ```url
    https://c-{{ cluster-id }}.rw.{{ dns-zone }}/
    ```

1. Make sure you can use {{ keycloak }}:

    * Check that you can access {{ keycloak }}.
    * Check that you can access the [realm](https://www.keycloak.org/docs/latest/server_admin/#configuring-realms) you need.
    * Check that you have the required permissions within this realm to manage:

        * Roles.
        * Users and groups.
        * Clients (in {{ keycloak }}, these are applications used for authentication).

    This tutorial assumes that:

    * To manage {{ keycloak }}, you need a [super administrator account](https://www.keycloak.org/docs/latest/server_admin/index.html#creating-first-admin_server_administration_guide) enabling any operation in any realm.
    * All operations are performed in the `master` realm.
    * {{ keycloak }} is accessible at:

        ```url
        http://keycloak.example.com:8080
        ```

    * The {{ keycloak }} admin console is accessible at:

        ```url
        http://keycloak.example.com:8080/admin/
        ```

## Configure an identity provider {#configure-idp}

1. Connect to the {{ keycloak }} management console and select the `master` realm.

1. Create a client:
    1. In the left-hand panel, select **Clients**. Click **Create client**.
    1. In the **Client type** field, select **SAML**.
    1. In the **Client ID** field, specify the client ID.

        This ID must match the URL used to connect to {{ OS }} Dashboards:

        ```url
        https://c-{{ cluster-id }}.rw.{{ dns-zone }}/
        ```

    1. Click **Next**.

    1. Specify the ACS URL in these fields:

        * **Home URL**
        * **Valid redirect URIs**
        * **IDP Initiated SSO Relay State**

        The ACS URL must be in the following format:

        ```url
        https://c-{{ cluster-id }}.rw.{{ dns-zone }}/_opendistro/_security/saml/acs
        ```

    1. Click **Save**.

1. Make sure you can use the client: the relevant option in the top-right corner must be set to **Enabled**.

1. On the **Settings** tab, configure the client parameters as follows:

    * **SAML Capabilities**:
        * **Name ID format**: `email`.
        * **Force name ID format**: Make sure to enable this option.
        * **Force POST binding**: Make sure to enable this option.
        * **Include AuthnStatement**: Make sure to enable this option.

    * **Signature and Encryption**:
        * **Sign documents**: Make sure to enable this option.
        * **Sign assertions**: Make sure to enable this option.
        * **Signature algorithm**: `RSA_SHA256`.
        * **SAML signature key name**: `CERT_SUBJECT`.
        * **Canonicalization method**: `EXCLUSIVE`.

1. Click **Save**.

1. On the **Keys** tab, disable the requirement for client message signing.

    To do this, disable **Client signature required**.

1. On the **Client scopes** tab, configure role mapping for the client:

    1. Click URL to connect to {{ OS }} Dashboards with the `-dedicated` suffix.

    1. On the **Mappers** tab, click **Configure a new mapper**. Select the **Role list** mapper from the list.

    1. Specify the following mapper settings:

        * **Name**: Any mapper name, e.g., `{{ OS }} Mapper`.
        * **Role attribute name**: `roles`.
        * **SAML Attribute NameFormat**: `Basic`.
        * **Single Role Attribute**: Make sure to enable this option.

    1. Click **Save**.

## Set up SSO for the cluster {#configure-sso}

1. Get the metadata for the [previously created client](#configure-idp):

    1. Connect to the {{ keycloak }} management console and select the `master` realm.
    1. In the left-hand panel, select **Clients**.
    1. Click URL to connect to {{ OS }} Dashboards.
    1. In the top-right corner, expand the **Action** menu and select **Download adapter config**.
    1. Select the `Mod Auth Mellon Files` format and click **Download**.

        This will download an archive.

    1. Extract the `idp-metadata.xml` file from the archive. This file contains all required metadata.

1. Set up SSO for the cluster.

    {% note tip %}

    Below are the steps for the management console; however you may [use other available {{ yandex-cloud }} interfaces](../../managed-opensearch/operations/saml-authentication.md#configuration-sso).

    {% endnote %}

    To set up a {{ keycloak }} authentication source:

    1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Click the cluster name and open the **{{ ui-key.yacloud.opensearch.auth.section_auth }}** tab.
    1. Click **{{ ui-key.yacloud.opensearch.auth.button_settings }}**.
    1. Specify the required values for these settings:

        * **{{ ui-key.yacloud.opensearch.auth.field_idp-entity-id }}**: Provider ID.

            For {{ keycloak }}, this ID matches the URL referring to the `master` realm:

            ```url
            http://keycloak.example.com:8080/realms/master
            ```

        * **idp_metadata_file**: Select and upload the metadata file extracted from the archive.

        * **{{ ui-key.yacloud.opensearch.auth.field_sp-entity-id }}**: Service provider ID.

            Use the same ID you [specified when configuring the {{ keycloak }} client](#configure-idp) in the **Client ID** field:

            ```url
            https://c-{{ cluster-id }}.rw.{{ dns-zone }}/
            ```

        * **{{ ui-key.yacloud.opensearch.auth.field_dashboards-url }}**: URL to connect to {{ OS }} Dashboards.

        * **{{ ui-key.yacloud.opensearch.auth.field_roles-key }}**: Attribute that stores a list of roles.

            Specify the same attribute [you configured for the {{ keycloak }} mapper](#configure-idp): `roles`.

        * **{{ ui-key.yacloud.opensearch.auth.field_subject-key }}**: Leave the field empty.

        * **{{ ui-key.yacloud.opensearch.auth.field_enabled }}**: Make sure to enable this option.

    1. Click **{{ ui-key.yacloud.opensearch.auth.button_save }}**.

1. Wait for the cluster status to change to `Running`. It may take a few minutes to apply settings.

## Configure roles for SSO {#map-roles}

1. Configure {{ keycloak }} so that its users get the appropriate roles:

    1. Connect to the {{ keycloak }} management console and select the `master` realm.

    1. Create a role:

        1. In the left-hand panel, select **Realm roles**. Click **Create role**.
        1. In the **Role name** field, enter a role name.

            In the steps below, we will use `kc_demo_role` as the role name.

        1. Click **Save**.

    1. Create and configure a user:

        1. In the left-hand panel, select **Users**. Click **Add user**.

        1. Specify user credentials:

            * **Username**: Account name.

                In the steps below, we will use `kc_demo_user` as the account name.

            * **Email**: Email address.

                In the steps below, we will use `kc_demo_user@example.com` as the email address.

            * **Email verified**: Make sure to enable this setting.

                {% note info %}

                For the sake of simplicity, this tutorial assumes that this setting is enabled to skip email verification at first login.

                {% endnote %}

        1. Click **Create**.
        1. In the **Credentials** tab, click **Set password** and enter a password.

            Also, disable **Temporary**.

            {% note info %}

            For the sake of simplicity, this tutorial assumes that this setting is disabled to avoid password change at first login.

            {% endnote %}

    1. Create and configure a group:

        1. In the left-hand panel, select **Groups** and click **Create group**.
        1. Enter a group name and click **Create**.

           In the steps below, we will use `kc_demo_group` as the group name.

        1. Click the group name to open its properties.
        1. In the **Members** tab, click **Add member**, select `kc_demo_user`, and click **Add**.
        1. In the **Role mapping** tab, click **Assign role**, enable **Filter by realm roles**, select `kc_demo_role` from the role list, and click **Assign**.

1. Map {{ OS }} cluster roles with those in {{ keycloak }}. This will enable you to access a cluster using SSO.

    To map roles:

    1. [Connect](../../managed-opensearch/operations/connect.md#dashboards) to {{ OS }} Dashboards as the `admin` user.
    1. In the left-hand menu, select **{{ OS }} Plugins** → **Security**.
    1. In the left-hand panel, select **Roles**.
    1. Configure role mapping:

        1. Click the role name.

            The next steps assume that you select the `kibana_user` role.

        1. Go to the **Mapped users** tab.
        1. Click **Manage mapping**.
        1. Under **Backend roles**, enter the name of the {{ keycloak }} role to map with the {{ OS }} role and click **Map**.

            The next steps assume that you select the `kc_demo_role` role.

{{ keycloak }} users added to `kc_demo_group` will now get the `kc_demo_role` role.

Upon successful authentication with {{ OS }} Dashboards, the user with the `kc_demo_role` role will get the `kibana_user` role in {{ OS }}.

## Test SSO {#test-sso}

1. Open your browser in guest or private browsing mode.

    For this, you must use a computer with access to {{ keycloak }}.

1. [Connect](../../managed-opensearch/operations/connect.md#dashboards) to {{ OS }} Dashboards.

    On the login page, click **Log in with single sign-on** rather than entering your username and password.

    If you have set up everything correctly, the browser will redirect you to the authentication page in {{ keycloak }}.

1. Enter the `kc_demo_user` credentials and click **Sign in**.

    After successful authentication, {{ keycloak }} will redirect you to the ACS URL, and from there you will be redirected to the {{ OS }} Dashboards home page.

1. Make sure the user has the `kibana_user` role in {{ OS }}.

    To do this, click the user avatar in the top-right corner and select **View roles and identities**. This will show you the roles assigned to the user.

1. Make sure you can perform all actions the `kibana_user` role permits.
