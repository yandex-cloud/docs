For a container to get access to a [secret](../../lockbox/concepts/secret.md), edit its settings to specify a [service account](../../iam/concepts/users/service-accounts.md) with the following roles assigned:
* `lockbox.payloadViewer` for the secret (learn how to assign access permissions for a secret [here](../../lockbox/operations/secret-access.md)).
* `kms.keys.encrypterDecrypter` for the encryption key if the secret was created using a {{ kms-full-name }} key (learn how to assign access permissions for an encryption key [here](../../kms/operations/key-access.md)).

A {{ lockbox-short-name }} secret provided to a container is cached in {{ serverless-containers-name }}. After the service account loses access to the secret, the container may retain it for up to five minutes.

Providing {{ lockbox-name }} secrets creates a new container revision. You cannot provide secrets to an existing revision.

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder with your container.
    1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. Select a container you want to provide a secret to.
    1. Navigate to the **{{ ui-key.yacloud.serverless-containers.label_editor }}** tab.
    1. In the window that opens, under **{{ ui-key.yacloud.serverless-containers.section_image }}**, specify the following in the **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret }}** field:
        * Name of the environment variable to store the secret.
        * Secret ID.
        * Secret version ID.
        * Key of a key-value pair in the secret version.
    1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_add-environment-variable }}**.

        You can provide multiple secrets to a container. To do this, click **{{ ui-key.yacloud.serverless-functions.item.editor.button_add-environment-variable }}**.

    1. Click **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**. This will create a new container revision with the specified secrets.
    
- CLI {#cli}

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    To provide {{ lockbox-name }} secrets to a container, run this command:

    {% note warning %}

    If secrets were already provided to the previous revision, they will be overwritten.

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
        * `key`: Key of a key-value pairs in the secret version.
      
      You can provide multiple secrets to a container. To do this, specify `--secret` as many times as needed.

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
          * `secrets`: Section with secret configuration. It contains the following settings:
            * `id`: Secret ID. This is a required setting.
            * `version_id`: Secret version ID. This is a required setting.
            * `key`: Key of a secret version’s key-value pair that will be stored in the environment variable. This is a required setting.
            * `environment_variable`: Name of the environment variable that will store the secret. This is a required setting.
        
        For more information about `yandex_serverless_container` properties, see [this provider guide]({{ tf-provider-resources-link }}/serverless_container).
 
    1. Apply the changes:

        {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

    You can check the function update and its settings in the [management console]({{ link-console-main }}).

- API {#api}

  To provide a {{ lockbox-name }} secret to a container, use the [deployRevision](../../serverless-containers/containers/api-ref/Container/deployRevision.md) REST API method for the [Container](../../serverless-containers/containers/api-ref/Container/index.md) resource or the [ContainerService/DeployRevision](../../serverless-containers/containers/api-ref/grpc/Container/deployRevision.md) gRPC API call.

{% endlist %}