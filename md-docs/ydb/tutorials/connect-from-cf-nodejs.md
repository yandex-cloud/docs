# Подключение к базе данных Managed Service for YDB из функции Yandex Cloud Functions на Node.js

{% note info %}

Руководство предназначено для пользователей Linux. На Windows пройти руководство можно в среде [WSL](https://docs.microsoft.com/ru-ru/windows/wsl/about).

{% endnote %}

Вы создадите [функцию](../../functions/concepts/function.md) с [приложением на Node.js](https://ydb.tech/docs/ru//reference/ydb-sdk/example/example-nodejs), которое выполняет простой запрос к базе данных [YDB](https://ydb.tech/). Развертывание приложения осуществляется с помощью Bash-скриптов, для компиляции используется команда `tcs`.

Функция с привязанным [сервисным аккаунтом](../../iam/concepts/users/service-accounts.md) авторизуется в YDB через сервис метаданных.

Приложение создает драйвер подключения к БД YDB, сессию, транзакцию и выполняет запрос, используя библиотеку `ydb`. Эта библиотека устанавливается как [зависимость](../../functions/lang/nodejs/dependencies.md) при создании [версии функции](../../functions/concepts/function.md#version). Параметры подключения к БД передаются в приложение через переменные окружения.

Чтобы настроить подключение к БД YDB:
1. [Подготовьте облако к работе](#before-begin).
1. [Подготовьте окружение](#prepare-environment).
1. [Создайте сервисный аккаунт](#create-sa).
1. [Создайте авторизованный ключ](#create-key).
1. [Создайте БД YDB](#create-database).
1. [Создайте функцию](#create-function).
1. [Протестируйте функцию](#test-function).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для этого сценария входит:
* Плата за использование функции (см. [тарифы Yandex Cloud Functions](../../functions/pricing.md)).
* Плата за выполнение запросов к БД (см. [тарифы Yandex Managed Service for YDB](../pricing/serverless.md)).

## Подготовьте окружение {#prepare-environment}

1. Клонируйте [репозиторий](https://github.com/yandex-cloud-examples/yc-ydb-connect-from-serverless-function) с помощью Git:

   ```bash
   git clone https://github.com/yandex-cloud-examples/yc-ydb-connect-from-serverless-function.git
   ```

1. Установите и инициализируйте [интерфейс командной строки Yandex Cloud](../../cli/quickstart.md).
1. Перейдите в корневую директорию проекта:

   ```bash
   cd ~/yc-ydb-connect-from-serverless-function
   ```

   Все последующие команды выполняйте в этой директории.
1. Установите утилиту [jq](https://stedolan.github.io/jq/download/):

   ```bash
   sudo apt-get install jq
   ```

1. Установите [Node.js](https://nodejs.org/en/download/package-manager/):

   ```bash
   curl --fail --silent --show-error --location https://deb.nodesource.com/setup_current.x | sudo -E bash - \
   sudo apt-get install -y nodejs
   ```

1. Установите зависимости:

   ```bash
   npm install
   ```

   Результат:

   ```text
   up to date, audited 269 packages in 1s

   29 packages are looking for funding
      run `npm fund` for details

   found 0 vulnerabilities
   ```

## Создайте сервисный аккаунт {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать сервисный аккаунт.
  1. Перейдите в сервис **Identity and Access Management**.
  1. Нажмите кнопку **Создать сервисный аккаунт**.
  1. Введите имя сервисного аккаунта: `sa-function`.
  1. Нажмите **Добавить роль** и выберите `editor`.
  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  1. [Создайте](../../iam/operations/sa/create.md#create-sa) сервисный аккаунт:

     ```bash
     yc iam service-account create --name sa-function
     ```

     Результат:

     ```text
     id: aje028do8n9r********
     folder_id: b1g681qpemb4********
     created_at: "2023-08-23T06:24:49.759304161Z"
     name: sa-function
     ```

  1. [Назначьте](../../iam/operations/sa/set-access-bindings.md#assign-role-to-sa) сервисному аккаунту [роль](../../iam/concepts/access-control/roles.md) `editor`:

     ```bash
     yc resource-manager folder add-access-binding <идентификатор_каталога> \
       --role editor \
       --subject serviceAccount:<идентификатор_сервисного_аккаунта>
     ```

     Результат:

     ```text
     ...1s...done (4s)
     effective_deltas:
     - action: ADD
        access_binding:
           role_id: viewer
           subject:
           id: aje028do8n9r********
           type: serviceAccount
     ```

  Подробнее о командах см. в [справочнике CLI](../../cli/cli-ref/iam/cli-ref/service-account/index.md).

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры сервисного аккаунта:

     ```hcl
     resource "yandex_iam_service_account" "sa" {
       name = "sa-function"
     }
     ```

     Более подробную информацию о ресурсах, которые вы можете создать с помощью Terraform, см. в [документации провайдера](../../terraform/resources/iam_service_account.md).
  1. Проверьте корректность конфигурационных файлов.
     1. В командной строке перейдите в директорию, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет.
  1. Разверните облачные ресурсы.
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

- API {#api}

  Чтобы создать сервисный аккаунт и назначить ему [роль](../../iam/concepts/access-control/roles.md), воспользуйтесь методами [create](../../iam/api-ref/ServiceAccount/create.md) и [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md).

{% endlist %}

## Создайте авторизованный ключ {#create-key}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит сервисный аккаунт.
  1. Перейдите в сервис **Identity and Access Management**.
  1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты**.
  1. В открывшемся списке выберите сервисный аккаунт `sa-function`.
  1. Нажмите кнопку **Создать новый ключ** на верхней панели.
  1. Выберите пункт **Создать авторизованный ключ**.
  1. Выберите алгоритм шифрования.
  1. Задайте описание [авторизованного ключа](../../iam/concepts/authorization/key.md), чтобы потом было проще найти его в консоли управления.
  1. Сохраните открытую и закрытую части авторизованного ключа в файл `yc-ydb-connect-from-serverless-function/service_account_key_file.json`:

     ```json
     {
       "service_account_id": "<идентификатор_сервисного_аккаунта_sa-function>",
       "key_algorithm": "RSA_2048",
       "public_key": "-----BEGIN PUBLIC KEY-----\n...\n-----END PUBLIC KEY-----\n",
       "private_key": "-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n"
     }
     ```

- CLI {#cli}

  Выполните команду:

  ```bash
  yc iam key create --service-account-name sa-function -o service_account_key_file.json
  ```

  Подробнее о команде `yc iam key create` см. в [справочнике CLI](../../cli/cli-ref/iam/cli-ref/key/create.md).

  В случае успеха в файл `service_account_key_file.json` будет записан закрытая часть авторизованного ключа (`privateKey`) и идентификатор открытой части (`id`).

- Terraform {#tf}

  1. Опишите в конфигурационном файле параметры авторизованного ключа:

     ```hcl
     resource "yandex_iam_service_account_key" "sa-auth-key" {
       service_account_id = "<идентификатор_сервисного_аккаунта_sa-function>"
       key_algorithm      = "RSA_2048"
     }
     ```

     Более подробную информацию о ресурсах, которые вы можете создать с помощью Terraform, см. в [документации провайдера](../../terraform/resources/iam_service_account_key.md).
  1. Проверьте корректность конфигурационных файлов.
     1. В командной строке перейдите в директорию, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет.
  1. Разверните облачные ресурсы.
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

- API {#api}

  Чтобы создать авторизованный ключ доступа, воспользуйтесь методом [create](../../iam/api-ref/Key/create.md) для ресурса [Key](../../iam/api-ref/Key/index.md).

{% endlist %}

## Создайте БД YDB {#create-database}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать БД.
  1. Перейдите в сервис **Managed Service for&nbsp;YDB**.
  1. Нажмите кнопку **Создать базу данных**.
  1. Введите имя БД. Требования к имени:

     * длина — от 3 до 63 символов;
     * может содержать строчные буквы латинского алфавита, цифры и дефисы;
     * первый символ — буква, последний — не дефис.

  1. В блоке **Тип базы данных** выберите опцию `Serverless`.
  1. Нажмите кнопку **Создать базу данных**.

     Дождитесь запуска БД. В процессе создания БД будет иметь статус `Provisioning`. Когда БД станет готова к использованию, статус сменится на `Running`.
  1. Нажмите на имя созданной БД.
  1. Сохраните значение поля **Эндпоинт** из блока **Соединение**. Оно понадобится на следующем шаге.

{% endlist %}

## Создайте функцию {#create-function}

{% note info %}

Перед созданием функции убедитесь, что в файле `.env` и файлах `create-func.sh` и `create-func-ver.sh` из директории `deploy` в качестве символа перевода строки установлен `LF`.

{% endnote %}

1. Перейдите в корневую директорию проекта:

   ```bash
   cd ~/yc-ydb-connect-from-serverless-function
   ```

1. Отредактируйте файл `.env`:
   * `ENDPOINT` — первая часть сохраненного ранее значения поля **Эндпоинт** (часть до вхождения `/?database=`). Например, `grpcs://ydb.serverless.yandexcloud.net:2135`.
   * `DATABASE` — вторая часть сохраненного ранее значения поля **Эндпоинт** (часть после вхождения `/?database=`). Например, `/ru-central1/r1gra875baom********/g5n22e7ejfr1********`.
   * `FUNCTION_NAME` — имя функции: `func-test-ydb`.
   * `FOLDER_ID` — идентификатор каталога.
   * `SERVICE_ACCOUNT_ID` — идентификатор сервисного аккаунта `sa-function`.

1. Создайте функцию:

   ```bash
   ./deploy/create-func.sh
   ```

   Этот скрипт создает новую функцию в вашем каталоге и делает ее публичной.
1. Создайте версию функции:

   ```bash
   ./deploy/create-func-ver.sh
   ```

   Результат:

   ```text
   npx tsc --build tsconfig.json
   rm: невозможно удалить '../build/func.zip': Нет такого файла или каталога
   adding: queries/ (stored 0%)
   adding: queries/clients-table.js (deflated 57%)
   adding: queries/helpers.js.map (deflated 43%)
   adding: queries/helpers.js (deflated 48%)
   adding: queries/clients-table.js.map (deflated 59%)
   adding: index.js (deflated 49%)
   adding: index.js.map (deflated 56%)
   adding: database.js.map (deflated 62%)
   adding: index-local.js (deflated 42%)
   adding: package.json (deflated 55%)
   adding: database.js (deflated 60%)
   adding: index-local.js.map (deflated 43%)
   yc function version create func-test-ydb 
   done (27s)
   id: abcd2d363b4b********
   function_id: efghm9el0ja9********
   created_at: "2023-08-15T07:41:07.591Z"
   runtime: nodejs16
   entrypoint: index.handler
   resources:
         memory: "268435456"
   execution_timeout: 5s
   service_account_id: hijk3hlu8gqe********
   image_size: "33497088"
   status: ACTIVE
   tags:
         - $latest
   log_group_id: lmnoivbe341g********
   environment:
         DATABASE: /ru-central1/b1gia87mbaom********/etnilt3o6v9e********
         ENDPOINT: grpcs://ydb.serverless.yandexcloud.net:2135
   log_options:
         folder_id: pqrs81qpemb********
   ```

## Протестируйте функцию {#test-function}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором находится функция.
  1. Перейдите в сервис **Cloud Functions**.
  1. Выберите функцию `func-test-ydb`.
  1. Перейдите на вкладку **Обзор**.
  1. В поле **Ссылка для вызова** нажмите на ссылку.
  1. В адресной строке браузера добавьте в ссылке параметр `api_key`, например `?api_key=b95`:

      ```http request
      https://functions.yandexcloud.net/efghm9el0ja9********?api_key=b95
      ```

  1. При успешном подключении в БД будет создана таблица `b95` и в нее будет добавлена одна запись. На странице появится сообщение в формате JSON, например:

     ```json
     {
       "info": "Создана таблица b95, вставлена одна запись"
     }
     ```

{% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. [Удалите БД](../operations/manage-databases.md#delete-db).
1. [Удалите функцию](../../functions/operations/function/function-delete.md).