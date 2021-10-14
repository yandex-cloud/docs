# Datasets

{% note info %}

Datasets are available in [early access mode](../early-access/index.md).

{% endnote %}

A dataset is an information storage mechanism that provides quick access to large amounts of data. A dataset stores up to 4 TB of data and supports faster data access rates than the main project store.

A dataset is created and populated at initialization. After initialization, a dataset becomes read-only.

## Initializing a dataset

You can create and initialize a dataset from a cell with the `#pragma dataset init` instruction in Bash or Python. During dataset initialization, specify the dataset size and [project-unique](project.md) name.

{% note info %}

The dataset initialization process will allocate the entire requested amount of disk space, but  some part of this space will be consumed by the file system. Make sure to specify an ample dataset size.

Datasets are not included in the main project store.

{% endnote %}

During initialization, the dataset makes a one-time read-and-write connection to the project. If the code in the dataset initialization cell executes successfully, the dataset is saved and reconnected with read-only access. If an error occurs during initialization, the dataset is disconnected and deleted.

You can create a dataset:

* From a file available by following a link.

  {% list tabs %}

  - Bash

    Creating the `<DATASET_NAME>` dataset from a [CIFAR](https://www.cs.toronto.edu/~kriz/cifar.html) archive:

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

    Creating the `<DATASET_NAME>` dataset from a [CIFAR](https://www.cs.toronto.edu/~kriz/cifar.html) archive:

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

* From file storage objects.

  {% list tabs %}

  - {{  objstorage-short-name }}

    ```python
    #pragma dataset init <DATASET_NAME> --size 1Gb
    
    from cloud_ml.storage.api import Storage
    s3 = Storage.s3(access_key=<access_key>, secret_key=<secret_key>])
    s3.get('bucket/<path_within_S3>/file.txt', '/home/jupyter/mnt/datasets/<DATASET_NAME>/<path>/file.txt')
    ```

  - Yandex.Disk

    To connect to Yandex.Disk, you will need your application ID and application secret. To get them:
    1. On the [application registration page]({{ ya-client-app }}) in Yandex ID, select the **Web services** option.
    1. In the **Callback URI** field, enter ```{{ ya-oauth }}```.
    1. Configure permissions for Yandex.Disk.

    ```python
    #pragma dataset init DATASET_NAME --size 1Gb
    
    from cloud_ml.storage.api import Storage
    
    disk = Storage.ya_disk(application_id='<id>', application_secret='<secret>')
    
    # downloading contents of the remote file into the local one
    disk.get('<path_within_ya_disk>/file.txt', '/home/jupyter/mnt/datasets/<DATASET_NAME>/<path>/file.txt')
    ```

  {% endlist %}

## Using a dataset

After the datasets are initialized, you can access them from your code using a path like `/home/jupyter/mnt/datasets/<DATASET_NAME>`.

To view all the project's available datasets, click the tab **Datasets** ![](../../_assets/datasphere/jupyterlab/dataset.svg). On the tab, you will see a listing of created datasets and will be able to view their contents.

You can display a list of all the project's available datasets by running the following code in a cell:

```
#pragma datasets list
```

After initialization, dataset data cannot be changed. If the data needs to be updated, delete the dataset and create a new one.

## Delete datasets

To delete the `<DATASET_NAME>` dataset, execute a cell containing the following code

```
#pragma dataset delete <DATASET_NAME>
```

