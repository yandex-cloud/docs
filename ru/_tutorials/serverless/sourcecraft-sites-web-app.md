# Веб-приложение на {{ src-name }} Sites и {{ sf-full-name }}

В этом практическом руководстве вы развернете веб-приложение из [репозитория](https://sourcecraft.dev/examples/sourcecraft-sites-web-app) с помощью [CI/CD]({{ link-src-docs }}/sourcecraft/concepts/ci-cd) {{ src-name }}. Приложение состоит из следующих компонентов:

* Фронтенд — статический сайт на [{{ src-name }} Sites]({{ link-src-docs }}/sourcecraft/concepts/sites) с полем для ввода имени и кнопкой **Hello**.
* Бэкенд — [функция](../../functions/concepts/function.md) {{ sf-full-name }} на Python, которая возвращает приветствие `Hello, <имя>!`.
* [шлюз](../../api-gateway/concepts/index.md) {{ api-gw-full-name }}, который принимает запросы от фронтенда и [вызывает функцию](../../api-gateway/concepts/extensions/cloud-functions.md).

Код приложения и конфигурация CI/CD хранятся в [репозитории]({{ link-src-docs }}/sourcecraft/concepts/#repos) {{ src-name }}. Ресурсы {{ yandex-cloud }} создаются через [сервисное подключение]({{ link-src-docs }}/sourcecraft/concepts/service-connections).

Этот сценарий подходит для прототипов и небольших проектов: вам не нужно управлять серверами, а {{ src-name }} Sites предоставляет бесплатный хостинг с доступом по HTTPS без загрузки собственного TLS-сертификата.

Чтобы создать веб-приложение:

1. [Подготовьтесь к работе](#prepare).
1. [Создайте сервисный аккаунт](#create-sa).
1. [Создайте ответвление репозитория](#create-repository).
1. [Создайте сервисное подключение](#create-service-connection).
1. [Подготовьте конфигурацию и код приложения](#configure).
1. [Разверните приложение](#deploy).
1. [Проверьте работу приложения](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out) и [снимите сайт с публикации](#delete).

## Подготовьтесь к работе {#prepare}

1. Войдите в [консоль управления]({{ link-console-main }}) {{ yandex-cloud }} или зарегистрируйтесь.
1. Убедитесь, что у вас есть [платежный аккаунт](../../billing/concepts/billing-account.md) в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите к нему облако](../../billing/operations/pin-cloud.md).
1. Выберите или [создайте каталог](../../resource-manager/operations/folder/create.md), в котором будут размещены функция и API-шлюз.
1. Аутентифицируйтесь в {{ src-name }} на [главной странице]({{ link-src-main }}) сервиса или [зарегистрируйтесь]({{ link-src-docs }}/sourcecraft/security/registration).
1. Выберите или [создайте публичную организацию]({{ link-src-docs }}/sourcecraft/operations/org-create) в {{ src-name }}.

    Для создания сервисного подключения на уровне организации нужна роль [{{ ui-key.sourcecraft.lib.value_role-org-admin_sTd3t }}]({{ link-src-docs }}/sourcecraft/security/#organization-manager-admin) (`organization-manager.admin`) или [{{ ui-key.sourcecraft.lib.value_role-org-owner_f9UaR }}]({{ link-src-docs }}/sourcecraft/security/#organization-manager-organizations-owner) (`organization-manager.organizations.owner`).

{% note warning %}

Публикация сайта возможна только из публичного репозитория в публичной организации {{ src-name }}. Файлы репозитория будут доступны всем пользователям интернета. Не сохраняйте в них токены, ключи доступа и другие секреты. Сервисное подключение позволяет обращаться к {{ yandex-cloud }} без хранения долгоживущих ключей в коде.

{% endnote %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* Плата за вызовы функции, вычислительные ресурсы и исходящий трафик ([тарифы {{ sf-full-name }}](../../functions/pricing.md)).
* Плата за запросы к шлюзу и исходящий трафик ([тарифы {{ api-gw-full-name }}](../../api-gateway/pricing.md)).

{% note info %}

Для {{ sf-name }} и {{ api-gw-name }} доступен [нетарифицируемый объем услуг](../../billing/concepts/serverless-free-tier.md). Использование сверх этого объема оплачивается по тарифам сервисов.

Хостинг сайта на {{ src-name }} Sites бесплатный. Условия использования CI/CD приведены в [правилах тарификации {{ src-name }}]({{ link-src-docs }}/sourcecraft/pricing#tariff-differences).

{% endnote %}

## Создайте сервисный аккаунт {#create-sa}

От имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) рабочие процессы CI/CD будут создавать и удалять ресурсы, а API-шлюз — вызывать функцию.

1. В [консоли управления]({{ link-console-main }}) {{ yandex-cloud }} выберите подготовленный каталог.
1. [Перейдите]({{ link-console-main }}/link/iam) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
1. Нажмите **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
1. В поле **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** укажите `sites-web-app-sa`.
1. Нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите роли на каталог:

    * [functions.editor](../../functions/security/index.md#functions-editor) — для создания, обновления, вызова и удаления функции.
    * [api-gateway.editor](../../api-gateway/security/index.md#api-gateway-editor) — для создания и удаления API-шлюза.
    * [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) — для указания сервисного аккаунта в версии функции и спецификации API-шлюза.

1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

## Создайте ответвление репозитория {#create-repository}

[Ответвление]({{ link-src-docs }}/sourcecraft/concepts/#forks) (fork) позволяет скопировать пример в свою организацию вместе с настройками CI/CD и {{ src-name }} Sites.

1. Откройте [репозиторий примера](https://sourcecraft.dev/examples/sourcecraft-sites-web-app).
1. В правом верхнем углу нажмите ![image](../../_assets/console-icons/code-fork.svg) **Ответвить**.
1. Выберите подготовленную публичную организацию и укажите название репозитория, например `sourcecraft-sites-web-app`.
1. Выберите для ответвления основную ветку `master` и нажмите **Создать ответвление**.

В репозитории находятся:

* `.sourcecraft/ci.yaml` — конфигурация CI/CD с рабочими процессами `create-resources` и `delete-resources`.
* `.sourcecraft/sites.yaml` — конфигурация публикации сайта из директории `sites` в ветке `release`.
* `sites/` — HTML и JavaScript фронтенда. Файл `sites/config.js` содержит адрес API-шлюза, который рабочий процесс подставляет при развертывании.
* `src/index.py` — код функции на Python.
* `yc-scripts/` — скрипты для получения IAM-токена, создания и удаления ресурсов {{ yandex-cloud }}.

{% note info %}

Клонирование примера на локальный компьютер не создает репозиторий в вашей организации. Для выполнения руководства используйте созданное ответвление в {{ src-name }}.

{% endnote %}

## Создайте сервисное подключение {#create-service-connection}

Создайте подключение на уровне организации. Имя `default-service-connection` должно совпадать с указанным в `.sourcecraft/ci.yaml`.

1. В {{ src-name }} откройте организацию, в которой вы создали ответвление репозитория.
1. В разделе ![image](../../_assets/console-icons/gear.svg) **{{ ui-key.sourcecraft.lib.settings_cwUYS }}** перейдите в секцию ![image](../../_assets/console-icons/cloud-nut-hex.svg) **{{ ui-key.sourcecraft.mainApp.route_service-connections_2PPgz }}**.
1. В правом верхнем углу нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.sourcecraft.serviceConnections.button_add-connection_6Bj7i }}**.
1. В блоке **{{ ui-key.sourcecraft.serviceConnections.section_basic_wmaiy }}** укажите название `default-service-connection`.
1. В блоке **{{ ui-key.sourcecraft.serviceConnections.section_scope_9gXcu }}** разрешите использование для всех репозиториев.
1. В блоке **{{ ui-key.sourcecraft.serviceConnections.section_cloud-settings_tDMfn }}** выберите подготовленный каталог и сервисный аккаунт `sites-web-app-sa`.

    {% include [service-connection-synchronization](../../_includes/sourcecraft/service-connection-synchronization.md) %}

1. Нажмите **{{ ui-key.sourcecraft.serviceConnections.button_create-connection_uyK29 }}** и дождитесь окончания операции.

Подробнее в инструкции [по настройке сервисного подключения]({{ link-src-docs }}/sourcecraft/operations/service-connections).

## Подготовьте конфигурацию и код приложения {#configure}

Чтобы отредактировать файл в интерфейсе {{ src-name }}, откройте его и нажмите ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.sourcecraft.repo.action_edit_ahQT7 }}**. После редактирования каждого файла нажмите **{{ ui-key.sourcecraft.repo.action_commit_brj4B }}** и выполните коммит в ветку `master`.

1. Откройте файл `.sourcecraft/ci.yaml`.
1. Убедитесь, что в блоке `tokens:SERVICE_CONNECTION_WITH_TOKEN:service_connection` указано название сервисного подключения, созданного ранее.
1. В блоке `env` проверьте имена функции (`YC_FUNCTION_NAME`) и API-шлюза (`YC_API_GATEWAY_NAME`).

    {% note warning %}

    Убедитесь, что в выбранном каталоге облака нет функции и API-шлюза с такими именами. Если они уже существуют, задайте другие имена: рабочий процесс обновляет существующую функцию, а при удалении ресурсов использует имена из этой конфигурации.

    {% endnote %}

## Разверните приложение {#deploy}

1. В своем репозитории в разделе ![image](../../_assets/console-icons/terminal-line.svg) **{{ ui-key.sourcecraft.cicd.title_cicd_qoXmk }}** перейдите в секцию ![image](../../_assets/console-icons/arrows-3-rotate-right.svg) **{{ ui-key.sourcecraft.repo.action_cicd_4jypo }}**.
1. Нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.sourcecraft.cicd.action_start-workflow_njaSz }}**.
1. Выберите ветку `master` для конфигурации и запуска, рабочий процесс `create-resources` и нажмите **{{ ui-key.sourcecraft.cicd.action_start_7MWxe }}**.
1. Дождитесь, пока рабочий процесс завершится со статусом **{{ ui-key.sourcecraft.cicd.value_succeeded_3Dd8C }}**. Если процесс завершился с ошибкой, откройте его и проверьте логи кубика, который не удалось выполнить.

Рабочий процесс получает IAM-токен через сервисное подключение, создает функцию и ее версию, затем создает API-шлюз с маршрутом `GET /hello/{name}`. После этого он записывает адрес шлюза в файл `sites/config.js` и публикует файлы в ветке `release`.

Файл `.sourcecraft/sites.yaml` в основной ветке уже настроен на публикацию из ветки `release`:

```yaml
site:
  root: sites
  ref: release
```

После появления этой ветки сайт публикуется автоматически в течение нескольких минут.

## Проверьте работу приложения {#test}

1. Откройте в браузере `https://<слаг_организации>.sourcecraft.site/<название_репозитория>/`.
1. В поле **Name** введите имя, например `Alice`, и нажмите **Hello**.
1. Убедитесь, что под кнопкой появилось приветствие `Hello, Alice!`.

## Удалите ресурсы {{ yandex-cloud }} {#clear-out}

1. В своем репозитории [вручную запустите]({{ link-src-docs }}/sourcecraft/operations/run-workflow-manually) рабочий процесс `delete-resources` из ветки `master`.
1. Дождитесь его успешного завершения. Рабочий процесс удалит API-шлюз и функцию с именами из `.sourcecraft/ci.yaml`.

Вы также можете удалить [API-шлюз](../../api-gateway/operations/api-gw-delete.md) и [функцию](../../functions/operations/function/function-delete.md) в консоли {{ yandex-cloud }}.

Если сервисный аккаунт `sites-web-app-sa` больше не используется, [удалите его](../../iam/operations/sa/delete.md) после удаления функции и API-шлюза.

## Снимите сайт с публикации {#delete}

Удаление функции и API-шлюза не снимает статический сайт с публикации. После удаления облачных ресурсов, удалите файл `.sourcecraft/sites.yaml` из основной ветки `master`.

#### Полезные ссылки {#see-also}

* [Хостинг статического сайта с помощью {{ src-name }} Sites]({{ link-src-docs }}/sourcecraft/tutorials/sites)
* [Настройка CI/CD с {{ sf-name }}](../../tutorials/serverless/ci-cd-sourcecraft-functions.md)
* [Подключение к базе данных {{ ydb-name }} из функции {{ sf-name }} на Python](../../tutorials/serverless/connect-from-cf.md)
