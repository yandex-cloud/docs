Пакет `yandex_query_magic` предоставляет _magic commands_ для работы в {{ jlab }}. Установите его для отправки запросов в {{ yq-name }}. Скопируйте код в ячейки ноутбука `yq-storage.ipynb`:

1. {% include [include](../../_includes/datasphere/ui-before-begin.md) %}

1. Установите пакет `yandex_query_magic`:

    ```python
    %pip install yandex_query_magic
    ```

1. После завершения установки на верхней панели выберите **Kernel** ⟶ **Restart kernel...**.

1. Загрузите расширение:

    ```python
    %load_ext yandex_query_magic
    ```

1. Настройте подключение, указав идентификатор каталога `data-folder` и название секрета с авторизованным ключом:

    ```sql
    %yq_settings --folder-id <идентификатор_каталога> --env-auth yq_access_key
    ```

1. Выполните тестовый запрос к {{ yq-name }}:

    ```sql
    %yq select "Hello, world!"
    ```