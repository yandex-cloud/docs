# Configuring SAML authentication

Security Assertion Markup Language (SAML) is used for exchanging authentication and authorization data between two parties. With SAML, you can implement a single sign-on system (SSO) to switch between applications without re-authentication.

When using SAML and SSO, a {{ mos-name }} cluster gets information from an identity provider (IdP).

For more information about SAML and SSO, see the [OASIS documentation](https://wiki.oasis-open.org/security/saml/).

{{ mos-name }} works with any SAML 2.0 compatible identity provider.

To set up SAML authentication:
1. [Configure an identity provider](#configuration-idp).
1. [Set up a {{ mos-name }} cluster](#configuration-sso) to use this IdP for SSO.
1. [Configure cluster roles](#roles-sso) for SSO users on the IdP side.

## Configure an identity provider {#configuration-idp}

1. Create an application on the IdP side.
1. Specify the **Assertion Consumer Service (ACS) URL**.

   Use the URL with a [special cluster FQDN](connect.md#special-fqdns):

   ```
   https://c-<{{ OS }}_cluster_ID>.rw.{{ dns-zone }}/api/security/saml/callback
   ```

   You can request the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

   **Example:** `https://c-e4ut2....rw.{{ dns-zone }}/api/security/saml/callback`

1. Specify the **SP Entity ID (Audience URI)**.

   Use the URL with a [special cluster FQDN](connect.md#special-fqdns):

   ```
   https://c-<cluster_ID>rw.{{ dns-zone }}
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

   1. In the [management console]({{ link-console-main }}), go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.opensearch.auth.section_auth }}** tab.
   1. Click **{{ ui-key.yacloud.opensearch.auth.button_settings }}**.
   1. Specify the parameters of external authorization source:

      * **{{ ui-key.yacloud.opensearch.auth.field_idp-entity-id }}**: Information about the Identity Provider Issuer obtained when [configuring the IdP](#configuration-idp).

      * **idp_metadata_file**: Provider's metadata file in XML format obtained when [configuring the IdP](#configuration-idp).

      * **{{ ui-key.yacloud.opensearch.auth.field_sp-entity-id }}**: Application-defined SP Entity ID (Audience URI). Make sure it is the same as the ID specified when [configuring the IdP](#configuration-idp).

      * **{{ ui-key.yacloud.opensearch.auth.field_dashboards-url }}**: URL with a [special cluster FQDN](./connect.md#special-fqdns), same as the **{{ ui-key.yacloud.opensearch.auth.field_sp-entity-id }}**.

      * **{{ ui-key.yacloud.opensearch.auth.field_roles-key }}**: SAML response parameter that stores the roles. If omitted, no roles are used.

      * **{{ ui-key.yacloud.opensearch.auth.field_subject-key }}**: The SAML response parameter that stores the subject. If omitted, the `NameID` parameter is used.

      * **{{ ui-key.yacloud.opensearch.auth.field_enabled }}**: Shows whether to activate an authorization source after creating it.

   1. Click **{{ ui-key.yacloud.opensearch.auth.button_save }}**.

- API

   1. Convert the metadata file received from the Identity Provider Issuer to Base64 format.
   1. To set identity provider settings on the cluster side, use the [updateAuthSettings](../api-ref/Cluster/updateAuthSettings.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/UpdateAuthSettings](../api-ref/grpc/cluster_service.md#UpdateAuthSettings) gRPC API call, and provide the following in the request:

      * Cluster ID in the `clusterId` parameter.

         {% include [get-cluster-id](../../_includes/managed-opensearch/get-cluster-id.md) %}

      * `True` value, in the `enabled` parameter.
      * ID of the Identity Provider Issuer obtained when [configuring the IdP](#configuration-idp), in the `idpEntityId` parameter.
      * Path to the Base64 metadata file, in the `idpMetadataFile` parameter.
      * URI of the SP Entity ID (Audience URI) application, in the `spEntityId` parameter. Use the URI you specified when [configuring the IdP](#configuration-idp).
      * URL of the {{ OS }} host with the `DASHBOARDS` role, in the `dashboardsUrl` parameter.
      * (Optional) SAML response parameter that stores the roles, in the `rolesKey` parameter.
      * (Optional) SAML response parameter that stores the subject, in the `subjectKey` parameter.

{% endlist %}

{% note info %}

For more information about SAML attributes, see the [{{ OS }} documentation]({{ os.docs }}/security/authentication-backends/saml/).

{% endnote %}

## Configure roles for SSO {#roles-sso}

To access the cluster via SSO, associate the cluster roles with the SSO users on the IdP side. To do this:

1. [Map the roles](https://opensearch.org/docs/latest/security/access-control/users-roles/) of the {{ OS }} users on the IdP side to the roles in the cluster. Perform this operation as an [`admin` user](../concepts/index.md) in one of the following ways:
   * Using [OpenSearch Dashboards](https://opensearch.org/docs/latest/security/access-control/users-roles/#opensearch-dashboards-2).
   * Using the [{{ OS }} API](https://opensearch.org/docs/latest/security/access-control/api/#create-role-mapping).
1. On the IdP side, create a user that meets the role mappings defined in {{ OS }}.
1. Grant this user access to the [previously created application](#configuration-idp).

To log in to {{ OS }} using the new user's credentials, go to the **{{ ui-key.yacloud.opensearch.title_opensearch-dashboards-section }}** page.
