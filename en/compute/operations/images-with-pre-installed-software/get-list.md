# Getting a list of public images

When creating a VM, you need to select its image with the software that you want to use.

{% list tabs %}

- Management console

  To get a list of available images:

  1. In the [management console]({{ link-console-main }}), open the folder where the VM will be created.
  1. Click **Create resource**.
  1. Select **Virtual machine**.
  1. Under **Image/boot disk selection**, go to the **{{ marketplace-name }}** tab.
  1. Click **Show more**. A list of all public images will be shown.

- CLI

  {% include [standard-images](../../../_includes/standard-images.md) %}

- API

  1. Get an [IAM token](../../../iam/concepts/authorization/iam-token.md) for authenticating in the examples:
     * [Instructions](../../../iam/operations/iam-token/create.md) for users with a Yandex account.
     * [Instructions](../../../iam/operations/iam-token/create-for-sa.md) for a service account.
  1. Get a list of public images from {{ yandex-cloud }} using the [List](../../api-ref/Image/list.md) method for the `Image` resource. In the request, specify the following parameters:
     * Specify `standard-images` as the folder ID.
     * The folder contains many images, so specify `pageSize=1000` or use the obtained value of `nextPageToken` to get the next page.

    Write the result to a file, for example `output.json`:

    ```bash
    export IAM_TOKEN=CggaATEVAgA...
    curl -H "Authorization: Bearer ${IAM_TOKEN}" "https://compute.api.cloud.yandex.net/compute/v1/images?folderId=standard-images&pageSize=1000" > output.json
    ```

{% endlist %}
