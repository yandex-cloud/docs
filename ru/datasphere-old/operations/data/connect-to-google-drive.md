# Подключение к Google Drive

Вы можете подключиться к сервису хранения файлов [Google Drive](https://drive.google.com) из интерфейса {{ ml-platform-name }}.

## Перед началом {#before-begin}

1. [Разрешите доступ к API](https://developers.google.com/drive/api/guides/enable-drive-api) вашего Google Drive.
1. [Создайте OAuth client ID](https://developers.google.com/workspace/guides/create-credentials#tvs-limited-input-devices), укажите тип приложения **TVs and Limited Input devices**. Сохраните файл `client_secret.json` с секретом пользователя, он понадобится при подключении к Google Drive. 
1. Откройте проект {{ ml-platform-name }}:

    {% list tabs %}

    - Консоль управления

      {% include [before-begin](../../../_includes/datasphere/before-begin.md) %}

    {% endlist %}

1. [Создайте секрет](secret-create.md), в котором будет хранится содержимое файла `client_secret.json`.

## Загрузите содержимое из файла на Google Drive в файл проекта {{ ml-platform-name }} {#get-file}

1. Перейдите в новую ячейку и скопируйте туда команду для загрузки содержимого из файла на Google Drive:

    ```python
    import os
    from cloud_ml.storage.api import Storage
    client_secret = {os.environ['<имя_секрета>']}
    gdrive = Storage.gdrive(client_secret)
    gdrive.get('<идентификатор_файла_Google_Drive>', '<путь_к_файлу_в_проекте_{{ ml-platform-name }}>')
    ```

    Где:

    * `<имя_секрета>` — имя секрета, в котором хранится содержимое файла `client_secret.json`.
    * `<идентификатор_файла_Google_Drive>` — [идентификатор файла Google Drive](https://developers.google.com/drive/api/guides/about-files?hl=en#file_characteristics), содержимое которого нужно загрузить в {{ ml-platform-name }}.
    * `<путь_к_файлу_в_проекте_{{ ml-platform-name }}>` — путь к файлу в проекте {{ ml-platform-name }}, в который загружаются данные.

1. Запустите ячейку, выбрав в меню **Run** → **Run Selected Cells** (также можно использовать сочетание клавиш **Shift** + **Enter**).

## Загрузите содержимое из каталога на Google Drive в каталог проекта {{ ml-platform-name }} {#get-dir}

1. Перейдите в новую ячейку и скопируйте туда команду для загрузки содержимого из каталога на Google Drive:

    ```python
    import os
    from cloud_ml.storage.api import Storage
    client_secret = {os.environ['<имя_секрета>']}
    gdrive = Storage.gdrive(client_secret)
    gdrive.get_dir('<идентификатор_каталога_Google_Drive>', '<путь_к_каталогу_в_проекте_{{ ml-platform-name }}>')
    ```

    Где:

    * `<имя_секрета>` — имя секрета, в котором хранится содержимое файла `client_secret.json`.
    * `<идентификатор_каталога_Google_Drive>` — [идентификатор каталога Google Drive](https://developers.google.com/drive/api/guides/about-files?hl=en#file_characteristics), содержимое которого нужно загрузить в {{ ml-platform-name }}.
    * `<путь_к_каталогу_в_проекте_{{ ml-platform-name }}>` — путь к каталогу в проекте {{ ml-platform-name }}, в который загружаются данные.

1. Запустите ячейку.

## Загрузите содержимое из файла проекта {{ ml-platform-name }} в файл на Google Drive {#put-file}

1. Перейдите в новую ячейку и скопируйте туда команду для загрузки содержимого файла проекта {{ ml-platform-name }} в Google Drive:

    ```python
    import os
    from cloud_ml.storage.api import Storage
    client_secret = {os.environ['<имя_секрета>']}
    gdrive = Storage.gdrive(client_secret)
    gdrive.put('<путь_к_файлу_в_проекте_{{ ml-platform-name }}>', '<идентификатор_файла_Google_Drive>')
    ```

    Где:

    * `<имя_секрета>` — имя секрета, в котором хранится содержимое файла `client_secret.json`.
    * `<путь_к_файлу_в_проекте_{{ ml-platform-name }}>` — путь к файлу в проекте {{ ml-platform-name }}, содержимое которого нужно загрузить в Google Drive.
    * `<идентификатор_файла_Google_Drive>` — [идентификатор файла Google Drive](https://developers.google.com/drive/api/guides/about-files?hl=en#file_characteristics), в который загружаются данные.

1. Запустите ячейку.

## Загрузите содержимое из каталога проекта {{ ml-platform-name }} в каталог на Google Drive {#put-dir}

1. Перейдите в новую ячейку и скопируйте туда команду для загрузки содержимого каталога проекта {{ ml-platform-name }} в Google Drive:

    ```python
    import os
    from cloud_ml.storage.api import Storage
    client_secret = {os.environ['<имя_секрета>']}
    gdrive = Storage.gdrive(client_secret)
    gdrive.put_dir('<путь_к_каталогу_в_проекте_{{ ml-platform-name }}>', '<идентификатор_файла_Google_Drive>')
    ```

    Где:

    * `<имя_секрета>` — имя секрета, в котором хранится содержимое файла `client_secret.json`.
    * `<путь_к_каталогу_в_проекте_{{ ml-platform-name }}>` — путь к каталогу в проекте {{ ml-platform-name }}, содержимое которого нужно загрузить в Google Drive.
    * `<идентификатор_каталога_Google_Drive>` — [идентификатор каталога Google Drive](https://developers.google.com/drive/api/guides/about-files?hl=en#file_characteristics), в который загружаются данные.

1. Запустите ячейку.