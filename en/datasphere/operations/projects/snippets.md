# Running sample code in a notebook

The notebook provides small code examples for loading data from different sources.

## Before you start {#before-begin}

If a project is already open, open the tab with a notebook.

If not, open the project:

1. {% include [include](../../../_includes/datasphere/first-step.md) %}
1. Go to the **Projects** tab.
1. Select the project you want to open and click ![image](../../../_assets/datalens/horizontal-ellipsis.svg).
1. Choose **Open** and wait for the project to open.

## Run the sample code {#run}

To run the sample code:

1. In the top panel in the project window, click **Kernel**.
1. In the menu that opens, click **Yandex Disk**.
1. In the menu that opens, click the example you want to run.
1. The example code will be inserted into the notebook cell.
    1. Follow the steps in the example.
    1. Run the cell. To do this, click ![Run](../../../_assets/datasphere/jupyterlab/run.svg).

### Code examples for loading data from different sources {#code}

To run the code examples, you will need the app ID and secret.
To get them:

1. Follow the link: `https://oauth.yandex.ru/client/new`.
1. Fill in the field **Application name**.
1. In **Platforms**, choose **Web service**.
1. In the **Callback URI #1** field, enter `https://oauth.yandex.ru/verification_code`.
1. In **Accesses**, mark access for Yandex.Disk.

**Uploading the contents of a remote file to a local file**

```
from cloud_ml.storage.api import Storage

disk = Storage.ya_disk(application_id='ID', application_secret='secret')

disk.get('path/to/file/within/ya/disk/file.txt', 'path/to/file.txt')
```

**Uploading the contents of a remote directory to a local file**

```
from cloud_ml.storage.api import Storage

disk = Storage.ya_disk(application_id='ID', application_secret='secret')

disk.get_dir('path/to/dir/within/ya/disk', 'path/to/dir')
```

**Uploading the contents of a local file to a remote file**

```
from cloud_ml.storage.api import Storage

disk = Storage.ya_disk(application_id='ID', application_secret='secret')

disk.put('path/to/file.txt', 'path/to/file/within/ya/disk/file.txt')
```

**Uploading the contents of a local directory to a remote directory**

```
from cloud_ml.storage.api import Storage

disk = Storage.ya_disk(application_id='ID', application_secret='secret')

disk.put_dir('path/to/dir', 'path/to/dir/within/ya/disk')
```

