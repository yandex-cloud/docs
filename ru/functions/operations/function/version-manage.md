# Управление версиями функции

Управление версиями функции позволяет:

- [Создать версию](version-manage.md#func-version-create)
- [Получить информацию о версии функции](version-manage.md#version-info)
    - [Получить список версий функции](version-manage.md#version-list)
    - [Получить подробную информацию о версии функции](version-manage.md#version-get)
- [Добавить переменную окружения](version-manage.md#version-env)
- [Управлять тегами версии](version-manage.md#manage-tags)

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

{% include [create-js-zip](../../../_includes/functions/create-js-zip.md) %}

### Создать версию функции {#version-create}

При создании версии необходимо задать следующие параметры:
- _Среда выполнения_ — предоставляет дополнительные библиотеки и переменные окружения, к которым можно получить доступ из кода функции. Соответствует языку программирования, на котором написана ваша функция.
- _Точка входа_ — функция, которая будет вызываться в качестве обработчика. Подробнее об обработчике читайте в разделе [Модель программирования](../../concepts/function.md#programming-model).
- _Таймаут_ — максимальное время выполнения функции, после которого сервис прервет выполнение, не дожидаясь ответа. Включает в себя время начальной инициализации при первом запуске.

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Откройте сервис **{{ sf-name }}**.
    1. Выберите функцию, версию которой хотите создать.
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

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы создать версию функции, выполните команду:

    ```
    yc serverless function version create \
    --function-name=my-nodejs-function \
    --runtime nodejs12 \
    --entrypoint index.handler \
    --memory 128m \
    --execution-timeout 5s \
    --source-path ./hello-js.zip
    ```

    где:

    `--function-name` — имя функции, версию которой вы хотите создать.
    `--runtime` — среда выполнения.
    `--entrypoint` — точка входа, указывается в формате <имя файла с функцией>.<имя обработчика>.
    `--memory` — объем RAM.
    `--execution-timeout` — максимальное время выполнения функции до таймаута.
    `--source-path` — ZIP-архив c кодом функции и необходимыми зависимостями.

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

- API

    Создать версию функции можно с помощью метода API [createVersion](../../functions/api-ref/Function/createVersion.md).

- Yandex Cloud Toolkit

    Создать версию функции можно с помощью [плагина Yandex Cloud Toolkit]{% if lang == "ru" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains){% endif %}{% if lang == "en" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md){% endif %} для семейства IDE на [платформе IntelliJ]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/opensource/idea/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/opensource/idea/){% endif %} от [JetBrains](https://www.jetbrains.com/).

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
    
    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Откройте сервис **{{ sf-name }}**.
    1. Выберите функцию, для версии которой хотите добавить переменную окружения.
    1. Перейдите на вкладку **Редактор**.
    1. В открывшемся окне, в блоке **Параметры**, укажите переменную окружения и нажмите **Добавить переменную окружения**. Можно добавить несколько переменных окружения.
    1. Нажмите кнопку **Создать версию**. Будет создана новая версия функции с указанными переменными окружения.
    
- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы добавить переменные окружения, выполните команду:

    {% note warning %}

    Если в прошлой версии уже были переменные окружения, они перезапишутся.

    {% endnote %}

    ```
    yc serverless function version create \
    --function-name=<имя функции> \
    --runtime <среда выполнения> \
    --entrypoint <точка входа> \
    --memory 128m \
    --execution-timeout 5s \
    --source-version-id <идентификатор версии> \
    --environment <переменные окружения>
    ```

    где:

    `--function-name` — имя функции.
    `--runtime` — среда выполнения.
    `--entrypoint` — точка входа, указывается в формате <имя файла с функцией>.<имя обработчика>.
    `--memory` — объем RAM.
    `--execution-timeout` — максимальное время выполнения функции до таймаута.
    `--source-version-id` — ID версии функции, код которой вы хотите скопировать.
    `--environment` — переменные окружения в формате key=value. Можно указать несколько пар через запятую.

- API

    Добавить переменные окружения можно с помощью метода API [createVersion](../../functions/api-ref/Function/createVersion.md).

- Yandex Cloud Toolkit

    Добавить переменные окружения можно с помощью [плагина Yandex Cloud Toolkit]{% if lang == "ru" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains){% endif %}{% if lang == "en" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md){% endif %} для семейства IDE на [платформе IntelliJ]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/opensource/idea/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/opensource/idea/){% endif %} от [JetBrains](https://www.jetbrains.com/).

{% endlist %}

## Управлять тегами версии {#manage-tags}

При создании новой версии ей присваивается [тег](../../concepts/function.md#) по умолчанию — `$latest`. Вы можете [добавить](version-manage.md#set-tag) или [удалить](version-manage.md#remove-tag) тег версии.

Для обращения к версии функции используйте ее уникальный идентификатор. Как узнать уникальный идентификатор версии, читайте в разделе [Получить список версий функции](version-manage.md#version-list).

### Добавить тег {#set-tag}

{% list tabs %}

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы добавить тег версии, выполните команду:

    ```
    yc serverless function version set-tag --id <идентификатор версии> --tag <тег>
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

- API

    Добавить тег можно с помощью метода API [setTag](../../functions/api-ref/Function/setTag.md).

- Yandex Cloud Toolkit

    Добавить тег можно с помощью [плагина Yandex Cloud Toolkit]{% if lang == "ru" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains){% endif %}{% if lang == "en" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md){% endif %} для семейства IDE на [платформе IntelliJ]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/opensource/idea/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/opensource/idea/){% endif %} от [JetBrains](https://www.jetbrains.com/).

{% endlist %}

### Удалить тег {#remove-tag}

{% list tabs %}

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы удалить тег версии, выполните команду:

    ```
    yc serverless function version remove-tag --id <идентификатор версии> --tag <тег>
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

- API

    Удалить тег можно с помощью метода API [removeTag](../../functions/api-ref/Function/removeTag.md).

- Yandex Cloud Toolkit

    Удалить тег можно с помощью [плагина Yandex Cloud Toolkit]{% if lang == "ru" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains){% endif %}{% if lang == "en" %}(https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md){% endif %} для семейства IDE на [платформе IntelliJ]{% if lang == "ru" %}(https://www.jetbrains.com/ru-ru/opensource/idea/){% endif %}{% if lang == "en" %}(https://www.jetbrains.com/opensource/idea/){% endif %} от [JetBrains](https://www.jetbrains.com/).

{% endlist %}
