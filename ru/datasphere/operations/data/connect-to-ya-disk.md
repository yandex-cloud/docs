# Подключение к Яндекс Диску

Вы можете подключиться к сервису хранения файлов [Яндекс Диск](https://disk.yandex.ru) из интерфейса {{ ml-platform-name }}.

## Перед началом {#before-begin}

1. [Зарегистрируйте](https://yandex.ru/dev/id/doc/dg/oauth/tasks/register-client.html) ваш проект в качестве приложения в Яндекс OAuth:

    {% include [oauth-token](../../../_includes/datasphere/token-for-ya-disk.md) %}

    {% note info %}

    При первом подключении {{ ml-platform-name }} к Яндекс Диску потребуется перейти на страницу авторизации Яндекс ID и скопировать код подтверждения в поле **Enter the confirmation code** ноутбука.

    {% endnote %}

1. {% include [before-begin](../../../_includes/datasphere/ui-before-begin.md) %}


## Загрузить содержимое из файла на Яндекс Диске в файл проекта {{ ml-platform-name }} {#get-file}

1. Перейдите в новую ячейку и скопируйте туда команду для загрузки содержимого из файла на Яндекс Диске:

    ```python
    # %pip install requests urllib if needed

    import requests
    from urllib.parse import urlencode

    base_url = 'https://cloud-api.yandex.net/v1/disk/public/resources/download?'
    public_key = '<путь_к_файлу_на_Яндекс_Диске>'

    final_url = base_url + urlencode(dict(public_key=public_key))
    response = requests.get(final_url)
    download_url = response.json()['href']
    response = requests.get(download_url)

    dist_path = '<путь_к_файлу_в_проекте_{{ ml-platform-name }}>'
    with open(dist_path, 'wb') as f:
        f.write(response.content)
    ```

    Где:

    * `<путь_к_файлу_на_Яндекс_Диске>` — путь к файлу на Яндекс Диске, содержимое которого нужно загрузить в {{ ml-platform-name }}.
    * `<путь_к_файлу_в_проекте_{{ ml-platform-name }}>` — путь к файлу в проекте {{ ml-platform-name }}, в который загружаются данные.

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
    public_key = '<путь_к_каталогу_на_Яндекс_Диске>'

    final_url = base_url + urlencode(dict(public_key=public_key))
    response = requests.get(final_url)
    download_url = response.json()['href']
    response = requests.get(download_url)

    dist_path = '<путь_к_каталогу_в_проекте_{{ ml-platform-name }}>'
    zipfile = ZipFile(BytesIO(response.content))
    zipfile.extractall(path=dist_path)
    ```

    Где:

    * `<путь_к_каталогу_на_Яндекс_Диске>` — путь к каталогу на Яндекс Диске, содержимое которого нужно загрузить в {{ ml-platform-name }}.
    * `<путь_к_каталогу_в_проекте_{{ ml-platform-name }}>` — путь к каталогу в проекте {{ ml-platform-name }}, в который загружаются данные.

1. Запустите ячейку.