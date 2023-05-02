# Connecting to Google Drive

You can connect to the [Google Drive](https://drive.google.com) file storage service from the {{ ml-platform-name }} interface.

## Before you start {#before-begin}

{% include [before-begin](../../../_includes/datasphere/ui-before-begin.md) %}

## Uploading the contents from a file on Google Drive to a {{ ml-platform-name }} project file {#get-file}

1. Go to a new cell and copy the command to import the contents from a file on Google Drive to it:

   ```python
   # %pip install gdown if needed

   import gdown

   gdrive_file_id = '<Google_Drive_file_ID>'
   dst_path = '<{{ ml-platform-name }}_project_file_path>'

   gdown.download(id=gdrive_file_id, output=dst_path)
   ```

   Where:

   * `<Google_Drive_file_ID>`: [ID of the Google Drive file](https://developers.google.com/drive/api/guides/about-files?hl=en#file_characteristics), the content of which needs to be imported to {{ ml-platform-name }}.
   * `<{{ ml-platform-name }}_project_file_path>`: Path to the {{ ml-platform-name }} project file to import data to.

1. Run the cell. To do this, choose **Run** → **Run Selected Cells** or press **Shift** + **Enter**.

## Uploading the contents from a folder on Google Drive to a {{ ml-platform-name }} project folder {#get-dir}

1. Go to a new cell and copy the command to import the contents from a folder on Google Drive to it:

   ```python
   # %pip install gdown if needed

   import gdown

   gdrive_folder_id = '<Google_Drive_folder_ID>'
   dst_path = '<{{ ml-platform-name }}_project_folder_path>'

   gdown.download_folder(id=gdrive_folder_id, output=dst_path)
   ```

   Where:

   * `<Google_Drive_folder_ID>`: [ID of the Google Drive folder](https://developers.google.com/drive/api/guides/about-files?hl=en#file_characteristics), the content of which needs to be imported to {{ ml-platform-name }}.
   * `<{{ ml-platform-name }}_project_folder_path>`: Path to the {{ ml-platform-name }} project folder to import data to.

1. Run the cell.