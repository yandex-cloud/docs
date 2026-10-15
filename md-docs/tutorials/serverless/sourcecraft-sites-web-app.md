[Документация Yandex Cloud](../../index.md) > [Практические руководства](../index.md) > [Бессерверные технологии](index.md) > Бэкенд на Serverless > Веб-приложение на SourceCraft Sites и Cloud Functions

# Веб-приложение на SourceCraft Sites и Yandex Cloud Functions

В этом практическом руководстве вы развернете веб-приложение из [репозитория](https://sourcecraft.dev/examples/sourcecraft-sites-web-app) с помощью [CI/CD](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/ci-cd) SourceCraft. Приложение состоит из следующих компонентов:

* Фронтенд — статический сайт на [SourceCraft Sites](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/sites) с полем для ввода имени и кнопкой **Hello**.
* Бэкенд — [функция](../../functions/concepts/function.md) Yandex Cloud Functions на Python, которая возвращает приветствие `Hello, <имя>!`.
* [шлюз](../../api-gateway/concepts/index.md) Yandex API Gateway, который принимает запросы от фронтенда и [вызывает функцию](../../api-gateway/concepts/extensions/cloud-functions.md).

Код приложения и конфигурация CI/CD хранятся в [репозитории](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/#repos) SourceCraft. Ресурсы Yandex Cloud создаются через [сервисное подключение](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/service-connections).

Этот сценарий подходит для прототипов и небольших проектов: вам не нужно управлять серверами, а SourceCraft Sites предоставляет бесплатный хостинг с доступом по HTTPS без загрузки собственного TLS-сертификата.

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

1. Войдите в [консоль управления](https://console.yandex.cloud) Yandex Cloud или зарегистрируйтесь.
1. Убедитесь, что у вас есть [платежный аккаунт](../../billing/concepts/billing-account.md) в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите к нему облако](../../billing/operations/pin-cloud.md).
1. Выберите или [создайте каталог](../../resource-manager/operations/folder/create.md), в котором будут размещены функция и API-шлюз.
1. Аутентифицируйтесь в SourceCraft на [главной странице](https://sourcecraft.dev) сервиса или [зарегистрируйтесь](https://sourcecraft.dev/portal/docs/ru/sourcecraft/security/registration).
1. Выберите или [создайте публичную организацию](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/org-create) в SourceCraft.

    Для создания сервисного подключения на уровне организации нужна роль [Администратор организации](https://sourcecraft.dev/portal/docs/ru/sourcecraft/security/#organization-manager-admin) (`organization-manager.admin`) или [Владелец организации](https://sourcecraft.dev/portal/docs/ru/sourcecraft/security/#organization-manager-organizations-owner) (`organization-manager.organizations.owner`).

{% note warning %}

Публикация сайта возможна только из публичного репозитория в публичной организации SourceCraft. Файлы репозитория будут доступны всем пользователям интернета. Не сохраняйте в них токены, ключи доступа и другие секреты. Сервисное подключение позволяет обращаться к Yandex Cloud без хранения долгоживущих ключей в коде.

{% endnote %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* Плата за вызовы функции, вычислительные ресурсы и исходящий трафик ([тарифы Yandex Cloud Functions](../../functions/pricing.md)).
* Плата за запросы к шлюзу и исходящий трафик ([тарифы Yandex API Gateway](../../api-gateway/pricing.md)).

{% note info %}

Для Cloud Functions и API Gateway доступен [нетарифицируемый объем услуг](../../billing/concepts/serverless-free-tier.md). Использование сверх этого объема оплачивается по тарифам сервисов.

Хостинг сайта на SourceCraft Sites бесплатный. Условия использования CI/CD приведены в [правилах тарификации SourceCraft](https://sourcecraft.dev/portal/docs/ru/sourcecraft/pricing#tariff-differences).

{% endnote %}

## Создайте сервисный аккаунт {#create-sa}

От имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) рабочие процессы CI/CD будут создавать и удалять ресурсы, а API-шлюз — вызывать функцию.

1. В [консоли управления](https://console.yandex.cloud) Yandex Cloud выберите подготовленный каталог.
1. [Перейдите](https://console.yandex.cloud/link/iam) в сервис **Identity and Access Management**.
1. Нажмите **Создать сервисный аккаунт**.
1. В поле **Имя** укажите `sites-web-app-sa`.
1. Нажмите ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роли на каталог:

    * [functions.editor](../../functions/security/index.md#functions-editor) — для создания, обновления, вызова и удаления функции.
    * [api-gateway.editor](../../api-gateway/security/index.md#api-gateway-editor) — для создания и удаления API-шлюза.
    * [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) — для указания сервисного аккаунта в версии функции и спецификации API-шлюза.

1. Нажмите **Создать**.

## Создайте ответвление репозитория {#create-repository}

[Ответвление](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/#forks) (fork) позволяет скопировать пример в свою организацию вместе с настройками CI/CD и SourceCraft Sites.

1. Откройте [репозиторий примера](https://sourcecraft.dev/examples/sourcecraft-sites-web-app).
1. В правом верхнем углу нажмите ![image](../../_assets/console-icons/code-fork.svg) **Ответвить**.
1. Выберите подготовленную публичную организацию и укажите название репозитория, например `sourcecraft-sites-web-app`.
1. Выберите для ответвления основную ветку `master` и нажмите **Создать ответвление**.

В репозитории находятся:

* `.sourcecraft/ci.yaml` — конфигурация CI/CD с рабочими процессами `create-resources` и `delete-resources`.
* `.sourcecraft/sites.yaml` — конфигурация публикации сайта из директории `sites` в ветке `release`.
* `sites/` — HTML и JavaScript фронтенда. Файл `sites/config.js` содержит адрес API-шлюза, который рабочий процесс подставляет при развертывании.
* `src/index.py` — код функции на Python.
* `yc-scripts/` — скрипты для получения IAM-токена, создания и удаления ресурсов Yandex Cloud.

{% note info %}

Клонирование примера на локальный компьютер не создает репозиторий в вашей организации. Для выполнения руководства используйте созданное ответвление в SourceCraft.

{% endnote %}

## Создайте сервисное подключение {#create-service-connection}

Создайте подключение на уровне организации. Имя `default-service-connection` должно совпадать с указанным в `.sourcecraft/ci.yaml`.

1. В SourceCraft откройте организацию, в которой вы создали ответвление репозитория.
1. В разделе ![image](../../_assets/console-icons/gear.svg) **Настройки** перейдите в секцию ![image](../../_assets/console-icons/cloud-nut-hex.svg) **Сервисные подключения**.
1. В правом верхнем углу нажмите ![image](../../_assets/console-icons/plus.svg) **Новое сервисное подключение**.
1. В блоке **Базовая информация** укажите название `default-service-connection`.
1. В блоке **Область применения** разрешите использование для всех репозиториев.
1. В блоке **Настройки Yandex Cloud** выберите подготовленный каталог и сервисный аккаунт `sites-web-app-sa`.

    {% note tip %}
    
    Чтобы повторно запросить список облаков, каталогов и сервисных аккаунтов из Yandex Cloud, нажмите ![image](../../_assets/console-icons/arrow-rotate-right.svg) **Синхронизировать**. Это может быть полезно, если параллельно с созданием сервисного подключения вы создали каталог или сервисный аккаунт.
    
    {% endnote %}

1. Нажмите **Создать сервисное подключение** и дождитесь окончания операции.

Подробнее в инструкции [по настройке сервисного подключения](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/service-connections).

## Подготовьте конфигурацию и код приложения {#configure}

Чтобы отредактировать файл в интерфейсе SourceCraft, откройте его и нажмите ![image](../../_assets/console-icons/pencil.svg) **Редактировать**. После редактирования каждого файла нажмите **Сохранить изменения** и выполните коммит в ветку `master`.

1. Откройте файл `.sourcecraft/ci.yaml`.
1. Убедитесь, что в блоке `tokens:SERVICE_CONNECTION_WITH_TOKEN:service_connection` указано название сервисного подключения, созданного ранее.
1. В блоке `env` проверьте имена функции (`YC_FUNCTION_NAME`) и API-шлюза (`YC_API_GATEWAY_NAME`).

    {% note warning %}

    Убедитесь, что в выбранном каталоге облака нет функции и API-шлюза с такими именами. Если они уже существуют, задайте другие имена: рабочий процесс обновляет существующую функцию, а при удалении ресурсов использует имена из этой конфигурации.

    {% endnote %}

## Разверните приложение {#deploy}

1. В своем репозитории в разделе ![image](../../_assets/console-icons/terminal-line.svg) **Автоматизации** перейдите в секцию ![image](../../_assets/console-icons/arrows-3-rotate-right.svg) **CI/CD**.
1. Нажмите ![image](../../_assets/console-icons/plus.svg) **Новый запуск**.
1. Выберите ветку `master` для конфигурации и запуска, рабочий процесс `create-resources` и нажмите **Запустить**.
1. Дождитесь, пока рабочий процесс завершится со статусом **Успех**. Если процесс завершился с ошибкой, откройте его и проверьте логи кубика, который не удалось выполнить.

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

## Удалите ресурсы Yandex Cloud {#clear-out}

1. В своем репозитории [вручную запустите](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/run-workflow-manually) рабочий процесс `delete-resources` из ветки `master`.
1. Дождитесь его успешного завершения. Рабочий процесс удалит API-шлюз и функцию с именами из `.sourcecraft/ci.yaml`.

Вы также можете удалить [API-шлюз](../../api-gateway/operations/api-gw-delete.md) и [функцию](../../functions/operations/function/function-delete.md) в консоли Yandex Cloud.

Если сервисный аккаунт `sites-web-app-sa` больше не используется, [удалите его](../../iam/operations/sa/delete.md) после удаления функции и API-шлюза.

## Снимите сайт с публикации {#delete}

Удаление функции и API-шлюза не снимает статический сайт с публикации. После удаления облачных ресурсов, удалите файл `.sourcecraft/sites.yaml` из основной ветки `master`.

#### Полезные ссылки {#see-also}

* [Хостинг статического сайта с помощью SourceCraft Sites](https://sourcecraft.dev/portal/docs/ru/sourcecraft/tutorials/sites)
* [Настройка CI/CD с Cloud Functions](ci-cd-sourcecraft-functions.md)
* [Подключение к базе данных Managed Service for YDB из функции Cloud Functions на Python](connect-from-cf.md)