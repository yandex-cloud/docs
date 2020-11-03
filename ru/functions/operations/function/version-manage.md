# Управление версиями функции

Управление версиями функции позволяет:

- [Создать версию](version-manage.md#func-version-create)
- [Получить информацию о версии функции](version-manage.md#version-info)
    - [Получить список версий функции](version-manage.md#version-list)
    - [Получить подробную информацию о версии функции](version-manage.md#version-get)
- [Управлять тегами версии](function-update.md#manage-tags)

Вы можете изменить код функции с помощью [редактора кода](function-editor.md).

{% note info %}

Для сохранения целостности связей изменение и удаление версий функции не предусмотрено. Подробнее о взаимосвязи ресурсов читайте в разделе [{#T}](../../concepts/function.md).

{% endnote %}

##  Получить список функций {#function-list}

Для управления версиями функции нужны имя или уникальный идентификатор функции, которой эта версия принадлежит. Чтобы узнать их, получите список функций.

{% include [function-list](../../../_includes/functions/function-list.md) %}

## Создать версию функции {#func-version-create}

{% include [create-version](../../../_includes/functions/create-version.md) %}

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
- _Точка входа_ — имя функции, которая будет вызываться в качестве обработчика. Подробнее об обработчике читайте в разделе [Модель программирования](../../concepts/function.md#programming-model).
- _Таймаут_ — максимальное время выполнения функции, после которого сервис прервет выполнение, не дожидаясь ответа. Включает в себя время начальной инициализации при первом запуске.

{% list tabs %}

- Консоль управления
    
    Создайте версию функции: 
    1. Откройте **{{ sf-name }}** в каталоге, где требуется создать версию функции.
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

    {% include [cli-install](../../../_includes/cli-install.md) %}
    
    Создайте версию функции:
    
    ```
    $ yc serverless function version create \
    --function-name=my-nodejs-function \ # Имя функции.
    --runtime nodejs12 \ # Среда выполенения.
    --entrypoint index.handler \ # Обработчик, указывается в формате <имя файла с функцией>.<имя обработчика>.
    --memory 128m \ # Объем RAM.
    --execution-timeout 5s \ # Максимальное время выполнения функции до таймаута.
    --source-path ./hello-js.zip # ZIP-архив c кодом функции и всеми необходимыми зависимостями.    
    ```
    Результат:
    ```
    done (1s)
    id: d4evvn8obisajd51plaq
    function_id: d4elpv8pft639ku7k0u6
    created_at: "2020-08-01T19:09:19.531Z"
    runtime: nodejs12
    entrypoint: index.handler
    resources:
    memory: "134217728"
    execution_timeout: 5s
    image_size: "4096"
    status: ACTIVE
    tags:
    - $latest
    log_group_id: ckg3qh8h363p40gmr9gn
    ```

{% endlist %}

## Получить информацию о версии функции {#version-info}

### Получить список версий функции {#version-list}

{% include [version-list](../../../_includes/functions/version-list.md) %}

### Получить подробную информацию о версии функции {#version-get}

{% include [version-get](../../../_includes/functions/version-get.md) %}

## Добавить переменную окружения {#version-env}

При добавлении переменных окружения создается новая версия функции. В существующую версию переменные добавить нельзя.

{% list tabs %}

- Консоль управления
    
    1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ sf-name }}**.
    1. Нажмите значок ![image](../../../_assets/vertical-ellipsis.svg) в строке функции, для версии которой вы хотите добавить переменную окружения.
    1. Откройте раздел **Редактор**. 
    1. В открывшемся окне в блоке **Параметры** добавьте переменную окружения в поле **Переменные окружения** и нажмите **Добавить переменную окружения**. Можно добавить несколько переменных.
    1. Нажмите кнопку **Создать версию** в верхнем правом углу. Будет создана новая версия функции с указанными переменными окружения. 
    
- CLI

    Выполните команду:

    ```
    $ yc serverless function version create \
    --function-name=<имя функции> \ # Имя функции.
    --runtime <среда выполнения> \ # Среда выполнения.
    --entrypoint <обработчик> \ # Обработчик, указывается в формате <имя файла с функцией>.<имя обработчика>.
    --memory 128m \ # Объем RAM.
    --execution-timeout 5s \ # Максимальное время выполнения функции до таймаута.
    --source-version-id <идентификатор версии> \ # id версии, с которой копируем исполняемый код
    --environment <переменные окружения> # Переменные окружения в формате key=value. Можно указать несколько пар через запятую
    ```   
    Если в прошлой версии уже были переменные окружения, эта команда их перезапишет.

{% end list %}

## Управлять тегами версии {#manage-tags}

При создании новой версии, ей присваивается [тег](../../concepts/function.md#) по умолчанию — `$latest`. Вы можете [добавить](version-manage.md#set-tag) или [удалить](version-manage.md#remove-tag) тег версии.

Для обращения к версии функции используйте ее уникальный идентификатор. Как узнать уникальный идентификатор версии, читайте в пункте [Получить список версий функции](version-manage.md#version-list).

### Добавить тег {#set-tag}

{% list tabs %}

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    Добавьте тег версии:

    ```
    $ yc serverless function version set-tag --id <идентификатор версии> --tag <тег>
    ```
    Результат:
    ```
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

    {% include [cli-install](../../../_includes/cli-install.md) %}

    Удалите тег версии:

    ```
    $ yc serverless function version remove-tag --id <идентификатор версии> --tag <тег>
    ```
    Результат:
    ```
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
