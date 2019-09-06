# Создание функции

{% list tabs %}

- Консоль управления

    1. В консоли управления выберите каталог, в котором будет создана функция.
    1. Нажмите кнопку **Создать ресурс**.
    1. Выберите **Функция**.
    1. Введите имя функции.
    
        {% include [name-format](../../_includes/name-format.md) %}
    
    1. Нажмите кнопку **Создать**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}    

    Создайте функцию:

    ```
    $ yc serverless function create --name=my-python-function
    .done
    id: b09bhaokchn9pnbrlseb
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-06-14T10:03:37.475Z"
    name: my-python-function
    log_group_id: eolm8aoq9vcppsieej6h
    http_invoke_url: https://functions.yandexcloud.net/b09bhaokchn9pnbrlseb
    ```

{% endlist %}
