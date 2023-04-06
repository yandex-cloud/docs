# Connecting to S3 storage

On your project page in the {{ ml-platform-name }} interface, you can manage your connection to an S3 object storage by using the **{{ ui-key.yc-ui-datasphere.resources.s3 }}** resource.

{% note info %}

Try not to use S3 storage in [FUSE](https://en.wikipedia.org/wiki/Filesystem_in_Userspace) mode for buckets with single-layer (non-recursive) folders that include many files. This usage scenario decreases storage performance significantly.

{% endnote %}

## Before you begin {#before-begin}

1. Get an access key from your S3 storage provider. Follow these steps in {{ objstorage-full-name }}:
1. [Create a service account](../../../iam/operations/sa/create.md).
1. To the created account, [assign](../../../iam/operations/sa/assign-role-for-sa.md) a [role](../../../storage/security/) that allows either reads only or both reads and writes.
1. [Create an access key](../../../iam/operations/sa/create-access-key.md) for the service account.

## Creating an S3 connector {#create}

To create an S3 connector:

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. If you're creating a connection to an {{ objstorage-name }} bucket, in the project settings, [specify](../projects/update.md) the service account on behalf of which {{ ml-platform-name }} will connect to it.
1. (Optional) In the top right corner, click **{{ ui-key.yc-ui-datasphere.common.create-resource }}**. In the window that pops up, select **{{ ui-key.yc-ui-datasphere.resources.secret }}** and [create a secret](secrets.md#create) with the secret part of a static access key for the service account. You can also create a secret when creating an S3 connector.
1. In the top right-hand corner, click **{{ ui-key.yc-ui-datasphere.common.create-resource }}**. In the window that opens, select **{{ ui-key.yc-ui-datasphere.resources.s3 }}**.
1. Complete the fields below:
   * **{{ ui-key.yc-ui-datasphere.common.name }}**: Name of the connector being created.
   * (Optional) **{{ ui-key.yc-ui-datasphere.common.description }}** of the new connector.
   * **{{ ui-key.yc-ui-datasphere.common.endpoint }}**: Storage host. For {{ objstorage-full-name }}, this is `https://{{ s3-storage-host }}/`.
   * **{{ ui-key.yc-ui-datasphere.common.bucket }}**: Name of the storage bucket.

      {% note warning %}

      Don't use buckets that have dots in their names for connecting. [Learn more about buckets](../../../storage/concepts/bucket.md).

      {% endnote %}

   * **{{ ui-key.yc-ui-datasphere.new-s3-page.mount-name }}**: Name of the volume for mounting the bucket into the project file system.
   * **{{ ui-key.yc-ui-datasphere.new-s3-page.access-key-id }}** used to connect to storage.
   * **{{ ui-key.yc-ui-datasphere.new-s3-page.static-access-key }}**: In the list, select a [secret](../../concepts/secrets.md) that contains the secret part of the static access key or create a new secret.
   * **{{ ui-key.yc-ui-datasphere.new-s3-page.mode }}**: Object storage access mode (**{{ ui-key.yc-ui-datasphere.s3-page.mode-read }}** or **{{ ui-key.yc-ui-datasphere.s3-page.mode-read-write }}**).
   * **{{ ui-key.yc-ui-datasphere.common.backend }}**: Backend mode (**{{ ui-key.yc-ui-datasphere.common.default }}**, **{{ ui-key.yc-ui-datasphere.new-s3-page.backend-geesefs }}**, or **{{ ui-key.yc-ui-datasphere.new-s3-page.backend-s3fs }}**).
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.

## Attaching an S3 storage to a project {#mount}

Go to the S3 connector page and click **{{ ui-key.yc-ui-datasphere.common.activate }}**. Once activated, the bucket is available in the {{ jlab }} Lab interface in the list on the **S3 Mounts** ![S3 Mounts](../../../_assets/datasphere/bucket.svg) tab, and you can view it as a file system.

## Using an S3 storage in a project {#usage}

You can access files in the connected bucket from the project code. Choose the desired file in the connected S3 storage on the **S3 Mounts** ![S3 Mounts](../../../_assets/datasphere/bucket.svg) tab, right-click it, then select **Copy path**. The file path is copied to the clipboard. Paste the copied path wherever you want in the project.

## Detaching an S3 storage {#unmount}

1. On the project page under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click **{{ ui-key.yc-ui-datasphere.resources.s3 }}**.
1. Select the desired connector and go to the resource page.
1. Click **{{ ui-key.yc-ui-datasphere.common.deactivate }}** in the top right corner of the page.

You can attach the S3 storage to your project again when needed.