---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Getting a list of public images

When creating a VM, you need to select its image with the software that you want to use.

{% list tabs %}

- Management console

  To get a list of available images:
  1. Open the folder where the VM will be created.
  1. Click **Create resource**.
  1. Select **Virtual machine**.
  1. Under **Images from {{ marketplace-name }}**, click **Select**.

- CLI

  {% include [standard-images](../../../_includes/standard-images.md) %}

- API
  1. Get an [IAM token](../../../iam/concepts/authorization/iam-token.md) for authenticating in the examples:
     * [Instructions](../../../iam/operations/iam-token/create.md) for users with a Yandex account.
     * [Instructions](../../../iam/operations/iam-token/create-for-sa.md) for a service account.
  1. Get a list of public images from Yandex.Cloud using the method [List](../../api-ref/Image/list.md) for the resource `Image`.. In the request, specify the following parameters:
     * Specify `standard-images` as the folder ID.
     * The folder contains many images, so specify `pageSize=1000` or use the obtained value of `nextPageToken` to get the next page.

    Write the result to a file, for example `output.json`:

    ```bash
    $ export IAM_TOKEN=CggaATEVAgA...
    $ curl -H "Authorization: Bearer ${IAM_TOKEN}" "https://compute.api.cloud.yandex.net/compute/v1/images?folderId=standard-images&pageSize=1000" > output.json
    ```

{% endlist %}

