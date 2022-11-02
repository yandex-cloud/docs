# How to migrate to the new interface

Along with the interface, {{ ml-platform-name }} has a new [resource model](../concepts/resource-model.md). Therefore, you can't transfer [projects](../concepts/project.md) automatically. To continue operations on a project in the new interface, [recreate](../operations/projects/create.md) it and [upload](#data-transfer) the necessary data to the project.

If you want to maintain both the code and [interpreter state](../concepts/save-state.md), create a project from a [checkpoint](#state-transfer).

## Transferring notebooks and data {#data-transfer}

Create [secrets](data/secrets.md#create), [S3 storage connections](data/connect-to-s3.md#s3-create), [datasets](../concepts/dataset.md#init), [nodes](deploy/node-create.md), and [Docker images](user-images.md#docker-create) again.

Make the [resources available to the community](../concepts/resource-model.md#sharing) if needed.

You can transfer your notebooks and data from the old project to the new {{ ml-platform-name }} interface in one of the following ways:
* [Use a remote Git repository](#transfer-git).
* [Save the old project's files to local disk](#transfer-local).
* [Use object storage](#transfer-s3).

### Transferring data using a remote Git repository {#transfer-git}

1. In the [management console]({{ link-console-main }}), go to **{{ ml-platform-name }}**.
1. Open the old project to transfer the data from.
1. [Create](./projects/work-with-git.md#init) a local repository in the project.
1. [Push](./projects/work-with-git.md#push) changes to a remote repository.
1. In the {{ ml-platform-name }} [new interface]({{ link-datasphere-main }}), [clone](./projects/work-with-git.md#clone) the remote repository to the project.

### Save the old project's files to local disk {#transfer-local}

1. In the [management console]({{ link-console-main }}), go to **{{ ml-platform-name }}**.
1. Open the old project to transfer the data from.
1. On the left-hand panel, select ![folder](../../_assets/datasphere/jupyterlab/folder.svg) **File Browser**.
1. Right-click on the file to save and select ![download](../../_assets/datasphere/jupyterlab/download.svg) **Download**. Save all the files you need one by one.
1. In the {{ ml-platform-name }} [new interface]({{ link-datasphere-main }}), open the project to transfer the files to.
1. In the ![folder](../../_assets/datasphere/jupyterlab/folder.svg) **File Browser** tab, click ![upload](../../_assets/datasphere/jupyterlab/upload.svg) **Upload Files** and select the files on the local disk.

You can also save all the files of the old project as a ZIP archive:
1. In the project's top panel, click **File** and select **Export project as zip**.
1. In the window that opens, click **Download** and wait for the ZIP archive to download.
1. In the {{ ml-platform-name }} [new interface]({{ link-datasphere-main }}), open the project to transfer the files to.
1. In the ![folder](../../_assets/datasphere/jupyterlab/folder.svg) **File Browser** tab, click ![upload](../../_assets/datasphere/jupyterlab/upload.svg) **Upload Files** and select the ZIP archive on the local disk.
1. Right-click on the ZIP archive and select ![extract](../../_assets/datasphere/jupyterlab/extract.svg) **Extract Archive**.

### Transferring data using object storage {#transfer-s3}

1. In the [management console]({{ link-console-main }}), go to **{{ ml-platform-name }}**.
1. Open the old project to transfer the data from.
1. If you don't have an S3 storage connection, create one.

   {% cut "How to create an S3 connection" %}

   1. Get an access key from your S3 storage provider. Follow these steps in {{ objstorage-full-name }}:
      1. [Create a service account](../../iam/operations/sa/create.md).
      1. [Assign](../../iam/operations/sa/assign-role-for-sa.md) the created service account a [role](../../storage/security/index.md) that allows data reads and writes.
      1. [Create an access key](../../iam/operations/sa/create-access-key.md) for the service account.
   1. Create a secret:
      1. Go to the ![Secrets](../../_assets/datasphere/jupyterlab/secret.svg) tab and click ![plus](../../_assets/datasphere/jupyterlab/add.svg).
      1. In the dialog box, fill in the fields below:
         * **Name**: Key ID.
         * **Content**: Secret key.
         * **Scope**: Select a `project`.
      1. Click **Save**.
      1. To make the secret available, restart the system kernel. To do this, select **Kernel ⟶ Restart kernel** from the {{ ml-platform-name }} interface menu.
   1. Go to the **S3 Mounts** ![S3 Mounts](../../_assets/datasphere/bucket.svg) tab, then click ![plus](../../_assets/datasphere/jupyterlab/add.svg).
   1. In the dialog box, fill in the fields below:
      * **Endpoint**: Storage host. For {{ objstorage-full-name }}, this is `https://{{ s3-storage-host }}/`.
      * **Bucket**: Name of the storage bucket.
      * **Mount name**: Bucket name to be used inside your {{ ml-platform-name }} project. It's automatically generated from the **Bucket** value, but you can change it.
      * **Static access key**: Secret with the access key.
      * **Mode**: Specify **Read / Write** access mode.
   1. Click **Test connection**. If successful, click **Mount**.

      Once connected, the bucket is available in the list on the **S3 Mounts** ![S3 Mounts](../../_assets/datasphere/bucket.svg) tab and you can view it in a file system format.

   {% endcut %}

1. Transfer the necessary data from the old project to object storage.
1. In the {{ ml-platform-name }} [new interface]({{ link-datasphere-main }}), [create](./data/connect-to-s3.md) a connection to the same S3 storage.
1. Transfer the data from this storage to the new project.

{% note info %}

You can also save the data from the old projects datasets to S3 storage and then [initialize](../concepts/dataset.md#init) a dataset in the new {{ ml-platform-name }} interface from this storage.

{% endnote %}

## Transferring an interpreter state {#state-transfer}

{% note warning %}

You can't transfer Docker images, nodes, datasets, and other resources automatically from the old project to the new interface using a checkpoint.

{% endnote %}

To transfer the old project's interpreter state to the new interface using a checkpoint:
1. In the [management console]({{ link-console-main }}), go to **{{ ml-platform-name }}**.
1. Open the old project and create a project checkpoint:
   * In [standard](../concepts/save-state.md#default-save) state saving mode:
      1. Open the ![checkpoints-panel](../../_assets/datasphere/jupyterlab/checkpoints-panel.svg) **Checkpoints** panel.

         If you already executed the open project's code, the **Checkpoints** list will contain the checkpoints created earlier.
      1. Run the code in a notebook cell or group of cells and wait for it to execute.
   * In [auto](../concepts/save-state.md#auto-save) state saving mode: in the upper-right corner of the ![checkpoints-panel](../../_assets/datasphere/jupyterlab/checkpoints-panel.svg) **Checkpoints** tab, click ![plus-sign](../../_assets/plus-sign.svg) or use the **Cmd** + **K** or **Ctrl** + **K** hotkeys.

   This creates a checkpoint that appears at the top of the **Checkpoints** list.
1. Save the checkpoint:
   1. Open the ![checkpoints-panel](../../_assets/datasphere/jupyterlab/checkpoints-panel.svg) **Checkpoints** panel.
   1. Select the desired checkpoint from the **Checkpoints** list and click **Pin**.
   1. In the window that opens, enter the name of the checkpoint to save.
   1. Click **Save**.

   The saved checkpoint is moved to the **Pinned checkpoints** list.
1. Export a checkpoint:
   1. Open the ![checkpoints-panel](../../_assets/datasphere/jupyterlab/checkpoints-panel.svg) **Checkpoints** panel.
   1. Select the desired checkpoint from the **Pinned checkpoints** list.
   1. Click **Share**.
   1. In the window that opens, click **Copy to clipboard**.

   The link to the checkpoint is copied to the clipboard.
1. In the new {{ ml-platform-name }} interface, create a project from a checkpoint:
   1. Go to the [page](https://datasphere.yandex.ru/create-project-from-previous-version) for creating a project from a checkpoint.
   1. Specify the project parameters:
      * Enter a checkpoint link.
      * Enter the name of the project.
      * (Optional) Enter a description of the project.
      * Select a [community](../concepts/community.md) for the project.
   1. Click **Create**.

#### See also {#see-also}

* [Creating a project](./projects/create.md)
* [Creating a secret](./data/secrets.md#create)
* [Creating an S3 connection](./data/connect-to-s3.md)
* [Creating a dataset](../concepts/dataset.md#init)
* [{#T}](./deploy/node-create.md)
* [Creating a Docker image](user-images.md#create)
