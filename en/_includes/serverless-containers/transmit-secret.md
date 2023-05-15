To provide the container with access to the secret, specify a [service account](../../iam/concepts/users/service-accounts.md) with the following roles in the container parameters:
* `lockbox.payloadViewer` for the secret (see [how to grant access rights to secrets](../../lockbox/operations/secret-access.md)).
* `kms.keys.encrypterDecrypter` for the encryption key if the secret was created using a {{ kms-full-name }} key (see [how to grant access rights to encryption keys](../../kms/operations/key-access.md)).

A new revision of a container is created when {{ lockbox-name }} secrets are transmitted. You cannot transmit secrets to an existing revision.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with your container.
   1. Open **{{ serverless-containers-name }}**.
   1. Select a container you want to transmit a secret to.
   1. Go to the **Editor** tab.
   1. In the window that opens, under **Image parameters**, in the **{{ lockbox-name }} secret** field, specify:
      * Name of the environment variable where the secret will be kept.
      * Secret ID.
      * Secret version ID.
      * Non-secret key ID.
   1. Click **Add**. You can transmit several secrets to a container.
   1. Click **Create revision**. A new container revision with the specified secrets will be created.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To transmit {{ lockbox-name }} secrets to a container, run this command:

   {% note warning %}

   If the secrets were already sent to the previous revision, they will be overwritten.

   {% endnote %}

   ```
   yc serverless container revision deploy \
      --container-name test \
      --image {{ registry }}/crpp35**************/repository:tag \
      --cores 1 \
      --memory 1GB \
      --service-account-id bfbtfc************** \
      --secret environment-variable=KEY,id=fc3q4a**************,version-id=fc3gvv**************,key=key-id
   ```

   Where:

   * `--container-name`: Container name.
   * `--image`: URL of a Docker image.
   * `--cores`: Number of cores available for the container.
   * `--memory`: Required memory. The default value is 128 MB.
   * `--service-account-id`: ID of a service account with the `lockbox.payloadViewer` role.
   * `--secret`:
      * `environment-variable`: Name of the environment variable where the secret will be kept.
      * `id`: Secret ID.
      * `version-id`: Secret version ID.
      * `key`: Non-secret key ID.

- API

   To transmit a {{ lockbox-name }} secret to a container, use the [deployRevision](../../serverless-containers/containers/api-ref/Container/deployRevision.md) REST API method for the [Container](../../serverless-containers/containers/api-ref/Container/index.md) resource or the [ContainerService/DeployRevision](../../serverless-containers/containers/api-ref/grpc/container_service.md#DeployRevision) gRPC API call.

{% endlist %}