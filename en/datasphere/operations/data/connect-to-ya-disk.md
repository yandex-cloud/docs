# Connecting to Yandex Disk

You can connect to [Yandex Disk](https://disk.yandex.com) from within the {{ ml-platform-name }} interface. To upload a file or folder to {{ ml-platform-name }}, make it accessible via a link.

## Getting started {#before-begin}

{% include [before-begin](../../../_includes/datasphere/ui-before-begin.md) %}


## Importing the contents from a file on Yandex Disk to a {{ ml-platform-name }} project file {#get-file}

1. Go to a new cell and paste the command to import the contents from a file on Yandex Disk:

    ```python
    # %pip install requests urllib if needed

    import requests
    from urllib.parse import urlencode

    base_url = 'https://cloud-api.yandex.net/v1/disk/public/resources/download?'
    public_key = '<link_to_file_on_Yandex_Disk>'

    final_url = base_url + urlencode(dict(public_key=public_key))
    response = requests.get(final_url)
    download_url = response.json()['href']
    response = requests.get(download_url)

    dist_path = '<path_to_file_in_project>'
    with open(dist_path, 'wb') as f:
        f.write(response.content)
    ```

    Where:

    * `<link_to_file_on_Yandex_Disk>`: Link to the Yandex Disk file whose contents you need to import to {{ ml-platform-name }}. To get the link, right-click the file and select **Share** ⟶ **Copy link**.
    * `<path_to_file_in_project>`: Path to the {{ ml-platform-name }} project file to import data to. To get the path, right-click the file and select **Copy path**.

1. Run the cell by selecting **Run** → **Run Selected Cells** or pressing **Shift** + **Enter**.

## Importing the contents from a folder on Yandex Disk to a {{ ml-platform-name }} project folder {#get-dir}

1. Go to a new cell and paste the command to import the contents from a folder on Yandex Disk:

    ```python
    # %pip install requests urllib if needed

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

    dist_path = '<path_to_folder_in_project>'
    zipfile = ZipFile(BytesIO(response.content))
    zipfile.extractall(path=dist_path)
    ```

    Where:

    * `<link_to_folder_on_Yandex_Disk>`: Link to the Yandex Disk folder whose contents you need to import to {{ ml-platform-name }}. To get the link, right-click the folder and select **Share** ⟶ **Copy link**.
    * `<path_to_folder_in_project>`: Path to the {{ ml-platform-name }} project folder to import data to. To get the path, right-click the folder and select **Copy path**.

1. Run the cell.