To provide the container with access to the [secret](../../lockbox/concepts/secret.md), specify a [service account](../../iam/concepts/users/service-accounts.md) with the following roles in the container parameters:
* `lockbox.payloadViewer` for the secret (see [how to grant access rights to secrets](../../lockbox/operations/secret-access.md)).
* `kms.keys.encrypterDecrypter` for the encryption key if the secret was created using a {{ kms-full-name }} key (see [how to grant access rights to encryption keys](../../kms/operations/key-access.md)).

A {{ lockbox-short-name }} secret transmitted to a container is cached in {{ serverless-containers-name }}. As soon as the service account can no longer access the secret, the container may store it for up to 5 minutes.

A new revision of a container is created when {{ lockbox-name }} secrets are transmitted. You cannot transmit secrets to an existing revision.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder with your container.
   1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
   1. Select a container you want to transmit a secret to.
   1. Go to the **{{ ui-key.yacloud.serverless-containers.label_editor }}** tab.
   1. In the window that opens, under **{{ ui-key.yacloud.serverless-containers.section_image }}**, in the **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret }}** field, specify:
      * Name of the environment variable to store the secret.
      * Secret ID.
      * Secret version ID.
      * Key of one of the key-value pairs contained in the secret version.
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

   ```
   yc serverless container revision deploy \
      --container-name test \
      --image {{ registry }}/crpp35a1s2d3********/repository:tag \
      --cores 1 \
      --memory 1GB \
      --service-account-id bfbtfcp0o9i8******** \
      --secret environment-variable=KEY,id=fc3q4aq3w5e6********,version-id=fc3gvvz4x5c6********,key=secret-key
   ```

   Where:

   * `--container-name`: Container name.
   * `--image`: URL of a Docker image.
   * `--cores`: Number of cores available for the container.
   * `--memory`: Required memory. The default value is 128 MB.
   * `--service-account-id`: ID of a service account with the `lockbox.payloadViewer` role.
   * `--secret`:
      * `environment-variable`: Name of the environment variable to store the secret.
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
        memory             = <memory_size>
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
         * `key`: Key of one of the key-value pairs contained in the version of the secret to be stored in the environment variable. This is a required parameter.
         * `environment_variable`: Name of the environment variable that will store the secret. This is a required parameter.

      For more information about the `yandex_serverless_container` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/serverless_container).

   1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

   You can check the function update and its configuration in the [management console]({{ link-console-main }}).

- API {#api}

   To transmit a {{ lockbox-name }} secret to a container, use the [deployRevision](../../serverless-containers/containers/api-ref/Container/deployRevision.md) REST API method for the [Container](../../serverless-containers/containers/api-ref/Container/index.md) resource or the [ContainerService/DeployRevision](../../serverless-containers/containers/api-ref/grpc/container_service.md#DeployRevision) gRPC API call.

{% endlist %}