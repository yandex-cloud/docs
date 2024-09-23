To provide the container with access to the [secret](../../lockbox/concepts/secret.md), specify a [service account](../../iam/concepts/users/service-accounts.md) with the following roles in the container parameters:
* `lockbox.payloadViewer` to access the secret (see [Granting permissions to access a secret](../../lockbox/operations/secret-access.md)).
* `kms.keys.encrypterDecrypter` to access the encryption key if the secret was created using a {{ kms-full-name }} key (see [Granting permissions to access an encryption key](../../kms/operations/key-access.md)).

A {{ lockbox-short-name }} secret transmitted to a container is cached in {{ serverless-containers-name }}. As soon as the service account can no longer access the secret, the container may store it for up to 5 minutes.

A new revision of a container is created when {{ lockbox-name }} secrets are transmitted. You cannot transmit secrets to an existing revision.

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), go to the folder with your container.
    1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. Select a container you want to transmit a secret to.
    1. Go to the **{{ ui-key.yacloud.serverless-containers.label_editor }}** tab.
    1. In the window that opens, under **{{ ui-key.yacloud.serverless-containers.section_image }}**, in the **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret }}** field, specify:
        * Name of the environment variable to store the secret.
        * Secret ID.
        * Secret version ID.
        * Key of one of the key-value pairs in the secret version.
    1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_add-environment-variable }}**.

        You can transmit multiple secrets to a container. To do this, click **{{ ui-key.yacloud.serverless-functions.item.editor.button_add-environment-variable }}**.

    1. Click **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**. A new container revision with the specified secrets will be created.
    
- CLI {#cli}

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    To transmit {{ lockbox-name }} secrets to a container, run this command:

    {% note warning %}

    If the secrets were already sent to the previous revision, they will be overwritten.

    {% endnote %}

    ```bash
    yc serverless container revision deploy \
       --container-name test \
       --image {{ registry }}/<registry_ID>/repository:tag \
       --cores 1 \
       --memory 1GB \
       --service-account-id <service_account_ID> \
       --secret environment-variable=<environment_variable_name>,id=<secret_ID>,version-id=<secret_version_ID>,key=<secret_key>
    ```

    Where:

    * `--container-name`: Container name.
    * `--image`: Docker image URL.
    * `--cores`: Number of cores available to the container.
    * `--memory`: Required memory. The default value is 128 MB.
    * `--service-account-id`: ID of the service account with the `lockbox.payloadViewer` role.
    * `--secret`:
        * `environment-variable`: Name of the environment variable that will store the secret.
        * `id`: Secret ID.
        * `version-id`: Secret version ID.
        * `key`: Key of one of the key-value pairs in the secret version.
      
      You can transmit multiple secrets to a container. To do this, specify the `--secret` parameter as many times as needed.

- {{ TF }} {#tf}

    {% include [terraform-install](../../_includes/terraform-install.md) %}

    1. Open the {{ TF }} configuration file and add the `secrets` section to the function description:

        ```hcl
        resource "yandex_serverless_container" "test-container" {
          name               = "<container_name>"
          memory             = <memory_amount>
          service_account_id = "<service_account_ID>"
          secrets {
            id                   = "<secret_ID>"
            version_id           = "secret_version_ID>"
            key                  = "<secret_1_key>"
            environment_variable = "<environment_variable_1_name>"
          }
          secrets {
            id                   = "<secret_ID>"
            version_id           = "<secret_version_ID>"
            key                  = "<secret_2_key>"
            environment_variable = "<environment_variable_2_name>"
          }
          image {
            url = "<Docker_image_URL>"
          }
        }
        ```

        Where:
          * `secrets`: Section with secret settings. It contains the following parameters:
            * `id`: Secret ID. This is a required parameter.
            * `version_id`: Secret version ID. This is a required parameter.
            * `key`: Key of one of the secret version's key-value pairs that will be stored in the environment variable. This is a required parameter.
            * `environment_variable`: Name of the environment variable that will store the secret. This is a required parameter.
        
        For more information about the `yandex_serverless_container` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/serverless_container).
 
    1. Apply the changes:

        {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

    You can check the function update and configuration in the [management console]({{ link-console-main }}).

- API {#api}

  To transmit a {{ lockbox-name }} secret to a container, use the [deployRevision](../../serverless-containers/containers/api-ref/Container/deployRevision.md) REST API method for the [Container](../../serverless-containers/containers/api-ref/Container/index.md) resource or the [ContainerService/DeployRevision](../../serverless-containers/containers/api-ref/grpc/container_service.md#deployRevision) gRPC API call.

{% endlist %}