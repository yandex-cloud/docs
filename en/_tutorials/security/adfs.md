# User group mapping in {{ microsoft-idp.adfs-full }}

You can use [{{ microsoft-idp.adfs-short }}](https://learn.microsoft.com/ru-ru/windows-server/identity/ad-fs/ad-fs-overview) ({{ microsoft-idp.adfs-abbreviated }}) to authenticate users in an organization.

To configure mapping between user groups in {{ microsoft-idp.adfs-abbreviated }} and user groups in an [identity federation](../../organization/concepts/add-federation.md):

1. [Collect the {{ microsoft-idp.adfs-abbreviated }} farm data](#get-adfs-info).
1. [Create a {{ org-full-name }} federation](#create-federation).
1. [Add an {{ microsoft-idp.adfs-abbreviated }} certificate to your federation](#add-certificate).
1. [Create and configure a relying party trust on the {{ microsoft-idp.adfs-abbreviated }} side](#create-relying-party-trust).
1. [Configure attribute mapping on the {{ microsoft-idp.adfs-abbreviated }} side](#adfs-mapping).
1. [Configure group mapping on the federation side](#org-mapping).
1. [Test authentication](#test-auth).

## Getting started {#before-you-begin}

Make sure to meet the following prerequisites:

1. You have access to the **Active Directory Users and Computers** MMC snap-in to manage domain computers, users, and groups.

1. You have configured a {{ microsoft-idp.adfs-abbreviated }} farm with one or more valid `Token-signing` certificates to sign tokens.

1. You have access to the following tools to manage this farm:

    * **{{ microsoft-idp.adfs-abbreviated }} Management** MMC snap-in.
    * [PowerShell module](https://learn.microsoft.com/en-us/powershell/module/adfs/) to manage {{ microsoft-idp.adfs-abbreviated }}.

## Collect {{ microsoft-idp.adfs-abbreviated }} farm data {#get-adfs-info}

1. Get and save the certificate that will be used to sign messages from {{ microsoft-idp.adfs-abbreviated }}.

    To get a `Token-Signing` certificate in Base64 format, run the following commands in PowerShell, providing the path where to save the certificate:

    {% include [adfs-cert-guide-powershell](../../_includes/organization/adfs-cert-guide-powershell.md) %}

1. Get and save the credentials you will use to configure your identity federation:

    1. Get the FS ID (**Federation Service identifier**):

        ```powershell
        Get-AdfsProperties | Select Identifier
        ```

        The ID contains the FQDN of the {{ microsoft-idp.adfs-abbreviated }} farm and has the following format:

        ```text
        http://<AD_FS_farm_FQDN>/adfs/services/trust
        ```

    1. {% include [get-adfs-endpoint](../../_includes/organization/get-adfs-endpoint.md) %}

    {% note info %}

    The `http://` scheme in the ID is does not mean that data will be sent in plain text over HTTP.

    {{ microsoft-idp.adfs-abbreviated }} and {{ yandex-cloud }} will interact via an endpoint over HTTPS.

    {% endnote %}

## Create a {{ org-full-name }} federation {#create-federation}

{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  1. Go to [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. In the left-hand panel, select ![icon-federation](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.

  1. Click ![Circles3Plus](../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.form.federation.action.create }}** in the top-right corner of the page. In the window that opens:

      1. Enter a name for the federation, e.g., `demo-federation`. It must be unique within the folder.

      1. You can also add a description, if required.

      1. In the **{{ ui-key.yacloud_org.entity.federation.field.cookieMaxAge }}** field, specify the time before the browser asks the user to re-authenticate.

      1. In the **{{ ui-key.yacloud_org.entity.federation.field.issuer }}** field, paste the federation service ID [you got when collecting {{ microsoft-idp.adfs-abbreviated }}](#get-adfs-info) farm data.

      1. Select `POST` from the **{{ ui-key.yacloud_org.entity.federation.field.ssoBinding }}** drop-down list.

      1. In the **{{ ui-key.yacloud_org.entity.federation.field.ssoUrl }}** field, paste the federation service endpoint you got when collecting {{ microsoft-idp.adfs-abbreviated }} farm data.

      1. Enable **{{ ui-key.yacloud_org.entity.federation.field.autocreateUsers }}** to automatically add a new user to your organization after authentication. Otherwise, you will need to [manually add](../../organization/operations/add-account.md#add-user-sso) your federated users.

          {% include [fed-users-note](../../_includes/organization/fed-users-note.md) %}

      1. (Optional) To make sure that all authentication requests from {{ yandex-cloud }} contain a digital signature, enable **{{ ui-key.yacloud_org.entity.federation.field.encryptedAssertions }}**. You will need to install a {{ yandex-cloud }} SAML certificate on the IdP side.

          {% include [download-saml-cert-when-creating-fed](../../_includes/organization/download-saml-cert-when-creating-fed.md) %}

          {% include [setup-cert-for-idp](../../_includes/organization/setup-cert-for-idp.md) %}

          You will need this certificate later when configuring the {{ microsoft-idp.adfs-abbreviated }} relying party trust.

      1. {% include [forceauthn-option-enable](../../_includes/organization/forceauthn-option-enable.md) %}

      1. Click **{{ ui-key.yacloud_org.form.federation.create.action.create }}**.

{% endlist %}

## Add the {{ microsoft-idp.adfs-abbreviated }} certificate to the federation {#add-certificate}

To enable {{ org-name }} to verify the {{ microsoft-idp.adfs-abbreviated }} certificate during authentication, add the certificate to the federation:

{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. In the left-hand panel, select ![VectorSquare](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.

  1. Click the row with `demo-federation` to add your certificate to.

  1. Click **{{ ui-key.yacloud_org.page.federation.section.certificates }}** under **{{ ui-key.yacloud_org.entity.certificate.action.add }}** at the bottom of the page.

  1. Enter the certificate name and specify the path to the `adfs_certificate.cer` file you saved earlier.

  1. Click **{{ ui-key.yacloud_org.actions.add }}**.

{% endlist %}

{% include [federation-certificates-note](../../_includes/organization/federation-certificates-note.md) %}

## Create and configure a relying party trust on the {{ microsoft-idp.adfs-abbreviated }} side {#create-relying-party-trust}

{{ microsoft-idp.adfs-abbreviated }} acts as the identity provider (IdP), with a relying party trust configured. To create and configure a relying party trust:

1. Open the **{{ microsoft-idp.adfs-abbreviated }} Management** MMC snap-in.

1. In the console tree, under **{{ microsoft-idp.adfs-abbreviated }}**, right-click **Relying Party Trusts** and select **Add Relying Party Trust**.

    This will open the Add Relying Party Trust wizard.

1. At the **Welcome** step, select **Claims aware**. Click **Start**.

1. At the **Select Data Source** step, select **Enter data about the relying party manually**. Click **Next**.

1. At the **Specify Display Name** step, specify a name for the relying party trust, e.g., `{{ yandex-cloud }}`, and its description, if required. Click **Next**.

1. Skip the **Configure Certificate** step by clicking **Next**.

1. At the **Configure URL** step, specify the redirect URL.

    1. Check the **Enable support for the SAML 2.0 Web SSO protocol** box.
    1. Specify the redirect URL in the **Relying party SAML 2.0 SSO service URL** field.

        The redirect URL must be in the following format:

        ```text
        https://{{ auth-host }}/federations/<federation_ID>
        ```

        {% cut "How to get the federation ID" %}

        {% include [get-federation-id](../../_includes/organization/get-federation-id.md) %}

        {% endcut %}

    1. Click **Next**.

1. At the **Configure Identifiers** step, specify the relying party ID:

    1. In the **Relying party identifier** field, specify the redirect URL from the previous step.

    1. Click **Add**.

    1. Click **Next**.

1. Enable **I do not want to configure access control policies at this time. No user will be permitted access for this application** at the **Choose Access Control Policy** step. Click **Next**.

    You will [configure](#configure-access-control-policy) access control policies later.

1. At the **Ready to Add Trust** step, make sure all the parameters are correct. Click **Next**.

1. Disable **Configure claims issuance policy for this application** at the **Finish** step. Click **Close**.

    You will [configure](#map-adfs-ldap) claim issuance policies later.

1. {% include [adfs-postinstall-setup-additional-encryption-settings](../../_includes/organization/adfs-postinstall-setup-additional-encryption-settings.md) %}

## Configure attribute mapping on the {{ microsoft-idp.adfs-abbreviated }} side {#adfs-mapping}

### Create a user {#create-user}

1. Open the **Active Directory Users and Computers** MMC snap-in.

1. In the console tree, select the organization unit (OU) where you need to create a user, right-click it, and select **New** → **User**.

    This will open the New Object - User wizard.

1. Specify user info:

    * **User logon name**: Username, such as `adfs_demo_user`, in combination with the domain, e.g., `example.com`.

        {% note info %}

        In the steps below, we will use the `example.com` domain name. If your domain has a different name, adjust the following steps accordingly.

        {% endnote %}

    * **Full name**: Full name of the user, e.g., `Ivan Ivanov`.

    You may provide other user info, if required.

1. Click **Next**.

1. Specify a password and configure the associated policies:

    1. Enter and confirm the password.

    1. Optionally, disable **User must change password at next login**.

        Otherwise, the user will be prompted to change the password the first time they get authenticated in {{ microsoft-idp.adfs-abbreviated }}.

    1. Make sure to uncheck **Account is disabled**.

        {% note warning %}

        Otherwise, the user account will be disabled.

        The user will be unable to get authenticated in {{ microsoft-idp.adfs-abbreviated }} and access {{ yandex-cloud }}.

        {% endnote %}

    1. If required, select other options based on the relevant password policies.

1. Click **Next** and then **Finish**.

### Create a group {#create-group}

1. Open the **Active Directory Users and Computers** MMC snap-in.

1. In the console tree, select the organization unit where you need to create a group, right-click it and select **New** → **Group**.

    This will open the New Object - Group wizard.

1. Specify the group info:

    * **Group name**: Name of the group, e.g., `adfs_group`.
    * **Group name (pre-Windows 2000)**: Group name in the legacy format to use with pre-Windows 2000 systems.

        By default, this name is the same as the group name you specify. You can enter a different name, if required.

1. Specify the group settings:

    * **Group scope**: `Global`
    * **Group type**: `Security`

1. Click **OK**.

### Add the user to the group {#add-user-to-group}

1. Open the **Active Directory Users and Computers** MMC snap-in.

1. In the console tree, select the organization unit containing the `adfs_group` group.

1. In the result pane, select the `adfs_group` group. Then, right-click the group and select **Properties** from the context menu.

    This will open the window with group properties.

1. Go to the **Members** tab and click **Add**.

1. Enter the `adfs_demo_user` username and click **OK**.

1. Click **OK**.

### Configure the access control policy {#configure-access-control-policy}

This policy enables authentication of users belonging to the [previously created group](#create-group).

To configure such a policy:

1. Open the **{{ microsoft-idp.adfs-abbreviated }} Management** MMC snap-in.

1. In the console tree, select **{{ microsoft-idp.adfs-abbreviated }}** → **Relying Party Trusts**.

1. Select the `{{ yandex-cloud }}` [relying party trust](#create-relying-party-trust) in the result pane.

1. Right-click the trust and select **Edit Access Control Policy**.

    This will open the window with a list of policies.

1. Select the `Permit Specific Group` policy from the **Choose an access control policy** list.

1. Click the `parameter` link in the **Policy** field with the selected policy description.

1. Click **Add**.

1. Enter the `adfs_group` group name and click **OK**.

1. In the **Select Groups** window, click **OK**.

1. In the **Edit Access Control Policy for {{ yandex-cloud }}** window, click **OK**.

### Configure LDAP attribute mapping {#map-adfs-ldap}

1. Open the **{{ microsoft-idp.adfs-abbreviated }} Management** MMC snap-in.

1. In the console tree, select **{{ microsoft-idp.adfs-abbreviated }}** → **Relying Party Trusts**.

1. Select the `{{ yandex-cloud }}` [relying party trust](#create-relying-party-trust) in the result pane.

1. Right-click the trust and select **Edit Claim Issuance Policy**.

    This will open the window with a list of policies.

1. Click **Add Rule**.

    This will open the Add Transform Claim Rule wizard.

1. Select `Send LDAP Attributes as Claims` from the **Claim rule template** drop-down list at the **Choose rule type** step. Click **Next**.

1. Configure the rule at the **Configure Claim Rule** step:

    * **Claim rule name**: Rule name, e.g., `LDAP Mappings`.

    * **Attribute store**: `Active Directory`.

    * **Mapping of LDAP attributes to outgoing claim types**: List of mappings in the form of attribute/outgoing claim type pairs.

        Add the following required mappings to the list to enable proper communication with {{ yandex-cloud }}:

        #|
        || **Attribute** | **Outgoing claim type** ||
        || `User-Principal-Name`

        Attribute to use to identify the user.

        In this case, the user will be identified by their [user principal name (UPN)](https://learn.microsoft.com/en-us/windows/win32/ad/naming-properties#userprincipalname). The UPN of the [previously created user](#create-user) will look like this:

        ```text
        adfs_demo_user@example.com
        ```

        You may use a different attribute as long as it is permanent and unique to ensure unambiguous user identification. In this case, adjust the following steps.

        | `Name ID` ||

        || `Token-Groups - Unqualified Names`

        List of groups the user belongs to. This list will be used for group mapping when authenticating the user in {{ yandex-cloud }}.

        This specific attribute enables sending short group names, such as `adfs_group` or `Domain Users`, that do not specify a domain.

        You may use a different attribute from the `Token-Groups` family, e.g., `Token-Groups as SIDs`. In this case, adjust the following steps.

        | `Group` ||

        |#

        {% note tip %}

        To send [other supported user attributes](../../organization/tutorials/federations/integration-adfs.md#configure-claims-mapping), add more mappings, if required.

        {% endnote %}

1. Click **Finish**.
1. Click **OK**.

## Configure group mapping on the federation side {#org-mapping}

{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. [Create a user group](../../organization/operations/create-group.md) named `yc-demo-group` in {{ org-name }} and [authorize it](../../organization/operations/access-group.md) to view resources in the cloud or a separate folder (the `viewer` role).

  1. In the left-hand panel, select ![VectorSquare](../../_assets/console-icons/vector-square.svg) **{{ ui-key.yacloud_org.pages.federations }}**.

  1. Select `demo-federation` [you created previously](#create-federation) and navigate to the **{{ ui-key.yacloud_org.form.group-mapping.note.tab-idp }}** tab.

  1. Enable **{{ ui-key.yacloud_org.form.group-mapping.field.idp }}**.

  1. Click **{{ ui-key.yacloud_org.form.group-mapping.create.add }}**.

  1. In the **{{ ui-key.yacloud_org.form.group-mapping.note.group-name }}** field, enter the group ID provided in [{{ microsoft-idp.adfs-abbreviated }}](#map-adfs-ldap) claims.

      When using `Token-Groups - Unqualified Names`, specify the short group name, i.e., `adfs_group`, as the ID.

  1. In the **{{ ui-key.yacloud_org.form.group-mapping.note.iam-group }}** field, select the `yc-demo-group` group you created in {{ org-full-name }} from the list.

  1. Click **{{ ui-key.yacloud_org.actions.save-changes }}**.

{% endlist %}

## Test authentication {#test-auth}

1. Open your browser in guest or private browsing mode.

    For this, you must use a domain-joined computer with access to {{ microsoft-idp.adfs-abbreviated }}.

1. Use this URL to log in to the management console:

    ```text
    https://{{ console-host }}/federations/<federation_ID>
    ```

    {% cut "How to get the federation ID" %}

    {% include [get-federation-id](../../_includes/organization/get-federation-id.md) %}

    {% endcut %}

    If you have set up everything correctly, the browser will redirect you to the authentication page in {{ microsoft-idp.adfs-abbreviated }}.

1. Enter the credentials of the `adfs_demo_user@example.com` user you [created earlier](#create-user) and click **Sign in**.

    On successful authentication, the IdP server will redirect you to the `https://{{ auth-host }}/federations/<federation_ID>` URL you specified in the [relying party trust](#create-relying-party-trust) settings and then to the [management console]({{ link-console-main }}) home page.

1. Make sure the signed in user belongs to `yc-demo-group` and has the viewer permissions for resources according to the role assigned to the group.
