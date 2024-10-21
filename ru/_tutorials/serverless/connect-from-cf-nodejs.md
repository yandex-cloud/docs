{% note info %}

Руководство предназначено для пользователей Linux. На Windows пройти руководство можно в среде [WSL](https://docs.microsoft.com/ru-ru/windows/wsl/about).

{% endnote %}

Вы создадите [функцию](../../functions/concepts/function.md) с [приложением на Node.js]({{ ydb.docs }}/reference/ydb-sdk/example/example-nodejs), которое выполняет простой запрос к базе данных [{{ ydb-short-name }}](https://ydb.tech/). Развертывание приложения осуществляется с помощью Bash-скриптов, для компиляции используется команда `tcs`.

Функция с привязанным [сервисным аккаунтом](../../iam/concepts/users/service-accounts.md) авторизуется в {{ ydb-short-name }} через сервис метаданных.

Приложение создает драйвер подключения к БД {{ ydb-short-name }}, сессию, транзакцию и выполняет запрос, используя библиотеку `ydb`. Эта библиотека устанавливается как [зависимость](../../functions/lang/nodejs/dependencies.md) при создании [версии функции](../../functions/concepts/function.md#version). Параметры подключения к БД передаются в приложение через переменные окружения.

Чтобы настроить подключение к БД {{ ydb-short-name }}:
1. [Подготовьте облако к работе](#before-begin).
1. [Подготовьте окружение](#prepare-environment).
1. [Создайте сервисный аккаунт](#create-sa).
1. [Создайте авторизованный ключ](#create-key).
1. [Создайте БД {{ ydb-short-name }}](#create-database).
1. [Создайте функцию](#create-function).
1. [Протестируйте функцию](#test-function).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для этого сценария входит:
* Плата за использование функции (см. [тарифы {{ sf-full-name }}](../../functions/pricing.md)).
* Плата за выполнение запросов к БД (см. [тарифы {{ ydb-full-name }}](../../ydb/pricing/serverless.md)).


## Подготовьте окружение {#prepare-environment}

1. Клонируйте [репозиторий examples](https://github.com/yandex-cloud/examples/tree/master/serverless/functions/YDB-connect-from-serverless-function) с помощью Git:

   ```bash
   git clone https://github.com/yandex-cloud/examples.git
   ```

1. Установите и инициализируйте [интерфейс командной строки {{ yandex-cloud }}](../../cli/quickstart.md).
1. Перейдите в корневую директорию проекта:

   ```bash
   cd ~/examples/serverless/functions/YDB-connect-from-serverless-function
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

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором хотите создать сервисный аккаунт.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя сервисного аккаунта: `sa-function`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите `{{ roles-editor }}`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

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

  Подробнее о командах см. в [справочнике CLI](../../cli/cli-ref/managed-services/iam/service-account/index.md).

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры сервисного аккаунта:

     ```hcl
     resource "yandex_iam_service_account" "sa" {
       name = "sa-function"
     }
     ```

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iam_service_account).
  1. Проверьте корректность конфигурационных файлов.
     1. В командной строке перейдите в директорию, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
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

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит сервисный аккаунт.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. В открывшемся списке выберите сервисный аккаунт `sa-function`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** на верхней панели.
  1. Выберите пункт **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_key }}**.
  1. Выберите алгоритм шифрования.
  1. Задайте описание [авторизованного ключа](../../iam/concepts/authorization/key.md), чтобы потом было проще найти его в консоли управления.
  1. Сохраните открытую и закрытую части авторизованного ключа в файл `examples/serverless/functions/YDB-connect-from-serverless-function/service_account_key_file.json`:

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

  Подробнее о команде `yc iam key create` см. в [справочнике CLI](../../cli/cli-ref/managed-services/iam/key/create.md).

  В случае успеха в файл `service_account_key_file.json` будет записан закрытая часть авторизованного ключа (`privateKey`) и идентификатор открытой части (`id`).

- {{ TF }} {#tf}

  1. Опишите в конфигурационном файле параметры авторизованного ключа:

     ```hcl
     resource "yandex_iam_service_account_key" "sa-auth-key" {
       service_account_id = "<идентификатор_сервисного_аккаунта_sa-function>"
       key_algorithm      = "RSA_2048"
     }
     ```

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iam_service_account_key).
  1. Проверьте корректность конфигурационных файлов.
     1. В командной строке перейдите в директорию, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Разверните облачные ресурсы.
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

- API {#api}

  Чтобы создать авторизованный ключ доступа, воспользуйтесь методом [create](../../iam/api-ref/Key/create.md) для ресурса [Key](../../iam/api-ref/Key/index.md).

{% endlist %}

## Создайте БД {{ ydb-short-name }} {#create-database}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать БД.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.ydb.databases.button_create }}**.
  1. Введите имя БД. Требования к имени:

     {% include [name-format](../../_includes/name-format.md) %}

  1. В блоке **{{ ui-key.yacloud.ydb.forms.label_field_database-type }}** выберите опцию `{{ ui-key.yacloud.ydb.forms.label_serverless-type }}`.
  1. Нажмите кнопку **{{ ui-key.yacloud.ydb.forms.button_create-database }}**.

     Дождитесь запуска БД. В процессе создания БД будет иметь статус `Provisioning`. Когда БД станет готова к использованию, статус сменится на `Running`.
  1. Нажмите на имя созданной БД.
  1. Сохраните значение поля **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** из блока **{{ ui-key.yacloud.ydb.overview.section_connection }}**. Оно понадобится на следующем шаге.

{% endlist %}

## Создайте функцию {#create-function}

{% note info %}

Перед созданием функции убедитесь, что в файле `.env` и файлах `create-func.sh` и `create-func-ver.sh` из директории `deploy` в качестве символа перевода строки установлен `LF`.

{% endnote %}

1. Перейдите в корневую директорию проекта:

   ```bash
   cd ~/examples/serverless/functions/YDB-connect-from-serverless-function
   ```

1. Отредактируйте файл `.env`:
   * `ENDPOINT` — первая часть сохраненного ранее значения поля **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** (часть до вхождения `/?database=`). Например, `{{ ydb.ep-serverless }}`.
   * `DATABASE` — вторая часть сохраненного ранее значения поля **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** (часть после вхождения `/?database=`). Например, `/{{ region-id }}/r1gra875baom********/g5n22e7ejfr1********`.
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
         DATABASE: /{{ region-id }}/b1gia87mbaom********/etnilt3o6v9e********
         ENDPOINT: grpcs://ydb.serverless.yandexcloud.net:2135
   log_options:
         folder_id: pqrs81qpemb********
   ```

## Протестируйте функцию {#test-function}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится функция.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Выберите функцию `func-test-ydb`.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.overview }}**.
  1. В поле **{{ ui-key.yacloud.serverless-functions.item.overview.label_invoke-link }}** нажмите на ссылку.
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
1. [Удалите БД](../../ydb/operations/manage-databases.md#delete-db).
1. [Удалите функцию](../../functions/operations/function/function-delete.md).