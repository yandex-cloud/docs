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
      * `key`: Key of one of the key-value pairs contained in the secret version.

      You can transmit multiple secrets to a container. To do this, specify the `--secret` parameter as many times as needed.

- API {#api}

   To transmit a {{ lockbox-name }} secret to a container, use the [deployRevision](../../serverless-containers/containers/api-ref/Container/deployRevision.md) REST API method for the [Container](../../serverless-containers/containers/api-ref/Container/index.md) resource or the [ContainerService/DeployRevision](../../serverless-containers/containers/api-ref/grpc/container_service.md#DeployRevision) gRPC API call.

{% endlist %}