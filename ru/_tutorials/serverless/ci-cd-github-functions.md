

[GitHub](https://github.com/) дает возможность хранить код функции [{{ sf-full-name }}](../../functions/) и развертывать новые версии [функции](../../functions/concepts/function.md) при изменениях в репозитории.

В этом руководстве вы настроите CI/CD между {{ sf-name }} и GitHub с помощью федерации сервисных аккаунтов [{{ iam-full-name }}](../../iam/) и развернете функции {{ sf-name }} через запуск [рабочих процессов](https://docs.github.com/{{ lang }}/actions/concepts/workflows-and-actions/workflows) GitHub Actions.

Чтобы настроить CI/CD:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте репозиторий](#create-repository).
1. [Подготовьте инфраструктуру в {{ yandex-cloud }}](#prepare-infrastructure).
1. [Настройте репозиторий](#configure-repo).
1. [Проверьте рабочие процессы](#check).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для этого практического руководства входят:

* Плата за количество вызовов функции, вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик (см. [тарифы {{ sf-name }}](../../functions/pricing.md)).
* Плата за запись и хранение логов функции в [лог-группе](../../logging/concepts/log-group.md) (см. [тарифы {{ cloud-logging-full-name }}](../../logging/pricing.md)).


## Создайте репозиторий {#create-repository}

[Создайте](https://docs.github.com/{{ lang }}/repositories/creating-and-managing-repositories/creating-a-new-repository) новый репозиторий на GitHub или используйте существующий, в котором у вас есть права на просмотр и запуск GitHub Actions.

Имена репозитория и пользователя GitHub потребуются в дальнейшем.


## Подготовьте инфраструктуру в {{ yandex-cloud }} {#prepare-infrastructure}

### Создайте сервисный аккаунт {#create-sa}

От имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) с [ролью](../../functions/security/index.md#functions-admin) `{{ roles-functions-admin }}` GitHub будет создавать функцию и ее версии.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете создавать инфраструктуру.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя сервисного аккаунта: `ci-cd-github-sa`.
  1. Нажмите ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите роль `{{ roles-functions-admin }}`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install.md](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Создайте сервисный аккаунт:

      ```bash
      yc iam service-account create --name ci-cd-github-sa
      ```

      Результат:

      ```text
      id: ajehqs5gee2e********
      folder_id: b1g681qpemb4********
      created_at: "2025-07-12T17:53:28.180991864Z"
      name: ci-cd-github-sa
      ```

  1. Назначьте роль `{{ roles-functions-admin }}` сервисному аккаунту:

      ```bash
      yc resource-manager folder add-access-binding <имя_или_идентификатор_каталога> \
        --role {{ roles-functions-admin }} \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

      Результат:

      ```text
      effective_deltas:
        - action: ADD
          access_binding:
            role_id: {{ roles-functions-admin }}
            subject:
              id: ajejocsfa1jj********
              type: serviceAccount
      ```

- API {#api}

  Чтобы создать сервисный аккаунт, воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).

  Чтобы назначить сервисному аккаунту роль `{{ roles-functions-admin }}` на каталог, воспользуйтесь методом REST API [updateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/UpdateAccessBindings](../../resource-manager/api-ref/grpc/Folder/updateAccessBindings.md).

{% endlist %}


### Создайте федерацию сервисных аккаунтов {#create-federation}

[Федерация сервисных аккаунтов](../../iam/concepts/workload-identity.md) необходима для настройки обмена токенов GitHub на [IAM-токены](../../iam/concepts/authorization/iam-token.md) {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![cpus](../../_assets/console-icons/cpus.svg) **{{ ui-key.yacloud.iam.label_federations }}**.
  1. Нажмите **{{ ui-key.yacloud.iam.label_create-wli-federation }}**.
  1. В поле **{{ ui-key.yacloud.iam.federations.field_issuer }}** введите URL OIDC-провайдера: `https://token.actions.githubusercontent.com`.
  1. В поле **{{ ui-key.yacloud.iam.federations.field_audiences }}** введите получателя токена: `https://github.com/<имя_пользователя_GitHub>`.
  1. В поле **{{ ui-key.yacloud.iam.federations.field_jwks }}** введите URL списка публичных ключей: `https://token.actions.githubusercontent.com/.well-known/jwks`.
  1. В поле **{{ ui-key.yacloud.iam.federations.field_name }}** введите имя федерации: `ci-cd-github-federation`.
  1. Нажмите **{{ ui-key.yacloud_billing.iam.cloud.create.popup-create-cloud_button_add }}**.

- {{ yandex-cloud }} CLI {#cli}

  Выполните команду:

  ```bash
  yc iam workload-identity oidc federation create \
    --name ci-cd-github-federation \
    --issuer "https://token.actions.githubusercontent.com" \
    --audiences "https://github.com/<имя_пользователя_GitHub>" \
    --jwks-url "https://token.actions.githubusercontent.com/.well-known/jwks"
  ```

  Где:

  * `--name` — имя создаваемой федерации.
  * `--issuer` — URL OIDC-провайдера.
  * `--audiences` — ресурсы, для которых будет предназначен получаемый токен. Вы можете через запятую задать одновременно несколько ресурсов-получателей IAM-токена.
  * `--jwks-url` — URL, по которому можно получить актуальный открытый ключ, выпущенный OIDC-провайдером и используемый для проверки подписи [JWT](https://ru.wikipedia.org/wiki/JSON_Web_Token).

  Результат:

  ```text
  id: ajeoerss1fa4********
  name: ci-cd-github-federation
  folder_id: b1g681qpemb4********
  enabled: true
  audiences:
    - https://github.com/eip********
  issuer: https://token.actions.githubusercontent.com
  jwks_url: https://token.actions.githubusercontent.com/.well-known/jwks
  created_at: "2025-07-24T18:20:33.546066838Z"
  ```

- API {#api}

  Чтобы создать федерацию сервисных аккаунтов, воспользуйтесь методом REST API [create](../../iam/workload/oidc/workload-identity/api-ref/Federation/create.md) для ресурса [Federation](../../iam/workload/oidc/workload-identity/api-ref/Federation/index.md) или вызовом gRPC API [FederationService/Create](../../iam/workload/oidc/workload-identity/api-ref/grpc/Federation/create.md).

  В запросе укажите значения параметров:

  * `issuer` — `https://token.actions.githubusercontent.com`.
  * `audiences` — `https://github.com/<имя_пользователя_GitHub>`.
  * `jwks-url`/`jwks_url` — `https://token.actions.githubusercontent.com/.well-known/jwks`.

{% endlist %}


### Создайте привязки сервисного аккаунта к федерации {#create-credential}

С помощью [привязок](../../iam/concepts/workload-identity.md#federated-credentials) вы настроите связь между федерацией сервисных аккаунтов, сервисным аккаунтом и GitHub.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Выберите сервисный аккаунт `ci-cd-github-sa`.
  1. Перейдите на вкладку ![cpus](../../_assets/console-icons/cpus.svg) **{{ ui-key.yacloud.iam.label_federations }}**.
  1. Нажмите **{{ ui-key.yacloud.iam.connected-federation.action_connect-federation }}**.
  1. В поле **{{ ui-key.yacloud.iam.connected-federation.field_federation }}** выберите федерацию `ci-cd-github-federation`.
  1. В поле **{{ ui-key.yacloud.iam.connected-federation.field_subject }}** укажите идентификатор внешнего субъекта для тестового окружения: `repo:<имя_пользователя_GitHub>/<имя_репозитория>:environment:preprod`.

      Окружение `preprod` будет использоваться далее в файлах `ci.yml` и `ct.yml`.

  1. Нажмите **{{ ui-key.yacloud.iam.connected-federation.action_connect }}**.

  Аналогичным способом создайте привязку с идентификатором внешнего субъекта для продакшен-окружения: `repo:<имя_пользователя_GitHub>/<имя_репозитория>:ref:refs/heads/main`.

- {{ yandex-cloud }} CLI {#cli}

  Выполните команды, чтобы создать привязки для тестового и продакшен-окружения:

  ```bash
  yc iam workload-identity federated-credential create \
    --service-account-id <идентификатор_сервисного_аккаунта> \
    --federation-id <идентификатор_федерации> \
    --external-subject-id "repo:<имя_пользователя_GitHub>/<имя_репозитория>:environment:preprod"

  yc iam workload-identity federated-credential create \
    --service-account-id <идентификатор_сервисного_аккаунта> \
    --federation-id <идентификатор_федерации> \
    --external-subject-id "repo:<имя_пользователя_GitHub>/<имя_репозитория>:ref:refs/heads/main"
  ```

  Где:

  * `--service-account-id` — идентификатор сервисного аккаунта `ci-cd-github-sa`.
  * `--federation-id` — идентификатор федерации сервисных аккаунтов `ci-cd-github-federation`.
  * `--external-subject-id` — идентификатор внешнего субъекта.

      Окружение `preprod` будет использоваться далее в файлах `ci.yml` и `ct.yml`.

  Результат:

  ```text
  id: ajek9t6ojc53********
  service_account_id: ajejocsfa1jj********
  federation_id: ajeoerss1fa4********
  external_subject_id: repo:eip********/ci-cd-github-repo:environment:preprod
  created_at: "2025-07-24T18:21:01.103940710Z"

  id: aje82obioirm********
  service_account_id: ajejocsfa1jj********
  federation_id: ajeoerss1fa4********
  external_subject_id: repo:eip********/ci-cd-github-repo:ref:refs/heads/main
  created_at: "2025-07-24T18:21:13.925210300Z"
  ```

- API {#api}

  Чтобы создать привязку, воспользуйтесь методом REST API [create](../../iam/workload/workload-identity/api-ref/FederatedCredential/create.md) для ресурса [FederatedCredential](../../iam/workload/workload-identity/api-ref/FederatedCredential/index.md) или вызовом gRPC API [FederatedCredentialService/Create](../../iam/workload/workload-identity/api-ref/grpc/FederatedCredential/create.md).

  В запросе укажите значение параметра `externalSubjectId`/`external_subject_id`:

  * Для тестового окружения —  `repo:<имя_пользователя_GitHub>/<имя_репозитория>:environment:preprod`.

      Окружение `preprod` будет использоваться далее в файлах `ci.yml` и `ct.yml`.

  * Для продакшен-окружения — `repo:<имя_пользователя_GitHub>/<имя_репозитория>:ref:refs/heads/main`.

{% endlist %}


## Настройте репозиторий {#configure-repo}

### Подготовьте файлы проекта {#prepare-files}

{% list tabs %}

- Репозиторий

  Склонируйте репозиторий:

  ```bash
  git clone https://github.com/yandex-cloud-examples/yc-serverless-ci-cd-github
  ```

  В репозитории вы увидите:

  * папку `.github/workflows` с файлами рабочих процессов: `cd.yml`, `ci.yml` и `ct.yml`;
  * код функции `index.js` и описание зависимостей `package.json`, `package-lock.json`.

- Вручную

  1. Создайте папку `yc-serverless-ci-cd-github` и перейдите в нее.
  1. Создайте файл `index.js` и вставьте в него код:

      ```javascript
      const sharp = require('sharp');

      async function cropImage(imageBase64, width, height) {
          try {
              // Decode image from base64
              const buffer = Buffer.from(imageBase64, 'base64');

              const croppedBuffer = await sharp(buffer)
                  .resize(width, height) 
                  .toBuffer(); 

              const croppedImageBase64 = croppedBuffer.toString('base64');
              return croppedImageBase64;
          } catch (error) {
              console.error('Error cropping image:', error);
              throw error;
          }
      }

      module.exports.handler = async function (event, context) {
          return {
              content: await cropImage(event.queryStringParameters.content, event.queryStringParameters.width, event.queryStringParameters.height)
          };
      };
      ```

  1. Создайте файл `package.json` и вставьте в него код:

      ```json
      {
        "name": "from-github",
        "version": "1.0.0"
      }
      ```

  1. Выполните команду:

      ```bash
      npm install --package-lock-only
      ```

      В результате выполнения команды появится файл `package-lock.json`.

  1. Создайте файлы `cd.yml`, `ci.yml`, `ct.yml` и вставьте в них код с нужными параметрами:

      {% cut "**cd.yml**" %}

      ```yml
      permissions:
        id-token: write # Это необходимо для запроса JWT

      on: 
        push:
          branches:
            - main
          paths-ignore:
            - '.github/**' # Это позволит игнорировать изменения в файлах рабочих процессов

        release:
          types:
            - published

        # Позволяет запускать этот рабочий процесс вручную из вкладки Actions
        workflow_dispatch:

      env:
        FOLDER_ID: <идентификатор_каталога>
        SA_ID: <идентификатор_сервисного_аккаунта>
        FUNCTION_NAME: from-github-cd
        FUNCTION_RUNTIME: nodejs22
        FUNCTION_ENTRYPOINT: index.handler
        FUNCTION_MEMORY: "128mb"
        FUNCTION_SOURCEROOT: .
        
      jobs:
        build:
          runs-on: ubuntu-latest
          
          steps:
            - uses: actions/checkout@v4
            - name: Deploy Function
              id: sls-func
              uses: yc-actions/yc-sls-function@v3.1.0
              with:
                yc-sa-id: $not_var{{env.SA_ID}}
                folder-id: $not_var{{env.FOLDER_ID}}
                function-name: $not_var{{env.FUNCTION_NAME}}
                runtime: $not_var{{env.FUNCTION_RUNTIME}}
                entrypoint: $not_var{{env.FUNCTION_ENTRYPOINT}}
                memory: $not_var{{env.FUNCTION_MEMORY}}
                source-root: $not_var{{env.FUNCTION_SOURCEROOT}}
                include: |
                  **/*.json
                  **/*.js
      ```

      {% endcut %}

      {% cut "**ci.yml**" %}

      ```yml
      permissions:
        id-token: write # Это необходимо для запроса JWT

      on: 
        push:
          branches: [ feature** ]
          paths-ignore:
            - '.github/**'

        # Позволяет запускать этот рабочий процесс вручную из вкладки Actions
        workflow_dispatch:

      env:
        FOLDER_ID: <идентификатор_каталога>
        SA_ID: <идентификатор_сервисного_аккаунта>
        FUNCTION_NAME: from-github-ci
        FUNCTION_RUNTIME: nodejs22
        FUNCTION_ENTRYPOINT: index.handler
        FUNCTION_MEMORY: "128mb"
        FUNCTION_SOURCEROOT: .
        
      jobs:
        build:
          environment: preprod
          runs-on: ubuntu-latest
          
          steps:
            - uses: actions/checkout@v4
            - name: Deploy Function
              id: sls-func
              uses: yc-actions/yc-sls-function@v3.1.0
              with:
                yc-sa-id: $not_var{{env.SA_ID}}
                folder-id: $not_var{{env.FOLDER_ID}}
                function-name: $not_var{{env.FUNCTION_NAME}}
                runtime: $not_var{{env.FUNCTION_RUNTIME}}
                entrypoint: $not_var{{env.FUNCTION_ENTRYPOINT}}
                memory: $not_var{{env.FUNCTION_MEMORY}}
                source-root: $not_var{{env.FUNCTION_SOURCEROOT}}
                include: |
                  **/*.json
                  **/*.js
      ```

      {% endcut %}

      {% cut "**ct.yml**" %}

      ```yml
      permissions:
        id-token: write # Это необходимо для запроса JWT

      on: 
        pull_request:
          branches: [ main ]
          paths-ignore:
            - '.github/**'
            
        # Позволяет запускать этот рабочий процесс вручную из вкладки Actions
        workflow_dispatch:

      env:
        FOLDER_ID: <идентификатор_каталога>
        SA_ID: <идентификатор_сервисного_аккаунта>
        FUNCTION_NAME: from-github-ct
        FUNCTION_RUNTIME: nodejs22
        FUNCTION_ENTRYPOINT: index.handler
        FUNCTION_MEMORY: "128mb"
        FUNCTION_SOURCEROOT: .
        
      jobs:
        build:
          environment: preprod
          runs-on: ubuntu-latest
          
          steps:
            - uses: actions/checkout@v4
            - name: Deploy Function
              id: sls-func
              uses: yc-actions/yc-sls-function@v3.1.0
              with:
                yc-sa-id: $not_var{{env.SA_ID}}
                folder-id: $not_var{{env.FOLDER_ID}}
                function-name: $not_var{{env.FUNCTION_NAME}}
                runtime: $not_var{{env.FUNCTION_RUNTIME}}
                entrypoint: $not_var{{env.FUNCTION_ENTRYPOINT}}
                memory: $not_var{{env.FUNCTION_MEMORY}}
                source-root: $not_var{{env.FUNCTION_SOURCEROOT}}
                include: |
                  **/*.json
                  **/*.js
      ```

      {% endcut %}

      Где:

      * `FOLDER_ID` — идентификатор каталога, в котором вы выполняете руководство.
      * `SA_ID` — идентификатор сервисного аккаунта, [привязанного](#create-credential) к федерации.
      * `FUNCTION_NAME` — имя функции. В примерах используются имена:

          * `from-github-ci`
          * `from-github-ct`
          * `from-github-cd`

      * `FUNCTION_RUNTIME` — [среда выполнения](../../functions/concepts/runtime/index.md) функции.
      * `FUNCTION_ENTRYPOINT` — точка входа функции.
      * `FUNCTION_MEMORY` — объем RAM функции.
      * `FUNCTION_SOURCEROOT` — путь к файлам функции в репозитории.

{% endlist %}


### Добавьте файлы рабочих процессов в репозиторий {#push-files}

{% list tabs %}

- CLI {#cli}

  1. Склонируйте ваш репозиторий, если это еще не сделано:

      ```bash
      git clone <URL_репозитория>
      ```

  1. Скопируйте полученные файлы рабочих процессов в локальную копию вашего репозитория:

      * `.github/workflows/cd.yml`
      * `.github/workflows/ci.yml`
      * `.github/workflows/ct.yml`

  1. Отправьте изменения в удаленный репозиторий:

      ```bash
      git add . && git commit -m "Added workflows" && git push
      ```

{% endlist %}


## Проверьте рабочие процессы {#check}

Последовательно запустите рабочие процессы [CI](#run-ci), [CT](#run-ct), [CD](#run-cd) и проверьте результаты их выполнения.


### Запустите рабочий процесс CI {#run-ci}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Переключитесь на ветку `main`:

      ```bash
      git checkout main
      ```

  1. Получите изменения из удаленного репозитория:

      ```bash
      git pull
      ```

  1. Создайте новую ветку `feature/smoke-test`:

      ```bash
      git checkout -b feature/smoke-test
      ```

  1. Скопируйте файлы функции в корневую папку локальной копии вашего репозитория:

      * `index.js`
      * `package.json`
      * `package-lock.json`

  1. Сохраните изменения, создайте коммит и отправьте изменения в удаленный репозиторий:

      ```bash
      git add .
      git commit -m "Added function"
      git push --set-upstream origin feature/smoke-test
      ```

      После отправки изменений автоматически запустится рабочий процесс `.github/workflows/ci.yml`.

      Дождитесь завершения рабочего процесса. Статус и логи выполнения можно проверить на вкладке ![image](../../_assets/console-icons/circle-play.svg) **Actions** вашего репозитория.

{% endlist %}


### Проверьте результат CI {#check-ci}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Выберите функцию `from-github-ci`.
  1. Перейдите на вкладку ![image](../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}**.
  1. {% include [testing-function](../_tutorials_includes/ci-cd-github-functions/testing-function.md) %}

{% endlist %}


### Запустите рабочий процесс CT {#run-ct}

{% list tabs group=instructions %}

- CLI {#cli}

  [Создайте пул-реквест](https://docs.github.com/{{ lang }}/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request) из ветки `feature/smoke-test` в ветку `main` через интерфейс GitHub.

  После создания пул-реквеста автоматически запустится рабочий процесс `.github/workflows/ct.yml`.

  Дождитесь завершения рабочего процесса. Статус и логи выполнения можно проверить на вкладке ![image](../../_assets/console-icons/circle-play.svg) **Actions** вашего репозитория.

{% endlist %}

### Проверьте результат CT {#check-ct}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Выберите функцию `from-github-ct`.
  1. Перейдите на вкладку ![image](../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}**.
  1. {% include [testing-function](../_tutorials_includes/ci-cd-github-functions/testing-function.md) %}

{% endlist %}


### Запустите рабочий процесс CD {#run-cd}

{% list tabs group=instructions %}

- CLI {#cli}

  [Смержите ваш пул-реквест](https://docs.github.com/{{ lang }}/pull-requests/collaborating-with-pull-requests/incorporating-changes-from-a-pull-request/merging-a-pull-request) в ветку `main` через интерфейс GitHub.

  После этого автоматически запустится рабочий процесс `.github/workflows/cd.yml`.

  Дождитесь завершения рабочего процесса. Статус и логи выполнения можно проверить на вкладке ![image](../../_assets/console-icons/circle-play.svg) **Actions** вашего репозитория.

{% endlist %}

### Проверьте результат CD {#check-cd}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Выберите функцию `from-github-cd`.
  1. Перейдите на вкладку ![image](../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}**.
  1. {% include [testing-function](../_tutorials_includes/ci-cd-github-functions/testing-function.md) %}

{% endlist %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../functions/operations/function/function-delete.md) функции.
1. [Удалите](../../logging/operations/delete-group.md) лог-группу.