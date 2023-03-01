# Transmitting Yandex Lockbox secrets to a container

{% include [note-preview-pp](../../_includes/note-preview-pp.md) %}

[{{ lockbox-name }}](../../lockbox/) is a service for storing secrets. You can transmit a {{ lockbox-name }} secret to a container in the [environment variable](../concepts/runtime.md#environment-variables).

A container can access the secret when a service account with the `lockbox.payloadViewer` role is specified in the container parameters. [How to create a service account](../../iam/operations/sa/create.md).

A new revision of a container is created when {{ lockbox-name }} secrets are transmitted. You cannot transmit secrets to an existing revision.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with your container.
   1. Open **{{ serverless-containers-name }}**.
   1. Select a container you want to transmit a secret to.
   1. Go to the **Editor** tab.
   1. In the window that opens, under **Image parameters**, in the **{{ lockbox-name }} secret** field, specify:
      * The name of the environment variable where the secret will be kept.
      * Secret ID.
      * Secret version ID.
      * Non-secret key ID.
   1. Click **Add**. You can transmit several secrets to a container.
   1. Click **Create revision**. A new container revision with the specified secrets will be created.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To transmit {{ lockbox-name }} secrets to a container, run the command:

   {% note warning %}

   If the secrets were already passed to the previous revision, they are overwritten.

   {% endnote %}

   ```
   yc serverless container revision deploy \
      --container-name test \
      --image cr.yandex/crpp35**************/repository:tag \
      --cores 1 \
      --memory 1GB \
      --service-account-id bfbtfc************** \
      --secret environment-variable=KEY,id=fc3q4a**************,version-id=fc3gvv**************,key=key-id
   ```

   Where:

   * `--container-name`: Container name.
   * `--image`: URL of a Docker image.
   * `--cores`: Number of cores available for the container.
   * `--memory`: Required memory. The default is 128 MB.
   * `--service-account-id`: ID of a service account with the `lockbox.payloadViewer` role.
   * `--secret`:
      * `environment-variable`: Name of the environment variable where the secret will be kept.
      * `id`: Secret ID.
      * `version-id`: Secret version ID.
      * `key`: Non-secret key ID.

- API

   To transmit a {{ lockbox-name }} secret to a container, use the [deployRevision](../containers/api-ref/Container/deployRevision.md) API method.

{% endlist %}