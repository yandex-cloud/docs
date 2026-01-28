В этом руководстве вы настроите [CI/CD]({{ link-src-docs }}/sourcecraft/concepts/ci-cd) между {{ sf-name }} и {{ src-name }}. Для этого вы создадите репозиторий, настроите развертывание функции и проверите результат. Интеграция между {{ src-name }} и {{ yandex-cloud }} будет выполнена с помощью [сервисного подключения]({{ link-src-docs }}/sourcecraft/concepts/service-connections).

{% include [service-connection-role-warning](../../_includes/sourcecraft/service-connection-role-warning.md) %}

Чтобы настроить CI/CD для развертывания функции {{ sf-name }} из репозитория {{ src-name }}:
1. [Создайте сервисный аккаунт](#create-sa).
1. [Создайте репозиторий](#repository).
1. [Создайте сервисное подключение](#create-service-connection).
1. [Отредактируйте конфигурацию CI/CD](#push-changes).
1. [Проверьте выполнение CI/CD](#check-ci-cd).
1. [Проверьте изменения в функции](#check-function).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит плата за количество вызовов функции, вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик (см. [тарифы {{ sf-name }}](../../functions/pricing.md)).

## Создайте сервисный аккаунт {#create-sa}

От имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) будет создаваться функция и ее версии.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Войдите в [консоль управления]({{ link-console-main }}) {{ yandex-cloud }}.
  1. В левой части экрана нажмите на строку с именем каталога, в котором вы хотите развернуть функцию {{ sf-name }}.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
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

## Создайте репозиторий {#repository}

Репозиторий будет создан из шаблона [yc-cloud-functions-template]({{ link-src-main }}/sourcecraft/yc-cloud-functions-template). В репозитории будут храниться примеры кода функций для разных языков программирования и фреймворков, а также настройки CI/CD-процесса.

{% list tabs group=instructions %}

- Интерфейс {{ src-name }} {#src}

  1. Откройте [главную страницу сервиса]({{ link-src-main }}).
  1. На панели слева нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.sourcecraft.mainApp.route_create-repository_4e8Ef }}**.
  1. В открывшемся окне выберите **{{ ui-key.sourcecraft.repoCreate.title_create-blank_2CxnQ }}**.
  1. В блоке **{{ ui-key.sourcecraft.repoCreate.title_new-repo-details_riAaE }}**:
      * В поле **{{ ui-key.sourcecraft.repoCreate.title_owner-field_7gbCn }}** выберите [организацию]({{ link-src-docs }}/sourcecraft/concepts/#org), в которой вы создали сервисный аккаунт в {{ yandex-cloud }}.
      * В поле **{{ ui-key.sourcecraft.repoCreate.title_repo-field_p5MD3 }}** укажите название репозитория. 

        Название должно быть уникальным в пределах организации и может содержать следующие [ASCII-символы](https://ru.wikipedia.org/wiki/ASCII): строчные и заглавные буквы латинского алфавита, цифры, запятые, дефисы и подчеркивания.

        Под названием отображается адрес, по которому репозиторий будет доступен.

      * (опционально) В поле **{{ ui-key.sourcecraft.repoSettings.field_description_1274t }}** укажите описание репозитория.

  1. В блоке **{{ ui-key.sourcecraft.repoCreate.section_template_vc5Jc }}** нажмите **{{ ui-key.sourcecraft.repoCreate.button_browse-templates_bP3xB }}**, выберите шаблон [yc-cloud-functions-template]({{ link-src-main }}/sourcecraft/yc-cloud-functions-template) и нажмите **{{ ui-key.sourcecraft.repo.button_use-template_ttBnP }}**.

      Чтобы посмотреть содержимое шаблона, нажмите **{{ ui-key.sourcecraft.repoCreate.button_preview-template_2WJAq }}**.

      В шаблоне содержатся:
      * файл [.sourcecraft/ci.yaml]({{ link-src-main }}/sourcecraft/yc-cloud-functions-template/browse/.sourcecraft/ci.yaml) с предустановленной конфигурацией CI/CD-процесса, который может быть запущен [вручную]({{ link-src-docs }}/sourcecraft/operations/run-workflow-manually) для публикации функции в конкретной [среде выполнения](../../functions/concepts/runtime/index.md#runtimes) или автоматически для среды выполнения `nodejs22` при создании коммита в основную ветку репозитория.
      * директории с примерами кода функций для разных языков программирования и фреймворков.
  1. Нажмите **{{ ui-key.sourcecraft.repoCreate.button_create-repo_nMrwv }}**.

{% endlist %}

## Создайте сервисное подключение {#create-service-connection}

{% list tabs group=instructions %}

- Интерфейс {{ src-name }} {#src}

  1. Откройте [главную страницу]({{ link-src-main }}) {{ src-name }}.
  1. Перейдите на вкладку ![image](../../_assets/console-icons/briefcase.svg) **{{ ui-key.sourcecraft.lib.organizations_5CjkW }}**.
  1. Выберите организацию, в которой вы создали сервисный аккаунт в {{ yandex-cloud }}.
  1. На странице организации в разделе ![image](../../_assets/console-icons/gear.svg) **{{ ui-key.sourcecraft.lib.settings_cwUYS }}** перейдите в секцию ![image](../../_assets/console-icons/cloud-nut-hex.svg) **{{ ui-key.sourcecraft.mainApp.route_service-connections_2PPgz }}**.
  1. Нажмите **{{ ui-key.sourcecraft.serviceConnections.button_add-connection_6Bj7i }}**.
  1. В открывшемся окне:
      * В блоке **{{ ui-key.sourcecraft.serviceConnections.section_basic_wmaiy }}** укажите имя сервисного подключения, например `default-service-connection`, опционально добавьте описание.
      * В блоке **{{ ui-key.sourcecraft.serviceConnections.section_scope_9gXcu }}** выберите, для каких репозиториев и веток будет доступно сервисное подключение, например, выберите репозиторий, созданный ранее.
      * В блоке **{{ ui-key.sourcecraft.serviceConnections.section_cloud-settings_tDMfn }}** выберите:
        * Каталог, на который вы назначили роль сервисному аккаунту.
        * Сервисный аккаунт, созданный ранее.

        {% note tip %}

        Чтобы повторно запросить список облаков, каталогов и сервисных аккаунтов из {{ yandex-cloud }}, нажмите  ![image](../../_assets/console-icons/arrow-rotate-right.svg) **Синхронизировать**. Это может быть полезно, если параллельно с созданием сервисного подключения вы создали каталог или сервисный аккаунт.

        {% endnote %}

  1. Нажмите **{{ ui-key.sourcecraft.serviceConnections.button_create-connection_uyK29 }}**.

      Дождитесь окончания операции. На открывшейся странице будут представлены детали сервисного подключения.

      В {{ yandex-cloud }} будет автоматически создана [федерация сервисных аккаунтов](../../iam/concepts/workload-identity.md) {{ iam-full-name }}.

      Чтобы посмотреть параметры созданного OIDC-провайдера, в блоке ![image](../../_assets/console-icons/cpus.svg) **{{ ui-key.sourcecraft.serviceConnections.title_oidc-federation_eC6Jw }}** нажмите на имя федерации.

{% endlist %}

## Отредактируйте конфигурацию CI/CD {#push-changes}

{% list tabs group=instructions %}

- Интерфейс {{ src-name }} {#src}

  1. Откройте [главную страницу]({{ link-src-main }}) {{ src-name }}.
  1. На вкладке ![image](../../_assets/console-icons/house.svg) **{{ ui-key.sourcecraft.lib.home_t2KmK }}** в секции ![image](../../_assets/console-icons/layout-tabs.svg) **{{ ui-key.sourcecraft.orgCommon.link_your-craftspace_bHYz8 }}** перейдите в раздел ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.sourcecraft.lib.repositories_vLJYc }}**.
  1. Выберите созданный ранее репозиторий.
  1. Выберите файл `.sourcecraft/ci.yaml`.
  1. В правом верхнем углу нажмите ![image](../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. В [рабочем процессе]({{ link-src-docs }}/sourcecraft/concepts/ci-cd#workflows) `deploy-nodejs-function` отредактируйте параметры создаваемой функции:
      * `YC_FUNCTION_NAME` — имя функции, например `test-function-nodejs`.
      * `YC_FUNCTION_RUNTIME` — [среда выполнения](../../functions/concepts/runtime/index.md#runtimes), например `nodejs22`.
      * `YC_FUNCTION_ENTRYPOINT` — точка входа функции, например `index.handler`. Задается в соответствии со средой выполнения согласно [документации](../../functions/quickstart/create-function/index.md).
      * `SOURCE_PATH` — путь в репозитории к коду функции, например `./nodejs`.

      Также вы можете добавить дополнительные параметры:
      * `ENVIRONMENT` — переменные окружения для функции, например `MY_ENV=SOURCECRAFT`. Аналог параметра `--environment` для команды {{ yandex-cloud }} CLI [yc serverless function version create](../../cli/cli-ref/serverless/cli-ref/function/version/create.md).
      * `PUBLIC` — сделать функцию доступной публично. Значение — `true`. Аналог команды {{ yandex-cloud }} CLI [yc serverless function allow-unauthenticated-invoke](../../cli/cli-ref/serverless/cli-ref/function/allow-unauthenticated-invoke.md).

  1. В правом верхнем углу нажмите **{{ ui-key.sourcecraft.repo.action_commit_brj4B }}**.
  1. Сделайте коммит:

      1. Введите сообщение об изменениях.
      1. В блоке **{{ ui-key.sourcecraft.repo.field_commit-branch_d1Mzi }}** выберите **{{ ui-key.sourcecraft.repo.field_text_commit-directly-to-the-branch_mBfk8 }} main**.
      1. В блоке **{{ ui-key.sourcecraft.repo.field_after-commit-action_mKjo4 }}** выберите **{{ ui-key.sourcecraft.repo.option_just-commit_to5sC }}**.
      1. Нажмите **{{ ui-key.sourcecraft.repo.button_commit_si86H }}**.

{% endlist %}

После сохранения изменений запустится рабочий процесс `deploy-nodejs-function`.

Аналогичным образом вы можете отредактировать код функции в файле `nodejs/index.js`. После этого также запустится рабочий процесс публикации новой версии функции.

{% note tip %}

В примере рассмотрен автоматический запуск рабочего процесса для среды выполнения `nodejs22`. Для других сред выполнения используйте [ручной]({{ link-src-docs }}/sourcecraft/operations/run-workflow-manually) запуск или отредактируйте блок `on` в файле `.sourcecraft/ci.yaml`.

{% cut "Пример автоматического запуска для python312" %}

```yaml
on:
  push:
    - workflows: [deploy-python-function] 
      filter: 
        branches: ["master", "main"]
```

{% endcut %}

{% endnote %}

Для развертывания функции {{ sf-name }} в конфигурации CI/CD используется готовый [кубик]({{ link-src-docs }}/sourcecraft/concepts/ci-cd#cubes) {{ src-name }} `yc-function`, подходящий для базовых сценариев.

Для более сложных сценариев развертывания функции {{ sf-name }} со всеми возможностями [{{ yandex-cloud }} CLI](../../cli/cli-ref/serverless/cli-ref/function/index.md) вы можете использовать готовые кубики `yc-iam` и `yc-cli`.

{% cut "Пример конфигурации CI/CD готовыми кубиками yc-iam и yc-cli" %}

```yaml
on:
  push:
    - workflows: [cicd]
      filter:
        branches: ["master", "main"]

tokens:
  # Произвольное имя токена.
  <имя_токена>:
    service_connection: default-service-connection
    # Область запроса доступа:
    # org — все репозитории.
    # repo — конкретный репозиторий.
    # ref — ветка или тег.
    scope: repo

workflows:
  cicd:
    tasks:
      - name: deploy-latest
        env:
          SOURCE_PATH: "./nodejs"
          YC_FUNCTION_NAME: "test-function-nodejs"
          YC_FUNCTION_RUNTIME: "nodejs22"
          YC_FUNCTION_ENTRYPOINT: "index.handler"
          # Кубик обменивает токен {{ src-name }} на IAM-токен {{ yandex-cloud }}
          # и сохраняет его в переменную IAM_TOKEN в блоке outputs.
        cubes:
          - name: get-iam-token
            env:
              ID_TOKEN: ${{ tokens.<имя_токена>.id_token}}
              YC_SA_ID: ${{ tokens.<имя_токена>.service_account_id }}
            image: {{ registry }}/sourcecraft/yc-iam:latest

          # Кубик с предустановленным {{ yandex-cloud }} CLI забирает из outputs 
          # переменную IAM_TOKEN и использует ее для проверки наличия функции {{ sf-name }}
          # с определенным именем, в случае отсутствия — создает ее.
          - name: check-and-create-function
            env:
              # Подставьте в блок для получения значений outputs имя кубика с
              # IAM-токеном, например get-iam-token.
              YC_IAM_TOKEN: ${{ cubes.<имя_кубика_с_IAM-токеном>.outputs.IAM_TOKEN }}
              YC_FOLDER_ID: ${{ tokens.<имя_токена>.folder_id }}
            image:
              name: {{ registry }}/sourcecraft/yc-cli:latest
              entrypoint: ""
            script:
              - |
                yc config set folder-id $YC_FOLDER_ID
                echo "Checking if function exists..."
                if ! yc serverless function get --name=$YC_FUNCTION_NAME; then
                  echo "Function does not exist. Creating new function..."
                  yc serverless function create --name=$YC_FUNCTION_NAME
                else
                  echo "Function already exists. Proceeding to version deployment..."
                fi

          # Кубик с предустановленным {{ yandex-cloud }} CLI забирает из outputs 
          # переменную IAM_TOKEN и использует ее для создания новой версии функции {{ sf-name }}.
          - name: deploy-function-version
            env:
              # Подставьте в блок для получения значений outputs имя кубика с
              # IAM-токеном, например get-iam-token.
              YC_IAM_TOKEN: ${{ cubes.<имя_кубика_с_IAM-токеном>.outputs.IAM_TOKEN }}
              YC_FOLDER_ID: ${{ tokens.<имя_токена>.folder_id }}
            image:
              name: {{ registry }}/sourcecraft/yc-cli:latest
              entrypoint: ""
            script:
              - mkdir -p ./tmp
              - cp "$SOURCE_PATH"/*.js* ./tmp
              - echo "Deploying new function version..."
              - |
                yc config set folder-id $YC_FOLDER_ID
                yc serverless function version create \
                  --function-name=$YC_FUNCTION_NAME \
                  --runtime $YC_FUNCTION_RUNTIME \
                  --entrypoint $YC_FUNCTION_ENTRYPOINT \
                  --execution-timeout 5s \
                  --source-path ./tmp
```

{% endcut %}

## Проверьте выполнение CI/CD {#check-ci-cd}

{% list tabs group=instructions %}

- Интерфейс {{ src-name }} {#src}

  1. Откройте [главную страницу]({{ link-src-main }}) {{ src-name }}.
  1. На вкладке ![image](../../_assets/console-icons/house.svg) **{{ ui-key.sourcecraft.lib.home_t2KmK }}** в секции ![image](../../_assets/console-icons/layout-tabs.svg) **{{ ui-key.sourcecraft.orgCommon.link_your-craftspace_bHYz8 }}** перейдите в раздел ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.sourcecraft.lib.repositories_vLJYc }}**.
  1. Выберите созданный ранее репозиторий.
  1. На странице репозитория в разделе ![image](../../_assets/console-icons/code.svg) **{{ ui-key.sourcecraft.repo.title_navigation-code_8bgjg }}** перейдите в секцию ![image](../../_assets/console-icons/arrows-3-rotate-right.svg) **{{ ui-key.sourcecraft.repo.action_cicd_4jypo }}**.
  1. В списке запусков автоматизаций вы увидите новый запуск со статусом ![image](../../_assets/console-icons/circle.svg) **{{ ui-key.sourcecraft.cicd.value_status-created_9AAET }}**. Дождитесь, когда статус изменится на ![image](../../_assets/console-icons/circle-check.svg) **{{ ui-key.sourcecraft.cicd.value_succeeded_3Dd8C }}**.

{% endlist %}

## Проверьте, что функция создалась {#check-function}

Убедитесь, что в сервисе {{ sf-name }} создалась функция с именем, которое вы задали в `.sourcecraft/ci.yaml`, например `test-function-nodejs`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором вы ранее создали сервисный аккаунт.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. В списке должна появиться функция `test-function-nodejs`, выберите ее.
  1. В разделе **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-history }}** должна появиться версия функции, по времени создания соответствующая времени [запуска CI/CD-процесса](#check-ci-cd).
  1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}**.
  1. В редакторе кода в файле `index.js` должен отобразиться код:

      ```javascript
      // Example Node.js function handler
          export const handler = async function (event, context) {
              // Log the incoming event for debugging
              console.log('Received event:', event);

              // Access request body (if it's a POST request)
              const requestBody = event.body ? JSON.parse(event.body) : {};

              // Access query parameters
              const name = event.queryStringParameters ? event.queryStringParameters.name : 'World';

              return {
                  statusCode: 200,
                  headers: {
                      'Content-Type': 'application/json',
                  },
                  body: JSON.stringify({
                      message: `Hello, ${name}! Your request body was:`,
                      data: requestBody,
                  }),
              };
          };
      ```

- CLI {#cli}

  1. Получите список функций в каталоге, указанном в файле `.sourcecraft/ci.yaml`:

      ```bash
      yc serverless function list
      ```

      Результат:

      ```text
      +----------------------+----------------------+----------------------+--------+
      |          ID          |         NAME         |      FOLDER ID       | STATUS |
      +----------------------+----------------------+----------------------+--------+
      | b097d9ous3ge******** | test-function-nodejs | aoek49ghmknn******** | ACTIVE |
      +----------------------+----------------------+----------------------+--------+
      ```

      В выводе команды должна отобразиться функция `test-function-nodejs`.

  1. Получите список версий функции `test-function-nodejs`:

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

  В списке должна отобразиться функция `test-function-nodejs`.

  Чтобы получить список версий функции, воспользуйтесь методом REST API [listVersions](../../functions/functions/api-ref/Function/listVersions.md) для ресурса [Function](../../functions/functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionsService/ListVersions](../../functions/functions/api-ref/grpc/Function/listVersions.md).

  В списке должна появиться новая версия функции, по времени создания соответствующая времени [запуска CI/CD-процесса](#check-ci-cd).

{% endlist %}

## Удалите созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны, удалите их:

1. [Удалите функцию](../../functions/operations/function/function-delete.md).
1. [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md).

## См. также {#see-also}

* [Настроить CI/CD для развертывания приложения в {{ serverless-containers-full-name }} с помощью GitHub Actions]({{ link-src-docs }}/sourcecraft/tutorials/ci-cd-sourcecraft-github-actions)
* [Настроить в {{ src-name }} сервисное подключение к {{ yandex-cloud }}]({{ link-src-docs }}/sourcecraft/operations/service-connections)
* [Интеграция с GitHub Actions в {{ src-name }}]({{ link-src-docs }}/sourcecraft/concepts/gh-actions)
* Репозиторий [yc-cloud-functions-template]({{ link-src-main }}/sourcecraft/yc-cloud-functions-template) в {{ src-name }}
* Репозиторий [yc-ci-cd-serverless]({{ link-src-main }}/sourcecraft/yc-ci-cd-serverless) в {{ src-name }}