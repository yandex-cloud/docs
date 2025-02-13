# Получение значения секрета Lockbox на стороне GitHub

{% include [move-groups-api](../../_includes/iam/wlif-instructions-intro.md) %}

В этом руководстве для примера показано, как получить значение [секрета](../../lockbox/concepts/secret) [{{ lockbox-full-name }}](../../lockbox/) со стороны GitHub от имени сервисного аккаунта в {{ yandex-cloud }}. Аналогично можно выполнить любое действие через {{ yandex-cloud }} [CLI](../../cli/quickstart.md), [API](../../api-design-guide/index.yaml) или [{{ TF }}]({{ tf-provider-link }}).

Чтобы получить значение секрета {{ lockbox-name }} от имени аккаунта на GitHub:

1. [Создайте репозиторий в GitHub](#create-github-repo).
1. [Подготовьте облако к работе](#prepare-cloud).
1. [Настройте сценарий GitHub Actions](#github-actions-workflow).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Создайте репозиторий в GitHub {#create-github-repo}

[Создайте](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-new-repository) новый репозиторий на GitHub или используйте существующий, в котором у вас есть права на просмотр и запуск GitHub Actions.

## Подготовьте облако к работе {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит плата за хранение [секрета](../../lockbox/concepts/secret.md) и запросы к нему (см. [тарифы {{ lockbox-name }}](../../lockbox/pricing.md)).

### Создайте федерацию сервисных аккаунтов {#federation-iam-accounts}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать федерацию сервисных аккаунтов.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. На панели слева выберите ![cpus](../../_assets/console-icons/cpus.svg) **{{ ui-key.yacloud.iam.label_federations }}**.
   1. Нажмите **{{ ui-key.yacloud.iam.label_create-wli-federation }}**.
   1. В поле **{{ ui-key.yacloud.iam.federations.field_issuer }}** введите URL OIDC-провайдера `https://token.actions.githubusercontent.com`.
   1. В поле **{{ ui-key.yacloud.iam.federations.field_audiences }}** введите получателя токена `https://github.com/<имя_пользователя_github>`.
   1. В поле **{{ ui-key.yacloud.iam.federations.field_jwks }}** введите URL списка публичных ключей `https://token.actions.githubusercontent.com/.well-known/jwks`.
   1. В поле **{{ ui-key.yacloud.iam.federations.field_name }}** введите имя федерации, например `test-iam-federation`.
   1. Нажмите кнопку **{{ ui-key.yacloud_billing.iam.cloud.create.popup-create-cloud_button_add }}**.

{% endlist %}

### Создайте пользовательский секрет

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан секрет.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.lockbox.button_create-secret }}**.
   1. В поле **{{ ui-key.yacloud.common.name }}** введите имя секрета `MY_SECRET`.
   1. Выберите **{{ ui-key.yacloud.lockbox.forms.title_secret-type }}** `{{ ui-key.yacloud.lockbox.forms.title_secret-type-custom }}`.
   1. В поле **{{ ui-key.yacloud.lockbox.forms.label_key }}** введите неконфиденциальный идентификатор, например `secret`.
   1. В поле **{{ ui-key.yacloud.lockbox.forms.label_value }}** введите конфиденциальные данные для хранения.
   1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Создайте сервисный аккаунт

1. Создайте сервисный аккаунт:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать сервисный аккаунт.
      1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. Введите имя сервисного аккаунта, например `sa-lockbox`.
      1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

   {% endlist %}

1. Назначьте сервисному аккаунту [роль](../../iam/concepts/access-control/roles.md) `{{ roles-lockbox-payloadviewer }}` на каталог: 

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. На [стартовой странице]({{ link-console-main }}) консоли управления выберите каталог.
      1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
      1. Найдите аккаунт `sa-lockbox` в списке и нажмите значок ![image](../../_assets/console-icons/ellipsis.svg).
      1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
      1. В открывшемся диалоге нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.acl.update-dialog.button_add-role }}** и выберите роль `{{ roles-lockbox-payloadviewer }}`.

   {% endlist %}

### Привяжите сервисный аккаунт к Федерации

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором был создан сервисный аккаунт.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. В списке выберите сервисный аккаунт `sa-lockbox`.
   1. Перейдите на вкладку **{{ ui-key.yacloud.iam.label_federations }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.connected-federation.action_connect-federation }}**.
   1. В поле **{{ ui-key.yacloud.iam.connected-federation.field_federation }}** выберите ранее созданную федерацию.
   1. В поле **{{ ui-key.yacloud.iam.connected-federation.field_subject }}** укажите идентификатор внешнего аккаунта `repo:<имя_пользователя_github>/<название_репозитория_github>:ref:refs/heads/main`.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.connected-federation.action_connect }}**.

{% endlist %}

## Настройте сценарий GitHub Actions {#github-actions-workflow}

1. Склонируйте ваш репозиторий, если это еще не сделано:

   ```bash
   git clone <URL_репозитория>
   ```

1. В локальной копии вашего репозитория создайте файл `blank.yml` в директории `.github/workflows`.
1. Вставьте в файл `blank.yml` следующий код, который получит значение секрета {{ lockbox-name }}:

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
       # Обменять токен задания рабочего процесса на IAM-токен сервисного аккаунта в {{ yandex-cloud }}
       - name: GetIAMToken
         run: |
           SA_ID="<идентификатор_сервисного_аккаунта>"
           IAMTOKEN=$(curl -sH "Content-Type: application/x-www-form-urlencoded" -d "grant_type=urn:ietf:params:oauth:grant-type:token-exchange&requested_token_type=urn:ietf:params:oauth:token-type:access_token&audience=$SA_ID&subject_token=$not_var{{steps.tokenid.outputs.id_token}}&subject_token_type=urn:ietf:params:oauth:token-type:id_token" -X POST https://{{ auth-main-host }}/oauth/token | jq -r '.access_token')
           echo "IAMToken=${IAMTOKEN}" >> $GITHUB_OUTPUT
         id: IAMtoken
       # Запросить значение секрета через API, используя IAM-токен в {{ yandex-cloud }}
       - name: GetLockboxPayload
         run: |
           SECRET_ID="<идентификатор_секрета>"
           SECRET_DATA=$(curl -sH "Authorization: Bearer $not_var{{steps.IAMtoken.outputs.IAMTOKEN}}" https://payload.lockbox.api.cloud.yandex.net/lockbox/v1/secrets/$SECRET_ID/payload)
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

* [секрет {{ lockbox-name }}](../../lockbox/operations/secret-delete.md);
* [сервисный аккаунт](../../iam/operations/sa/delete.md).

## Смотрите также {#see-also}

* [{#T}](../../tutorials/security/gitlab-lockbox-integration.md).