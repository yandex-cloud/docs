# Connecting to Google Drive

You can connect to the [Google Drive](https://drive.google.com) file storage service from the {{ ml-platform-name }} interface.

## Before you start {#before-begin}

1. [Allow access to the API](https://developers.google.com/drive/api/guides/enable-drive-api) of your Google Drive.
1. [Create an OAuth client ID](https://developers.google.com/workspace/guides/create-credentials#tvs-limited-input-devices) and specify the **TVs and Limited Input devices** application type. Save the `client_secret.json` file with a user secret. You'll need it when connecting to Google Drive.
1. {% include [before-begin](../../../_includes/datasphere/ui-before-begin.md) %}

1. [Create a secret](../data/secrets.md#create) that will store the contents of the `client_secret.json` file.

## Uploading the contents from a file on Google Drive to a {{ ml-platform-name }} project file {#get-file}

1. Go to a new cell and copy the command to import the contents from a file on Google Drive to it:

   ```python
   import os
   from cloud_ml.storage.api import Storage
   client_secret = {os.environ['<secret_name>']}
   gdrive = Storage.gdrive(client_secret)
   gdrive.get('<Google_Drive_file_ID>', '<{{ ml-platform-name }}_project_file_path>')
   ```

   Where:

   * `<secret name>` is the name of the secret that stores the contents of the `client_secret.json` file.
   * `<Google_Drive_file_ID>` is the [ID of the Google Drive file](https://developers.google.com/drive/api/guides/about-files?hl=en#file_characteristics) whose contents need to be imported to {{ ml-platform-name }}.
   * `<{{ ml-platform-name }}_project_file_path>` is the path to the {{ ml-platform-name }} project file that data is imported to.

1. Run the cell. To do this, choose **Run** → **Run Selected Cells** or press **Shift** + **Enter**.

## Uploading the contents from a folder on Google Drive to a {{ ml-platform-name }} project folder {#get-dir}

1. Go to a new cell and copy the command to import the contents from a folder on Google Drive to it:

   ```python
   import os
   from cloud_ml.storage.api import Storage
   client_secret = {os.environ['<secret_name>']}
   gdrive = Storage.gdrive(client_secret)
   gdrive.get_dir('<Google_Drive_folder_ID>', '<{{ ml-platform-name }}_project_folder_path>')
   ```

   Where:

   * `<secret name>` is the name of the secret that stores the contents of the `client_secret.json` file.
   * `<Google_Drive_folder_ID>` is the [ID of the Google Drive folder](https://developers.google.com/drive/api/guides/about-files?hl=en#file_characteristics) whose contents need to be imported to {{ ml-platform-name }}.
   * `<{{ ml-platform-name }}_project_folder_path>` is the path to the {{ ml-platform-name }} project folder that data is imported to.

1. Run the cell.

## Uploading the contents from a {{ ml-platform-name }} project file to a file on Google Drive {#put-file}

1. Go to a new cell and copy the command to import the contents from a {{ ml-platform-name }} project file to Google Drive to it:

   ```python
   import os
   from cloud_ml.storage.api import Storage
   client_secret = {os.environ['<secret_name>']}
   gdrive = Storage.gdrive(client_secret)
   gdrive.put('<{{ ml-platform-name }}_project_file_path>', '<Google_Drive_file_ID>')
   ```

   Where:

   * `<secret name>` is the name of the secret that stores the contents of the `client_secret.json` file.
   * `<{{ ml-platform-name }}_project_file_path>` is the path to the {{ ml-platform-name }} project file whose contents need to be uploaded to Google Drive.
   * `<Google_Drive_file_ID>` is the [ID of the Google Drive file](https://developers.google.com/drive/api/guides/about-files?hl=en#file_characteristics) that data is uploaded to.

1. Run the cell.

## Uploading the contents from a {{ ml-platform-name }} project folder to a folder on Google Drive {#put-dir}

1. Go to a new cell and copy the command to import the contents from a {{ ml-platform-name }} project folder to Google Drive to it:

   ```python
   import os
   from cloud_ml.storage.api import Storage
   client_secret = {os.environ['<secret_name>']}
   gdrive = Storage.gdrive(client_secret)
   gdrive.put_dir('<{{ ml-platform-name }}_project_folder_path>', '<Google_Drive_folder_path>')
   ```

   Where:

   * `<secret name>` is the name of the secret that stores the contents of the `client_secret.json` file.
   * `<{{ ml-platform-name }}_project_folder_path>` is the path to the {{ ml-platform-name }} project folder whose contents need to be uploaded to Google Drive.
   * `<Google_Drive_folder_ID>` is the [ID of the Google Drive folder](https://developers.google.com/drive/api/guides/about-files?hl=en#file_characteristics) that data is uploaded to.

1. Run the cell.