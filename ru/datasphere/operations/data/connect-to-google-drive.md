# Подключение к Google Drive

Вы можете подключиться к сервису хранения файлов [Google Drive](https://drive.google.com) из интерфейса {{ ml-platform-name }}.

## Перед началом {#before-begin}

1. [Разрешите доступ к API](https://developers.google.com/drive/api/guides/enable-drive-api) вашего Google Drive.
1. [Создайте OAuth client ID](https://developers.google.com/workspace/guides/create-credentials#tvs-limited-input-devices), укажите тип приложения **TVs and Limited Input devices**. Сохраните файл `client_secret.json` с секретом пользователя, он понадобится при подключении к Google Drive. 
1. {% include [before-begin](../../../_includes/datasphere/ui-before-begin.md) %}

1. [Создайте секрет](../data/secrets.md#create), в котором будет храниться содержимое файла `client_secret.json`.

## Загрузить содержимое из файла на Google Drive в файл проекта {{ ml-platform-name }} {#get-file}

1. Перейдите в новую ячейку и скопируйте туда команду для загрузки содержимого из файла на Google Drive:

    ```python
    # %pip install gdown if needed

    import gdown

    gdrive_file_id = '<идентификатор_файла_Google_Drive>'
    dst_path = '<путь_к_файлу_в_проекте_{{ ml-platform-name }}>'

    gdown.download(id=gdrive_file_id, output=dst_path)
    ```

    Где:

    * `<идентификатор_файла_Google_Drive>` — [идентификатор файла Google Drive](https://developers.google.com/drive/api/guides/about-files?hl=en#file_characteristics), содержимое которого нужно загрузить в {{ ml-platform-name }}.
    * `<путь_к_файлу_в_проекте_{{ ml-platform-name }}>` — путь к файлу в проекте {{ ml-platform-name }}, в который загружаются данные.

1. Запустите ячейку, выбрав в меню **Run** → **Run Selected Cells** (также можно использовать сочетание клавиш **Shift** + **Enter**).

## Загрузить содержимое из каталога на Google Drive в каталог проекта {{ ml-platform-name }} {#get-dir}

1. Перейдите в новую ячейку и скопируйте туда команду для загрузки содержимого из каталога на Google Drive:

    ```python
    # %pip install gdown if needed

    import gdown

    gdrive_folder_id = '<идентификатор_каталога_Google_Drive>'
    dst_path = '<путь_к_каталогу_в_проекте_{{ ml-platform-name }}>'

    gdown.download_folder(id=gdrive_folder_id, output=dst_path)
    ```

    Где:

    * `<идентификатор_каталога_Google_Drive>` — [идентификатор каталога Google Drive](https://developers.google.com/drive/api/guides/about-files?hl=en#file_characteristics), содержимое которого нужно загрузить в {{ ml-platform-name }}.
    * `<путь_к_каталогу_в_проекте_{{ ml-platform-name }}>` — путь к каталогу в проекте {{ ml-platform-name }}, в который загружаются данные.

1. Запустите ячейку.