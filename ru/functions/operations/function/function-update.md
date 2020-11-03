# Изменение функции

Вы можете изменить [имя](function-update.md#update-name) или [описание](function-update.md#update-description) функции, а также [управлять метками функции](function-update.md#manage-label). Для изменения кода или параметров работы функции необходимо [создать новую версию функции](version-manage.md#version-create).

{% include [function-list-note](../../../_includes/functions/function-list-note.md) %}

## Изменить имя функции {#update-name}

{% list tabs %}

- Консоль управления

    Чтобы изменить имя [функции](../../concepts/function.md):
    1. Откройте раздел **{{ sf-name }}** в каталоге, где требуется изменить функцию.
    1. В списке функций выберите функцию, которую необходимо изменить.
    1. В открывшемся окне нажмите кнопку **Редактировать**.
    1. В открывшемся окне укажите нужное имя функции.
    1. Нажмите кнопку **Сохранить**.

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    Измените имя функции:
    
    ```
    $ yc serverless function update <имя функции> --new-name <новое имя функции>
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
  
{% endlist %}


## Изменить описание функции {#update-description}

{% list tabs %}

- Консоль управления

    Чтобы изменить имя [функции](../../concepts/function.md):
    1. Откройте раздел **{{ sf-name }}** в каталоге, где требуется изменить функцию.
    1. В списке функций выберите функцию, которую необходимо изменить.
    1. В открывшемся окне нажмите кнопку **Редактировать**.
    1. В открывшемся окне укажите нужное описание функции.
    1. Нажмите кнопку **Сохранить**.        
    
- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    Измените описание функции:
    
    ```
    $ yc serverless function update <имя функции> --description "<описание функции>"
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
    
    Добавьте метку функции:
    
    ```
    $ yc serverless function add-labels <имя функции> --labels <ключ>=<значение>
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

{% endlist %}

### Изменить метку {#update-label}

{% list tabs %}

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    Измените метку функции:
  
    {% note warning %}
    
    Существующий набор `labels` полностью перезаписывается набором, переданным в запросе.
    
    {% endnote %}
  
    ```
    $ yc serverless function update <имя функции> --labels <ключ>=<значение>
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
  
{% endlist %}

### Удалить метку {#remove-label}

{% list tabs %}

- CLI
  
    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    Удалите метку функции:
    
    ```
    $ yc serverless function remove-labels <имя функции> --labels <ключ>
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
  
{% endlist %}
