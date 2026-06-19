# Создание навыка Алисы в консоли управления, с помощью Yandex Cloud CLI или API


Чтобы создать навык Алисы в консоли управления Yandex Cloud, с помощью CLI или API:

Чтобы добавить навык Алисы на основе [функции](*functions):

1. [Подготовьте облако к работе](#before-you-begin).
1. [Подготовьте код навыка](#prepare-code).
1. [Создайте функцию и версию функции](#create-function).
1. [Добавьте ссылку на функцию в навык Алисы](#add-link).
1. [Протестируйте работу навыка](#test).

Если созданные ресурсы больше не нужны, [удалите](#clear-out) их.

Подробнее о [разработке навыка Алисы](https://yandex.ru/dev/dialogs/alice/doc/development-docpage/#test__dev-cycle).

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

## Подготовьте код для навыка Алисы {#prepare-code}

Чтобы создать [версию](*function_version) функции, вы можете воспользоваться одним из [форматов загрузки кода](*upload_formats). В данном примере код будет загружен в Yandex Cloud Functions в формате ZIP-архива.

{% list tabs group=programming_language %}

- Python {#python}

    1. Скачайте из репозитория на GitHub файл с примером: [parrot.py](https://github.com/yandex-cloud-examples/yc-serverless-alice-skill/blob/main/parrot.py).
    1. Создайте ZIP-архив `parrot-py.zip` с файлом `parrot.py`.

- Node.js {#node}

    1. Скачайте из репозитория на GitHub файл с примером: [index.js](https://github.com/yandex-cloud-examples/yc-serverless-alice-skill/blob/main/index.js).
    1. Создайте ZIP-архив `parrot-js.zip` с файлом `index.js`.

{% endlist %}

## Создайте функцию и версию функции {#create-function}

После создания функция будет содержать только информацию о себе: имя, описание, уникальный идентификатор и т.д. Непосредственно код навыка будет добавлен в версию функции.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](*folder), в котором будет создана функция.
  1. Нажмите кнопку ![plus](../../../_assets/console-icons/plus.svg) **Создать ресурс** и выберите ![curly-brackets-function](../../../_assets/console-icons/curly-brackets-function.svg) **Функция**.
  1. Задайте [имя](*naming) функции. Например: `my-parrot-function`.
  1. Нажмите кнопку **Создать**.
  1. Создайте версию функции:

      {% list tabs group=programming_language %}

      - Python {#python}

        1. В списке языков программирования выберите `Python 3.14`.
        1. Отключите опцию **Добавить файлы с примерами кода** и нажмите **Продолжить**.
        1. Подготовьте код функции:

            * В поле **Источник кода** выберите `ZIP-архив` и прикрепите созданный ранее архив `parrot-py.zip`.
            * В поле **Точка входа** укажите `parrot.handler`.
        1. Задайте параметры версии:

            * **Таймаут**: `2`.
            * **Память**: `128 МБ`.
            * Значение остальных параметров оставьте по умолчанию.
        1. Нажмите кнопку **Сохранить изменения**.

      - Node.js {#node}

        1. В списке языков программирования выберите `Node.js 22`.
        1. Отключите опцию **Добавить файлы с примерами кода** и нажмите **Продолжить**.
        1. Подготовьте код функции:

            * В поле **Источник кода** выберите `ZIP-архив` и прикрепите созданный ранее архив `parrot-js.zip`.
            * В поле **Точка входа** укажите `index.handler`.
        1. Задайте параметры версии:

            * **Таймаут**: `2`.
            * **Память**: `128 МБ`.
            * Значение остальных параметров оставьте по умолчанию.
        1. Нажмите кнопку **Сохранить изменения**.

      {% endlist %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Чтобы создать функцию, выполните команду:

      ```bash
      yc serverless function create \
        --name my-parrot-function
      ```

      Результат:

      ```text
      id: d4el0mi6ps6s********
      folder_id: b1g5bhjofg7o********
      created_at: "2026-06-15T08:16:02.695Z"
      name: my-parrot-function
      http_invoke_url: https://functions.yandexcloud.net/d4el0mi6ps6s********
      status: ACTIVE
      ```

  1. Чтобы создать версию функции, выполните команду:

      {% list tabs group=programming_language %}

      - Python {#python}

        ```
        yc serverless function version create \
          --function-name my-parrot-function \
          --runtime python314 \
          --entrypoint index.handler \
          --memory 128m \
          --execution-timeout 5s \
          --source-path ./parrot-py.zip
        ```

        Результат:

        ```text
        done (2s)
        id: d4easr8ok281********
        function_id: d4el0mi6ps6s********
        created_at: "2026-06-15T08:42:20.771Z"
        runtime: python314
        entrypoint: index.handler
        resources:
          memory: "134217728"
        execution_timeout: 5s
        image_size: "4096"
        status: ACTIVE
        tags:
          - $latest
        concurrency: "1"
        log_options:
          folder_id: b1g5bhjofg7o********
        ```

      - Node.js {#node}

        ```
        yc serverless function version create \
          --function-name my-parrot-function \
          --runtime nodejs22 \
          --entrypoint index.handler \
          --memory 128m \
          --execution-timeout 5s \
          --source-path ./parrot-js.zip
        ```

        Результат:

        ```text
        done (2s)
        id: d4etv45m1vor********
        function_id: d4el0mi6ps6s********
        created_at: "2026-06-15T08:45:25.313Z"
        runtime: nodejs22
        entrypoint: index.handler
        resources:
          memory: "134217728"
        execution_timeout: 5s
        image_size: "4096"
        status: ACTIVE
        tags:
          - $latest
        concurrency: "1"
        log_options:
          folder_id: b1g5bhjofg7o********
        ```

      {% endlist %}

- API {#api}

  Чтобы создать функцию, воспользуйтесь методом REST API [create](../../functions/api-ref/Function/create.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/Create](../../functions/api-ref/grpc/Function/create.md).

  Чтобы создать версию функции, воспользуйтесь методом REST API [createVersion](../../functions/api-ref/Function/createVersion.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/CreateVersion](../../functions/api-ref/grpc/Function/createVersion.md).

{% endlist %}

## Добавьте ссылку на функцию в навык Алисы {#add-link}

{% list tabs %}

- Интерфейс Яндекс Диалогов

  1. Перейдите на страницу навыка Алисы в [личном кабинете](https://dialogs.yandex.ru/developer/).
  1. Нажмите ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **Создать навык Алисы** и в открывшемся окне:

      1. В поле **Название навыка** задайте уникальное имя создаваемого навыка.
      1. В поле **Backend** выберите вариант **Функция в Яндекс Облаке**. В выпадающем списке выберите созданную ранее функцию.

          {% note warning %}

          В списке отображаются функции, которые вы имеете право просматривать. Чтобы прикрепить функцию к навыку, вам необходимо разрешение на запуск функции. Это разрешение входит в роль [functions.functionInvoker](*functions_invoker) и выше.

          {% endnote %}

      1. Настройки остальных параметров оставьте без изменений и вверху страницы нажмите кнопку **Сохранить**.

{% endlist %}

[*functions_invoker]: Роль `functions.functionInvoker` позволяет вызывать функции. Подробнее об управлении доступом в Yandex Cloud читайте в разделе [Как устроено управление доступом в Yandex Cloud](../../../iam/concepts/access-control/index.md).

## Протестируйте работу навыка {#test}

{% list tabs %}

- Интерфейс Яндекс Диалогов

  1. В [личном кабинете](https://dialogs.yandex.ru/developer/) Яндекс Диалогов на странице с созданным ранее навыком в меню слева выберите **Тестирование**.
  1. Если все настроено правильно, в блоке **Чат** вы увидите сообщение с приглашением начать беседу: `Hello! I'll repeat anything you say to me.`
  1. Отправьте сообщение с любым текстом и убедитесь, что вам пришел ответ с таким же содержанием.

{% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы прекратить работу навыка, [удалите](../../operations/function/function-delete.md) функцию.

[*functions]: Функции Yandex Cloud Functions позволяют размещать в Yandex Cloud код, который можно запускать по запросу или триггеру. Подробнее читайте в разделе [Функция](../../concepts/function.md).

[*folder]: Каталог — это логическое пространство, в котором создаются и группируются ресурсы Yandex Cloud. Как и каталоги в файловой системе, каталоги в Yandex Cloud упрощают управление ресурсами. Подробнее читайте в разделе [Каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).

[*naming]: Требования к имени:
* длина — от 3 до 63 символов;
* может содержать строчные буквы латинского алфавита, цифры и дефисы;
* первый символ — буква, последний — не дефис.

[*function_version]: Версия содержит код функции, параметры запуска, а также все необходимые зависимости. На разных стадиях процесса разработки вы можете работать с разными версиями одной функции. Подробнее читайте в разделе [Версия функции](../../concepts/function.md#version).

[*upload_formats]: Загружать код версии функции можно несколькими способами: в редакторе в консоли управления, из локальных файлов и директорий или в виде архива. Подробнее читайте в разделе [Формат загрузки кода](../../concepts/function.md#upload).

#### Полезные ссылки {#see-also}

* [Создание навыка Алисы с помощью Terraform](terraform.md)