# Connecting to Yandex Disk

{% include [link-on-new-ui-datasphere-in-old-ui](../../../_includes/datasphere/datasphere-old-note.md) %}

You can connect to the [Yandex Disk]{% if lang == "ru" %}(https://disk.yandex.ru){% endif %}{% if lang == "en" %}(https://disk.yandex.com){% endif %} file storage service from the {{ ml-platform-name }} interface.

## Before you begin {#before-begin}

1. [Register]{% if lang == "ru" %}(https://yandex.ru/dev/id/doc/dg/oauth/tasks/register-client.html){% endif %}{% if lang == "en" %}(https://yandex.com/dev/id/doc/dg/oauth/tasks/register-client.html){% endif %} your project as an application in Yandex OAuth:
   1. Go to the [application creation page]{% if lang == "ru" %}(https://oauth.yandex.ru/client/new){% endif %}{% if lang == "en" %}(https://oauth.yandex.com/client/new){% endif %} and log in using your [Yandex ID]{% if lang == "ru" %}(https://yandex.ru/support/id/index.html){% endif %}{% if lang == "en" %}(https://yandex.com/support/id/index.html){% endif %}.
   1. In the **App name** field, specify the name of your project in {{ ml-platform-name }}.
   1. Under **Platforms**, select **Web services**.
   1. In the **Callback URI #1** field, insert `https://oauth.yandex.ru/verification_code`.
   1. Under **Access**, expand **Yandex Disk REST API (cloud_api)** and select all the access permissions offered.
   1. Click **Create app**.
   1. Save the app's ID and password. You'll need them when connecting to Yandex Disk.

   {% note info %}

   When {{ ml-platform-name }} tries to connect to Yandex Disk for the first time, you'll need to go to the Yandex ID login page and copy and paste the confirmation code in the notebook's **Enter the confirmation code** field.

   {% endnote %}

1. Open the {{ ml-platform-name }} project:

   {% list tabs %}

   - Management console

      {% include [before-begin](../../../_includes/datasphere/before-begin.md) %}

   {% endlist %}

## Uploading the contents from a file on Yandex Disk to a {{ ml-platform-name }} project file {#get-file}

1. Go to a new cell and copy the command to import the contents from a file on Yandex Disk to it:

   ```python
   from cloud_ml.storage.api import Storage
   disk = Storage.ya_disk(application_id='<application_ID>', application_secret='<application_password>')
   disk.get('<Yandex_Disk_file_path>', '<{{ ml-platform-name }}_project_file_path>')
   ```

   Where:

   * `<application_ID>` is the ID of the application registered in Yandex OAuth.
   * `<application_password>` is the password of the application registered in Yandex OAuth.
   * `<Yandex_Disk_file_path>` is the path to the file on Yandex Disk whose contents need to be uploaded to {{ ml-platform-name }}.
   * `<{{ ml-platform-name }}_project_file_path>` is the path to the {{ ml-platform-name }} project file to import data to.

1. Run the cell. To do this, choose **Run** → **Run Selected Cells** or press **Shift** + **Enter**.

## Uploading the contents from a folder on Yandex Disk to a {{ ml-platform-name }} project folder {#get-dir}

1. Go to a new cell and copy the command to import the contents from a folder on Yandex Disk to it:

   ```python
   from cloud_ml.storage.api import Storage
   disk = Storage.ya_disk(application_id='<application_ID>', application_secret='<application_password>')
   disk.get_dir('<Yandex_Disk_folder_path>', '<{{ ml-platform-name }}_project_folder_path>')
   ```

   Where:

   * `<application_ID>` is the ID of the application registered in Yandex OAuth.
   * `<application_password>` is the password of the application registered in Yandex OAuth.
   * `<Yandex_Disk_folder_path>` is the path to the folder on Yandex Disk whose contents need to be uploaded to {{ ml-platform-name }}.
   * `<{{ ml-platform-name }}_project_folder_path>` is the path to the {{ ml-platform-name }} project folder to import data to.

1. Run the cell.

## Uploading the contents from a {{ ml-platform-name }} project file to a file on Yandex Disk {#put-file}

1. Go to a new cell and copy the command to upload the contents from a {{ ml-platform-name }} project file on Yandex Disk to it:

   ```python
   from cloud_ml.storage.api import Storage
   disk = Storage.ya_disk(application_id='<application_ID>', application_secret='<application_password>')
   disk.put('<{{ ml-platform-name }}_project_file_path>', '<Yandex_Disk_file_path>')
   ```

   Where:

   * `<application_ID>` is the ID of the application registered in Yandex OAuth.
   * `<application_password>` is the password of the application registered in Yandex OAuth.
   * `<{{ ml-platform-name }}_project_file_path>` is the path to the {{ ml-platform-name }} project file whose contents need to be uploaded to Yandex Disk.
   * `<Yandex_Disk_file_path>` is the path to the file on Yandex Disk to upload data to.

1. Run the cell.

## Uploading the contents from a {{ ml-platform-name }} project folder to a folder on Yandex Disk {#put-dir}

1. Go to a new cell and copy the command to upload the contents from a {{ ml-platform-name }} project folder on Yandex Disk to it:

   ```python
   from cloud_ml.storage.api import Storage
   disk = Storage.ya_disk(application_id='<application_ID>', application_secret='<application_password>')
   disk.put_dir('<{{ ml-platform-name }}_project_folder_path>', '<Yandex_Disk_folder_path>')
   ```

   Where:

   * `<application_ID>` is the ID of the application registered in Yandex OAuth.
   * `<application_password>` is the password of the application registered in Yandex OAuth.
   * `<{{ ml-platform-name }}_project_folder_path>` is the path to the {{ ml-platform-name }} project folder whose contents need to be uploaded to Yandex Disk.
   * `<Yandex_Disk_folder_path>` is the path to the folder on Yandex Disk to upload data to.

1. Run the cell.

#### See also {#see-also}

* [How do I resolve the error: <q>The following variables cannot be serialized</q>?](../../qa/index.md#error-variables)