# Working with datasets

Use [datasets](../../concepts/dataset.md) if you need to handle large data amounts in {{ ml-platform-name }}. For key operations with datasets, run `#pragma dataset` [utility commands](../../concepts/pragma.md) from the cell code.

## Create and initialize a dataset {#create}

To create and initialize a dataset, use a Bash or Python cell with the `#pragma dataset init` command. At initialization, specify a [project](../../concepts/project.md)-unique dataset name and the size of the [disk](../../../compute/concepts/disk.md) to host the dataset.

{% note info %}

The dataset initialization process will allocate the entire requested amount of disk space but the file system will take up a part of this space. Specify the dataset size in GB rounded up to the nearest integer.

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

  import os
  import boto3

  S3_CREDS = {
      "aws_access_key_id": os.environ['<secret_with_access_key_ID>'],
      "aws_secret_access_key": os.environ['<secret_with_secret_key>']
  }
  bucket_name = "<bucket_name>"

  source_path = ''
  target_path = '/home/jupyter/mnt/datasets/<dataset_name>/'

  s3r = boto3.resource(service_name='s3', endpoint_url='https://storage.yandexcloud.net', **S3_CREDS)
  bucket = s3r.Bucket(bucket_name)

  for obj in bucket.objects.filter(Prefix=source_path):
      if not os.path.relpath(obj.key, source_path).startswith('../'):
          os.makedirs(os.path.join(target_path, os.path.dirname(obj.key)), exist_ok=True)
          if obj.key[-1] != '/':
              bucket.download_file(obj.key, os.path.join(target_path, obj.key))
  ```

  Where:

  * `aws_access_key_id`: ID of the [static access key](../../../iam/concepts/authorization/access-key.md) [generated](../../../iam/operations/sa/create-access-key.md) for the project service account.
  * `aws_secret_access_key`: Secret key generated for that service account.

- Yandex.Disk

   Initialize the dataset in a cell with the following code:

   ```python
   #pragma dataset init <dataset_name> --size 8Gb

   import requests
   from urllib.parse import urlencode
   from io import BytesIO
   from zipfile import ZipFile

   base_url = 'https://cloud-api.yandex.net/v1/disk/public/resources/download?'
   public_key = '<Yandex_Disk_folder_link>'

   final_url = base_url + urlencode(dict(public_key=public_key))
   response = requests.get(final_url)
   download_url = response.json()['href']
   response = requests.get(download_url)

   dist_path = '/home/jupyter/mnt/datasets/<dataset_name>/'
   zipfile = ZipFile(BytesIO(response.content))
   zipfile.extractall(path=dist_path)
   ```

   Where `<Yandex_Disk_folder_link>` is the URL of the folder on Yandex Disk whose contents need to be imported to {{ ml-platform-name }}.

- Google Drive

  1. Install the [gdown](https://pypi.org/project/gdown/) package:

     ```python
     %pip install gdown
     ```

  1. Initialize the dataset in a cell with the following code:

     ```python
     #pragma dataset init <dataset_name> --size 1Gb

     import gdown

     gdrive_folder_id = '<Google_Drive_folder_ID>'
     dst_path = '/home/jupyter/mnt/datasets/<dataset_name>/'

     gdown.download_folder(id=gdrive_folder_id, output=dst_path, use_cookies=False)
     ```

     Where `gdrive_folder_id` is the ID of the Google Drive folder specified in the URL after `https://drive.google.com/drive/folders/`. For example, in the `https://drive.google.com/drive/folders/exampleId` URL, the folder ID is `exampleId`.

{% endlist %}

## Enabling a dataset {#use}

Once initialized, the dataset becomes enabled in the project and available at the path: `/home/jupyter/mnt/datasets/<dataset_name>`. Up to three datasets can be activated in a project at the same time. During your work, you can activate datasets whenever needed and disable them when you no longer need the data.

To enable a dataset:

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![dataset](../../../_assets/datasphere/dataset.svg)**{{ ui-key.yc-ui-datasphere.resources.dataset}}**.
1. In the line with the appropriate dataset, click ![options](../../../_assets/options.svg) and select **{{ ui-key.yc-ui-datasphere.common.activate}}**.

## Viewing a list of datasets available in the project {#list}

On the project page under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, select ![dataset](../../../_assets/datasphere/dataset.svg) **{{ ui-key.yc-ui-datasphere.resources.dataset}}**. Next, go to the **{{ ui-key.yc-ui-datasphere.common.shared-with-project-resources }}** tab.

## Sharing a dataset {#share}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![dataset](../../../_assets/datasphere/dataset.svg) **{{ ui-key.yc-ui-datasphere.resources.dataset }}**.
1. Select the appropriate dataset from the list.
1. Go to the **{{ ui-key.yc-ui-datasphere.common.access }}** tab.
1. Enable the visibility option next to the name of the community to share the dataset in.

## Deleting a dataset {#delete}

You can delete a dataset only if it is:

* Not enabled in any of your projects.
* Not used in other projects.
* Unavailable to the community.

To delete a dataset:

1. On the project page under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![dataset](../../../_assets/datasphere/dataset.svg) **{{ ui-key.yc-ui-datasphere.resources.dataset }}**.
1. In the line with the appropriate dataset, click ![options](../../../_assets/options.svg) and select **{{ ui-key.yc-ui-datasphere.common.delete }}**.
