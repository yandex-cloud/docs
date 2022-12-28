# Working with datasets

Use [datasets](../../concepts/dataset.md) if you need to handle large data amounts in {{ ml-platform-name }}. For key operations with datasets, run `#pragma dataset` [utility commands](../../concepts/pragma.md) from the cell code.

## Create and initialize a dataset {#create}

To create and initialize a dataset, use a Bash or Python cell with the `#pragma dataset init` command. At initialization, specify a [project](../../concepts/project.md)-unique dataset name and the size of the [disk](../../../compute/concepts/disk.md) to host the dataset.

{% note info %}

The dataset initialization process will allocate the entire requested amount of disk space but the file system will take up a part of this space. Specify the dataset size with room to spare.

{% endnote %}

{% note tip %}

The larger is the [disk](../../../compute/concepts/disk.md) allocated for the dataset, the higher is the data read speed.

{% endnote %}

During initialization, the dataset makes a one-time connection to the project with read and write access. If the code in the dataset initialization cell executes successfully, the dataset is saved and reconnected with read-only access. If an error occurs during initialization, the dataset will be disconnected and deleted.

After initialization, dataset data cannot be changed. If the data needs to be updated, delete the dataset and create a new one.

### Populate the dataset with files from the project storage or an attached object storage {#from-files}

This method is also good for creating a dataset with data from an [{{ objstorage-full-name }}](../../../storage/) bucket or another object storage attached to the storage via an [S3 connector](connect-to-s3.md).

{% list tabs %}

- Bash

   To create a `<dataset_name>` dataset, initialize it and copy files from the folder `<source_folder_name>`:

   ```bash
   #!:bash
   #pragma dataset init <dataset_name> --size 1Gb

   set -e
   cp -r <source folder name> /home/jupyter/mnt/datasets/<dataset_name>
   ```

{% endlist %}

### Populate the dataset from a file by a link {#from-link}

