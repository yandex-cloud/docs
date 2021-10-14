# Connecting to S3 Storage

{% note info %}

You can connect to S3 object storage using the GUI in [early access mode](../../early-access/index.md).

{% endnote %}

You can connect to S3 object storage from the Jupiter Notebook interface.

1. Get an access key from your S3 storage provider. Follow these steps in {{objstorage-full-name }}:
   1. [Create a service account](../../../iam/operations/sa/create.md).
   1. [Assign](../../../iam/operations/sa/assign-role-for-sa.md) the created service account the [role](../../../storage/security/) to allow either reads only or both reads and writes.
   1. [Create an access key](../../../iam/operations/sa/create-access-key.md) for the service account.
1. [Create a secret](secret-create.md) in `<key ID>:<secret key>` format.
1. Go to the **S3 Mounts** ![S3 Mounts](../../../_assets/datasphere/bucket.svg) tab and click the ![plus](../../../_assets/datasphere/jupyterlab/add.svg) icon.
1. In the dialog box, fill in the fields below:
   * **Endpoint**: Storage host. For {{ objstorage-full-name }}, this is `https://storage.yandexcloud.net/`.
   * **Bucket**: Name of the storage bucket.
   * **Mount name**: Bucket name to be used inside your {{ ml-platform-name }} project. It's automatically generated from the **Bucket** value, but you can change it.
   * **Static access key**: The key created in step 1.
   * **Mode**: Access mode (**Read Only** or **Read / Write**).
1. Click **Test connection**. If successful, click **Mount**.

Once connected, the bucket is available in the list on the **S3 Mounts** ![S3 Mounts](../../../_assets/datasphere/bucket.svg) tab and you can view it as a file system.

## Using S3 in a project {#usage}

You can access files in the connected bucket from the project code. Choose the desired file in the connected S3 storage on the **S3 Mounts** ![S3 Mounts](../../../_assets/datasphere/bucket.svg) tab, right-click on it, and select **Copy path**. The file path is copied to the clipboard. Paste the copied path wherever you want in the project.

## Disabling S3 {#unmount}

To disable S3 storage, choose the appropriate bucket from the list on the **S3 Mounts** ![S3 Mounts](../../../_assets/datasphere/bucket.svg) tab, right-click on it, and select **Unmount**.

