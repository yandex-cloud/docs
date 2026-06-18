## Подготовьте код для навыка Алисы {#prepare-code}

Для создания [версии](*function_version) функции вы можете воспользоваться одним из [форматов загрузки кода](*upload_formats). Для примера код будет загружен в формате ZIP-архива.

{% list tabs group=programming_language %}

- Python {#python}

    1. Скачайте из репозитория на GitHub файл с примером: [parrot.py](https://github.com/yandex-cloud-examples/yc-alice-skill-python/blob/main/parrot/parrot.py).
    1. Создайте ZIP-архив `parrot-py.zip` с файлом `parrot.py`.

- Node.js {#node}

    1. Скачайте из репозитория на GitHub файл с примером: [index.js](https://github.com/yandex-cloud-examples/yc-alice-skill-node/blob/main/parrot/index.js).
    1. Создайте ZIP-архив `parrot-js.zip` с файлом `index.js`.

{% endlist %}

[*function_version]: Версия содержит код функции, параметры запуска, а также все необходимые зависимости. На разных стадиях процесса разработки вы можете работать с разными версиями одной функции. Подробнее читайте в разделе [{#T}](../../../functions/concepts/function.md#version).

[*upload_formats]: Загружать код версии функции можно несколькими способами: в редакторе в консоли управления, из локальных файлов и директорий или в виде архива. Подробнее читайте в разделе [{#T}](../../../functions/concepts/function.md#upload).