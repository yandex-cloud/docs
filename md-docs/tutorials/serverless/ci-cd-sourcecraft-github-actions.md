# Настройка CI/CD в SourceCraft для развертывания приложения в Yandex Serverless Containers с помощью GitHub Actions

# Настройка CI/CD для развертывания приложения в Yandex Serverless Containers с помощью GitHub Actions


В этом практическом руководстве вы настроите [CI/CD-процесс](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/ci-cd) для развертывания контейнеризированного приложения в [Serverless Containers](../../serverless-containers/concepts/index.md) из [репозитория](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/#repos) SourceCraft с помощью [GitHub Actions](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/gh-actions). Интеграция между SourceCraft и Yandex Cloud будет выполнена с помощью [сервисного подключения](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/service-connections).

{% note warning %}

Для создания сервисного подключения у вас должна быть [роль](https://sourcecraft.dev/portal/docs/ru/sourcecraft/security/#organization-manager-organizations-owner) `Владелец организации` (`organization-manager.organizations.owner`).

{% endnote %}

Чтобы настроить CI/CD для развертывания приложения в Serverless Containers из репозитория SourceCraft с помощью GitHub Actions:
1. [Создайте сервисный аккаунт](#create-sa).
1. [Создайте реестр](#create-registry).
1. [Создайте репозиторий](#create-repository-sc).
1. [Создайте сервисное подключение](#create-service-connection).
1. [Настройте CI/CD](#config-ci-cd).
1. [Проверьте выполнение CI/CD](#check-ci-cd).
1. [Проверьте, что контейнер создан](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:
* Плата за хранение созданных Docker-образов (см. [тарифы Container Registry](../../container-registry/pricing.md).
* Плата за количество вызовов контейнера, вычислительные ресурсы, выделенные для выполнения приложения, и исходящий трафик (см. [тарифы Serverless Containers](../../serverless-containers/pricing.md).

## Создайте сервисный аккаунт {#create-sa}

От имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) будут загружаться Docker-образы в [реестры](../../container-registry/concepts/registry.md) Yandex Container Registry и развертываться [контейнеры](../../serverless-containers/concepts/container.md) в Serverless Containers.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Войдите в [консоль управления](https://console.yandex.cloud) Yandex Cloud.
  1. В левой части экрана нажмите на строку с именем каталога, в котором вы хотите развернуть контейнер.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Identity and Access Management**.
  1. Нажмите **Создать сервисный аккаунт**.
  1. В поле **Имя** укажите `github-action`.
  1. Нажмите ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роли:

      * `container-registry.images.pusher` — для работы с Docker-образами в реестре;
      * `serverless-containers.editor` — для управления контейнером;
      * `iam.serviceAccounts.user` — для возможности при создании ревизии контейнера указать сервисный аккаунт, от имени которого Docker-образ будет загружен из реестра.

  1. Нажмите **Создать**.

- CLI {#cli}

  1. Создайте сервисный аккаунт:

      ```bash
      yc iam service-account create \
        --name github-action
        --folder-name <имя_каталога>
      ```

      Результат:

      ```yaml
      id: ajeab0cnib1p********
      folder_id: b0g12ga82bcv********
      created_at: "2025-10-03T09:44:35.989446Z"
      name: github-action
      ```

  1. Назначьте сервисному аккаунту [роли](../../iam/concepts/access-control/roles.md) на каталог:

      * `iam.serviceAccounts.user` — для возможности при создании ревизии контейнера указать сервисный аккаунт, от имени которого Docker-образ будет загружен из реестра:

        ```bash
        yc resource-manager folder add-access-binding <имя_каталога> \
          --service-account-name github-action \
          --role iam.serviceAccounts.user \
          --folder-name <имя_каталога>
        ```

      * `serverless-containers.editor` — для управления контейнером:

        ```bash
        yc resource-manager folder add-access-binding <имя_каталога> \
          --service-account-name github-action \
          --role serverless-containers.editor \
          --folder-name <имя_каталога>
        ```

      * `container-registry.images.pusher` — для работы с Docker-образами в реестре:

        ```bash
        yc resource-manager folder add-access-binding <имя_каталога> \
          --service-account-name github-action \
          --role container-registry.images.pusher \
          --folder-name <имя_каталога>
        ```

- API {#api}

  1. Создайте сервисный аккаунт `github-action`. Для этого воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).
  1. Назначьте сервисному аккаунту в текущем каталоге [роли](../../iam/concepts/access-control/roles.md):

      * `iam.serviceAccounts.user` — для возможности при создании ревизии контейнера указать сервисный аккаунт, от имени которого Docker-образ будет загружен из реестра;
      * `serverless-containers.editor` — для управления контейнером;
      * `container-registry.images.pusher` — для работы с Docker-образами в реестре.

      Для этого воспользуйтесь методом REST API [setAccessBindings](../../resource-manager/api-ref/Folder/setAccessBindings.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/SetAccessBindings](../../resource-manager/api-ref/grpc/Folder/setAccessBindings.md).

{% endlist %}

## Создайте реестр {#create-registry}

В реестре Container Registry будет храниться Docker-образ приложения.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите **Container Registry**.
  1. Нажмите **Создать реестр**.
  1. Задайте имя реестра `github-action`.
  1. Нажмите **Создать реестр**.
  1. Сохраните идентификатор созданного реестра, он понадобится в дальнейшем.

- CLI {#cli}

  Создайте реестр `github-action`:

  ```bash
  yc container registry create --name github-action
  ```

  Результат:

  ```text
  id: crpd50616s9a********
  folder_id: b1g88tflru0e********
  name: github-action
  status: ACTIVE
  created_at: "2025-10-03T10:34:06.601Z"
  ```

  Сохраните идентификатор созданного реестра, он понадобится в дальнейшем.

- API {#api}

  Воспользуйтесь методом REST API [create](../../container-registry/api-ref/Registry/create.md) для ресурса [Registry](../../container-registry/api-ref/Registry/index.md) или вызовом gRPC API [RegistryService/CreateRegistryRequest](../../container-registry/api-ref/grpc/Registry/create.md).

  Сохраните идентификатор созданного реестра, он понадобится в дальнейшем.

{% endlist %}

## Создайте репозиторий {#create-repository-sc}

Репозиторий будет создан из шаблона [yc-ci-cd-serverless](https://sourcecraft.dev/sourcecraft/yc-ci-cd-serverless). В репозитории будут храниться `Dockerfile` и вспомогательные файлы для создания Docker-образа, а также настройки CI/CD-процесса.

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

  1. В блоке **Шаблон репозитория** нажмите **Просмотр шаблонов**, выберите шаблон [yc-ci-cd-serverless](https://sourcecraft.dev/sourcecraft/yc-ci-cd-serverless) и нажмите **Использовать шаблон**.

      Чтобы посмотреть содержимое шаблона, нажмите **Предварительный просмотр**.

      В шаблоне содержатся:
      * файл [.sourcecraft/ci.yaml](https://sourcecraft.dev/sourcecraft/yc-ci-cd-serverless/browse/.sourcecraft/ci.yaml) с предустановленной конфигурацией CI/CD-процесса, который запускается при создании коммита и выполняет следующее:
        * Получает IAM-токен Yandex Cloud с помощью сервисного подключения с именем `default-service-connection`.
        * Устанавливает в окружение [воркера](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/ci-cd#workers) утилиту [Docker Buildx](https://github.com/docker/buildx) с помощью GitHub Action [Docker Setup Buildx](https://github.com/marketplace/actions/docker-setup-buildx).
        * Аутентифицируется в Container Registry с помощью GitHub Action [Docker Login](https://github.com/marketplace/actions/docker-login) и IAM-токена Yandex Cloud.
        * Собирает Docker-образ из `Dockerfile`, размещенного в корне репозитория, и отправляет образ в Container Registry с помощью GitHub Action [Build and push Docker images](https://github.com/marketplace/actions/build-and-push-docker-images).
        * Разворачивает контейнер в Serverless Containers из собранного Docker-образа.
      * файлы [Dockerfile](https://sourcecraft.dev/sourcecraft/yc-ci-cd-serverless/browse/Dockerfile), [index.html](https://sourcecraft.dev/sourcecraft/yc-ci-cd-serverless/browse/index.html) и [docker/nginx/conf.d/default.conf](https://sourcecraft.dev/sourcecraft/yc-ci-cd-serverless/browse/docker/nginx/conf.d/default.conf) с конфигурацией контейнера со статическим веб‑приложением на базе [Nginx](https://nginx.org/ru/).

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
  1. В блоке **Базовая информация** укажите имя сервисного подключения `default-service-connection`.
  1. В блоке **Область применения** выберите созданный ранее репозиторий.
  1. В блоке **Настройки Yandex Cloud** выберите:

      * Каталог, в котором ранее вы развернули облачную инфраструктуру и назначили роль сервисному аккаунту.
      * Сервисный аккаунт `github-action`.

        {% note tip %}
        
        Чтобы повторно запросить список облаков, каталогов и сервисных аккаунтов из Yandex Cloud, нажмите ![image](../../_assets/console-icons/arrow-rotate-right.svg) **Синхронизировать**. Это может быть полезно, если параллельно с созданием сервисного подключения вы создали каталог или сервисный аккаунт.
        
        {% endnote %}

  1. Нажмите **Создать сервисное подключение**.

{% endlist %}

Дождитесь окончания операции. На открывшейся странице будут представлены детали сервисного подключения.

В Yandex Cloud будет автоматически создана [федерация сервисных аккаунтов](../../iam/concepts/workload-identity.md) Yandex Identity and Access Management.

Чтобы посмотреть параметры созданного OIDC-провайдера, в блоке ![image](../../_assets/console-icons/cpus.svg) **Федерация cервисных аккаунтов** нажмите на имя федерации.

{% note info %}

Вы также можете создать сервисное подключение на уровне репозитория. В этом случае оно будет доступно только для этого репозитория. Подробнее см. в разделе [{#T}](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/service-connections#create-service-connection).

{% endnote %}

## Настройте CI/CD {#config-ci-cd}

{% list tabs group=instructions %}

- Интерфейс SourceCraft {#src}

  1. Откройте [главную страницу](https://sourcecraft.dev) SourceCraft.
  1. На вкладке ![image](../../_assets/console-icons/house.svg) **Домой** в секции ![image](../../_assets/console-icons/layout-tabs.svg) **Ваша мастерская** перейдите в раздел ![image](../../_assets/console-icons/archive.svg) **Репозитории**.
  1. Выберите созданный ранее репозиторий.
  1. Выберите файл `.sourcecraft/ci.yaml`.
  1. В правом верхнем углу нажмите ![image](../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. В параметре `YC_DOCKER_REGISTRY_URI` укажите идентификатор созданного [ранее](#create-registry) реестра:

      ```yaml
      YC_DOCKER_REGISTRY_URI: cr.yandex/<идентификатор_реестра>
      ```

  1. В правом верхнем углу нажмите **Сохранить изменения**.
  1. Сделайте коммит:

      1. Введите сообщение об изменениях.
      1. В блоке **Ветка изменений** выберите **Сохранить непосредственно в ветку: main**.
      1. В блоке **Действие после сохранения изменений** выберите **Просто сохранить**.
      1. Нажмите **Сохранить изменения**.

{% endlist %}

После сохранения изменений запустится рабочий процесс `demo-service-connection-workflow`.

## Проверьте выполнение CI/CD {#check-ci-cd}

{% list tabs group=instructions %}

- Интерфейс SourceCraft {#src}

  1. Откройте [главную страницу](https://sourcecraft.dev) SourceCraft.
  1. На вкладке ![image](../../_assets/console-icons/house.svg) **Домой** в секции ![image](../../_assets/console-icons/layout-tabs.svg) **Ваша мастерская** перейдите в раздел ![image](../../_assets/console-icons/archive.svg) **Репозитории**.
  1. Выберите созданный ранее репозиторий.
  1. На странице репозитория в разделе ![image](../../_assets/console-icons/code.svg) **Код** перейдите в секцию ![image](../../_assets/console-icons/arrows-3-rotate-right.svg) **CI/CD**.
  1. В списке запусков автоматизаций вы увидите новый запуск. Дождитесь, когда статус изменится на ![image](../../_assets/console-icons/circle-check.svg) **Успех**.

{% endlist %}

## Проверьте, что контейнер создан {#check-result}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления](https://console.yandex.cloud).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Serverless Containers**.
  1. В списке должен появиться контейнер `demo-serverless-container1`, выберите его.

      В блоке **Ревизии** должна появиться ревизия контейнера, по времени создания соответствующая времени [запуска CI/CD-процесса](#check-ci-cd).

- CLI {#cli}

  Выполните команду:

  ```bash
  yc serverless container revision list \
    --container-name demo-serverless-container1
  ```

  Где `--container-name` — имя контейнера, указанное в `.sourcecraft/ci.yaml`.

  Результат:

  ```text
  +----------------------+----------------------+--------------------------------------------------------+---------------------+
  |          ID          |     CONTAINER ID     |                 IMAGE                                  |     CREATED AT      |
  +----------------------+----------------------+--------------------------------------------------------+---------------------+
  | bba27hejd69a******** | bba83i1mrb5s******** | cr.yandex/yc/serverless/demo-serverless-container1     | 2025-10-04 09:38:14 |
  +----------------------+----------------------+--------------------------------------------------------+---------------------+
  ```

- API {#api}

  Воспользуйтесь методом REST API [listRevisions](../../serverless-containers/containers/api-ref/Container/listRevisions.md) для ресурса [Container](../../serverless-containers/containers/api-ref/Container/index.md) или вызовом gRPC API [RegistryService/CreateRegistryRequest](../../serverless-containers/containers/api-ref/grpc/Container/listRevisions.md).

{% endlist %}

## Удалите созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. [Удалите](../../serverless-containers/operations/delete.md) контейнер.
1. [Удалите](../../container-registry/operations/docker-image/docker-image-delete.md) Docker-образ.
1. [Удалите](../../container-registry/operations/registry/registry-delete.md) реестр.

## См. также {#see-also}

* [Настроить CI/CD между SourceCraft и Yandex Cloud Functions](ci-cd-sourcecraft-functions.md)
* [Сервисные подключения](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/service-connections)
* [Настроить в SourceCraft сервисное подключение к Yandex Cloud](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/service-connections)
* [Интеграция с GitHub Actions в SourceCraft](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/gh-actions)
* [Использовать GitHub Actions в CI/CD SourceCraft](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/gh-actions)
* [Пайплайны GitLab в CI/CD SourceCraft](https://sourcecraft.dev/portal/docs/ru/sourcecraft/concepts/gl-pipelines)
* [Использовать пайплайн GitLab в CI/CD SourceCraft](https://sourcecraft.dev/portal/docs/ru/sourcecraft/operations/gl-pipelines)
* [Репозиторий serverless-functions в SourceCraft](https://sourcecraft.dev/yandex-cloud-examples/serverless-functions)
* [Репозиторий yc-ci-cd-serverless в SourceCraft](https://sourcecraft.dev/sourcecraft/yc-ci-cd-serverless)