To create a dataset named `<dataset_name>` from a [CIFAR-10](https://www.cs.toronto.edu/~kriz/cifar.html)archive, executive the following code from a cell:

{% list tabs %}

- Bash

   ```bash
   #!:bash
   #pragma dataset init <dataset_name> --size 1Gb

   set -e
   cd /home/jupyter/mnt/datasets/<dataset_name>
   wget https://www.cs.toronto.edu/~kriz/cifar-10-python.tar.gz
   tar -xvf cifar-10-python.tar.gz
   rm -rf cifar-10-python.tar.gz
   ```

- Python 3

   ```python
   #pragma dataset init <dataset_name> --size 1Gb

   from urllib.request import urlopen
   import tarfile
   from os import remove

   file_name = 'cifar-10-python.tar.gz'
   file_url = 'https://www.cs.toronto.edu/~kriz/' + file_name
   dest_dir = '/home/jupyter/mnt/datasets/<dataset_name>/'
   dest_file = dest_dir + file_name

   with urlopen(file_url) as i:
     with open(dest_file, 'w+b') as o:
       o.write(i.read())

   tar = tarfile.open(dest_file)
   tar.extractall(dest_dir)
   tar.close()

   remove(dest_file)

   # This prevents serialization of temporary variables
   del i, o, tar
   ```

{% endlist %}

### Populate a dataset from file storage objects {#from-objects}

{% list tabs %}

- {{ objstorage-short-name }}

   If you are connecting to an {{ objstorage-name }} bucket using an S3 connector, create a dataset from objects as if they were [local files](#from-files) in your project.

   ```python
   #pragma dataset init <dataset_name> --size 1Gb

   from cloud_ml.storage.api import Storage
   s3 = Storage.s3(access_key=<access_key>, secret_key=<secret_key>])
   s3.get('bucket/<storage_path>/file.txt', '/home/jupyter/mnt/datasets/<dataset_name>/<path>/file.txt')
   ```

   Where:
   * `access_key`: ID of a [static access key](../../../iam/concepts/authorization/access-key.md) [generated](../../../iam/operations/sa/create-access-key.md) for the project's service account.
   * `secret_key`: Secret key generated for that service account.

   {% include [use secrets](../../../_includes/datasphere/use-secrets.md) %}

- Yandex.Disk

   To connect to Yandex Disk, you'll need your application ID (`ClientID`) and secret key (`Client secret`). To get them:

   {% include [oauth-token](../../../_includes/datasphere/token-for-ya-disk.md) %}

   1. [In the {{ ml-platform-name }} interface]({{ link-datasphere-main }}), [create the secrets](secrets.md#create) That include the values of the application ID and secret key.
   1. Initialize the dataset in a cell with the following code:

      ```python
      #pragma dataset init <dataset_name> --size 1Gb

      from cloud_ml.storage.api import Storage

      disk = Storage.ya_disk(application_id=os.environ[<secret_with_ClientID>], application_secret=[<secret_with_Client_secret>])

      # downloading contents of the remote file into the local one
      disk.get('<path_on_Yandex_Disk>/file.txt', '/home/jupyter/mnt/datasets/<dataset_name>/<path>/file.txt')
      ```

   {% note info %}

   When {{ ml-platform-name }} tries to connect to Yandex Disk for the first time, you'll need to go to the Yandex ID login page and copy and paste the confirmation code in the notebook's **Enter the confirmation code** field.

   {% endnote %}

{% if audience == "draft" %}
- Google Drive

   To connect to Google Drive, follow the [instructions](https://developers.google.com/drive/api/v3/enable-drive-api) in the official documentation and create an **OAuth client ID** of the **TVs and limited input devices** type.

   Use the created **OAuth client ID** and initialize the dataset by executing the following code in a cell:

   ```python
   #pragma dataset init <dataset_name> --size 1Gb

   client_secret = {<OAuth_ID_of_client_file>}

   gdrive = Storage.gdrive(client_secret)
   gdrive_file_id = '<file_ID_on_Google_Drive>'
   dst_path = '/home/jupyter/mnt/datasets/<dataset_name>/<path>/file.txt'
   gdrive.get(gdrive_file_id, dst_path)
   ```
{% endif %}

{% endlist %}

## Enabling a dataset {#use}

Once initialized, the dataset becomes enabled in the project and available at the path: `/home/jupyter/mnt/datasets/<dataset_name>`. Up to three datasets can be activated in a project at the same time. During your work, you can activate datasets whenever needed and disable them when you no longer need the data.

To enable a dataset:

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **Project resources**, click ![dataset](../../../_assets/datasphere/dataset.svg) **Dataset**.
1. In the line with the appropriate dataset, click ![options](../../../_assets/options.svg) and select **Apply**.

## Viewing a list of datasets available in the project {#list}

{% list tabs %}

- {{ ml-platform-name }} interface

   Open the project page under **Project resources** → ![dataset](../../../_assets/datasphere/dataset.svg) **Dataset** and click **Available**.

- Code in the notebook

   Run the code cell:

   ```bash
   #pragma datasets list
   ```

{% endlist %}

## Sharing a dataset {#share}

Only a community admin can share a dataset in the community.

To learn more about roles that apply in {{ ml-platform-name }}, see [{#T}](../../security/index.md).

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **Project resources**, click ![dataset](../../../_assets/datasphere/dataset.svg) **Dataset**.
1. Select the appropriate dataset from the list.
1. Go to the **Access** tab.
1. Enable the visibility option next to the name of the community to share the dataset in.

## Deleting a dataset {#delete}

You can delete a dataset only if it is:

* Not enabled in any of your projects.
* Not used in other projects.
* Unavailable to the community.

To delete a dataset:

{% list tabs %}

- {{ ml-platform-name }} interface

   1. On the project page under **Project resources**, click ![dataset](../../../_assets/datasphere/dataset.svg)**Dataset**.
   1. In the line with the appropriate dataset, click ![options](../../../_assets/options.svg) and select **Delete**.

- Code in the notebook

   To delete a dataset named `<dataset_name>`, execute a cell containing the following code:

   ```bash
   #pragma dataset delete <dataset_name>
   ```

{% endlist %}