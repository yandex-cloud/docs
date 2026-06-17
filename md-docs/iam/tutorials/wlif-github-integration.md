# Получение значения секрета Yandex Lockbox на стороне GitHub

[Федерации сервисных аккаунтов](../concepts/workload-identity.md) (Workload Identity Federation) позволяют настроить связь между внешними системами и Yandex Cloud по протоколу [OpenID Connect](https://openid.net/developers/how-connect-works/) (OIDC). За счет этого внешние системы могут выполнять действия с ресурсами Yandex Cloud от имени [сервисных аккаунтов](../concepts/users/service-accounts.md) IAM без использования [авторизованных ключей](../concepts/authorization/key.md). Это более безопасный способ, минимизирующий риск утечки учетных данных и возможность несанкционированного доступа.

В этом руководстве для примера показано, как получить значение [секрета](../../lockbox/concepts/secret.md) [Yandex Lockbox](../../lockbox/index.md) со стороны GitHub от имени сервисного аккаунта в Yandex Cloud. Аналогично можно выполнить любое действие через Yandex Cloud [CLI](../../cli/quickstart.md), [API](../../api-design-guide/index.md) или [Terraform](../../terraform/index.md).

Чтобы получить значение секрета Yandex Lockbox от имени аккаунта на GitHub:

1. [Создайте репозиторий в GitHub](#create-github-repo).
1. [Подготовьте облако к работе](#prepare-cloud).
1. [Настройте сценарий GitHub Actions](#github-actions-workflow).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Создайте репозиторий в GitHub {#create-github-repo}

[Создайте](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-new-repository) новый репозиторий на GitHub или используйте существующий, в котором у вас есть права на просмотр и запуск GitHub Actions.

## Подготовьте облако к работе {#prepare-cloud}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит плата за хранение [секрета](../../lockbox/concepts/secret.md) и запросы к нему ([тарифы Yandex Lockbox](../../lockbox/pricing.md)).

### Создайте федерацию сервисных аккаунтов {#federation-iam-accounts}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы хотите создать федерацию сервисных аккаунтов.
   1. Перейдите в сервис **Identity and Access Management**.
   1. На панели слева выберите ![cpus](../../_assets/console-icons/cpus.svg) **Федерации сервисных аккаунтов**.
   1. Нажмите **Создать федерацию**.
   1. В поле **Значение Issuer (iss)** введите URL OIDC-провайдера `https://token.actions.githubusercontent.com`.
   1. В поле **Допустимые значения Audience (aud)** введите получателя токена `https://github.com/<имя_пользователя_github>`.
   1. В поле **Адрес JWKS** введите URL списка публичных ключей `https://token.actions.githubusercontent.com/.well-known/jwks`.
   1. В поле **Имя** введите имя федерации, например `test-iam-federation`.
   1. Нажмите кнопку **Создать**.

{% endlist %}

### Создайте пользовательский секрет

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором будет создан секрет.
   1. Перейдите в сервис **Lockbox**.
   1. Нажмите кнопку **Создать секрет**.
   1. В поле **Имя** введите имя секрета `MY_SECRET`.
   1. Выберите **Тип секрета** `Пользовательский`.
   1. В поле **Ключ** введите неконфиденциальный идентификатор, например `secret`.
   1. В поле **Значение** введите конфиденциальные данные для хранения.
   1. Нажмите кнопку **Создать**.

{% endlist %}

### Создайте сервисный аккаунт

1. Создайте сервисный аккаунт:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать сервисный аккаунт.
      1. Перейдите в сервис **Identity and Access Management**.
      1. Нажмите кнопку **Создать сервисный аккаунт**.
      1. Введите имя сервисного аккаунта, например `sa-lockbox`.
      1. Нажмите кнопку **Создать**.

   {% endlist %}

1. Назначьте сервисному аккаунту [роль](../concepts/access-control/roles.md) `lockbox.payloadViewer` на каталог: 

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. На [стартовой странице](https://console.yandex.cloud) консоли управления выберите каталог.
      1. Перейдите на вкладку **Права доступа**.
      1. Найдите аккаунт `sa-lockbox` в списке и нажмите значок ![image](../../_assets/console-icons/ellipsis.svg).
      1. Нажмите кнопку **Изменить роли**.
      1. В открывшемся диалоге нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль `lockbox.payloadViewer`.

   {% endlist %}

### Привяжите сервисный аккаунт к Федерации

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором был создан сервисный аккаунт.
   1. Перейдите в сервис **Identity and Access Management**.
   1. В списке выберите сервисный аккаунт `sa-lockbox`.
   1. На верхней панели нажмите ![image](../../_assets/console-icons/cpus.svg) **Привязать к федерации**.
   1. В поле **Федерация сервисных аккаунтов** выберите ранее созданную федерацию.
   1. В поле **Значение Subject (sub)** укажите идентификатор внешнего аккаунта `repo:<имя_пользователя_github>/<название_репозитория_github>:ref:refs/heads/main`.
   1. Нажмите кнопку **Привязать**.

{% endlist %}

## Настройте сценарий GitHub Actions {#github-actions-workflow}

1. Склонируйте ваш репозиторий, если это еще не сделано:

   ```bash
   git clone <URL_репозитория>
   ```

1. В локальной копии вашего репозитория создайте файл `blank.yml` в директории `.github/workflows`.
1. Вставьте в файл `blank.yml` следующий код, который получит значение секрета Yandex Lockbox:

   ```yaml
   name: CI

   permissions:
     id-token: write # Требуется для запроса JWT-токена

   # Controls when the workflow will run
   on:
     # Запускает выполнение сценария при пуш или пул-реквесте в ветке "main"
     push:
       branches: [ "main" ]
     pull_request:
       branches: [ "main" ]
   
     # Позволяет запустить сценарий вручную во вкладке Actions
     workflow_dispatch:

   jobs:
     job:
       runs-on: ubuntu-latest
       steps:
       - name: Install OIDC Client from Core Package
         run: npm install @actions/core @actions/http-client
       # Получить токен задания рабочего процесса
       - name: Get Id Token
         uses: actions/github-script@v7
         id: tokenid
         with:
           script: |
             const coredemo = require('@actions/core')
             let id_token = await coredemo.getIDToken()
             coredemo.setOutput('id_token', id_token)
       # Обменять токен задания рабочего процесса на IAM-токен сервисного аккаунта в Yandex Cloud
       - name: GetIAMToken
         run: |
           SA_ID="<идентификатор_сервисного_аккаунта>"
           IAMTOKEN=$(curl -sH "Content-Type: application/x-www-form-urlencoded" -d "grant_type=urn:ietf:params:oauth:grant-type:token-exchange&requested_token_type=urn:ietf:params:oauth:token-type:access_token&audience=$SA_ID&subject_token=${{steps.tokenid.outputs.id_token}}&subject_token_type=urn:ietf:params:oauth:token-type:id_token" -X POST https://auth.yandex.cloud/oauth/token | jq -r '.access_token')
           echo "IAMToken=${IAMTOKEN}" >> $GITHUB_OUTPUT
         id: IAMtoken
       # Запросить значение секрета через API, используя IAM-токен в Yandex Cloud
       - name: GetLockboxPayload
         run: |
           SECRET_ID="<идентификатор_секрета>"
           SECRET_DATA=$(curl -sH "Authorization: Bearer ${{steps.IAMtoken.outputs.IAMTOKEN}}" https://payload.lockbox.api.cloud.yandex.net/lockbox/v1/secrets/$SECRET_ID/payload)
           echo "SECRET_DATA=${SECRET_DATA}" >> $GITHUB_OUTPUT
         id: getlockboxpayload
   ```

   Где:
   * `SA_ID` — идентификатор сервисного аккаунта;
   * `SECRET_ID` — идентификатор пользовательского секрета.

1. Сохраните файл и отправьте изменения в удаленный репозиторий:

   ```bash
   git add . && git commit -m "Added blank.yml" && git push
   ```

   После отправки кода в репозиторий начнется выполнение рабочего процесса. Результат выполнения сценария можно посмотреть в логе на вкладке `Actions` вашего репозитория:

   ```json
   {
   "entries": [
   {
      "key": "secret",
      "textValue": "67cH2£?pO********"
   }
   ],
   "versionId": "e6q8isknpcp7********"
   }
   ```

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

* [секрет Yandex Lockbox](../../lockbox/operations/secret-delete.md);
* [сервисный аккаунт](../operations/sa/delete.md).

## Смотрите также {#see-also}

* [Безопасное хранение паролей для GitLab CI в виде секретов Yandex Lockbox](../../tutorials/security/gitlab-lockbox-integration.md).