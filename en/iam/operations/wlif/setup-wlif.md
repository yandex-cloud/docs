---
title: How to set up a workload identity federation in {{ iam-full-name }}
description: In this guide, you will learn how to set up workload identity federations in {{ iam-name }}.
---

# Setting up workload identity federations

{% include [move-groups-api](../../../_includes/iam/wlif-instructions-intro.md) %}

To set up authentication in the {{ yandex-cloud }} API via a workload identity federation:

1. [Prepare your cloud environment](#prepare-cloud).
1. [Create a workload identity federation](#create-wlif).
1. [Create federated credentials](#create-federated-credential).
1. [Exchange a JWT of an external subject for a service account IAM token](#exchange-jwt-for-iam).

For examples of setting up authentication for specific OIDC providers, see these tutorials:

* [GitHub](../../tutorials/wlif-github-integration.md).
* [{{ GL }}](../../tutorials/wlif-gitlab-integration.md).

## Prepare your cloud environment{#prepare-cloud}

{% include [before-you-begin](../../../_tutorials/_tutorials_includes/before-you-begin.md) %}

To set up a workload identity federation, you need a [service account](../../concepts/users/service-accounts.md). If you do not have a service account, [create](../sa/create.md) one.

## Create a workload identity federation {#create-wlif}

{% note info %}

To create a workload identity federation, the user needs the `iam.workloadIdentityFederations.editor` [role](../../security/index.md#iam-workloadIdentityFederations-editor) or higher for the folder.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a workload identity federation.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![cpus](../../../_assets/console-icons/cpus.svg) **{{ ui-key.yacloud.iam.label_federations }}**.
  1. Click **{{ ui-key.yacloud.iam.label_create-wli-federation }}** and in the form that opens, proceed as follows:
      1. In the **{{ ui-key.yacloud.iam.federations.field_issuer }}** field, enter the OIDC provider's URL.

          To get this value, refer to the OIDC provider's documentation or contact their support.
      1. In the **{{ ui-key.yacloud.iam.federations.field_audiences }}** field, specify the resource for which the token will be issued.

          To get this value, refer to the OIDC provider's documentation or contact their support.

          You can specify multiple resources to issue the IAM token for.
      1. In the **{{ ui-key.yacloud.iam.federations.field_jwks }}** field, specify the URL for retrieving the current public key issued by the OIDC provider and used for [JWT](https://en.wikipedia.org/wiki/JSON_Web_Token) signature verification.

          To get this value, refer to the OIDC provider's documentation or contact their support.
      1. In the **{{ ui-key.yacloud.iam.federations.field_name }}** field, enter a name for the new federation, e.g., `sample-iam-federation`.
      1. Click **{{ ui-key.yacloud_billing.iam.cloud.create.popup-create-cloud_button_add }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the command for creating a workload identity federation:

      ```bash
      yc iam workload-identity oidc federation create --help
      ```

  1. Create a workload identity federation in the default folder:

      ```bash
      yc iam workload-identity oidc federation create \
        --name <federation_name> \
        --issuer "<OIDC_provider_URL>" \
        --audiences "<resource_1>","<resource_2>",...,"<resource_n>" \
        --jwks-url "<JWKS_address>"
      ```

      Where:

      * `--name`: Name of the new federation, e.g., `sample-iam-federation`. The naming requirements are as follows:

          {% include [name-format](../../../_includes/name-format.md) %}
      * `--issuer`: URL of the OIDC provider.

          To get this value, refer to the OIDC provider's documentation or contact their support.
      * `--audiences`: Resources to issue the token for. You can specify multiple resources at once, separated by commas.

          To get this value, refer to the OIDC provider's documentation or contact their support.
      * `--jwks-url`: URL for retrieving the current public key issued by the OIDC provider and used for [JWT](https://en.wikipedia.org/wiki/JSON_Web_Token) signature verification.

          To get this value, refer to the OIDC provider's documentation or contact their support.

      Result:

      ```text
      id: aje2c4qv19lf********
      name: sample-iam-federation
      folder_id: b1gfq9pe6rd2********
      enabled: true
      audiences:
        - https://gitlab.example.ru
        - https://gitlab.example.com
      issuer: https://gitlab.com
      jwks_url: https://gitlab.com/oauth/discovery/keys
      created_at: "2024-12-28T16:04:31.530652473Z"
      ```

      Save the value of the new workload identity federation ID. You will need it to create federated credentials.

      For more information about the `yc iam workload-identity oidc federation create` command, see the [CLI reference](../../../cli/cli-ref/iam/cli-ref/workload-identity/oidc/federation/create.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. In the {{ TF }} configuration file, define the parameters of the federation you want to create:

      ```hcl
      resource "yandex_iam_workload_identity_oidc_federation" "wlif" {
        name        = "<federation_name>"
        folder_id   = "<folder_ID>"
        audiences   = ["<resource_1>","<resource_2>",...,"<resource_n>"]
        issuer      = "<OIDC_provider_URL>"
        jwks_url    = "<JWKS_address>"
      }
      ```

      Where:

      * `name`: Name of the new federation, e.g., `sample-iam-federation`. The naming requirements are as follows:

          {% include [name-format](../../../_includes/name-format.md) %}
      * `folder_id`: [ID](../../../resource-manager/operations/folder/get-id.md) of the folder to create the workload identity federation in.
      * `audiences`: Resources to issue the token for. You can specify multiple resources at once, separated by commas.

          To get this value, refer to the OIDC provider's documentation or contact their support.
      * `issuer`: URL of the OIDC provider.

          To get this value, refer to the OIDC provider's documentation or contact their support.
      * `jwks_url`: URL for retrieving the current public key issued by the OIDC provider and used for [JWT](https://en.wikipedia.org/wiki/JSON_Web_Token) signature verification.

          To get this value, refer to the OIDC provider's documentation or contact their support.

      For more information about the `yandex_iam_workload_identity_oidc_federation` resource parameters in {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/iam_workload_identity_oidc_federation).

  1. Create resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create a workload identity federation. You can check the new federation using the [management console]({{ link-console-main }}) or this CLI command:

     ```bash
     yc iam workload-identity oidc federation list
     ```

- API {#api}

  To create a workload identity federation, use the [create](../../workload/oidc/workload-identity/api-ref/Federation/create.md) REST API method for the [Federation](../../workload/oidc/workload-identity/api-ref/Federation/index.md) resource or the [FederationService/Create](../../workload/oidc/workload-identity/api-ref/grpc/Federation/create.md) gRPC API call.

{% endlist %}

## Create federated credentials {#create-federated-credential}

Federated credentials refer to the link established between a workload identity federation, a {{ yandex-cloud }} service account, and an external subject. Federated credentials are used to identify external subjects in {{ iam-full-name }}.

{% note info %}

To create federated credentials, the user needs the following:
* `iam.serviceAccounts.federatedCredentialEditor` [role](../../security/index.md#iam-serviceAccounts-federatedCredentialEditor) or higher for the service account that will be used in the federated credentials.
* `iam.workloadIdentityFederations.user` [role](../../security/index.md#iam-workloadIdentityFederations-user) or higher for the folder containing the workload identity federation.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the service account.
  
      [Create](../sa/create.md) a new service account if you need to.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Select the appropriate service account from the list.
  1. Go to the **{{ ui-key.yacloud.iam.label_federations }}** tab.
  1. Click **{{ ui-key.yacloud.iam.connected-federation.action_connect-federation }}**.
  1. In the **{{ ui-key.yacloud.iam.connected-federation.field_federation }}** field, select the federation you created earlier.
  1. In the **{{ ui-key.yacloud.iam.connected-federation.field_subject }}** field, specify the external subject ID.

      To get this value, refer to the OIDC provider's documentation or contact their support.
  1. Click **{{ ui-key.yacloud.iam.connected-federation.action_connect }}**.

- CLI {#cli}

  1. View the description of the command for creating federated credentials:

      ```bash
      yc iam workload-identity federated-credential create --help
      ```

  1. Create federated credentials, specifying the ID of the appropriate service account:

      ```bash
      yc iam workload-identity federated-credential create \
        --service-account-id <service_account_ID> \
        --federation-id <federation_ID> \
        --external-subject-id "<external_subject_ID>"
      ```

      Where:

      * `--service-account-id`: [ID](../sa/get-id.md) of the {{ yandex-cloud }} service account.

          The service account can reside in a folder other than the one containing the workload identity federation.
      * `--federation-id`: Workload identity federation ID obtained in the previous step.
      * `--external-subject-id`: External subject ID.

          To get this value, refer to the OIDC provider's documentation or contact their support.

      Result:

      ```text
      id: aje401v1sup8********
      service_account_id: ajek7v5j65cg********
      federation_id: aje2c4qv19lf********
      external_subject_id: project_path:root/test-iam-wlif:ref_type:branch:ref:master
      created_at: "2024-12-28T16:33:47.057632267Z"
      ```
            
      For more information about the `yc iam workload-identity federated-credential create` command, see the [CLI reference](../../../cli/cli-ref/iam/cli-ref/workload-identity/federated-credential/create.md).

- {{ TF }} {#tf}

  1. In the {{ TF }} configuration file, define the parameters of the federated credentials you want to create:

      ```hcl
      resource "yandex_iam_workload_identity_federated_credential" "fc" {
        service_account_id  = "<service_account_ID>"
        federation_id       = "<federation_ID>"
        external_subject_id = "<external_subject_ID>"
      }
      ```

      Where:

      * `service_account_id`: [ID](../sa/get-id.md) of the {{ yandex-cloud }} service account.

          The service account can reside in a folder other than the one containing the workload identity federation.
      * `federation_id`: Workload identity federation ID.
      * `external_subject_id`: External subject ID.

          To get this value, refer to the OIDC provider's documentation or contact their support.

      For more information about the `yandex_iam_workload_identity_federated_credential` resource parameters in {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/iam_workload_identity_federated_credential).

  1. Create resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create the specified federated credentials. You check the new service account federated credentials using the [management console]({{ link-console-main }}) or this CLI command:

     ```bash
     yc iam workload-identity federated-credential list \
       --service-account-id <service_account_ID>
     ```

- API {#api}

  To create federated credentials, use the [create](../../workload/workload-identity/api-ref/FederatedCredential/create.md) REST API method for the [FederatedCredential](../../workload/workload-identity/api-ref/FederatedCredential/index.md) resource or the [FederatedCredentialService/Create](../../workload/workload-identity/api-ref/grpc/FederatedCredential/create.md) gRPC API call.

{% endlist %}

## Exchange a JWT for a service account IAM token {#exchange-jwt-for-iam}

Send a request to the {{ yandex-cloud }} token exchange service:

```text
POST https://{{ auth-main-host }}/oauth/token HTTP/1.1
     Content-Type: application/x-www-form-urlencoded

     grant_type=urn:ietf:params:oauth:grant-type:token-exchange&
     requested_token_type=urn:ietf:params:oauth:token-type:access_token&
     audience=<service_account_ID>&
     subject_token=<JWT>&
     subject_token_type=urn:ietf:params:oauth:token-type:id_token
```

Where:

* `grant_type`: Request type, which is always `urn:ietf:params:oauth:grant-type:token-exchange`.
* `requested_token_type`: Requested token type, which is always `urn:ietf:params:oauth:token-type:access_token`.
* `audience`: [ID](../sa/get-id.md) of the {{ yandex-cloud }} service account.
* `subject_token`: External subject JWT.
* `subject_token_type`: External subject token type, which is always `urn:ietf:params:oauth:token-type:id_token`.

Result:

```text
HTTP/1.1 200 OK
Content-Type: application/json

{
    "access_token": "t1.9euelZqZlJyXlJGNno6JlIzGmsyUzO3rnpWazY6elMidm8-Nk8iPlZyZkJLl8_d_IUBE-e8AIgRS_d3z9z9QPUT57wAiBFL9zef1656Vmo2RyZqOm5KSj82KkZHNi5WL7_zN5_XrnpWaj46TnZvNksmNks2dj43MmJPv-MXrnpWajZHJmo6bkpKPzYqRkc2LlYu9656Vmp2PyJqYnprLk8aRxpqXzZbPteuGnNGWnpLRkI********************",
    "token_type": "Bearer",
    "expires_in": 43200
}
```

Where `access_token` is the requested service account IAM token you can use for authentication when working in the [{{ yandex-cloud }} API](../../../api-design-guide/index.yaml).

## See also {#see-also}

* [{#T}](../../concepts/workload-identity.md).
* [{#T}](../../tutorials/wlif-github-integration.md).
* [{#T}](../../tutorials/wlif-gitlab-integration.md).