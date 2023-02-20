# Connecting to S3 storage

{% include [link-on-new-ui-datasphere-in-old-ui](../../../_includes/datasphere/datasphere-old-note.md) %}

You can connect to an {% if lang == "ru" and audience != "internal" %}[S3](../../../glossary/s3.md){% else %}S3{% endif %} object storage from the {{ jlab }} Notebook interface.

1. Get an access key from your S3 storage provider. Follow these steps in {{ objstorage-full-name }}:
   1. [Create a service account](../../../iam/operations/sa/create.md).
   1. To the created account, [Assign](../../../iam/operations/sa/assign-role-for-sa.md) a [role](../../../storage/security/) that allows either reads only or both reads and writes.
   1. [Create an access key](../../../iam/operations/sa/create-access-key.md) for the service account.
1. [Create a secret](secret-create.md) in `<key ID>:<secret key>` format.
1. Go to the **S3 Mounts** ![S3 Mounts](../../../_assets/datasphere/bucket.svg) tab, then click ![plus](../../../_assets/datasphere/jupyterlab/add.svg).
1. In the dialog box, fill in the fields below:
   * **Endpoint**: Storage host. For {{ objstorage-full-name }}, this is `https://{{ s3-storage-host }}/`.
   * **Bucket**: Name of the storage bucket.

      {% note warning %}

      Don't use buckets that have dots in their names for connecting. [Learn more about buckets](../../../storage/concepts/bucket.md).

      {% endnote %}

   * **Mount name**: Bucket name to be used inside your {{ ml-platform-name }} project. It's automatically generated from the **Bucket** value, but you can change it.
   * **Static access key**: The key created in step 1.
   * **Mode**: Access mode (**Read Only** or **Read / Write**).
1. Click **Test connection**. If successful, click **Mount**.

Once connected, the bucket is available in the list on the **S3 Mounts** ![S3 Mounts](../../../_assets/datasphere/bucket.svg) tab and you can view it in a file system format.

{% note info %}

Try not to use S3 storage in [FUSE]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Filesystem_in_Userspace){% endif %} mode for buckets with single-layer (non-recursive) folders that include many files. This usage scenario decreases storage performance significantly.

{% endnote %}

## Using S3 in a project {#usage}

You can access files in the connected bucket from the project code. Choose the desired file in the connected S3 storage on the **S3 Mounts** ![S3 Mounts](../../../_assets/datasphere/bucket.svg) tab, right-click it, then select **Copy path**. The file path is copied to the clipboard. Paste the copied path wherever you want in the project.

## Disabling S3 {#unmount}

To disable S3 storage, choose a bucket from the list on the **S3 Mounts** ![S3 Mounts](../../../_assets/datasphere/bucket.svg) tab, right-click it, then select **Unmount**.
