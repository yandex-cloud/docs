# Datasets

A _dataset_ is an information storage mechanism providing quick access to large amounts of data. A dataset can store up to 4 TB of information giving faster access to data than the main project store.

A dataset is created and populated during initialization. After initialization, a dataset is read-only.

## Initializing a dataset {#init}

You can create and initialize a dataset from a cell with the Bash or Python instruction `#pragma dataset init`. During initialization, you must specify the size and a unique dataset name for the [project](project.md).

{% note info %}

The dataset initialization process will allocate the entire requested amount of disk space but the file system will take up a part of this space. Specify the dataset size with room to spare.

Datasets are not included in the main project store.

{% endnote %}

During initialization, the dataset makes a one-time connection to the project with read and write access. If the code in the dataset initialization cell executes successfully, the dataset is saved and reconnected with read-only access. If an error occurs during initialization, the dataset will be disconnected and deleted.

You can create a dataset:

* From a file available by following a link.

   {% list tabs %}

   - Bash

      Creating a `<DATASET_NAME>` dataset from the [CIFAR](https://www.cs.toronto.edu/~kriz/cifar.html) archive:

      ```bash
      #!:bash
      #pragma dataset init <DATASET_NAME> --size 1Gb
      
      set -e
      cd /home/jupyter/mnt/datasets/<DATASET_NAME>
      wget https://www.cs.toronto.edu/~kriz/cifar-10-python.tar.gz
      tar -xvf cifar-10-python.tar.gz
      rm -rf cifar-10-python.tar.gz
      ```

   - Python 3

      Creating a `<DATASET_NAME>` dataset from the [CIFAR](https://www.cs.toronto.edu/~kriz/cifar.html) archive:

      ```python
      #pragma dataset init <DATASET_NAME> --size 1Gb
      
      from urllib.request import urlopen
      import tarfile
      from os import remove
      
      file_name = 'cifar-10-python.tar.gz'
      file_url = 'https://www.cs.toronto.edu/~kriz/' + file_name
      dest_dir = '/home/jupyter/mnt/datasets/<DATASET_NAME>/'
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

* From file store objects.

   {% list tabs %}

   - {{ objstorage-short-name }}

      ```python
      #pragma dataset init <DATASET_NAME> --size 1Gb
      
      from cloud_ml.storage.api import Storage
      s3 = Storage.s3(access_key=<access_key>, secret_key=<secret_key>])
      s3.get('bucket/<path_within_S3>/file.txt', '/home/jupyter/mnt/datasets/<DATASET_NAME>/<path>/file.txt')
      ```

   - Yandex Disk

      To connect to Yandex Disk, you will need an application ID and a secret. To get them:
      1. On the [app registration page]({{ ya-client-app }}) in Yandex ID, select the **Web services** option.
      1. In the **Callback URI** field, enter ```{{ ya-oauth }}```.
      1. Configure permissions for Yandex Disk.
      1. Initialize the dataset in a cell with the following code:

      ```python
      #pragma dataset init <DATASET_NAME> --size 1Gb
      
      from cloud_ml.storage.api import Storage
      
      disk = Storage.ya_disk(application_id='<id>', application_secret='<secret>')
      
      # downloading contents of the remote file into the local one
      disk.get('<path_within_ya_disk>/file.txt', '/home/jupyter/mnt/datasets/<DATASET_NAME>/<path>/file.txt')
      ```

   - Google Drive

      To connect to Google Drive, follow the [instructions](https://developers.google.com/drive/api/v3/enable-drive-api) in the official documentation and create an **OAuth client ID** of the **TVs and limited input devices** type.

      Use the created **OAuth client ID** and initialize the dataset by executing the following code in a cell:

      ```python
      #pragma dataset init <DATASET_NAME> --size 1Gb
      
      client_secret = {<client_secret>}
      
      gdrive = Storage.gdrive(client_secret)
      gdrive_file_id = '<fileID>'
      dst_path = '/home/jupyter/mnt/datasets/<DATASET_NAME>/<path>/file.txt'
      gdrive.get(gdrive_file_id, dst_path)
      ```

   {% endlist %}

* From local files.

   {% list tabs %}

   - Bash

      To create a dataset in an arbitrary format, copy the local files:

      ```bash
      #!:bash
      #pragma dataset init <DATASET_NAME> --size 1Gb
      
      set -e
      cp -r <SOURCE_FOLDER_NAME> /home/jupyter/mnt/datasets/<DATASET_NAME>
      ```

   {% endlist %}

## Using a dataset {#use}

After initialization, datasets are accessible via code using a path like `/home/jupyter/mnt/datasets/<DATASET_NAME>`.

To view all the project's available datasets, click the **Datasets** ![](../../_assets/datasphere/jupyterlab/dataset.svg). On the tab, you will see a listing of created datasets and will be able to view their contents.

You can display a list of all the project's available datasets by running the following code in a cell:

```
#pragma datasets list
```

After initialization, dataset data cannot be changed. If the data needs to be updated, delete the dataset and create a new one.

## Deleting a dataset {#delete}

To delete a `<DATASET_NAME>` dataset, run a cell with the following code

```
#pragma dataset delete <DATASET_NAME>
```
