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

  1. В консоли управления выберите каталог, в котором будет создана функция.
  1. Нажмите кнопку **Создать ресурс**.
  1. Выберите **Функция**.
  1. Введите имя функции.

      {% include [name-format](../../_includes/name-format.md) %}

  1. Нажмите кнопку **Создать**.

- CLI

  Создайте функцию с помощью команды:

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

#### Создайте версию функции {#create-py-version}

1. Добавьте файл `main.py` в ZIP-архив `hello-py.zip`.

{% list tabs %}

- Консоль управления

  1. Откройте **{{ sf-name }}** в каталоге, где требуется создать [версию](../concepts/function.md#version) функции.
  1. Выберите функцию, для которой необходимо создать версию.
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

  Создайте версию функции:

  ```
  $ yc serverless function version create \
  --function-name=my-python-function \ # Имя функции.
  --runtime python37 \ # Среда выполнения.
  --entrypoint main.handler \ # Обработчик, указывается в формате <имя файла с функцией>.<имя обработчика>.
  --memory 128m \ # Объем RAM.
  --execution-timeout 5s \ # Максимальное время выполнения функции до таймаута.
  --source-path ./hello-py.zip # ZIP-архив c кодом функции и всеми необходимыми зависимостями.
  ```

{% endlist %}

## Создайте функцию на Node.js {#nodejs-func}

{% list tabs %}

- Консоль управления

  1. В консоли управления выберите каталог, в котором будет создана функция.
  1. Нажмите кнопку **Создать ресурс**.
  1. Выберите **Функция**.
  1. Введите имя функции.

      {% include [name-format](../../_includes/name-format.md) %}

  1. Нажмите кнопку **Создать**.

- CLI

  Создайте функцию с помощью команды:

  ```
  $ yc serverless function create --name=my-nodejs-function
  ..........done
  id: b09hnm3nucbm1tk8dops
  folder_id: aoek49ghmknnpj1ll45e
  created_at: "2019-06-14T09:53:39.885Z"
  name: my-nodejs-function
  log_group_id: eol8eetd68mq3849eurs
  http_invoke_url: https://functions.yandexcloud.net/b09hnm3nucbm1tk8dops
  ```

{% endlist %}

### Создайте первую версию функции {#create-js-version}

Чтобы создать версию функции вам понадобится ZIP-архив с кодом функции и всеми необходимыми зависимостями.

#### Подготовьте ZIP-архив с кодом функции {#create-js-zip}

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

#### Создайте версию функции {#create-js-func}

{% list tabs %}

- Консоль управления

  1. Откройте **{{ sf-name }}** в каталоге, где требуется создать версию функции.
  1. Выберите функцию, для которой необходимо создать версию.
  1. В разделе **Последняя версия** нажмите кнопку **Создать в редакторе**.
  1. Задайте параметры версии:
      - **Среда выполнения:** `nodejs12`.
      - **Таймаут, секунды:** 5.
      - **Память:** 128 МБ.
      - **Сервисный аккаунт:** Не выбрано.
  1. Подготовьте код функции:
      - **Способ:** ZIP-архив.
      - **Файл:** `hello-js.zip`.
      - **Точка входа:** `index.handler`.
  1. Нажмите кнопку **Создать версию**.

- CLI

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

{% endlist %}

## Вызовите функцию {#invoke}

{% note info %}

Чтобы любой пользователь мог вызывать функцию, необходимо [сделать ее публичной](../operations/function-public.md). Подробнее о правах читайте в разделе [{#T}](../security/index.md).

{% endnote %}

Для обращения к функции используйте ее имя или уникальный идентификатор, которые можно узнать с помощью команды:

```
$ yc serverless function list
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

    Вызовите функцию, указав в параметре имя для приветствия:

    ```
    $ yc serverless function invoke my-python-function -d '{"queryStringParameters": {"name": "Username"}}'
    {"statusCode":200,"isBase64Encoded":false,"body":"{\"message\":\"Hello, Username!\"}"}
    ```

{% endlist %}

## Что дальше {#what-is-next}

- Прочитайте, какой должна быть структура функции для вызова разными способами (HTTP, CLI), в разделе [{#T}](../concepts/function-invoke.md).
- Ознакомьтесь с [концепциями сервиса](../concepts/index.md).
- Посмотрите, что можно делать с функциями и версиями в [пошаговых инструкциях](../operations/index.md).
