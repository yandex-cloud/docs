# Connecting to S3 storage

On your project page in the {{ ml-platform-name }} interface, you can manage your connection to an S3 object storage by using the **Connector S3** resource.

{% note info %}

Try not to use S3 storage in [FUSE](https://en.wikipedia.org/wiki/Filesystem_in_Userspace) mode for buckets with single-layer (non-recursive) folders that include many files. This usage scenario decreases storage performance significantly.

{% endnote %}

## Creating an S3 connector {#create}

1. Get an access key from your S3 storage provider. Follow these steps in {{ objstorage-full-name }}:

   1. [Create a service account](../../../iam/operations/sa/create.md).
   1. To the created account, [assign](../../../iam/operations/sa/assign-role-for-sa.md) a [role](../../../storage/security/) that allows either reads only or both reads and writes.
   1. [Create an access key](../../../iam/operations/sa/create-access-key.md) for the service account.

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. If you're creating a connection to an {{ objstorage-name }} bucket, in the project settings, [specify](../projects/update.md) the service account on behalf of which {{ ml-platform-name }} will connect to it.
1. (Optional) In the upper-right corner, click **Create resource**. In the window that appears, select **Secret** and [create a secret](secrets.md#create) with the secret part of the static access key for the service account. You can also create a secret when creating an S3 connection.
1. In the upper-right corner, click **Create resource**. In the window that appears, select **S3 connector**.
1. Complete the fields below:
   * **Name**: Name of the connector being created.
   * (Optional) **Description** of the new connector.
   * **Endpoint**: Storage host. For {{ objstorage-full-name }}, this is `https://{{ s3-storage-host }}/`.
   * **Bucket**: Name of the storage bucket.

      {% note warning %}

      Don't use buckets that have dots in their names for connecting. [Learn more about buckets](../../../storage/concepts/bucket.md).

      {% endnote %}

   * **Mount name**: Name of the volume for mounting the bucket into the project file system.
   * **Static access key ID** used to connect to storage.
   * **Static access key**: In the list, select a [secret](../../concepts/secrets.md) that contains the secret part of a static access key or create a new secret.
   * **Operation mode**: Object storage access mode (**Read-only** or **Read and write**).
   * **Backend**: Backend mode (**Default**, **GeeseFS**, or **s3fs**).
1. Click **Create**.

## Attaching an S3 storage to a project {#mount}

Go to the S3 connector page and click **Activate**. Once activated, the bucket is available in the {{ jlab }}Lab interface in the list on the **S3 Mounts** ![S3 Mounts](../../../_assets/datasphere/bucket.svg) tab, and you can view it as a file system.

## Using an S3 storage in a project {#usage}

You can access files in the connected bucket from the project code. Choose the desired file in the connected S3 storage on the **S3 Mounts** ![S3 Mounts](../../../_assets/datasphere/bucket.svg) tab, right-click it, then select **Copy path**. The file path is copied to the clipboard. Paste the copied path wherever you want in the project.

## Detaching an S3 storage {#unmount}

1. On your project page under **Resources**, click **S3 connector**.
1. Select the desired connector and go to the resource page.
1. Click **Deactivate** in the upper-right corner of the page.

You can attach the S3 storage to your project again when needed.