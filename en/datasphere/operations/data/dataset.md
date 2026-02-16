# Working with datasets

Use [datasets](../../concepts/dataset.md) if you need to handle large data amounts in {{ ml-platform-name }}. For key operations with datasets, run `#pragma dataset` utility commands in code cells.

## Creating and initializing a dataset {#create}

To create and initialize a dataset, use a Bash or Python cell with the `#pragma dataset init` command. When initializing, specify a [project](../../concepts/project.md)-unique dataset name and the size of the [disk](../../../compute/concepts/disk.md) to host your dataset. Follow these dataset naming requirements:

{% include [name-format](../../../_includes/name-format.md) %}

{% note info %}

When you initialize a dataset, the system will allocate the entire requested disk space, though a portion will be used by the file system. Specify the dataset size in GB, rounded up to the nearest integer.

{% endnote %}

{% note tip %}

The larger the [disk](../../../compute/concepts/disk.md) allocated for the dataset, the higher the data read speed.

{% endnote %}

During initialization, the dataset gets a one-time read and write connection to the project. If the code in the dataset initialization cell runs successfully, the dataset is saved and reconnected with read-only access permissions. If initialization fails, the dataset will be disconnected and deleted.

After initialization is complete, you will not be able to change the data in the dataset. If you need to update the data, delete the dataset and create a new one.

### Populating a dataset with files from the project storage or an attached object storage {#from-files}

You can also use this method to create a dataset with data from a [{{ objstorage-full-name }}](../../../storage/) bucket or another object storage attached to your project storage via an [S3 connector](connect-to-s3.md).

{% list tabs group=programming_language %}

- Bash {#bash}

  To create a dataset called `<dataset_name>`, initialize it and copy files from the `<source_folder_name>` folder:

  ```bash
  #!:bash
  #pragma dataset init <dataset_name> --size 1Gb

  set -e
  cp -r <source_folder_name> /home/jupyter/mnt/datasets/<dataset_name>
  ```

{% endlist %}

### Populating a dataset from a file available by a link {#from-link}

To create a dataset called `<dataset_name>` from a [CIFAR-10](https://www.cs.toronto.edu/~kriz/cifar.html) archive, run the following code from a cell:

{% list tabs group=programming_language %}

- Bash {#bash}

  ```bash
  #!:bash
  #pragma dataset init <dataset_name> --size 1Gb

  set -e
  cd /home/jupyter/mnt/datasets/<dataset_name>
  wget https://www.cs.toronto.edu/~kriz/cifar-10-python.tar.gz
  tar -xvf cifar-10-python.tar.gz
  rm -rf cifar-10-python.tar.gz
  ```

- Python 3 {#python}

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

### Populating a dataset with file storage objects {#from-objects}

{% list tabs %}

- {{ objstorage-short-name }}

  If you are connecting to an {{ objstorage-name }} bucket using an S3 connector, create a dataset from objects as if they were [local files](#from-files) in your project.

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

  s3r = boto3.resource(service_name='s3', endpoint_url='https://{{ s3-storage-host }}', **S3_CREDS)
  bucket = s3r.Bucket(bucket_name)

  for obj in bucket.objects.filter(Prefix=source_path):
      if not os.path.relpath(obj.key, source_path).startswith('../'):
          os.makedirs(os.path.join(target_path, os.path.dirname(obj.key)), exist_ok=True)
          if obj.key[-1] != '/':
              bucket.download_file(obj.key, os.path.join(target_path, obj.key))
  ```

  Where:

  * `aws_access_key_id`: ID of the [static access key](../../../iam/concepts/authorization/access-key.md) [generated](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) for the project service account.
  * `aws_secret_access_key`: Secret key generated for that service account.

- Yandex Disk

  Initialize the dataset in a code cell:

  ```python
  #pragma dataset init <dataset_name> --size 8Gb

  import requests
  from urllib.parse import urlencode
  from io import BytesIO
  from zipfile import ZipFile

  base_url = 'https://cloud-api.yandex.net/v1/disk/public/resources/download?'
  public_key = '<link_to_folder_on_Yandex_Disk>'

  final_url = base_url + urlencode(dict(public_key=public_key))
  response = requests.get(final_url)
  download_url = response.json()['href']
  response = requests.get(download_url)

  dist_path = '/home/jupyter/mnt/datasets/<dataset_name>/'
  zipfile = ZipFile(BytesIO(response.content))
  zipfile.extractall(path=dist_path)
  ```

  Where `<link_to_folder_on_Yandex_Disk>` is the link to the Yandex Disk folder whose contents you need to import to {{ ml-platform-name }}.

- Google Drive

  1. Install [gdown](https://pypi.org/project/gdown/):

     ```python
     %pip install gdown
     ```

  1. Initialize the dataset in a code cell:

     ```python
     #pragma dataset init <dataset_name> --size 1Gb

     import gdown

     gdrive_folder_id = '<Google_Drive_folder_ID>'
     dst_path = '/home/jupyter/mnt/datasets/<dataset_name>/'

     gdown.download_folder(id=gdrive_folder_id, output=dst_path, use_cookies=False)
     ```

     Where `<Google_Drive_folder_ID>` is the Google Drive folder ID specified in the URL after `https://drive.google.com/drive/folders/`. For example, in the `https://drive.google.com/drive/folders/exampleId` URL, the folder ID is `exampleId`.

{% endlist %}

## Activating a dataset {#use}

Once initialized, the dataset becomes active within the project and available at `/home/jupyter/mnt/datasets/<dataset_name>`. You can have up to three active datasets within a project at the same time. During your work, you can activate datasets whenever needed and disable them when the data is no longer in use.

To activate a dataset:

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![dataset](../../../_assets/console-icons/layers.svg)**{{ ui-key.yc-ui-datasphere.resources.dataset}}**.
1. Next to the dataset in question, click ![options](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yc-ui-datasphere.common.activate}}**.

## Viewing a list of datasets available in the project {#list}

On the project page under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, select ![dataset](../../../_assets/console-icons/layers.svg) **{{ ui-key.yc-ui-datasphere.resources.dataset}}**. Next, go to the **{{ ui-key.yc-ui-datasphere.common.shared-with-project-resources }}** tab.

## Sharing a dataset {#share}

{% include [zones](../../../_includes/datasphere/zones.md) %}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![dataset](../../../_assets/console-icons/layers.svg) **{{ ui-key.yc-ui-datasphere.resources.dataset }}**.
1. Select the dataset from the list.
1. Go to the **{{ ui-key.yc-ui-datasphere.common.access }}** tab.
1. Enable the visibility option next to the name of the community you want to share the dataset with.

To make a dataset available for use in another project, you need to [add](../projects/use-shared-resource.md) that dataset in the **{{ ui-key.yc-ui-datasphere.common.shared-with-project-resources }}** tab.

## Disabling a dataset {#deactivate}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. On the project page under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![dataset](../../../_assets/console-icons/layers.svg) **{{ ui-key.yc-ui-datasphere.resources.dataset }}**.
1. Next to the dataset in question, click ![options](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yc-ui-datasphere.common.deactivate }}**.

## Deleting a dataset {#delete}

You can delete a dataset only if it is:

* Not activated for the current project.
* Not used in other projects.
* Unavailable to the community.

To delete a dataset:

1. On the project page under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![dataset](../../../_assets/console-icons/layers.svg) **{{ ui-key.yc-ui-datasphere.resources.dataset }}**.
1. Next the dataset in question, click ![options](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yc-ui-datasphere.common.delete }}**.

{% include [deletion-time](../../../_includes/datasphere/deletion-time.md) %}
