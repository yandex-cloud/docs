# Connecting to Google Drive

You can connect to [Google Drive](https://drive.google.com) from within the {{ ml-platform-name }} interface.

## Getting started {#before-begin}

{% include [before-begin](../../../_includes/datasphere/ui-before-begin.md) %}

## Importing the contents from a file on Google Drive to a {{ ml-platform-name }} project file {#get-file}

1. Go to a new cell and paste the command to import the contents from a file on Google Drive:

    ```python
    # %pip install gdown if needed

    import gdown

    gdrive_file_id = '<Google_Drive_file_ID>'
    dst_path = '<path_to_file_in_{{ ml-platform-name }}_project>'

    gdown.download(id=gdrive_file_id, output=dst_path)
    ```

    Where:

    * `<Google_Drive_file_ID>`: [ID of the Google Drive file](https://developers.google.com/drive/api/guides/about-files?hl=en#file_characteristics) whose contents you need to import to {{ ml-platform-name }}.
    * `<path_to_file_in_{{ ml-platform-name }}_project>`: Path to the {{ ml-platform-name }} project file to import data to.

1. Run the cell by selecting **Run** → **Run Selected Cells** or pressing **Shift** + **Enter**.

## Importing the contents from a folder on Google Drive to a {{ ml-platform-name }} project folder {#get-dir}

1. Go to a new cell and paste the command to import the contents from a folder on Google Drive:

    ```python
    # %pip install gdown if needed

    import gdown

    gdrive_folder_id = '<Google_Drive_folder_ID>'
    dst_path = '<path_to_folder_in_{{ ml-platform-name }}_project>'

    gdown.download_folder(id=gdrive_folder_id, output=dst_path)
    ```

    Where:

    * `<Google_Drive_folder_ID>`: [ID of the Google Drive folder](https://developers.google.com/drive/api/guides/about-files?hl=en#file_characteristics) whose contents you need to import to {{ ml-platform-name }}.
    * `<path_to_folder_in_{{ ml-platform-name }}_project>`: Path to the {{ ml-platform-name }} project folder to import data to.

1. Run the cell.