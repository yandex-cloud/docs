# Connecting to an S3 storage

On your project page in the {{ ml-platform-name }} interface, you can manage your connection to an S3 object storage by using the **{{ ui-key.yc-ui-datasphere.resources.s3 }}** resource.

To connect to the object storage from the notebook code, follow this guide: [{#T}](connect-to-s3.md).

{% include [fuse-disclaimer](../../../_includes/datasphere/fuse-disclaimer.md) %}

## Getting started {#before-begin}

Get an access key from your S3 storage provider. To do this in [{{ objstorage-full-name }}](../../../storage/), follow these steps:

  1. [Create a service account](../../../iam/operations/sa/create.md).
  1. [Assign](../../../iam/operations/sa/assign-role-for-sa.md) to the created account a [role](../../../storage/security/) allowing either reads only or both reads and writes.
  1. [Create an access key](../../../iam/operations/sa/create-access-key.md) for the service account.

## Creating an S3 connector {#create}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. (Optional) In the top right corner, click **{{ ui-key.yc-ui-datasphere.common.create-resource }}**. In the pop-up window, select **{{ ui-key.yc-ui-datasphere.resources.secret }}** and [create a secret](secrets.md#create) with the secret part of a static access key for the service account. You can also create a secret when creating an S3 connector.
1. In the top-right corner, click **{{ ui-key.yc-ui-datasphere.common.create-resource }}**. In the pop-up window, select **{{ ui-key.yc-ui-datasphere.resources.s3 }}**.
1. Fill out the fields below:
   * **{{ ui-key.yc-ui-datasphere.common.name }}**: Name of the connector being created.
   * (Optional) **{{ ui-key.yc-ui-datasphere.common.description }}** of the new connector.
   * **{{ ui-key.yc-ui-datasphere.common.endpoint }}**: Storage host. For {{ objstorage-name }}, this is `https://{{ s3-storage-host }}/`.
   * **{{ ui-key.yc-ui-datasphere.common.bucket }}**: Name of the storage bucket.

      {% note warning %}

      Do not use buckets with periods in their names for connection. You can learn more about buckets [here](../../../storage/concepts/bucket.md).

      {% endnote %}

   * **{{ ui-key.yc-ui-datasphere.new-s3-page.mount-name }}**: Name of the volume for mounting the bucket into the project file system.
   * **{{ ui-key.yc-ui-datasphere.new-s3-page.access-key-id }}** used to connect to storage.
   * **{{ ui-key.yc-ui-datasphere.new-s3-page.static-access-key }}**: In the list, select a [secret](../../concepts/secrets.md) that contains the secret part of the static access key or create a new secret.
   * **{{ ui-key.yc-ui-datasphere.new-s3-page.mode }}**: Object storage access mode (**{{ ui-key.yc-ui-datasphere.s3-page.mode-read }}** or **{{ ui-key.yc-ui-datasphere.s3-page.mode-read-write }}**).
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.

## Attaching an S3 storage to a project {#mount}

Go to the S3 connector page and click **{{ ui-key.yc-ui-datasphere.common.activate }}**. Once activated, the bucket is available in the {{ jlab }}Lab interface in the list on the **S3 Mounts** ![S3 Mounts](../../../_assets/datasphere/bucket.svg) tab, and you can view it as a file system.

## Using an S3 storage in a project {#usage}

You can access files in the connected bucket from the project code. Choose the file you need in the connected S3 storage on the **S3 Mounts** ![S3 Mounts](../../../_assets/datasphere/bucket.svg) tab, right-click it, and select **Copy path**. This will copy the file path to the clipboard. Paste the copied path wherever you need in the project.

## Detaching an S3 storage {#unmount}

1. On the project page under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click **{{ ui-key.yc-ui-datasphere.resources.s3 }}**.
1. Select the desired connector and go to the resource page.
1. Click **{{ ui-key.yc-ui-datasphere.common.deactivate }}** in the top right corner of the page.

You can attach the S3 storage to your project again when needed.

## Sharing an S3 connector {#share}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![dataset](../../../_assets/console-icons/bucket.svg) **{{ ui-key.yc-ui-datasphere.resources.s3 }}**.
1. Select your S3 connector in the list.
1. Go to the **{{ ui-key.yc-ui-datasphere.common.access }}** tab.
1. Enable the visibility option next to the name of the community you want to share the S3 connector with.

## Deleting an S3 connector {#delete}

You can only delete a [deactivated](#unmount) connector, unavailable to the community.

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![secret](../../../_assets/console-icons/bucket.svg)**{{ ui-key.yc-ui-datasphere.resources.s3 }}**.
1. In the list of S3 connectors, select the one you want to delete. Click ![options](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yc-ui-datasphere.common.delete }}**.
1. Click **{{ ui-key.yc-ui-datasphere.common.submit }}**.

You will see a message saying that the secret has been deleted.
