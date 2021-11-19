# Изменение функции

Вы можете изменить [имя](function-update.md#update-name) или [описание](function-update.md#update-description) функции, а также [управлять метками функции](function-update.md#manage-label). Для изменения кода или параметров работы функции необходимо [создать новую версию функции](version-manage.md#version-create).

{% include [function-list-note](../../../_includes/functions/function-list-note.md) %}

## Изменить имя функции {#update-name}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите изменить имя [функции](../../concepts/function.md).
    1. Откройте сервис **{{ sf-name }}**.
    1. Выберите функцию.
    1. В правом верхнем углу нажмите кнопку **Редактировать**.
    1. В открывшемся окне укажите нужное имя функции.
    1. Нажмите кнопку **Сохранить**.

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    Чтобы изменить имя функции, выполните команду:

    ```
    yc serverless function update <имя функции> --new-name <новое имя функции>
    ```

    Результат:
    ```    
    id: b097d9ous3gep99khe83
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-06-06T11:36:48.688Z"
    name: my-beta-function
    labels:
     test: test
    log_group_id: eolv6578frac08uh5h6s
    http_invoke_url: https://functions.yandexcloud.net/b097d9ous3gep99khe83
    status: ACTIVE
  ```

- API

    Изменить имя функции можно с помощью метода API [update](../../functions/api-ref/Function/update.md).

- Yandex.Cloud Toolkit

    Изменить имя функции можно с помощью [плагина Yandex.Cloud Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) для семейства IDE на [платформе Intellij](https://www.jetbrains.com/ru-ru/opensource/idea/) от [JetBrains](https://www.jetbrains.com/).

{% endlist %}


## Изменить описание функции {#update-description}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите изменить описание [функции](../../concepts/function.md).
    1. Откройте сервис **{{ sf-name }}**.
    1. Выберите функцию.
    1. В правом верхнем углу нажмите кнопку **Редактировать**.
    1. В открывшемся окне укажите нужное описание функции.
    1. Нажмите кнопку **Сохранить**.        
    
- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    Чтобы изменить описание функции, выполните команду:

    ```
    yc serverless function update <имя функции> --description "<описание функции>"
    ```

    Результат:

    ```       
    id: b097d9ous3gep99khe83
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-06-06T11:36:48.688Z"
    name: my-beta-function
    description: My beta function.
    labels:
      test: test
    log_group_id: eolv6578frac08uh5h6s
    http_invoke_url: https://functions.yandexcloud.net/b097d9ous3gep99khe83
    status: ACTIVE
   ```

- API

    Изменить описание функции можно с помощью метода API [update](../../functions/api-ref/Function/update.md).

- Yandex.Cloud Toolkit

    Изменить описание функции можно с помощью [плагина Yandex.Cloud Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) для семейства IDE на [платформе Intellij](https://www.jetbrains.com/ru-ru/opensource/idea/) от [JetBrains](https://www.jetbrains.com/).

{% endlist %}

## Управлять метками функции {#manage-label}

Вы можете выполнять следующие действия с метками функции:

- [Добавить](#add-label)
- [Изменить](#update-label)
- [Удалить](#remove-label)

### Добавить метку {#add-label}

{% list tabs %}

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    Чтобы добавить метку функции, выполните команду:

    ```
    yc serverless function add-labels <имя функции> --labels <ключ>=<значение>
    ```

    Результат:

    ```     
    id: b097d9ous3gep99khe83
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-06-06T11:36:48.688Z"
    name: my-beta-function
    description: My beta function.
    labels:
      test: test
      version: beta
    log_group_id: eolv6578frac08uh5h6s
    http_invoke_url: https://functions.yandexcloud.net/b097d9ous3gep99khe83
    status: ACTIVE
    ```

- API

    Добавить метку функции можно с помощью метода API [update](../../functions/api-ref/Function/update.md).

{% endlist %}

### Изменить метку {#update-label}

{% list tabs %}

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    Чтобы изменить метку функции, выполните команду:
  
    {% note warning %}
    
    Существующий набор `labels` полностью перезаписывается набором, переданным в запросе.
    
    {% endnote %}

    ```
    yc serverless function update <имя функции> --labels <ключ>=<значение>
    ```

    Результат:

    ```
    id: b097d9ous3gep99khe83
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-06-06T11:36:48.688Z"
    name: my-beta-function
    description: My beta function.
    labels:
      new_labels: my-beta-function
    log_group_id: eolv6578frac08uh5h6s
    http_invoke_url: https://functions.yandexcloud.net/b097d9ous3gep99khe83
    ```

- API

    Изменить метки функции можно с помощью метода API [update](../../functions/api-ref/Function/update.md).

{% endlist %}

### Удалить метку {#remove-label}

{% list tabs %}

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
    
    Чтобы удалить метку функции, выполните команду:

    ```
    yc serverless function remove-labels <имя функции> --labels <ключ>
    ```

    Результат:

    ```
    id: b097d9ous3gep99khe83
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-06-06T11:36:48.688Z"
    name: my-beta-function
    description: My beta function.
    labels:
      version: beta
    log_group_id: eolv6578frac08uh5h6s
    http_invoke_url: https://functions.yandexcloud.net/b097d9ous3gep99khe83
    status: ACTIVE
    ```

- API

    Удалить метку функции можно с помощью метода API [update](../../functions/api-ref/Function/update.md).

{% endlist %}
