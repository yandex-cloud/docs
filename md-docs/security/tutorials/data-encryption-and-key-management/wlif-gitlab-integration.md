[Документация Yandex Cloud](../../../index.md) > [Безопасность в Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > Шифрование данных и управление ключами > Получение значения секрета Yandex Lockbox на стороне GitLab

# Получение значения секрета Yandex Lockbox на стороне GitLab

[Федерации сервисных аккаунтов](../../../iam/concepts/workload-identity.md) (Workload Identity Federation) позволяют настроить связь между внешними системами и Yandex Cloud по протоколу [OpenID Connect](https://openid.net/developers/how-connect-works/) (OIDC). За счет этого внешние системы могут выполнять действия с ресурсами Yandex Cloud от имени [сервисных аккаунтов](../../../iam/concepts/users/service-accounts.md) IAM без использования [авторизованных ключей](../../../iam/concepts/authorization/key.md). Это более безопасный способ, минимизирующий риск утечки учетных данных и возможность несанкционированного доступа.

В этом руководстве для примера показано, как получить значение [секрета](../../../lockbox/concepts/secret.md) [Yandex Lockbox](../../../lockbox/index.md) со стороны GitLab от имени сервисного аккаунта в Yandex Cloud. Аналогично можно выполнить любое действие через Yandex Cloud [CLI](../../../cli/quickstart.md), [API](../../../api-design-guide/index.md) или [Terraform](../../../terraform/index.md).

Чтобы получить значение секрета Yandex Lockbox от имени аккаунта на GitLab:

1. [Создайте проект GitLab](#create-gitlab-project).
1. [Подготовьте облако к работе](#prepare-cloud).
1. [Настройте сценарий GitLab CI/CD](#gitlab-actions-workflow).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Создайте проект GitLab {#create-gitlab-project}

[Создайте новый проект GitLab](https://docs.gitlab.com/ee/user/project/) или используйте существующий, в котором у вас есть права на просмотр и выполнение GitLab CI/CD пайплайнов.

## Подготовьте облако к работе {#prepare-cloud}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит плата за хранение [секрета](../../../lockbox/concepts/secret.md) и запросы к нему ([тарифы Yandex Lockbox](../../../lockbox/pricing.md)).

### Создайте федерацию сервисных аккаунтов {#federation-iam-accounts}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы хотите создать федерацию сервисных аккаунтов.
   1. Перейдите в сервис **Identity and Access Management**.
   1. На панели слева выберите ![cpus](../../../_assets/console-icons/cpus.svg) **Федерации сервисных аккаунтов**.
   1. Нажмите **Создать федерацию**.
   1. В поле **Значение Issuer (iss)** введите URL OIDC-провайдера `https://gitlab.com`.
   1. В поле **Допустимые значения Audience (aud)** введите получателя токена `https://gitlab.com/<название_группы>/<название_проекта_gitlab>`.
   1. В поле **Адрес JWKS** введите URL списка публичных ключей `https://gitlab.com/oauth/discovery/keys`.
   1. В поле **Имя** введите имя федерации, например `test-iam-federation`.
   1. Нажмите кнопку **Создать**.

   {% note info %}

   Если вы используете пользовательскую инсталляцию GitLab, замените `https://gitlab.com` на адрес вашей инсталляции во всех упоминаемых значениях.

   {% endnote %}

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

1. Назначьте сервисному аккаунту [роль](../../../iam/concepts/access-control/roles.md) `lockbox.payloadViewer` на каталог: 

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. На [стартовой странице](https://console.yandex.cloud) консоли управления выберите каталог.
      1. Перейдите на вкладку **Права доступа**.
      1. Найдите аккаунт `sa-lockbox` в списке и нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg).
      1. Нажмите кнопку **Изменить роли**.
      1. В открывшемся диалоге нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль `lockbox.payloadViewer`.

   {% endlist %}

### Привяжите сервисный аккаунт к федерации

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором был создан сервисный аккаунт.
   1. Перейдите в сервис **Identity and Access Management**.
   1. В списке выберите сервисный аккаунт `sa-lockbox`.
   1. На верхней панели нажмите ![image](../../../_assets/console-icons/cpus.svg) **Привязать к федерации**.
   1. В поле **Федерация сервисных аккаунтов** выберите ранее созданную федерацию.
   1. В поле **Значение Subject (sub)** укажите идентификатор внешнего аккаунта `project_path:<название_группы>/<название_проекта_gitlab>:ref_type:branch:ref:<название_ветки_репозитория>`.
   1. Нажмите кнопку **Привязать**.

{% endlist %}

## Настройте сценарий GitLab CI/CD {#gitlab-ci-workflow}

1. Склонируйте ваш репозиторий, если это еще не сделано:

   ```bash
   git clone <URL_репозитория>
   ```

1. В локальной копии вашего репозитория создайте файл `.gitlab-ci.yml` в корневой директории.
1. Вставьте в файл `.gitlab-ci.yml` следующий код, который получит значение секрета Yandex Lockbox:

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
      # Обменять токен задания рабочего процесса на IAM-токен сервисного аккаунта в Yandex Cloud
      - SA_ID="<идентификатор_сервисного_аккаунта>"      
      - >-
       IAM_TOKEN="$(curl -s
       -H "Content-Type: application/x-www-form-urlencoded" 
       -d "grant_type=urn:ietf:params:oauth:grant-type:token-exchange&requested_token_type=urn:ietf:params:oauth:token-type:access_token&audience=${SA_ID}&subject_token=${GITLAB_OIDC_TOKEN}&subject_token_type=urn:ietf:params:oauth:token-type:id_token" 
       -X POST https://auth.yandex.cloud/oauth/token | jq -r '.access_token')"
      # Запросить значение секрета через API, используя IAM-токен в Yandex Cloud
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

1. В меню слева в GitLab перейдите в раздел **Build** → **Pipelines**.
1. Убедитесь, что сборка принимает статус **Passed**. Он означает, что сборка прошла успешно.
1. В меню слева в GitLab перейдите в раздел **Build** → **Jobs**.
1. Нажмите на последнее выполненное задание, чтобы посмотреть результат выполнения сценария в логе:

   ```json
   { "entries": [ { "key": "secret", "textValue": "67cH2£?pO********" } ], "versionId": "e6q8isknpcp7********" }
   ```

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы не платить за них:

* [секрет Yandex Lockbox](../../../lockbox/operations/secret-delete.md);
* [сервисный аккаунт](../../../iam/operations/sa/delete.md).

## Полезные ссылки {#see-also}

* [Безопасное хранение паролей для GitLab CI в виде секретов Yandex Lockbox](../../../tutorials/security/gitlab-lockbox-integration.md);
* [Получение значения секрета Yandex Lockbox на стороне GitHub](../../../tutorials/security/wlif-github-integration.md).