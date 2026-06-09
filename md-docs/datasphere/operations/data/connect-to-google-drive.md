# Подключение к Google Drive

Вы можете подключиться к сервису хранения файлов [Google Drive](https://drive.google.com) из интерфейса DataSphere.

## Перед началом работы {#before-begin}

Откройте проект DataSphere:

1. Выберите нужный проект в своем сообществе или на [главной странице](https://datasphere.yandex.cloud) DataSphere во вкладке **Недавние проекты**.
1. Нажмите кнопку **Открыть проект в JupyterLab** и дождитесь окончания загрузки.
1. Откройте вкладку с ноутбуком.

## Загрузить содержимое из файла на Google Drive в файл проекта DataSphere {#get-file}

1. Перейдите в новую ячейку и скопируйте туда команду для загрузки содержимого из файла на Google Drive:

    ```python
    # %pip install gdown if needed

    import gdown

    gdrive_file_id = '<идентификатор_файла_Google_Drive>'
    dst_path = '<путь_к_файлу_в_проекте_DataSphere>'

    gdown.download(id=gdrive_file_id, output=dst_path)
    ```

    Где:

    * `<идентификатор_файла_Google_Drive>` — [идентификатор файла Google Drive](https://developers.google.com/drive/api/guides/about-files?hl=en#file_characteristics), содержимое которого нужно загрузить в DataSphere.
    * `<путь_к_файлу_в_проекте_DataSphere>` — путь к файлу в проекте DataSphere, в который загружаются данные.

1. Запустите ячейку, выбрав в меню **Run** → **Run Selected Cells** (также можно использовать сочетание клавиш **Shift** + **Enter**).

## Загрузить содержимое из каталога на Google Drive в каталог проекта DataSphere {#get-dir}

1. Перейдите в новую ячейку и скопируйте туда команду для загрузки содержимого из каталога на Google Drive:

    ```python
    # %pip install gdown if needed

    import gdown

    gdrive_folder_id = '<идентификатор_каталога_Google_Drive>'
    dst_path = '<путь_к_каталогу_в_проекте_DataSphere>'

    gdown.download_folder(id=gdrive_folder_id, output=dst_path)
    ```

    Где:

    * `<идентификатор_каталога_Google_Drive>` — [идентификатор каталога Google Drive](https://developers.google.com/drive/api/guides/about-files?hl=en#file_characteristics), содержимое которого нужно загрузить в DataSphere.
    * `<путь_к_каталогу_в_проекте_DataSphere>` — путь к каталогу в проекте DataSphere, в который загружаются данные.

1. Запустите ячейку.