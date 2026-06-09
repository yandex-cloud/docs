# Настройка CI/CD с GitHub

[GitHub](https://github.com/) дает возможность хранить код функции [Yandex Cloud Functions](../index.md) и развертывать новые версии [функции](../concepts/function.md) при изменениях в репозитории.

В этом руководстве вы настроите CI/CD между Cloud Functions и GitHub с помощью федерации сервисных аккаунтов [Yandex Identity and Access Management](../../iam/index.md) и развернете функции Cloud Functions через запуск [рабочих процессов](https://docs.github.com/ru/actions/concepts/workflows-and-actions/workflows) GitHub Actions.

Чтобы настроить CI/CD:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте репозиторий](#create-repository).
1. [Подготовьте инфраструктуру в Yandex Cloud](#prepare-infrastructure).
1. [Настройте репозиторий](#configure-repo).
1. [Проверьте рабочие процессы](#check).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для этого практического руководства входят:

* Плата за количество вызовов функции, вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик (см. [тарифы Cloud Functions](../pricing.md)).
* Плата за запись и хранение логов функции в [лог-группе](../../logging/concepts/log-group.md) (см. [тарифы Yandex Cloud Logging](../../logging/pricing.md)).


## Создайте репозиторий {#create-repository}

[Создайте](https://docs.github.com/ru/repositories/creating-and-managing-repositories/creating-a-new-repository) новый репозиторий на GitHub или используйте существующий, в котором у вас есть права на просмотр и запуск GitHub Actions.

Имена репозитория и пользователя GitHub потребуются в дальнейшем.


## Подготовьте инфраструктуру в Yandex Cloud {#prepare-infrastructure}

### Создайте сервисный аккаунт {#create-sa}

От имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) с [ролью](../security/index.md#functions-admin) `functions.admin` GitHub будет создавать функцию и ее версии.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете создавать инфраструктуру.
  1. Перейдите в сервис **Identity and Access Management**.
  1. Нажмите **Создать сервисный аккаунт**.
  1. Введите имя сервисного аккаунта: `ci-cd-github-sa`.
  1. Нажмите ![plus](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль `functions.admin`.
  1. Нажмите **Создать**.

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

  1. Назначьте роль `functions.admin` сервисному аккаунту:

      ```bash
      yc resource-manager folder add-access-binding <имя_или_идентификатор_каталога> \
        --role functions.admin \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

      Результат:

      ```text
      effective_deltas:
        - action: ADD
          access_binding:
            role_id: functions.admin
            subject:
              id: ajejocsfa1jj********
              type: serviceAccount
      ```

- API {#api}

  Чтобы создать сервисный аккаунт, воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).

  Чтобы назначить сервисному аккаунту роль `functions.admin` на каталог, воспользуйтесь методом REST API [updateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/UpdateAccessBindings](../../resource-manager/api-ref/grpc/Folder/updateAccessBindings.md).

{% endlist %}


### Создайте федерацию сервисных аккаунтов {#create-federation}

[Федерация сервисных аккаунтов](../../iam/concepts/workload-identity.md) необходима для настройки обмена токенов GitHub на [IAM-токены](../../iam/concepts/authorization/iam-token.md) Yandex Cloud.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Identity and Access Management**.
  1. На панели слева выберите ![cpus](../../_assets/console-icons/cpus.svg) **Федерации сервисных аккаунтов**.
  1. Нажмите **Создать федерацию**.
  1. В поле **Значение Issuer (iss)** введите URL OIDC-провайдера: `https://token.actions.githubusercontent.com`.
  1. В поле **Допустимые значения Audience (aud)** введите получателя токена: `https://github.com/<имя_пользователя_GitHub>`.
  1. В поле **Адрес JWKS** введите URL списка публичных ключей: `https://token.actions.githubusercontent.com/.well-known/jwks`.
  1. В поле **Имя** введите имя федерации: `ci-cd-github-federation`.
  1. Нажмите **Создать**.

- Yandex Cloud CLI {#cli}

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

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Identity and Access Management**.
  1. Выберите сервисный аккаунт `ci-cd-github-sa`.
  1. На верхней панели нажмите ![image](../../_assets/console-icons/cpus.svg) **Привязать к федерации**.
  1. В поле **Федерация сервисных аккаунтов** выберите федерацию `ci-cd-github-federation`.
  1. В поле **Значение Subject (sub)** укажите идентификатор внешнего субъекта для тестового окружения: `repo:<имя_пользователя_GitHub>/<имя_репозитория>:environment:preprod`.

      Окружение `preprod` будет использоваться далее в файлах `ci.yml` и `ct.yml`.

  1. Нажмите **Привязать**.

  Аналогичным способом создайте привязку с идентификатором внешнего субъекта для продакшен-окружения: `repo:<имя_пользователя_GitHub>/<имя_репозитория>:ref:refs/heads/main`.

- Yandex Cloud CLI {#cli}

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

      * `FUNCTION_RUNTIME` — [среда выполнения](../concepts/runtime/index.md) функции.
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

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Cloud Functions**.
  1. Выберите функцию `from-github-ci`.
  1. Перейдите на вкладку ![image](../../_assets/console-icons/circle-play.svg) **Тестирование**.
  1. В поле **Входные данные** введите следующий код и нажмите ![image](../../_assets/console-icons/play-fill.svg) **Запустить тест**:
     
     ```json
     {
       "queryStringParameters": {
         "content": "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAAAAAA6fptVAAAACklEQVR4nGNgYAAAAAMAASsJTYQAAAAASUVORK5CYII=",
         "width": 100,
         "height": 100
       }
     }
     ```
     
     В разделе **Результат тестирования** появится ответ функции:
     
     ```json
     {
         "content": "iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAIAAAD/gAIDAAAACXBIWXMAAAsTAAALEwEAmpwYAAAANElEQVR4nO3BAQ0AAADCoPdPbQ43oAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAujF1lAABe5jSrAAAAABJRU5ErkJggg=="
     }
     ```

{% endlist %}


### Запустите рабочий процесс CT {#run-ct}

{% list tabs group=instructions %}

- CLI {#cli}

  [Создайте пул-реквест](https://docs.github.com/ru/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request) из ветки `feature/smoke-test` в ветку `main` через интерфейс GitHub.

  После создания пул-реквеста автоматически запустится рабочий процесс `.github/workflows/ct.yml`.

  Дождитесь завершения рабочего процесса. Статус и логи выполнения можно проверить на вкладке ![image](../../_assets/console-icons/circle-play.svg) **Actions** вашего репозитория.

{% endlist %}

### Проверьте результат CT {#check-ct}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Cloud Functions**.
  1. Выберите функцию `from-github-ct`.
  1. Перейдите на вкладку ![image](../../_assets/console-icons/circle-play.svg) **Тестирование**.
  1. В поле **Входные данные** введите следующий код и нажмите ![image](../../_assets/console-icons/play-fill.svg) **Запустить тест**:
     
     ```json
     {
       "queryStringParameters": {
         "content": "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAAAAAA6fptVAAAACklEQVR4nGNgYAAAAAMAASsJTYQAAAAASUVORK5CYII=",
         "width": 100,
         "height": 100
       }
     }
     ```
     
     В разделе **Результат тестирования** появится ответ функции:
     
     ```json
     {
         "content": "iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAIAAAD/gAIDAAAACXBIWXMAAAsTAAALEwEAmpwYAAAANElEQVR4nO3BAQ0AAADCoPdPbQ43oAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAujF1lAABe5jSrAAAAABJRU5ErkJggg=="
     }
     ```

{% endlist %}


### Запустите рабочий процесс CD {#run-cd}

{% list tabs group=instructions %}

- CLI {#cli}

  [Смержите ваш пул-реквест](https://docs.github.com/ru/pull-requests/collaborating-with-pull-requests/incorporating-changes-from-a-pull-request/merging-a-pull-request) в ветку `main` через интерфейс GitHub.

  После этого автоматически запустится рабочий процесс `.github/workflows/cd.yml`.

  Дождитесь завершения рабочего процесса. Статус и логи выполнения можно проверить на вкладке ![image](../../_assets/console-icons/circle-play.svg) **Actions** вашего репозитория.

{% endlist %}

### Проверьте результат CD {#check-cd}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Cloud Functions**.
  1. Выберите функцию `from-github-cd`.
  1. Перейдите на вкладку ![image](../../_assets/console-icons/circle-play.svg) **Тестирование**.
  1. В поле **Входные данные** введите следующий код и нажмите ![image](../../_assets/console-icons/play-fill.svg) **Запустить тест**:
     
     ```json
     {
       "queryStringParameters": {
         "content": "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAAAAAA6fptVAAAACklEQVR4nGNgYAAAAAMAASsJTYQAAAAASUVORK5CYII=",
         "width": 100,
         "height": 100
       }
     }
     ```
     
     В разделе **Результат тестирования** появится ответ функции:
     
     ```json
     {
         "content": "iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAIAAAD/gAIDAAAACXBIWXMAAAsTAAALEwEAmpwYAAAANElEQVR4nO3BAQ0AAADCoPdPbQ43oAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAujF1lAABe5jSrAAAAABJRU5ErkJggg=="
     }
     ```

{% endlist %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../operations/function/function-delete.md) функции.
1. [Удалите](../../logging/operations/delete-group.md) лог-группу.