[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Functions](../index.md) > [Практические руководства](index.md) > Рабочие процессы и автоматизация на Serverless > Настройка CI/CD с SourceCraft

# Настройка CI/CD с SourceCraft


[SourceCraft](https://sourcecraft.dev/portal/docs/ru/) дает возможность хранить код функции Cloud Functions и развертывать новые версии [функции](../concepts/function.md) при изменениях в [репозитории](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/#repos).

В этом руководстве вы настроите [CI/CD](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/ci-cd) между Cloud Functions и SourceCraft. Для этого вы создадите репозиторий, настроите развертывание функции и проверите результат. Интеграция между SourceCraft и Yandex Cloud будет выполнена с помощью [сервисного подключения](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/service-connections).

{% note warning %}

Для создания сервисного подключения у вас должна быть [роль](https://sourcecraft.dev/portal/docs/ru/sourcecraft/security/#organization-manager-organizations-owner) `Владелец организации` (`organization-manager.organizations.owner`).

{% endnote %}

Чтобы настроить CI/CD для развертывания функции Cloud Functions из репозитория SourceCraft:
1. [Создайте сервисный аккаунт](#create-sa).
1. [Создайте репозиторий](#repository).
1. [Создайте сервисное подключение](#create-service-connection).
1. [Отредактируйте конфигурацию CI/CD](#push-changes).
1. [Проверьте выполнение CI/CD](#check-ci-cd).
1. [Проверьте изменения в функции](#check-function).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит плата за количество вызовов функции, вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик ([тарифы Cloud Functions](../pricing.md)).

## Создайте сервисный аккаунт {#create-sa}

От имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) будет создаваться функция и ее версии.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Войдите в [консоль управления](https://console.yandex.cloud) Yandex Cloud.
  1. В левой части экрана нажмите на строку с именем каталога, в котором вы хотите развернуть функцию Cloud Functions.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Identity and Access Management**.
  1. Нажмите **Создать сервисный аккаунт**.
  1. Введите имя сервисного аккаунта: `functions-cicd-sa`.
  1. Нажмите ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите [роль](../security/index.md#functions-admin) `functions.admin`.
  1. Нажмите **Создать**.

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

  1. Назначьте сервисному аккаунту [роль](../security/index.md#functions-admin) `functions.admin` на каталог:

      ```bash
      yc resource-manager folder add-access-binding <идентификатор_каталога> \
        --role functions.admin \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

      Результат:

      ```bash
      done (3s)
      effective_deltas:
        - action: ADD
          access_binding:
            role_id: functions.admin
            subject:
              id: ajehb3tcdfa1********
              type: serviceAccount
      ```

- API {#api}

  Чтобы создать сервисный аккаунт, воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).

  Чтобы назначить сервисному аккаунту [роль](../security/index.md#functions-admin) `functions.admin` на каталог, воспользуйтесь методом [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md).

{% endlist %}

## Создайте репозиторий {#repository}

Репозиторий будет создан из шаблона [yc-cloud-functions-template](https://sourcecraft.dev/sourcecraft/yc-cloud-functions-template). В репозитории будут храниться примеры кода функций для разных языков программирования и фреймворков, а также настройки CI/CD-процесса.

{% list tabs group=instructions %}

- Интерфейс SourceCraft {#src}

  1. Откройте [главную страницу сервиса](https://sourcecraft.dev).
  1. На панели слева нажмите ![image](../../_assets/console-icons/plus.svg) **Создать репозиторий**.
  1. В открывшемся окне выберите **Пустой репозиторий**.
  1. В блоке **Сведения о новом репозитории**:
      * В поле **Владелец** выберите [организацию](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/#org), в которой вы создали сервисный аккаунт в Yandex Cloud.
      * В поле **Название** укажите название репозитория. 

        Название должно быть уникальным в пределах организации и может содержать следующие [ASCII-символы](https://ru.wikipedia.org/wiki/ASCII): строчные и заглавные буквы латинского алфавита, цифры, запятые, дефисы и подчеркивания.

        Под названием отображается адрес, по которому репозиторий будет доступен.

      * (опционально) В поле **Описание** укажите описание репозитория.

  1. В блоке **Шаблон репозитория** нажмите **Просмотр шаблонов**, выберите шаблон [yc-cloud-functions-template](https://sourcecraft.dev/sourcecraft/yc-cloud-functions-template) и нажмите **Использовать шаблон**.

      Чтобы посмотреть содержимое шаблона, нажмите **Предварительный просмотр**.

      В шаблоне содержатся:
      * файл [.sourcecraft/ci.yaml](https://sourcecraft.dev/sourcecraft/yc-cloud-functions-template/browse/.sourcecraft/ci.yaml) с предустановленной конфигурацией CI/CD-процесса, который может быть запущен [вручную](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/run-workflow-manually) для публикации функции в конкретной [среде выполнения](../concepts/runtime/index.md#runtimes) или автоматически для среды выполнения `nodejs22` при создании коммита в основную ветку репозитория.
      * директории с примерами кода функций для разных языков программирования и фреймворков.
  1. Нажмите **Создать репозиторий**.

{% endlist %}

## Создайте сервисное подключение {#create-service-connection}

{% list tabs group=instructions %}

- Интерфейс SourceCraft {#src}

  1. Откройте [главную страницу](https://sourcecraft.dev) SourceCraft.
  1. Перейдите на вкладку ![image](../../_assets/console-icons/briefcase.svg) **Организации**.
  1. Выберите организацию, в которой вы создали сервисный аккаунт в Yandex Cloud.
  1. На странице организации в разделе ![image](../../_assets/console-icons/gear.svg) **Настройки** перейдите в секцию ![image](../../_assets/console-icons/cloud-nut-hex.svg) **Сервисные подключения**.
  1. Нажмите **Новое сервисное подключение**.
  1. В открывшемся окне:
      * В блоке **Базовая информация** укажите имя сервисного подключения, например `default-service-connection`, опционально добавьте описание.
      * В блоке **Область применения** выберите, для каких репозиториев и веток будет доступно сервисное подключение, например, выберите репозиторий, созданный ранее.
      * В блоке **Настройки Yandex Cloud** выберите:
        * Каталог, на который вы назначили роль сервисному аккаунту.
        * Сервисный аккаунт, созданный ранее.

        {% note tip %}
        
        Чтобы повторно запросить список облаков, каталогов и сервисных аккаунтов из Yandex Cloud, нажмите ![image](../../_assets/console-icons/arrow-rotate-right.svg) **Синхронизировать**. Это может быть полезно, если параллельно с созданием сервисного подключения вы создали каталог или сервисный аккаунт.
        
        {% endnote %}

  1. Нажмите **Создать сервисное подключение**.

{% endlist %}

Дождитесь окончания операции. На открывшейся странице будут представлены детали сервисного подключения.

В Yandex Cloud будет автоматически создана [федерация сервисных аккаунтов](../../iam/concepts/workload-identity.md) Yandex Identity and Access Management.

Чтобы посмотреть параметры созданного OIDC-провайдера, в блоке ![image](../../_assets/console-icons/cpus.svg) **Федерация cервисных аккаунтов** нажмите на имя федерации.

{% note info %}

Вы также можете создать сервисное подключение на уровне репозитория. В этом случае оно будет доступно только для этого репозитория. Подробнее в разделе [{#T}](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/service-connections#create-service-connection).

{% endnote %}

## Отредактируйте конфигурацию CI/CD {#push-changes}

{% list tabs group=instructions %}

- Интерфейс SourceCraft {#src}

  1. Откройте [главную страницу](https://sourcecraft.dev) SourceCraft.
  1. На вкладке ![image](../../_assets/console-icons/house.svg) **Домой** в секции ![image](../../_assets/console-icons/layout-tabs.svg) **Ваша мастерская** перейдите в раздел ![image](../../_assets/console-icons/archive.svg) **Репозитории**.
  1. Выберите созданный ранее репозиторий.
  1. Выберите файл `.sourcecraft/ci.yaml`.
  1. В правом верхнем углу нажмите ![image](../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. В [рабочем процессе](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/ci-cd#workflows) `deploy-nodejs-function` отредактируйте параметры создаваемой функции:
      * `YC_FUNCTION_NAME` — имя функции, например `test-function-nodejs`.
      * `YC_FUNCTION_RUNTIME` — [среда выполнения](../concepts/runtime/index.md#runtimes), например `nodejs22`.
      * `YC_FUNCTION_ENTRYPOINT` — точка входа функции, например `index.handler`. Задается в соответствии со средой выполнения согласно [документации](../quickstart/create-function/index.md).
      * `SOURCE_PATH` — путь в репозитории к коду функции, например `./nodejs`.

      Также вы можете добавить дополнительные параметры:
      * `ENVIRONMENT` — переменные окружения для функции, например `MY_ENV=SOURCECRAFT`. Аналог параметра `--environment` для команды Yandex Cloud CLI [yc serverless function version create](../../cli/cli-ref/serverless/cli-ref/function/version/create.md).
      * `PUBLIC` — сделать функцию доступной публично. Значение — `true`. Аналог команды Yandex Cloud CLI [yc serverless function allow-unauthenticated-invoke](../../cli/cli-ref/serverless/cli-ref/function/allow-unauthenticated-invoke.md).

  1. В правом верхнем углу нажмите **Сохранить изменения**.
  1. Сделайте коммит:

      1. Введите сообщение об изменениях.
      1. В блоке **Ветка изменений** выберите **Сохранить непосредственно в ветку: main**.
      1. В блоке **Действие после сохранения изменений** выберите **Просто сохранить**.
      1. Нажмите **Сохранить изменения**.

{% endlist %}

После сохранения изменений запустится рабочий процесс `deploy-nodejs-function`.

Аналогичным образом вы можете отредактировать код функции в файле `nodejs/index.js`. После этого также запустится рабочий процесс публикации новой версии функции.

{% note tip %}

В примере рассмотрен автоматический запуск рабочего процесса для среды выполнения `nodejs22`. Для других сред выполнения используйте [ручной](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/run-workflow-manually) запуск или отредактируйте блок `on` в файле `.sourcecraft/ci.yaml`.

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

Для развертывания функции Cloud Functions в конфигурации CI/CD используется готовый [кубик](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/ci-cd#cubes) SourceCraft `yc-function`, подходящий для базовых сценариев.

Для более сложных сценариев развертывания функции Cloud Functions со всеми возможностями [Yandex Cloud CLI](../../cli/cli-ref/serverless/cli-ref/function/index.md) вы можете использовать готовые кубики `yc-iam` и `yc-cli`.

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
          # Кубик обменивает токен SourceCraft на IAM-токен Yandex Cloud
          # и сохраняет его в переменную IAM_TOKEN в блоке outputs.
        cubes:
          - name: get-iam-token
            env:
              ID_TOKEN: ${{ tokens.<имя_токена>.id_token}}
              YC_SA_ID: ${{ tokens.<имя_токена>.service_account_id }}
            image: cr.yandex/sourcecraft/yc-iam:latest

          # Кубик с предустановленным Yandex Cloud CLI забирает из outputs 
          # переменную IAM_TOKEN и использует ее для проверки наличия функции Cloud Functions
          # с определенным именем, в случае отсутствия — создает ее.
          - name: check-and-create-function
            env:
              # Подставьте в блок для получения значений outputs имя кубика с
              # IAM-токеном, например get-iam-token.
              YC_IAM_TOKEN: ${{ cubes.<имя_кубика_с_IAM-токеном>.outputs.IAM_TOKEN }}
              YC_FOLDER_ID: ${{ tokens.<имя_токена>.folder_id }}
            image:
              name: cr.yandex/sourcecraft/yc-cli:latest
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

          # Кубик с предустановленным Yandex Cloud CLI забирает из outputs 
          # переменную IAM_TOKEN и использует ее для создания новой версии функции Cloud Functions.
          - name: deploy-function-version
            env:
              # Подставьте в блок для получения значений outputs имя кубика с
              # IAM-токеном, например get-iam-token.
              YC_IAM_TOKEN: ${{ cubes.<имя_кубика_с_IAM-токеном>.outputs.IAM_TOKEN }}
              YC_FOLDER_ID: ${{ tokens.<имя_токена>.folder_id }}
            image:
              name: cr.yandex/sourcecraft/yc-cli:latest
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

- Интерфейс SourceCraft {#src}

  1. Откройте [главную страницу](https://sourcecraft.dev) SourceCraft.
  1. На вкладке ![image](../../_assets/console-icons/house.svg) **Домой** в секции ![image](../../_assets/console-icons/layout-tabs.svg) **Ваша мастерская** перейдите в раздел ![image](../../_assets/console-icons/archive.svg) **Репозитории**.
  1. Выберите созданный ранее репозиторий.
  1. На странице репозитория в разделе ![image](../../_assets/console-icons/code.svg) **Код** перейдите в секцию ![image](../../_assets/console-icons/arrows-3-rotate-right.svg) **CI/CD**.
  1. В списке запусков автоматизаций вы увидите новый запуск со статусом ![image](../../_assets/console-icons/circle.svg) **В очереди**. Дождитесь, когда статус изменится на ![image](../../_assets/console-icons/circle-check.svg) **Успех**.

{% endlist %}

## Проверьте, что функция создалась {#check-function}

Убедитесь, что в сервисе Cloud Functions создалась функция с именем, которое вы задали в `.sourcecraft/ci.yaml`, например `test-function-nodejs`.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором вы ранее создали сервисный аккаунт.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Functions**.
  1. В списке должна появиться функция `test-function-nodejs`, выберите ее.
  1. В разделе **История версий** должна появиться версия функции, по времени создания соответствующая времени [запуска CI/CD-процесса](#check-ci-cd).
  1. Перейдите на вкладку **Редактор**.
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

  Чтобы получить список функций, воспользуйтесь методом REST API [list](../functions/api-ref/Function/list.md) для ресурса [Function](../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionsService/List](../functions/api-ref/grpc/Function/list.md).

  В списке должна отобразиться функция `test-function-nodejs`.

  Чтобы получить список версий функции, воспользуйтесь методом REST API [listVersions](../functions/api-ref/Function/listVersions.md) для ресурса [Function](../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionsService/ListVersions](../functions/api-ref/grpc/Function/listVersions.md).

  В списке должна появиться новая версия функции, по времени создания соответствующая времени [запуска CI/CD-процесса](#check-ci-cd).

{% endlist %}

## Удалите созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны, удалите их:

1. [Удалите функцию](../operations/function/function-delete.md).
1. [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md).

## Полезные ссылки {#see-also}

* [Настроить CI/CD для развертывания приложения в Yandex Serverless Containers с помощью GitHub Actions](https://sourcecraft.dev/portal/docs/ru/sourcecraft/tutorials/ci-cd-sourcecraft-github-actions)
* [Настроить в SourceCraft сервисное подключение к Yandex Cloud](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/service-connections)
* [Интеграция с GitHub Actions в SourceCraft](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/gh-actions)
* Репозиторий [yc-cloud-functions-template](https://sourcecraft.dev/sourcecraft/yc-cloud-functions-template) в SourceCraft
* Репозиторий [yc-ci-cd-serverless](https://sourcecraft.dev/sourcecraft/yc-ci-cd-serverless) в SourceCraft