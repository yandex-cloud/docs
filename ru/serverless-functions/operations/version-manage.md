# Управление версиями функции

Для управления версиями функции необходимо знать имя или уникальный идентификатор функции, которой эта версия принадлежит. 

{% include [yc-function-list](../../_includes/serverless-functions/function-list.md) %}

Управление версиями функции позволяет:  

- [Создать версию](version-manage.md#func-version-create)
- [Получить информацию о версии функции](version-manage.md#info)
    - [Получить список версий функции](version-manage.md#version-list)
    - [Получить подробную информацию о версии функции](version-manage.md#version-get)  
- [Управлять тегами версии](function-update.md#manage-tags)

{% note info %}

Изменение и удаление версий функции не предусмотрено, для сохранения целостности связей. Подробнее о взаимосвязи ресурсов читайте в разделе [#T](../concepts/function.md).

{% endnote %}

## Создать версию функции {#func-version-create}

Для создания [версии](../concepts/function.md#version) функции вам понадобится ZIP-архив с функцией и всеми необходимыми зависимостями.

### Подготовить ZIP-архив с кодом функции {#zip-archive}

1. Сохраните следующий код в файл с названием `index.js`:

    ```
    exports.handler = async function (event, context) {
        let name = 'World';
        if (event.queryStringParameters && event.queryStringParameters.name) {
            name = event.queryStringParameters.name
        }
        return {
            'statusCode': 200,
            'headers': {
                'Content-Type': 'text/plain'
            },
            'isBase64Encoded': false,
            'body': `Hello, ${name}!`
        }
    };
    ```

1. Добавьте файл `index.js` в ZIP-архив `hello-js.zip`.

### Создать версию функции {#version-create}

При создании версии необходимо задать следующие параметры:
- _Среда выполнения_ — предоставляет дополнительные библиотеки и переменные окружения, к которым можно получить доступ из кода функции. Соответствует языку программирования, на котором написана ваша функция. 
- _Точка входа_ — имя функции, которая будет вызываться в качестве обработчика. Подробнее об обработчике читайте в разделе [Модель программирования](../concepts/function.md#programming-model).
- _Таймаут_ — максимальное время выполнения функции, после которого сервис прервет выполнение, не дожидаясь ответа. Включает в себя время начальной инициализации при первом запуске.

{% list tabs %}

- Консоль управления
  
  1. Откройте **Serverless Functions** в каталоге, где требуется создать версию функции.
  1. Выберите функцию, для которой необходимо создать версию.
  1. В разделе **Последняя версия** нажмите кнопку **Создать в редакторе**.
  1. Задайте параметры версии: 
      - Среда выполнения: `nodejs`.
      - Таймаут, с: 5.
      - Память: 128 МБ.
      - Сервисный аккаунт: Не выбрано.
  1. Подготовьте код функции: 
      - Способ: ZIP-архив.
      - Файл: `hello-js.zip`.
      - Точка входа: `index.handler`.
  1. Нажмите кнопку **Создать версию**.
  
- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  Создайте версию функции: 
  
  ```
  $ yc serverless function version create \
  --function-name=my-nodejs-function \ # Имя функции.
  --runtime nodejs10 \ # Среда выполенения.
  --entrypoint index.handler \ # Обработчик, указывается в формате <имя файла с функцией>.<имя обработчика>.
  --memory 128m \ # Объем RAM. 
  --execution-timeout 5s \ # Максимальное время выполнения функции до таймаута.
  --source-path ./hello-js.zip # ZIP-архив c кодом функции и всеми необходимыми зависимостями.
  ```
  
{% endlist %}

## Получить информацию о версии функции {#version-info}

### Получить список версий функции {#version-list}

{% list tabs %}

- Консоль управления

    1. Откройте **Serverless Functions** в каталоге с функцией, для которой требуется получить список версий.
    1. Выберите функцию, для которой необходимо получить список версий.
    1. В разделе **История версий** будет показан список версий функции и подробная информация о них.  

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}
    
    ```
    $ yc serverless function version list --function-name my-beta-function
    +----------------------+----------------------+----------+--------------+---------+---------------------+
    |          ID          |     FUNCTION ID      | RUNTIME  |  ENTRYPOINT  |  TAGS   |     CREATED AT      |
    +----------------------+----------------------+----------+--------------+---------+---------------------+
    | b09u830mb1n32a7rj0n8 | b097d9ous3gep99khe83 | python37 | test.handler | $latest | 2019-06-13 09:23:23 |
    | b09ch6pmpohfc9sogj5f | b097d9ous3gep99khe83 | python37 | test.handler | beta    | 2019-06-13 09:12:38 |
    +----------------------+----------------------+----------+--------------+---------+---------------------+
    ```
    
{% endlist %}

### Получить подробную информацию о версии функции {#version-get}

{% list tabs %}

- Консоль управления

    1. Откройте **Serverless Functions** в каталоге с функцией, для которой требуется получить список версий.
    1. Выберите функцию, для которой необходимо получить список версий.
    1. В разделе **История версий** будет показан список версий функции и подробная информация о них.

- CLI 

    {% include [cli-install](../../_includes/cli-install.md) %}

    Для обращения к версии используйте параметры `ID` или `TAGS` из [предыдущего](version-manage.md#version-list) пункта.

    - Получите подробную информацию о версии с помощью **уникального идентификатора**:

        ```
        $ yc serverless function version get b09u830mb1n32a7rj0n8
        
        id: b09u830mb1n32a7rj0n8
        function_id: b097d9ous3gep99khe83
        description: test2
        created_at: "2019-06-13T09:23:23.383Z"
        runtime: python37
        entrypoint: test.handler
        resources:
          memory: "134217728"
        execution_timeout: 5s
        image_size: "4096"
        status: ACTIVE
        tags:
        - $latest
        log_group_id: eolv6578frac08uh5h6s
    
    - Получите подробную информацию о версии с помощью **тега**:
        
        ````
        $ yc serverless function version get-by-tag --function-name my-beta-function --tag beta
        
        id: b09ch6pmpohfc9sogj5f
        function_id: b097d9ous3gep99khe83
        created_at: "2019-06-13T09:12:38.464Z"
        runtime: python37
        entrypoint: test.handler
        resources:
          memory: "134217728"
        execution_timeout: 5s
        image_size: "4096"
        status: ACTIVE
        tags:
        - beta
        log_group_id: eolv6578frac08uh5h6s
        ```

{% endlist %}

## Управлять тегами версии {#manage-tags}

При создании новой версии, ей присваивается [тег](../concepts/function.md#) по умолчанию — `$latest`. Вы можете [добавить](version-manage.md#set-tag) или [удалить](version-manage.md#remove) тег версии.

Для обращения к версии функции используйте ее уникальный идентификатор. Как узнать уникальный идентификатор версии, читайте в пункте [Получить список версий функции](version-manage.md#version-list).

### Добавить тег {#set-tag}

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}
    
    Добавьте тег версии:
    
    ```
    $ yc serverless function version set-tag --id b09ch6pmpohfc9sogj5f --tag first
    
    id: b09ch6pmpohfc9sogj5f
    function_id: b097d9ous3gep99khe83
    created_at: "2019-06-13T09:12:38.464Z"
    runtime: python37
    entrypoint: test.handler
    resources:
      memory: "134217728"
    execution_timeout: 5s
    image_size: "4096"
    status: ACTIVE
    tags:
    - beta
    - first
    log_group_id: eolv6578frac08uh5h6s
    ```

{% endlist %}

### Удалить тег {#remove-tag}

{% list tabs %}

- CLI
  
    {% include [cli-install](../../_includes/cli-install.md) %}
    
    Удалите тег версии:
    
    ```
    $ yc serverless function version remove-tag --id b09ch6pmpohfc9sogj5f --tag first
    
    id: b09ch6pmpohfc9sogj5f
    function_id: b097d9ous3gep99khe83
    created_at: "2019-06-13T09:12:38.464Z"
    runtime: python37
    entrypoint: test.handler
    resources:
      memory: "134217728"
    execution_timeout: 5s
    image_size: "4096"
    status: ACTIVE
    tags:
    - beta
    log_group_id: eolv6578frac08uh5h6s
    ```
  
{% endlist %}
