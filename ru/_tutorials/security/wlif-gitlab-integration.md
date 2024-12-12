# Получение значения секрета Lockbox на стороне {{ GL }}

[Федерации сервисных аккаунтов](../../iam/concepts/workload-identity) (Workload Identity Federation) позволяют настроить связь между внешними системами и {{ yandex-cloud }} по протоколу [OpenID Connect](https://openid.net/developers/how-connect-works/) (OIDC). За счет этого внешние системы могут выполнять действия с ресурсами {{ yandex-cloud }} от имени сервисных аккаунтов без генерации статических учетных данных, например авторизованных ключей или IAM-токенов. Это более безопасный способ, минимизирующий риск утечки учетных данных и возможность несанкционированного доступа.

В этом руководстве для примера показано, как получить значение [секрета](../../lockbox/concepts/secret) [{{ lockbox-full-name }}](../../lockbox/) со стороны {{ GL }} от имени сервисного аккаунта в {{ yandex-cloud }}. Аналогично можно выполнить любое действие через {{ yandex-cloud }} [CLI](../../cli/quickstart.md), [API](../../api-design-guide/index.yaml) или [{{ TF }}]({{ tf-provider-link }}).

Чтобы получить значение секрета {{ lockbox-name }} от имени аккаунта на {{ GL }}:

1. [Создайте проект {{ GL }}](#create-gitlab-project)
1. [Подготовьте облако к работе](#prepare-cloud).
1. [Настройте сценарий {{ GL }} CI/CD](#gitlab-actions-workflow).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Создайте проект {{ GL }} {#create-gitlab-project}

[Создайте новый проект {{ GL }}]({{ gl.docs }}/ee/user/project/) или используйте существующий, в котором у вас есть права на просмотр и выполнение {{ GL }} CI/CD пайплайнов.

## Подготовьте облако к работе {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит плата за хранение [секрета](../../lockbox/concepts/secret.md) и запросы к нему (см. [тарифы {{ lockbox-name }}](../../lockbox/pricing.md)).


### Создайте федерацию сервисных аккаунтов {#federation-iam-accounts}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать федерацию сервисных аккаунтов.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. Перейдите на вкладку **{{ ui-key.yacloud.iam.label_federations }}**.
   1. Нажмите **{{ ui-key.yacloud.iam.label_create-wli-federation }}**.
   1. В поле **{{ ui-key.yacloud.iam.federations.field_issuer }}** введите URL OIDC-провайдера `https://gitlab.com`.
   1. В поле **{{ ui-key.yacloud.iam.federations.field_audiences }}** введите получателя токена `https://gitlab.com/<название_группы>/<название_проекта_gitlab>`.
   1. В поле **{{ ui-key.yacloud.iam.federations.field_jwks }}** введите URL списка публичных ключей `https://gitlab.com/oauth/discovery/keys`.
   1. В поле **{{ ui-key.yacloud.iam.federations.field_name }}** введите имя федерации, например `test-iam-federation`.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.cloud.create.popup-create-cloud_button_add }}**.

   {% note info %}

   Если вы используете пользовательскую инсталляцию {{ GL }}, замените `https://gitlab.com` на адрес вашей инсталляции во всех упоминаемых значениях.

   {% endnote %}

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

### Привяжите сервисный аккаунт к федерации

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором была создан сервисный аккаунт.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. В списке выберите сервисный аккаунт `sa-lockbox`.
   1. Перейдите на вкладку **{{ ui-key.yacloud.iam.label_federations }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.connected-federation.action_connect-federation }}**.
   1. В поле **{{ ui-key.yacloud.iam.connected-federation.field_federation }}** выберите ранее созданную федерацию.
   1. В поле **{{ ui-key.yacloud.iam.connected-federation.field_subject }}** укажите идентификатор внешнего аккаунта `project_path:<название_группы>/<название_проекта_gitlab>:ref_type:branch:ref:<название_ветки_репозитория>`.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.connected-federation.action_connect }}**.

{% endlist %}

## Настройте сценарий {{ GL }} CI/CD {#gitlab-ci-workflow}

1. Склонируйте ваш репозиторий, если это еще не сделано:

   ```bash
   git clone <URL_репозитория>
   ```

1. В локальной копии вашего репозитория создайте файл `.gitlab-ci.yml` в корневой директории.
1. Вставьте в файл `.gitlab-ci.yml` следующий код, который получит значение секрета {{ lockbox-name }}:

   ```yaml
   stages:
   - check_token

   check_token:
     stage: check_token
     image: 
       name: ubuntu
     id_tokens:
       GITLAB_OIDC_TOKEN:
         aud: https://gitlab.com/<название_группы>/<название_проекта_gitlab>
     script:
      - apt update && apt install curl jq -y
      # Обменять токен задания рабочего процесса на IAM-токен сервисного аккаунта в {{ yandex-cloud }}
      - SA_ID="<идентификатор_сервисного_аккаунта>"      
      - >-
       IAM_TOKEN="$(curl -s
       -H "Content-Type: application/x-www-form-urlencoded" 
       -d "grant_type=urn:ietf:params:oauth:grant-type:token-exchange&requested_token_type=urn:ietf:params:oauth:token-type:access_token&audience=${SA_ID}&subject_token=${GITLAB_OIDC_TOKEN}&subject_token_type=urn:ietf:params:oauth:token-type:id_token" 
       -X POST https://auth.yandex.cloud/oauth/token | jq -r '.access_token')"
      # Запросить значение секрета через API, используя IAM-токен в {{ yandex-cloud }}
      - SECRET_ID="<идентификатор_секрета>"
      - >-
       SECRET_DATA=$(curl -sH "Authorization: Bearer ${IAM_TOKEN}" https://payload.lockbox.api.cloud.yandex.net/lockbox/v1/secrets/$SECRET_ID/payload)
      - echo ${SECRET_DATA}
     tags:
       - app-test
   ```

   Где:
   * `aud` — получатель токена, указанный при создании федерации сервисных аккаунтов;
   * `SA_ID` — идентификатор сервисного аккаунта;
   * `SECRET_ID` — идентификатор пользовательского секрета.

1. Сохраните файл и отправьте изменения в удаленный репозиторий:

   ```bash
   git add . && git commit -m "Added .gitlab-ci.yml" && git push
   ```

   После отправки кода в репозиторий начнется выполнение рабочего процесса.

1. В меню слева в {{ GL }} перейдите в раздел **Build** → **Pipelines**.
1. Убедитесь, что сборка принимает статус **Passed**. Он означает, что сборка прошла успешно.
1. В меню слева в {{ GL }} перейдите в раздел **Build** → **Jobs**.
1. Нажмите на последнее выполненное задание, чтобы посмотреть результат выполнения сценария в логе:

   ```json
   { "entries": [ { "key": "secret", "textValue": "67cH2£?pO********" } ], "versionId": "e6q8isknpcp7********" }
   ```

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

* [секрет {{ lockbox-name }}](../../lockbox/operations/secret-delete.md);
* [сервисный аккаунт](../../iam/operations/sa/delete.md).

## Смотрите также {#see-also}

* [{#T}](../../tutorials/security/gitlab-lockbox-integration.md);
* [{#T}](../../tutorials/security/wlif-github-integration.md).