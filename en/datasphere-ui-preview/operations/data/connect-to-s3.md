# Connecting to S3 storage

You can manage connections to S3 object storage in the {{ ml-platform-name }} interface on your project page.

{% note info %}

Try not to use S3 storage in [FUSE]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/FUSE_(kernel_module)){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Filesystem_in_Userspace){% endif %} mode for buckets with single-layer (non-recursive) folders that include many files. This usage scenario decreases storage performance significantly.

{% endnote %}

## Creating an S3 connection {#create}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. In the upper-right corner, click **Create resource**. In the window that appears, select **S3 connection**.
1. Complete the fields below:
   * **Name**: Name of the connection being created.
   * (Optional) **Description** of the new connection.
   * **Endpoint**: Storage host. For {{ objstorage-full-name }}, this is `https://{{ s3-storage-host }}/`.
   * **Bucket**: Name of the storage bucket.
   * **Mount name**: Name of the volume for mounting the bucket into the project file system.
   * **Static access key ID** used to connect to storage.
   * **Static access key**: In the list, select a [secret](../../concepts/secrets.md) that contains a static access key or create a new one.
   * **Operation mode**: Object storage access mode (**Read-only** or **Read and write**).
   * **Backend**: Backend mode (**Default**, **GeeseFS**, or **s3fs**).
1. Click **Create**.

## Enabling S3 {#mount}

Go to the S3 connection page and click **Attach**. Once connected, the bucket is available in the JupyterLab interface in the list on the **S3 Mounts** ![S3 Mounts](../../../_assets/datasphere/bucket.svg) tab and you can view it as a file system.

## Using S3 in a project {#usage}

You can access files in the connected bucket from the project code. Choose the desired file in the connected S3 storage on the **S3 Mounts** ![S3 Mounts](../../../_assets/datasphere/bucket.svg) tab, right-click it, then select **Copy path**. The file path is copied to the clipboard. Paste the copied path wherever you want in the project.

## Disabling S3 {#unmount}

1. On your project page under **Resources**, click **S3 connection**.
1. Select the desired connection and go to the resource page.
1. Click **Detach** in the upper-right corner of the page.

You can attach S3 to your project again when needed.