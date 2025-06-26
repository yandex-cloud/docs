В этом руководстве вы настроите [CI/CD]({{ link-src-docs }}/sourcecraft/concepts/ci-cd) между {{ sf-name }} и {{ src-name }}. Для этого вы создадите репозиторий, настроите развертывание функции и проверите результат.

Чтобы настроить CI/CD:

1. [Создайте сервисный аккаунт и авторизованный ключ](#iam).
1. [Создайте репозиторий](#repository).
1. [Создайте секрет в репозитории](#create-secret).
1. [Внесите изменения в репозиторий](#push-changes).
1. [Проверьте CI/CD-процесс](#check-ci-cd).
1. [Проверьте изменения в функции](#check-function).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит плата за количество вызовов функции, вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик (см. [тарифы {{ sf-name }}](../../functions/pricing.md)).


## Создайте сервисный аккаунт и авторизованный ключ {#iam}

От имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) {{ src-name }} будет создавать функцию и ее версии.

### Создайте сервисный аккаунт {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя сервисного аккаунта: `functions-cicd-sa`.
  1. Нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите [роль](../../functions/security/index.md#functions-admin) `{{ roles-functions-admin }}`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- CLI {#cli}

  1. Создайте сервисный аккаунт с именем `functions-cicd-sa`:

      ```bash
      yc iam service-account create --name functions-cicd-sa
      ```

      Результат:

      ```bash
      id: ajehb3tcdfa1********
      folder_id: b1g86q4m5vej********
      created_at: "2025-05-28T16:05:14.237381531Z"
      name: functions-cicd-sa
      ```

  1. Назначьте сервисному аккаунту [роль](../../functions/security/index.md#functions-admin) `{{ roles-functions-admin }}` на каталог:

      ```bash
      yc resource-manager folder add-access-binding <идентификатор_каталога> \
        --role {{ roles-functions-admin }} \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

      Результат:

      ```bash
      done (3s)
      effective_deltas:
        - action: ADD
          access_binding:
            role_id: {{ roles-functions-admin }}
            subject:
              id: ajehb3tcdfa1********
              type: serviceAccount
      ```

- API {#api}

  Чтобы создать сервисный аккаунт, воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).

  Чтобы назначить сервисному аккаунту [роль](../../functions/security/index.md#functions-admin) `{{ roles-functions-admin }}` на каталог, воспользуйтесь методом [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md).

{% endlist %}


### Создайте авторизованный ключ {#create-key}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Выберите сервисный аккаунт `functions-cicd-sa`.
  1. На верхней панели нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите пункт **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_key }}**.
  1. Выберите алгоритм шифрования.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.overview.action_download-keys-file }}**. Убедитесь, что файл сохранился на компьютере. Его содержимое понадобится при [создании секрета](#create-secret). Открытый ключ нельзя будет посмотреть в консоли управления.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc iam key create --service-account-name sa-function -o functions-cicd-sa_key_file.json
  ```

  В случае успеха в файл `functions-cicd-sa_key_file.json` будут записаны данные авторизованного ключа. Например:

  ```json
  {
    "id": "ajek6nubd5g3********",
    "service_account_id": "ajelprpohp7r********",
    "created_at": "2025-05-28T16:17:17.721526532Z",
    "key_algorithm": "RSA_2048",
    "public_key": "-----BEGIN PUBLIC KEY-----\nMI...QAB\n-----END PUBLIC KEY-----\n",
    "private_key": "PLEASE DO NOT REMOVE THIS LINE! Yandex.Cloud SA Key ID \u003cajek6nubd5g3********\u003e\n-----BEGIN PRIVATE KEY-----\nMI...WdQ=\n-----END PRIVATE KEY-----\n"
  }
  ```

- API {#api}

  Чтобы создать авторизованный ключ доступа, воспользуйтесь методом REST API [create](../../iam/api-ref/Key/create.md) для ресурса [Key](../../iam/api-ref/Key/index.md) или вызовом gRPC API [Key/Create](../../iam/api-ref/grpc/Key/create.md).

{% endlist %}


## Создайте репозиторий {#repository}

В репозитории будут храниться параметры и код функции, а также настройки CI/CD-процесса.

{% list tabs group=instructions %}

- Интерфейс {{ src-name }} {#src}

  1. Откройте [главную страницу]({{ link-src-main }}) {{ src-name }}.
  1. На панели слева нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.sourcecraft.ui_modules_mainApp.route_create-repository }}**.
  1. В открывшемся окне выберите **{{ ui-key.sourcecraft.ui_modules_repoCreate.title_create-blank }}**.
  1. {% include [repo-create-details](../../_includes/sourcecraft/repo-create-details.md) %}
  1. Нажмите **{{ ui-key.sourcecraft.ui_modules_repoCreate.button_create-repo }}**.

{% endlist %}


## Создайте секрет в репозитории {#create-secret}

В [секрете]({{ link-src-docs }}/sourcecraft/operations/secrets) в зашифрованном виде будет храниться авторизованный ключ сервисного аккаунта для доступа к функции.

{% list tabs group=instructions %}

- Интерфейс {{ src-name }} {#src}

  1. Откройте [главную страницу]({{ link-src-main }}) {{ src-name }}.
  1. На вкладке ![image](../../_assets/console-icons/house.svg) **{{ ui-key.sourcecraft.ui_lib.home }}** перейдите в раздел ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.sourcecraft.ui_modules_mainApp.route_repositories }}**.
  1. Выберите созданный ранее репозиторий.
  1. На странице репозитория в разделе ![image](../../_assets/console-icons/gear.svg) **{{ ui-key.sourcecraft.ui_modules_repo.title_navigation-repository-settings }}** перейдите в секцию ![image](../../_assets/console-icons/vault.svg) **{{ ui-key.sourcecraft.ui_lib.tab_secrets }}**.
  1. На странице с секретами нажмите **{{ ui-key.sourcecraft.ui_modules_secrets.action_new-secrete }}**.
  1. В открывшемся окне:

      * В поле **{{ ui-key.sourcecraft.ui_modules_secrets.field_name }}** введите название секрета — `authorized-key`.
      * В поле **{{ ui-key.sourcecraft.ui_modules_secrets.field_secret }}** вставьте содержимое файла с авторизованным ключом, [сохраненное ранее](#create-key).

  1. Нажмите **{{ ui-key.sourcecraft.ui_modules_secrets.action_add-secret }}**.

{% endlist %}


## Внесите изменения в репозиторий {#push-changes}

Создайте в репозитории следующие файлы:

* `index.js` с кодом функции;
* `.sourcecraft/ci.yaml` с параметрами функции и настройками CI/CD-процесса.

{% list tabs group=instructions %}

- Интерфейс {{ src-name }} {#src}

  1. Откройте [главную страницу]({{ link-src-main }}) {{ src-name }}.
  1. На вкладке ![image](../../_assets/console-icons/house.svg) **{{ ui-key.sourcecraft.ui_lib.home }}** перейдите в раздел ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.sourcecraft.ui_modules_mainApp.route_repositories }}**.
  1. Выберите созданный ранее репозиторий.
  1. Нажмите **{{ ui-key.sourcecraft.ui_modules_repoMain.action_go-to-browse }}**.
  1. Справа от имени ветки нажмите ![image](../../_assets/console-icons/square-plus.svg) → ![image](../../_assets/console-icons/file.svg) **{{ ui-key.sourcecraft.ui_modules_repo.file }}**.
  1. Введите название файла `index.js` и нажмите **{{ ui-key.sourcecraft.ui_modules_repo.action_create-file }}**.
  1. Вставьте в файл `index.js` следующий код:

      ```javascript
      module.exports.handler = async function (event, context) {
          return {
              statusCode: 200,
              body: 'Hello from SourceCraft!',
          };
      };
      ```

  1. Аналогичным образом создайте файл `.sourcecraft/ci.yaml`. Вставьте в него следующий код, указав идентификатор каталога, в котором хотите создать функцию:

      ```yaml
      on:
        push:
          - workflows: cicd
            filter:
              branches: [ main ]
      workflows:
        cicd:
          tasks:
            - name: deploy-latest
              env:
                TMP_PATH: ./tmp
                YC_AUTHORIZED_KEY_JSON: $not_var{{ secrets.authorized-key }}
                YC_FOLDER_ID: <идентификатор_каталога>
                YC_FUNCTION_NAME: cicd-test
                YC_FUNCTION_RUNTIME: nodejs22
                YC_FUNCTION_ENTRYPOINT: index.handler
                YC_FUNCTION_MEMORY: 128m
              cubes:
                - name: install-and-configure-yc
                  script:
                    - curl -o ./yc-install.sh -L https://storage.yandexcloud.net/yandexcloud-yc/install.sh
                    - chmod +x ./yc-install.sh && ./yc-install.sh -i /tmp/yc -n && mv /tmp/yc/bin/yc /usr/bin/yc
                    - echo "$YC_AUTHORIZED_KEY_JSON" > key.json
                    - yc config profile create sa-profile
                    - yc config set service-account-key key.json
                    - yc config set format json
                    - yc config set folder-id $YC_FOLDER_ID

                - name: check-and-create-function
                  script:
                    - |
                      echo "Checking if function exists..."
                      if ! yc serverless function get --name=$YC_FUNCTION_NAME; then
                        echo "Function does not exist. Creating new function..."
                        yc serverless function create --name=$YC_FUNCTION_NAME
                      else
                        echo "Function already exists. Proceeding to version deployment..."
                      fi

                - name: deploy-function-version
                  script:
                    - mkdir -p $TMP_PATH
                    - cp ./*.js* $TMP_PATH
                    - echo "Deploying new function version..."
                    - |
                      yc serverless function version create \
                        --function-name=$YC_FUNCTION_NAME \
                        --runtime $YC_FUNCTION_RUNTIME \
                        --entrypoint $YC_FUNCTION_ENTRYPOINT \
                        --memory $YC_FUNCTION_MEMORY \
                        --execution-timeout 5s \
                        --source-path $TMP_PATH
      ```

      Где:

      * `YC_FOLDER_ID` — идентификатор каталога, в котором вы хотите создать функцию.
      * `YC_FUNCTION_NAME` — имя функции.
      * `YC_FUNCTION_RUNTIME` — среда выполнения.
      * `YC_FUNCTION_ENTRYPOINT` — точка входа.
      * `YC_FUNCTION_MEMORY` — объем RAM.

  1. В правом верхнем углу нажмите **{{ ui-key.sourcecraft.ui_modules_repo.action_commit }}**.
  1. Сделайте коммит:
      1. Введите сообщение об изменениях.
      1. В блоке **{{ ui-key.sourcecraft.ui_modules_repo.field_commit-branch }}** выберите **{{ ui-key.sourcecraft.ui_modules_repo.field_text_commit-directly-to-the-branch }} main**.
      1. В блоке **{{ ui-key.sourcecraft.ui_modules_repo.field_after-commit-action }}** выберите **{{ ui-key.sourcecraft.ui_modules_repo.option_just-commit }}**.
      1. Нажмите **{{ ui-key.sourcecraft.ui_modules_repo.button_commit-and-go-to-read-mode }}**.

{% endlist %}


## Проверьте CI/CD-процесс {#check-ci-cd}

Убедитесь, что CI/CD-процесс прошел успешно.

{% list tabs group=instructions %}

- Интерфейс {{ src-name }} {#src}

  1. Откройте [главную страницу]({{ link-src-main }}) {{ src-name }}.
  1. На вкладке ![image](../../_assets/console-icons/house.svg) **{{ ui-key.sourcecraft.ui_lib.home }}** перейдите в раздел ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.sourcecraft.ui_modules_mainApp.route_repositories }}**.
  1. Выберите созданный ранее репозиторий.
  1. На странице репозитория в разделе ![image](../../_assets/console-icons/code.svg) **{{ ui-key.sourcecraft.ui_modules_repo.title_navigation-code }}** перейдите в секцию ![image](../../_assets/console-icons/arrows-3-rotate-right.svg) **{{ ui-key.sourcecraft.ui_modules_repo.action_cicd }}**.
  1. В списке запусков автоматизаций вы увидите новый запуск со статусом ![image](../../_assets/console-icons/circle.svg) **{{ ui-key.sourcecraft.ui_modules_cicd.value_status-created }}**. Дождитесь, когда статус изменится на ![image](../../_assets/console-icons/circle-check.svg) **{{ ui-key.sourcecraft.ui_modules_cicd.value_succeeded }}**.

{% endlist %}


## Проверьте, что функция создалась {#check-function}

Убедитесь, что в сервисе {{ sf-name }} создалась функция с именем `cicd-test`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, который указали в файле `.sourcecraft/ci.yaml`.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. В списке должна появиться функция `cicd-test`, выберите ее.
  1. В разделе **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-history }}** должна появиться версия функции, по времени создания соответствующая времени [запуска CI/CD-процесса](#check-ci-cd).
  1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}**.
  1. В редакторе кода в файле `index.js` должен отобразиться код:

      ```javascript
      module.exports.handler = async function (event, context) {
          return {
              statusCode: 200,
              body: 'Hello from SourceCraft!',
          };
      };
      ```

- CLI {#cli}

  1. Получите список функций в каталоге, указанном в файле `.sourcecraft/ci.yaml`:
      ```
      yc serverless function list
      ```

      Результат:
      ```
      +----------------------+-----------+----------------------+--------+
      |          ID          |   NAME    |      FOLDER ID       | STATUS |
      +----------------------+-----------+----------------------+--------+
      | b097d9ous3ge******** | cicd-test | aoek49ghmknn******** | ACTIVE |
      +----------------------+-----------+----------------------+--------+
      ```

      В выводе команды должна отобразиться функция `cicd-test`.

  1. Получите список версий функции `cicd-test`:

      ```bash
      yc serverless function version list --function-id <идентификатор_функции>
      ```

      Результат:
    
      ```text
      +----------------------+----------------------+----------+---------------+---------+---------------------+
      |          ID          |     FUNCTION ID      | RUNTIME  |  ENTRYPOINT   |  TAGS   |     CREATED AT      |
      +----------------------+----------------------+----------+---------------+---------+---------------------+
      | b097d9ousd36******** | b097d9ous3ge******** | nodejs22 | index.handler | $latest | 2025-05-28 05:05:12 |
      +----------------------+----------------------+----------+---------------+---------+---------------------+
      ```

      В выводе команды должна отобразиться версия функции, по времени создания соответствующая времени [запуска CI/CD-процесса](#check-ci-cd).

- API {#api}

  Чтобы получить список функций, воспользуйтесь методом REST API [list](../../functions/functions/api-ref/Function/list.md) для ресурса [Function](../../functions/functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionsService/List](../../functions/functions/api-ref/grpc/Function/list.md).

  В списке должна отобразиться функция `cicd-test`.
  
  Чтобы получить список версий функции, воспользуйтесь методом REST API [listVersions](../../functions/functions/api-ref/Function/listVersions.md) для ресурса [Function](../../functions/functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionsService/ListVersions](../../functions/functions/api-ref/grpc/Function/listVersions.md).

  В списке должна появиться новая версия функции, по времени создания соответствующая времени [запуска CI/CD-процесса](#check-ci-cd).

{% endlist %}


## Удалите созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны, удалите их:

1. [Удалите функцию](../../functions/operations/function/function-delete.md).
1. [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md).
