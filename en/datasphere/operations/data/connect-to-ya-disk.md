# Connecting to Yandex Disk

You can connect to the [Yandex Disk](https://disk.yandex.com) file storage service from the {{ ml-platform-name }} interface.

## Before you begin {#before-begin}

1. [Register](https://yandex.com/dev/id/doc/dg/oauth/tasks/register-client.html) your project as an application in Yandex OAuth:

   {% include [oauth-token](../../../_includes/datasphere/token-for-ya-disk.md) %}

   {% note info %}

   When {{ ml-platform-name }} tries to connect to Yandex Disk for the first time, you'll need to go to the Yandex ID login page and copy and paste the confirmation code in the notebook's **Enter the confirmation code** field.

   {% endnote %}

1. {% include [before-begin](../../../_includes/datasphere/ui-before-begin.md) %}


## Uploading the contents from a file on Yandex Disk to a {{ ml-platform-name }} project file {#get-file}

1. Go to a new cell and copy the command to import the contents from a file on Yandex Disk to it:

   ```python
   # %pip install requests urllib if needed

   import requests
   from urllib.parse import urlencode

   base_url = 'https://cloud-api.yandex.net/v1/disk/public/resources/download?'
   public_key = '<Yandex_Disk_file_path>'

   final_url = base_url + urlencode(dict(public_key=public_key))
   response = requests.get(final_url)
   download_url = response.json()['href']
   response = requests.get(download_url)

   dist_path = '<{{ ml-platform-name }}_project_file_path>'
   with open(dist_path, 'wb') as f:
       f.write(response.content)
   ```

   Where:

   * `<Yandex_Disk_file_path>`: Path to the file on Yandex Disk, the content of which needs to be uploaded to {{ ml-platform-name }}.
   * `<{{ ml-platform-name }}_project_file_path>`: Path to the {{ ml-platform-name }} project file to import data to.

1. Run the cell. To do this, choose **Run** → **Run Selected Cells** or press **Shift** + **Enter**.

## Uploading the contents from a folder on Yandex Disk to a {{ ml-platform-name }} project folder {#get-dir}

1. Go to a new cell and copy the command to import the contents from a folder on Yandex Disk to it:

   ```python
   # %pip install requests urllib if needed

   import requests
   from urllib.parse import urlencode
   from io import BytesIO
   from zipfile import ZipFile

   base_url = 'https://cloud-api.yandex.net/v1/disk/public/resources/download?'
   public_key = '<Yandex_Disk_folder_path>'

   final_url = base_url + urlencode(dict(public_key=public_key))
   response = requests.get(final_url)
   download_url = response.json()['href']
   response = requests.get(download_url)

   dist_path = '<{{ ml-platform-name }}_project_folder_path>'
   zipfile = ZipFile(BytesIO(response.content))
   zipfile.extractall(path=dist_path)
   ```

   Where:

   * `<Yandex_Disk_folder_path>` is the path to the folder on Yandex Disk whose contents need to be uploaded to {{ ml-platform-name }}.
   * `<{{ ml-platform-name }}_project_folder_path>` is the path to the {{ ml-platform-name }} project folder to import data to.

1. Run the cell.