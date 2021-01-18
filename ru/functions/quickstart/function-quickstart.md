# Создание и выполнение функции

Создайте и выполните [функцию](../concepts/function.md), которая приветствует пользователя. Используйте для этого языки программирования Python или Node.js.

- [Перед началом работы](#before-begin)
- [Создайте функцию на Python](#python-func)
    - [Создайте функцию](#create-py-func)
    - [Создайте первую версию функции](#create-py-version)
- [Создайте функцию на Node.js](#nodejs-func)
    - [Создайте функцию](#create-js-func)
    - [Создайте первую версию функции](#create-js-version)
- [Вызовите функцию](#invoke)
- [Что дальше](#what-is-next)

## Перед началом работы {#before-you-begin}

1. [Создайте каталог](../../resource-manager/operations/folder/create.md) в {{ yandex-cloud }}.
1. [Установите](../../cli/quickstart.md) интерфейс командной строки YC CLI.

## Создайте функцию на Python {#python-func}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать функцию.
  1. Откройте сервис **{{ sf-name }}**
  1. Нажмите кнопку **Создать функцию**.
  1. Введите имя и описание функции. Формат имени:

      {% include [name-format](../../_includes/name-format.md) %}

  1. Нажмите кнопку **Создать**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать функцию, выполните команду:

  ```
  yc serverless function create --name=my-python-function
  ```

  Результат:

  ```
  .done
  id: b09bhaokchn9pnbrlseb
  folder_id: aoek49ghmknnpj1ll45e
  created_at: "2019-06-14T10:03:37.475Z"
  name: my-python-function
  log_group_id: eolm8aoq9vcppsieej6h
  http_invoke_url: https://functions.yandexcloud.net/b09bhaokchn9pnbrlseb
  ```

- API

  Создать функцию можно с помощью метода API [create](../functions/api-ref/Function/create.md).

{% endlist %}

### Создайте первую версию функции {#create-py-version}

{% include [create-version](../../_includes/functions/create-version.md) %}

#### Подготовьте ZIP-архив с кодом функции {#create-py-zip}

1. Сохраните следующий код в файл с названием `main.py`:

    ```
    def handler(event, context):
        name = 'World'
        if 'queryStringParameters' in event and 'name' in event['queryStringParameters']:
            name = event['queryStringParameters']['name']

        return {
            'statusCode': 200,
            'headers': {
                'Content-Type': 'text/plain'
            },
            'isBase64Encoded': False,
            'body': 'Hello, {}!'.format(name)
        }
    ```
1. Добавьте файл `main.py` в ZIP-архив `hello-py.zip`.

#### Создайте версию функции {#create-py-version}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
  1. Откройте сервис **{{ sf-name }}**
  1. Выберите функцию, версию которой хотите создать.
  1. В разделе **Последняя версия** нажмите кнопку **Создать в редакторе**.
  1. Задайте параметры версии:
      - **Среда выполнения:** `python37`.
      - **Таймаут, секунды:** 5.
      - **Память:** 128 МБ.
      - **Сервисный аккаунт:** Не выбрано.
  1. Подготовьте код функции:
      - **Способ:** ZIP-архив.
      - **Файл:** `hello-py.zip`.
      - **Точка входа:** `main.handler`.
  1. Нажмите кнопку **Создать версию**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создайть версию функции, выполните команду:

  ```
  yc serverless function version create \
  --function-name=my-python-function \
  --runtime python37 \
  --entrypoint main.handler \
  --memory 128m \
  --execution-timeout 5s \
  --source-path ./hello-py.zip
  ```

  где:

  `--function-name` — имя функции.
  `--runtime` — среда выполнения.
  `--entrypoint` — точка входа, указывается в формате <имя файла с функцией>.<имя обработчика>.
  `--memory` — объем RAM.
  `--execution-timeout` — максимальное время выполнения функции до таймаута.
  `--source-path` — ZIP-архив c кодом функции и необходимыми зависимостями.

- API

  Создать версию функции можно с помощью метода API [createVersion](../functions/api-ref/Function/createVersion.md).

{% endlist %}

## Создайте функцию на Node.js {#nodejs-func}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать функцию.
  1. Откройте сервис **{{ sf-name }}**
  1. Нажмите кнопку **Создать функцию**.
  1. Введите имя и описание функции. Формат имени:

      {% include [name-format](../../_includes/name-format.md) %}

  1. Нажмите кнопку **Создать**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать функцию, выполните команду:

  ```
  yc serverless function create --name=my-nodejs-function
  ```

  Результат:

  ```
  ..........done
  id: b09hnm3nucbm1tk8dops
  folder_id: aoek49ghmknnpj1ll45e
  created_at: "2019-06-14T09:53:39.885Z"
  name: my-nodejs-function
  log_group_id: eol8eetd68mq3849eurs
  http_invoke_url: https://functions.yandexcloud.net/b09hnm3nucbm1tk8dops
  ```

- API

  Создать функцию можно с помощью метода API [create](../functions/api-ref/Function/create.md).

{% endlist %}

### Создайте первую версию функции {#create-js-version}

Чтобы создать версию функции вам понадобится ZIP-архив с кодом функции и всеми необходимыми зависимостями.

#### Подготовьте ZIP-архив с кодом функции {#create-js-zip}

{% include [create-js-zip](../../_includes/functions/create-js-zip.md) %}

#### Создайте версию функции {#create-js-func}

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

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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
    `--runtime` — среда выполенения.
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

    Создать версию функции можно с помощью метода API [createVersion](../../functions/functions/api-ref/Function/createVersion.md).

{% endlist %}

## Вызовите функцию {#invoke}

{% note info %}

Чтобы любой пользователь мог вызывать функцию, необходимо [сделать ее публичной](../operations/function-public.md). Подробнее о правах читайте в разделе [{#T}](../security/index.md).

{% endnote %}

Для обращения к функции используйте ее имя или уникальный идентификатор. Чтобы узнать их, выполните команду:

```
yc serverless function list
```

Результат:

```
+----------------------+--------------------+----------------------+
|          ID          |        NAME        |      FOLDER ID       |
+----------------------+--------------------+----------------------+
| b097d9ous3gep99khe83 | my-beta-function   | aoek49ghmknnpj1ll45e |
| b09bhaokchn9pnbrlseb | my-python-function | aoek49ghmknnpj1ll45e |
| b09hnm3nucbm1tk8dops | my-nodejs-function | aoek49ghmknnpj1ll45e |
+----------------------+--------------------+----------------------+
```

{% list tabs %}

- HTTP

    {% note info %}

    Для обеспечения безопасности вызов функции возможен только с использованием протокола TLS.

    {% endnote %}

    Вы можете посмотреть ссылку для вызова функции в параметре `http_invoke_url` при [создании функции](../operations/function/function-create.md).

    Вызовите функцию как обычный HTTP-запрос, вставив ссылку в адресную строку браузера. В данном случае используется пример функции на [Python](#python-func):

    ```
    https://functions.yandexcloud.net/b09bhaokchn9pnbrlseb
    ```

    На странице появится ответ:

    ```
    Hello, World!
    ```

    При вызове функции вы можете добавлять в URL параметры. В качестве примера добавьте параметр `name`:

    ```
    https://functions.yandexcloud.net/b09bhaokchn9pnbrlseb?name=Username
    ```

    На странице появится следующий ответ:

    ```
    Hello, Username!
    ```

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Вызовите функцию, указав в параметре имя для приветствия:

    ```
    yc serverless function invoke my-python-function -d '{"queryStringParameters": {"name": "Username"}}'
    {"statusCode":200,"isBase64Encoded":false,"body":"{\"message\":\"Hello, Username!\"}"}
    ```

{% endlist %}

## Что дальше {#what-is-next}

- Прочитайте, какой должна быть структура функции для вызова разными способами (HTTP, CLI), в разделе [{#T}](../concepts/function-invoke.md).
- Ознакомьтесь с [концепциями сервиса](../concepts/index.md).
- Посмотрите, что можно делать с функциями и версиями в [пошаговых инструкциях](../operations/index.md).
