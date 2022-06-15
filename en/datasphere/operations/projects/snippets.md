# Running sample code in a notebook

The notebook includes small code samples that upload data from different sources.

## Before you start {#before-begin}

If a project is already open, open the tab with a notebook.

If not, open the project:

1. {% include [include](../../../_includes/datasphere/first-step.md) %}
1. Go to the **Projects** tab.
1. Select the project you want to open and click ![image](../../../_assets/datalens/horizontal-ellipsis.svg).
1. Choose **Open** and wait for the project to open.

## Run a code sample {#run}

To run a code sample:

1. In the top panel in the project window, click **Snippets**.
1. In the menu that opens, click **Yandex Disk**.
1. In the menu that opens, click the code example you want to run.
1. The code example will be copied to the notebook cell.
   1. Follow the steps from the example.
   1. Run the cell. To do this, click ![Run](../../../_assets/datasphere/jupyterlab/run.svg).

### Code examples to upload data from different sources {#code}

To run code samples, you'll need an app ID and a secret.
To get them:
1. Go to `https://oauth.yandex.ru/client/new`.
1. Fill out the **App name** field.
1. Under **Platforms**, select **Web services**.
1. In the **Callback URI #1** field, insert `https://oauth.yandex.ru/verification_code`.
1. Under **Permissions**, select permissions for Yandex Disk.

**Loading the contents of a remote file to a local file**

```
from cloud_ml.storage.api import Storage

disk = Storage.ya_disk(application_id='ID', application_secret='secret')

disk.get('path/to/file/within/ya/disk/file.txt', 'path/to/file.txt')
```

**Loading the contents of a remote folder to a local folder**

```
from cloud_ml.storage.api import Storage

disk = Storage.ya_disk(application_id='ID', application_secret='secret')

disk.get_dir('path/to/dir/within/ya/disk', 'path/to/dir')
```

**Loading the contents of a local file to a remote file**

```
from cloud_ml.storage.api import Storage

disk = Storage.ya_disk(application_id='ID', application_secret='secret')

disk.put('path/to/file.txt', 'path/to/file/within/ya/disk/file.txt')
```

**Loading the contents of a local folder to a remote folder**

```
from cloud_ml.storage.api import Storage

disk = Storage.ya_disk(application_id='ID', application_secret='secret')

disk.put_dir('path/to/dir', 'path/to/dir/within/ya/disk')
```

#### What's next {#what-is-next}

* [{#T}](checkpoints.md)
