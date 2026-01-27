# Configuring SAML authentication

The Security Assertion Markup Language (SAML) is used for transferring authentication and authorization data between two parties. With SAML, you can implement a single sign-on system (SSO) to switch between applications without re-authentication.

When using SAML and SSO, a {{ mos-name }} cluster gets information from an identity provider (IdP). For more information about SAML and SSO, see [this OASIS guide](https://wiki.oasis-open.org/security/saml/).

{{ mos-name }} works with any SAML 2.0-compatible identity provider.

To set up SAML authentication:
1. [Configure an identity provider](#configuration-idp).
1. [Set up a {{ mos-name }} cluster](#configuration-sso) to use this IdP for SSO.
1. [Configure cluster roles](#roles-sso) for SSO users on the IdP side.

## Configuring an identity provider {#configuration-idp}

1. Create an application on the IdP side.
1. Specify the **Assertion Consumer Service (ACS) URL**.

    Use this URL with a [special cluster FQDN](connect.md#special-fqdns):

    ```text
    https://c-<{{ OS }}_cluster_ID>.rw.{{ dns-zone }}/_opendistro/_security/saml/acs
    ```

    You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    URL example: `https://c-e4ut2....rw.{{ dns-zone }}/_opendistro/_security/saml/acs`

1. Specify the **SP Entity ID (Audience URI)**.

    Use this URL with a [special cluster FQDN](connect.md#special-fqdns):

    ```text
    https://c-<cluster_ID>rw.{{ dns-zone }}/
    ```

    URL example: `https://c-e4ut2....rw.{{ dns-zone }}/`

1. Specify the **Name ID Format**:

    * `email`, if you use [an identity federation with the Keycloak provider](../../organization/tutorials/federations/integration-keycloak.md).
    * `persistent`, for other providers.

1. Get the data you need to set up SAML SSO on {{ OS }} side:
    * Copy the information about the identity provider issuer.
    * Save the provider metadata file in XML format.

    You will need it to set up SSO for your cluster.

## Setting up SSO for the cluster {#configuration-sso}

{% note warning %}

Incorrect settings may cause the cluster to fail.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder page.
    1. [Navigate to](../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}** service.
    1. Click the name of your cluster and select the **{{ ui-key.yacloud.opensearch.auth.section_auth }}** tab.
    1. Click **{{ ui-key.yacloud.opensearch.auth.button_settings }}**.
    1. Specify the parameters of your external authentication source:

        * **{{ ui-key.yacloud.opensearch.auth.field_idp-entity-id }}**: Information about the identity provider issuer obtained when [configuring the IdP](#configuration-idp).

        * **idp_metadata_file**: Provider metadata file in XML format obtained when [configuring the IdP](#configuration-idp).

        * **{{ ui-key.yacloud.opensearch.auth.field_sp-entity-id }}**: Application-defined SP Entity ID (Audience URI). Make sure it matches the ID specified when [configuring the IdP](#configuration-idp).

        * **{{ ui-key.yacloud.opensearch.auth.field_dashboards-url }}**: URL with a [special cluster FQDN](./connect.md#special-fqdns), same as **{{ ui-key.yacloud.opensearch.auth.field_sp-entity-id }}**.

        * **{{ ui-key.yacloud.opensearch.auth.field_roles-key }}**: Name of the SAML response parameter that stores the roles. The SAML response comes from the identity provider. Skipping this parameter disables the use of roles.

        * **{{ ui-key.yacloud.opensearch.auth.field_subject-key }}**: Name of the SAML response parameter that stores the subject. The SAML response comes from the identity provider. If it is not specified, the `NameID` parameter is used.

        * **{{ ui-key.yacloud.opensearch.auth.field_jwt-default-expiration-timeout }}**: Session lifetime, in minutes. Specify it if it is not set by the identity provider.

            If there is no value or `0`, the session lifetime is unlimited (default).

        * **{{ ui-key.yacloud.opensearch.auth.field_enabled }}**: Sets whether to activate an authentication source after creating it.

    1. Click **{{ ui-key.yacloud.opensearch.auth.button_save }}**.

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Call the [Cluster.UpdateAuthSettings](../api-ref/Cluster/updateAuthSettings.md) method, e.g., via the following {{ api-examples.rest.tool }} request:

        ```bash
        curl \
            --request PUT \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>/auth' \
            --data '{
                        "settings": {
                            "saml": {
                                "enabled": "<enable_SSO>",
                                "idpEntityId": "<IdP_issuer_ID>",
                                "idpMetadataFile": "<metadata_file>",
                                "spEntityId": "<SP_Entity_ID_app_URI>",
                                "dashboardsUrl": "<Dashboards_host_URL>",
                                "rolesKey": "<parameter_with_roles_in_SAML_response>",
                                "subjectKey": "<parameter_with_subject_in_SAML_response>",
                                "jwtDefaultExpirationTimeout": "<session_lifetime>"
                            }
                        }
                    }'
        ```

        Where `settings` is a set of SSO settings that contain the `saml` section with the following parameters:

        * `enabled`: Enable SSO, `true` or `false`.
        * `idpEntityId`: ID of the identity provider issuer obtained when [configuring the IdP](#configuration-idp).
        * `idpMetadataFile`: Path to the Base64 metadata file.
        * `spEntityId`: SP Entity ID (Audience URI) of your application. Make sure it matches the URI you specified when [configuring the IdP](#configuration-idp).
        * `dashboardsUrl`: URL of the host with the `DASHBOARDS` role.
        * `rolesKey`: Name of the SAML response parameter that stores the roles. The SAML response comes from the identity provider. Skipping this parameter disables the use of roles.
        * `subjectKey`: Name of the SAML response parameter that stores the subject. The SAML response comes from the identity provider. If it is not specified, the `NameID` parameter is used.
        * `jwtDefaultExpirationTimeout`: Session lifetime, in minutes. Specify it if it is not set by the identity provider.

            If there is no value or `0`, the session lifetime is unlimited (default).

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. Check the [server response](../api-ref/Cluster/updateAuthSettings.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Call the [ClusterService.UpdateAuthSettings](../api-ref/grpc/Cluster/updateAuthSettings.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "settings": {
                    "saml": {
                        "enabled": "<enable_SSO>",
                        "idp_entity_id": "<IdP_issuer_ID>",
                        "idp_metadata_file": "<metadata_file>",
                        "sp_entity_id": "<SP_Entity_ID_app_URI>",
                        "dashboards_url": "<Dashboards_host_URL>",
                        "roles_key": "<parameter_with_roles_in_SAML_response>",
                        "subject_key": "<parameter_with_subject_in_SAML_response>",
                        "jwt_default_expiration_timeout": "<session_lifetime>"
                    }
                }
            }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.opensearch.v1.ClusterService.UpdateAuthSettings
        ```

        Where `settings` is a set of SSO settings that contain the `saml` section with the following parameters:

        * `enabled`: Enable SSO, `true` or `false`.
        * `idp_entity_id`: ID of the identity provider issuer obtained when [configuring the IdP](#configuration-idp).
        * `idp_metadata_file`: Path to the Base64 metadata file.
        * `sp_entity_id`: SP Entity ID (Audience URI) of your application. Make sure it matches the URI you specified when [configuring the IdP](#configuration-idp).
        * `dashboards_url`: URL of the host with the `DASHBOARDS` role.
        * `roles_key`: Name of the SAML response parameter that stores the roles. The SAML response comes from the identity provider. Skipping this parameter disables the use of roles.
        * `subject_key`: Name of the SAML response parameter that stores the subject. The SAML response comes from the identity provider. If it is not specified, the `NameID` parameter is used.
        * `jwt_default_expiration_timeout`: Session lifetime, in minutes. Specify it if it is not set by the identity provider.

            If there is no value or `0`, the session lifetime is unlimited (default).

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/updateAuthSettings.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% note info %}

For more information about SAML attributes, see [this {{ OS }} guide]({{ os.docs }}/security/authentication-backends/saml/).

{% endnote %}

## Configuring roles for SSO {#roles-sso}

To access the cluster via SSO, associate the cluster roles with the SSO users on the IdP side:

1. [Map the roles](https://opensearch.org/docs/latest/security/access-control/users-roles/) of the {{ OS }} users on the IdP side to the roles in the cluster. Perform this operation as [`admin`](../concepts/index.md) in one of the following ways:
    * Using [OpenSearch Dashboards](https://opensearch.org/docs/latest/security/access-control/users-roles/#opensearch-dashboards-2).
    * Using the [{{ OS }} API](https://opensearch.org/docs/latest/security/access-control/api/#create-role-mapping).
1. On the IdP side, create a user that meets the role mappings defined in {{ OS }}.
1. Grant this user access to the [previously created application](#configuration-idp).

To log in to {{ OS }} using the new user's credentials, go to the **OpenSearch Dashboards** page.

## Examples of integration with providers {#examples}

[{#T}](../tutorials/saml-keycloak.md).
