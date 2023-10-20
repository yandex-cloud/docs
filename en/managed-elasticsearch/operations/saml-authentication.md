---
title: "How to set up SAML authentication"
description: "This guide describes how you can set up SAML authentication."
---

# Configuring SAML authentication

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

Security Assertion Markup Language (SAML) is used for exchanging authentication and authorization data between two parties. With SAML, you can implement a single sign-on system (SSO) to switch between applications without re-authentication.

When using SAML and SSO, a {{ mes-name }} cluster gets information from an identity provider (IdP).

For more information about SAML and SSO, see the [OASIS documentation](https://wiki.oasis-open.org/security/saml/).

{{ mes-name }} works with any SAML 2.0 compatible identity provider.

{% note warning %}

SSO is supported by {{ mes-name }} clusters in the **Platinum** edition with public access enabled for all hosts with the _Data node_ role. If you [downgrade the {{ ES }} edition](./cluster-version-update.md#start-edition-update), the SSO feature is disabled.

{% endnote %}

To set up SAML authentication:
1. [Configure an identity provider](#configuration-idp).
1. [Set up a {{ mes-name }} cluster](#configuration-sso) to use this IdP for SSO.
1. [Configure cluster roles](#roles-sso) for SSO users on the IdP side.

## Configure an identity provider {#configuration-idp}

1. Create an application on the IdP side.
1. Specify the **Assertion Consumer Service (ACS) URL**.

   Use the URL with a [special cluster FQDN](cluster-connect.md#automatic-host-selection):

   ```
   https://c-<{{ ES }} cluster ID>.rw.{{ dns-zone }}/api/security/saml/callback
   ```

   The cluster ID can be requested with a [list of clusters in the folder](cluster-list.md#list-clusters).

   **Example:** `https://c-e4ut2....rw.{{ dns-zone }}/api/security/saml/callback`

1. Specify the **SP Entity ID (Audience URI)**.

   Use the URL with a [special cluster FQDN](cluster-connect.md#automatic-host-selection):

   ```
   https://c-<cluster ID>rw.{{ dns-zone }}
   ```

   **Example:** `https://c-e4ut2....rw.{{ dns-zone }}`

1. Specify the **Name ID Format**: `Persistent`.
1. Using the data provided by the IdP:
   * Copy the information about the Identity Provider Issuer.
   * Save the provider's metadata file in XML format.

   You will need it to set up SSO for your cluster.

## Set up SSO for the cluster {#configuration-sso}

{% note warning %}

Incorrect settings may cause the cluster to fail.

{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.elasticsearch.auth.auth-providers }}** tab.
   1. Click **{{ ui-key.yacloud.common.create }}**.
   1. Create an authentication provider:
      * **{{ ui-key.yacloud.elasticsearch.auth.provider-type }}**: `SAML`.

      * **{{ ui-key.yacloud.common.name }}**: Provider name.

      * **{{ ui-key.yacloud.common.description }}**: Provider description.

      * **{{ ui-key.yacloud.elasticsearch.auth.provider-hint }}**: Login hint.

      * **{{ ui-key.yacloud.elasticsearch.auth.provider-icon }}**: Provider icon.

      * Select **{{ ui-key.yacloud.elasticsearch.auth.provider-enabled }}**.

      * **{{ ui-key.yacloud.elasticsearch.auth.saml_settings }}**:

         * **{{ ui-key.yacloud.elasticsearch.auth.saml-idp_entity_id }}**: Information about the Identity Provider Issuer obtained when [configuring the IdP](#configuration-idp).

         * **{{ ui-key.yacloud.elasticsearch.auth.saml-idp_metadata_file }}**: Provider's metadata file in XML format obtained when [configuring the IdP](#configuration-idp).

         * **{{ ui-key.yacloud.elasticsearch.auth.saml-sp_entity_id }}**: Application-defined SP Entity ID (Audience URI). Make sure it is the same as the ID specified when [configuring the IdP](#configuration-idp).

         * **{{ ui-key.yacloud.elasticsearch.auth.saml-kibana_url }}**: URL with a [special cluster FQDN](cluster-connect.md#automatic-host-selection). Same as the **{{ ui-key.yacloud.elasticsearch.auth.saml-sp_entity_id }}**.

         * **{{ ui-key.yacloud.elasticsearch.auth.saml-attribute_principal }}**: Format of the `nameid` parameter, such as `nameid:persistent`. Same as the **Name ID Format** of the IdP.

         * **{{ ui-key.yacloud.elasticsearch.auth.saml-attribute_groups }}**: User privileges groups (recommended).

         * **{{ ui-key.yacloud.elasticsearch.auth.saml-attribute_name }}**: Username (optional).

         * **{{ ui-key.yacloud.elasticsearch.auth.saml-attribute_email }}**: User's email address (optional).

         * **{{ ui-key.yacloud.elasticsearch.auth.saml-attribute_dn }}**: ID of the `X.500 Distinguished Name` user (optional).

   1. Click **{{ ui-key.yacloud.common.create }}**.

- API

   1. Convert the metadata file received from the Identity Provider Issuer to Base64 format.
   1. To set identity provider settings on the cluster side, use the [addProviders](../api-ref/Auth/addProviders.md) REST API method for the [Auth](../api-ref/Auth/index.md) resource or the [AuthService/AddProviders](../api-ref/grpc/auth_service.md#AddProviders) gRPC API call and provide the following in the request:

      * Cluster ID in the `clusterId` parameter.

         {% include [get-cluster-id](../../_includes/managed-elasticsearch/get-cluster-id.md) %}

      * The `SAML` value, in the `type` parameter.
      * Provider name, in the `name` parameter.
      * The `true` value, in the `enabled` parameter.
      * Provider description, in the `description` parameter.
      * ID of the Identity Provider Issuer obtained when [configuring the IdP](#configuration-idp), in the `idpEntityId` parameter.
      * Path to the Base64 metadata file, in the `idpMetadataFile` parameter.
      * URI of the SP Entity ID (Audience URI) application, in the `spEntityId` parameter. Use the URI you specified when [configuring the IdP](#configuration-idp).
      * URL with a [special cluster FQDN](cluster-connect.md#automatic-host-selection), in the `kibanaUrl` parameter. Same as the `spEntityId`.
      * Format of `nameid` parameter, for example, `nameid:persistent`, in the `attributePrincipal` parameter. Same as the **Name ID Format** of the IdP.

{% endlist %}

{% note info %}

Learn more about SAML attributes in the [Elasticsearch documentation]({{ links.es.docs }}/elasticsearch/reference/6.8/saml-guide-authentication.html#saml-user-properties).

{% endnote %}

## Configure roles for SSO {#roles-sso}

To access the cluster via SSO, associate the cluster roles with the SSO users on the IdP side. To do this:

1. [Map the roles](https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-roles.html) of the {{ ES }} users on the IdP side to the roles in the cluster. Perform this operation as an [`admin` user](../concepts/index.md) in one of the following ways:
   * Using [Kibana](https://www.elastic.co/guide/en/kibana/current/role-mappings.html).
   * Using the [{{ ES }} Security API](https://www.elastic.co/guide/en/elasticsearch/reference/current/security-api-put-role-mapping.html).
1. On the IdP side, create a user that meets the role mappings defined in {{ ES }}.
1. Grant this user access to the [previously created application](#configuration-idp).

To log in to the {{ ES }} cluster using the new user's credentials, go to the **Kibana** page.

## Examples {#examples}

### Enabling SAML SSO with Okta {#example-okta}

To set up SSO with Okta for a cluster with the `c9qmc1lmo2k060fkj2nj` ID:
1. [Configure the Okta identity provider](#example-configuration-okta).
1. [Set up SSO for the {{ mes-name }} cluster](#example-configuration-sso).
1. [Configure roles for SSO with Okta](#example-roles-sso).

#### Configure the Okta identity provider {#example-configuration-okta}

1. Create a new application:
   * Select the **Applications** tab.
   * Click **Create App Integration**.
   * Select **SAML 2.0**.
   * Click **Next**.
1. Under **General Settings**, specify the application name in the **App name** parameter and click **Next**.
1. Under **SAML Settings**:
   * Specify the **Single sign on URL**:

      ```
      https://c-c9qmc1lmo2k060fkj2nj.rw.{{ dns-zone }}/api/security/saml/callback
      ```

   * Enable the **Use this for Recipient URL and Destination URL** option.
   * Specify the **Audience URI (SP Entity ID)**:

      ```
      https://c-c9qmc1lmo2k060fkj2nj.rw.{{ dns-zone }}
      ```

   * Specify the **Name ID Format**: `Persistent`.
   * Click **Next**.
1. Under **Feedback**:
   * Select **I'm an Okta customer adding an internal app** and **This is an internal app that we have created**.
   * Click **Finish**.
1. On the **Sign On** tab, click **View Setup Instructions**:
   * Copy the **Identity Provider Issuer**:

      ```
      http://www.okta.com/exkv2pzpvigX4c0bK5d6
      ```

   * Copy the **Provide the following IDP metadata to your SP provider** field value and save it to a file, such as `okta.xml`.

For more information about other parameters, see the [Okta documentation](https://help.okta.com/en/prod/Content/Topics/Apps/Apps_App_Integration_Wizard.htm).

#### Set up SSO for the cluster {#example-configuration-sso}

Let's assume we have an **{{ ui-key.yacloud.elasticsearch.auth.saml-idp_entity_id }}** like `http://www.okta.com/exkv2pzpvigX4c0bK5d6` provided after the IdP setup.

[Set up SSO for the cluster](#configuration-sso). When setting it up, specify:
* **{{ ui-key.yacloud.elasticsearch.auth.saml-idp_entity_id }}**: `http://www.okta.com/exkv2pzpvigX4c0bK5d6`.
* **{{ ui-key.yacloud.elasticsearch.auth.saml-idp_metadata_file }}**: Metadata file provided by Okta.
* **{{ ui-key.yacloud.elasticsearch.auth.saml-sp_entity_id }}**: `https://c-c9qmc1lmo2k060fkj2nj.rw.{{ dns-zone }}`.
* **{{ ui-key.yacloud.elasticsearch.auth.saml-kibana_url }}**: `https://c-c9qmc1lmo2k060fkj2nj.rw.{{ dns-zone }}`.
* **{{ ui-key.yacloud.elasticsearch.auth.saml-attribute_principal }}**: `nameid:persistent`.

#### Configure roles for SSO with Okta {#example-roles-sso}

To access the cluster via SSO, associate the cluster roles with the SSO users on the IdP side. To do this:

1. Configure roles for the {{ mes-name }} cluster:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.elasticsearch.label_kibana }}** tab.
   1. In the authorization window, specify the `admin` user and the password you set when configuring the cluster.
   1. Open **Management → Stack Management → Security → Role Mappings**.

      {% note info %}

      The **Role Mappings** function is available in the {{ ES }} `Platinum` edition.

      [Read more about updating the {{ ES }} edition](./cluster-version-update.md#start-edition-update).

      {% endnote %}

   1. Click **Create role mapping**.
   1. To create a [role mapping](#roles-sso), fill in the fields:
      * **Mapping name**: Unique role mapping name.
      * **Roles**: Selected role.
      * **Mapping rules**: Rules for mapping roles.

      For example, to set a rule that will map users with the `example.com` domain and the `editor` role:

      1. Select the `editor` role.
      1. Add the **All are true** rule.
      1. Add the `username` field with the `text` type and the `*@example.com` value to the rule.

{% endlist %}

1. Create a user on the Okta side:
   1. Open **Directory → People**
   1. Click **Add person**.
   1. Specify the user parameters: `First name`, `Last name`, `username`, and `password`.

      They must meet the role mapping rules set in {{ mes-name }}.

   1. Click **Save**.
1. Go to the **Applications** section.
1. Click **Assign User to App**.
1. [Assign the application](https://help.okta.com/en/prod/Content/Topics/users-groups-profiles/usgp-assign-apps.htm) to the appropriate user.
1. Click **Next**.
1. If necessary, edit the specified `username`. This will be the username displayed in **Kibana**.
1. Click **Confirm Assignments**.

To log in to the {{ mes-name }} cluster using the new user's credentials:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-elasticsearch }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.elasticsearch.label_kibana }}** tab.
   1. In the authorization window, select the option that you specified when [setting up SSO](#configuration-sso) in the **Provider description**.
   1. Specify **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** and **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**.

{% endlist %}
