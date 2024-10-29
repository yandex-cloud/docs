# Подключение к Яндекс Диску

Вы можете подключиться к сервису хранения файлов [Яндекс Диск](https://disk.yandex.ru) из интерфейса {{ ml-platform-name }}. Чтобы загрузить файл или каталог в {{ ml-platform-name }}, откройте к нему доступ по ссылке.

## Перед началом работы {#before-begin}

{% include [before-begin](../../../_includes/datasphere/ui-before-begin.md) %}


## Загрузить содержимое из файла на Яндекс Диске в файл проекта {{ ml-platform-name }} {#get-file}

1. Перейдите в новую ячейку и скопируйте туда команду для загрузки содержимого из файла на Яндекс Диске:

    ```python
    # %pip install requests urllib if needed

    import requests
    from urllib.parse import urlencode

    base_url = 'https://cloud-api.yandex.net/v1/disk/public/resources/download?'
    public_key = '<ссылка_на_файл_на_Яндекс_Диске>'

    final_url = base_url + urlencode(dict(public_key=public_key))
    response = requests.get(final_url)
    download_url = response.json()['href']
    response = requests.get(download_url)

    dist_path = '<путь_к_файлу_в_проекте>'
    with open(dist_path, 'wb') as f:
        f.write(response.content)
    ```

    Где:

    * `<ссылка_на_файл_на_Яндекс_Диске>` — ссылка для доступа к файлу на Яндекс Диске, содержимое которого нужно загрузить в {{ ml-platform-name }}. Чтобы получить ссылку, нажмите правой кнопкой мыши на файл и выберите **Поделиться** ⟶ **Скопировать ссылку**.
    * `<путь_к_файлу_в_проекте>` — путь к файлу в проекте {{ ml-platform-name }}, в который загружаются данные. Чтобы получить путь, нажмите правой кнопкой мыши на файл и выберите **Copy path**.

1. Запустите ячейку, выбрав в меню **Run** → **Run Selected Cells** (также можно использовать сочетание клавиш **Shift** + **Enter**).

## Загрузить содержимое из каталога на Яндекс Диске в каталог проекта {{ ml-platform-name }} {#get-dir}

1. Перейдите в новую ячейку и скопируйте туда команду для загрузки содержимого из каталога на Яндекс Диске:

    ```python
    # %pip install requests urllib if needed

    import requests
    from urllib.parse import urlencode
    from io import BytesIO
    from zipfile import ZipFile

    base_url = 'https://cloud-api.yandex.net/v1/disk/public/resources/download?'
    public_key = '<ссылка_на_каталог_на_Яндекс_Диске>'

    final_url = base_url + urlencode(dict(public_key=public_key))
    response = requests.get(final_url)
    download_url = response.json()['href']
    response = requests.get(download_url)

    dist_path = '<путь_к_каталогу_в_проекте>'
    zipfile = ZipFile(BytesIO(response.content))
    zipfile.extractall(path=dist_path)
    ```

    Где:

    * `<ссылка_на_каталог_на_Яндекс_Диске>` — ссылка для доступа к каталогу на Яндекс Диске, содержимое которого нужно загрузить в {{ ml-platform-name }}. Чтобы получить ссылку, нажмите правой кнопкой мыши на каталог и выберите **Поделиться** ⟶ **Скопировать ссылку**.
    * `<путь_к_каталогу_в_проекте>` — путь к каталогу в проекте {{ ml-platform-name }}, в который загружаются данные. Чтобы получить путь, нажмите правой кнопкой мыши на каталог и выберите **Copy path**.

1. Запустите ячейку.