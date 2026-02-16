# Настройка CI/CD для развертывания приложения в {{ serverless-containers-full-name }} с помощью GitHub Actions


В этом практическом руководстве вы настроите [CI/CD-процесс]({{ link-src-docs }}/sourcecraft/concepts/ci-cd) для развертывания контейнеризированного приложения в [{{ serverless-containers-name }}](../../serverless-containers/concepts/index.md) из [репозитория]({{ link-src-docs }}/sourcecraft/concepts/#repos) {{ src-name }} с помощью [GitHub Actions]({{ link-src-docs }}/sourcecraft/concepts/gh-actions). Интеграция между {{ src-name }} и {{ yandex-cloud }} будет выполнена с помощью [сервисного подключения]({{ link-src-docs }}/sourcecraft/concepts/service-connections).

{% include [service-connection-role-warning](../../_includes/sourcecraft/service-connection-role-warning.md) %}

Чтобы настроить CI/CD для развертывания приложения в {{ serverless-containers-name }} из репозитория {{ src-name }} с помощью GitHub Actions:
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
* Плата за хранение созданных Docker-образов (см. [тарифы {{ container-registry-name }}](../../container-registry/pricing.md).
* Плата за количество вызовов контейнера, вычислительные ресурсы, выделенные для выполнения приложения, и исходящий трафик (см. [тарифы {{ serverless-containers-name }}](../../serverless-containers/pricing.md).

## Создайте сервисный аккаунт {#create-sa}

От имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) будут загружаться Docker-образы в [реестры](../../container-registry/concepts/registry.md) {{ container-registry-full-name }} и развертываться [контейнеры](../../serverless-containers/concepts/container.md) в {{ serverless-containers-name }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Войдите в [консоль управления]({{ link-console-main }}) {{ yandex-cloud }}.
  1. В левой части экрана нажмите на строку с именем каталога, в котором вы хотите развернуть контейнер.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. В поле **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** укажите `github-action`.
  1. Нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите роли:

      * `{{ roles-cr-pusher }}` — для работы с Docker-образами в реестре;
      * `serverless-containers.editor` — для управления контейнером;
      * `iam.serviceAccounts.user` — для возможности при создании ревизии контейнера указать сервисный аккаунт, от имени которого Docker-образ будет загружен из реестра.

  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

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

      * `{{ roles-cr-pusher }}` — для работы с Docker-образами в реестре:

        ```bash
        yc resource-manager folder add-access-binding <имя_каталога> \
          --service-account-name github-action \
          --role {{ roles-cr-pusher }} \
          --folder-name <имя_каталога>
        ```

- API {#api}

  1. Создайте сервисный аккаунт `github-action`. Для этого воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).
  1. Назначьте сервисному аккаунту в текущем каталоге [роли](../../iam/concepts/access-control/roles.md):

      * `iam.serviceAccounts.user` — для возможности при создании ревизии контейнера указать сервисный аккаунт, от имени которого Docker-образ будет загружен из реестра;
      * `serverless-containers.editor` — для управления контейнером;
      * `{{ roles-cr-pusher }}` — для работы с Docker-образами в реестре.

      Для этого воспользуйтесь методом REST API [setAccessBindings](../../resource-manager/api-ref/Folder/setAccessBindings.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/SetAccessBindings](../../resource-manager/api-ref/grpc/Folder/setAccessBindings.md).

{% endlist %}

## Создайте реестр {#create-registry}

В реестре {{ container-registry-name }} будет храниться Docker-образ приложения.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_container-registry }}**.
  1. Нажмите **{{ ui-key.yacloud.cr.overview.button_create }}**.
  1. Задайте имя реестра `github-action`.
  1. Нажмите **{{ ui-key.yacloud.cr.overview.popup-create_button_create }}**.
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

Репозиторий будет создан из шаблона [yc-ci-cd-serverless]({{ link-src-main }}/sourcecraft/yc-ci-cd-serverless). В репозитории будут храниться `Dockerfile` и вспомогательные файлы для создания Docker-образа, а также настройки CI/CD-процесса.

{% list tabs group=instructions %}

- Интерфейс {{ src-name }} {#src}

  1. Откройте [главную страницу сервиса]({{ link-src-main }}).
  1. На панели слева нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.sourcecraft.mainApp.route_create-repository_4e8Ef }}**.
  1. В открывшемся окне выберите **{{ ui-key.sourcecraft.repoCreate.title_create-blank_2CxnQ }}**.
  1. В блоке **{{ ui-key.sourcecraft.repoCreate.title_new-repo-details_riAaE }}**:
      * В поле **{{ ui-key.sourcecraft.repoCreate.title_owner-field_7gbCn }}** выберите [организацию]({{ link-src-docs }}/sourcecraft/concepts/#org), в которой вы создали сервисный аккаунт в {{ yandex-cloud }}.
      * В поле **{{ ui-key.sourcecraft.repoCreate.title_repo-field_p5MD3 }}** укажите название репозитория. 

        Название должно быть уникальным в пределах организации и может содержать следующие [ASCII-символы](https://ru.wikipedia.org/wiki/ASCII): строчные и заглавные буквы латинского алфавита, цифры, запятые, дефисы и подчеркивания.

        Под названием отображается адрес, по которому репозиторий будет доступен.

      * (опционально) В поле **{{ ui-key.sourcecraft.repoSettings.field_description_1274t }}** укажите описание репозитория.

  1. В блоке **{{ ui-key.sourcecraft.repoCreate.section_template_vc5Jc }}** нажмите **{{ ui-key.sourcecraft.repoCreate.button_browse-templates_bP3xB }}**, выберите шаблон [yc-ci-cd-serverless]({{ link-src-main }}/sourcecraft/yc-ci-cd-serverless) и нажмите **{{ ui-key.sourcecraft.repo.button_use-template_ttBnP }}**.

      Чтобы посмотреть содержимое шаблона, нажмите **{{ ui-key.sourcecraft.repoCreate.button_preview-template_2WJAq }}**.

      В шаблоне содержатся:
      * файл [.sourcecraft/ci.yaml]({{ link-src-main }}/sourcecraft/yc-ci-cd-serverless/browse/.sourcecraft/ci.yaml) с предустановленной конфигурацией CI/CD-процесса, который запускается при создании коммита и выполняет следующее:
        * Получает IAM-токен {{ yandex-cloud }} с помощью сервисного подключения с именем `default-service-connection`.
        * Устанавливает в окружение [воркера]({{ link-src-docs }}/sourcecraft/concepts/ci-cd#workers) утилиту [Docker Buildx](https://github.com/docker/buildx) с помощью GitHub Action [Docker Setup Buildx](https://github.com/marketplace/actions/docker-setup-buildx).
        * Аутентифицируется в {{ container-registry-name }} с помощью GitHub Action [Docker Login](https://github.com/marketplace/actions/docker-login) и IAM-токена {{ yandex-cloud }}.
        * Собирает Docker-образ из `Dockerfile`, размещенного в корне репозитория, и отправляет образ в {{ container-registry-name }} с помощью GitHub Action [Build and push Docker images](https://github.com/marketplace/actions/build-and-push-docker-images).
        * Разворачивает контейнер в {{ serverless-containers-name }} из собранного Docker-образа.
      * файлы [Dockerfile]({{ link-src-main }}/sourcecraft/yc-ci-cd-serverless/browse/Dockerfile), [index.html]({{ link-src-main }}/sourcecraft/yc-ci-cd-serverless/browse/index.html) и [docker/nginx/conf.d/default.conf]({{ link-src-main }}/sourcecraft/yc-ci-cd-serverless/browse/docker/nginx/conf.d/default.conf) с конфигурацией контейнера со статическим веб‑приложением на базе [Nginx](https://nginx.org/{{ lang }}/).

  1. Нажмите **{{ ui-key.sourcecraft.repoCreate.button_create-repo_nMrwv }}**.

{% endlist %}

## Создайте сервисное подключение {#create-service-connection}

{% list tabs group=instructions %}

- Интерфейс {{ src-name }} {#src}

  1. Откройте [главную страницу]({{ link-src-main }}) {{ src-name }}.
  1. Перейдите на вкладку ![image](../../_assets/console-icons/briefcase.svg) **{{ ui-key.sourcecraft.lib.organizations_5CjkW }}**.
  1. Выберите организацию, в которой вы создали сервисный аккаунт в {{ yandex-cloud }}.
  1. На странице организации в разделе ![image](../../_assets/console-icons/gear.svg) **{{ ui-key.sourcecraft.lib.settings_cwUYS }}** перейдите в секцию ![image](../../_assets/console-icons/cloud-nut-hex.svg) **{{ ui-key.sourcecraft.mainApp.route_service-connections_2PPgz }}**.
  1. Нажмите **{{ ui-key.sourcecraft.serviceConnections.button_add-connection_6Bj7i }}**.
  1. В блоке **{{ ui-key.sourcecraft.serviceConnections.section_basic_wmaiy }}** укажите имя сервисного подключения `default-service-connection`.
  1. В блоке **{{ ui-key.sourcecraft.serviceConnections.section_scope_9gXcu }}** выберите созданный ранее репозиторий.
  1. В блоке **{{ ui-key.sourcecraft.serviceConnections.section_cloud-settings_tDMfn }}** выберите:

      * Каталог, в котором ранее вы развернули облачную инфраструктуру и назначили роль сервисному аккаунту.
      * Сервисный аккаунт `github-action`.

        {% note tip %}

        Чтобы повторно запросить список облаков, каталогов и сервисных аккаунтов из {{ yandex-cloud }}, нажмите  ![image](../../_assets/console-icons/arrow-rotate-right.svg) **Синхронизировать**. Это может быть полезно, если параллельно с созданием сервисного подключения вы создали каталог или сервисный аккаунт.

        {% endnote %}

  1. Нажмите **{{ ui-key.sourcecraft.serviceConnections.button_create-connection_uyK29 }}**.

      Дождитесь окончания операции. На открывшейся странице будут представлены детали сервисного подключения.

      В {{ yandex-cloud }} будет автоматически создана [федерация сервисных аккаунтов](../../iam/concepts/workload-identity.md) {{ iam-full-name }}.

      Чтобы посмотреть параметры созданного OIDC-провайдера, в блоке ![image](../../_assets/console-icons/cpus.svg) **{{ ui-key.sourcecraft.serviceConnections.title_oidc-federation_eC6Jw }}** нажмите на имя федерации.

{% endlist %}

## Настройте CI/CD {#config-ci-cd}

{% list tabs group=instructions %}

- Интерфейс {{ src-name }} {#src}

  1. Откройте [главную страницу]({{ link-src-main }}) {{ src-name }}.
  1. На вкладке ![image](../../_assets/console-icons/house.svg) **{{ ui-key.sourcecraft.lib.home_t2KmK }}** в секции ![image](../../_assets/console-icons/layout-tabs.svg) **{{ ui-key.sourcecraft.orgCommon.link_your-craftspace_bHYz8 }}** перейдите в раздел ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.sourcecraft.lib.repositories_vLJYc }}**.
  1. Выберите созданный ранее репозиторий.
  1. Выберите файл `.sourcecraft/ci.yaml`.
  1. В правом верхнем углу нажмите ![image](../../_assets/console-icons/pencil.svg) **Редактировать**.
  1. В параметре `YC_DOCKER_REGISTRY_URI` укажите идентификатор созданного [ранее](#create-registry) реестра:

      ```yaml
      YC_DOCKER_REGISTRY_URI: {{ registry }}/<идентификатор_реестра>
      ```

  1. В правом верхнем углу нажмите **{{ ui-key.sourcecraft.repo.action_commit_brj4B }}**.
  1. Сделайте коммит:

      1. Введите сообщение об изменениях.
      1. В блоке **{{ ui-key.sourcecraft.repo.field_commit-branch_d1Mzi }}** выберите **{{ ui-key.sourcecraft.repo.field_text_commit-directly-to-the-branch_mBfk8 }} main**.
      1. В блоке **{{ ui-key.sourcecraft.repo.field_after-commit-action_mKjo4 }}** выберите **{{ ui-key.sourcecraft.repo.option_just-commit_to5sC }}**.
      1. Нажмите **{{ ui-key.sourcecraft.repo.button_commit_si86H }}**.

{% endlist %}

После сохранения изменений запустится рабочий процесс `demo-service-connection-workflow`.

## Проверьте выполнение CI/CD {#check-ci-cd}

{% list tabs group=instructions %}

- Интерфейс {{ src-name }} {#src}

  1. Откройте [главную страницу]({{ link-src-main }}) {{ src-name }}.
  1. На вкладке ![image](../../_assets/console-icons/house.svg) **{{ ui-key.sourcecraft.lib.home_t2KmK }}** в секции ![image](../../_assets/console-icons/layout-tabs.svg) **{{ ui-key.sourcecraft.orgCommon.link_your-craftspace_bHYz8 }}** перейдите в раздел ![image](../../_assets/console-icons/archive.svg) **{{ ui-key.sourcecraft.lib.repositories_vLJYc }}**.
  1. Выберите созданный ранее репозиторий.
  1. На странице репозитория в разделе ![image](../../_assets/console-icons/code.svg) **{{ ui-key.sourcecraft.repo.title_navigation-code_8bgjg }}** перейдите в секцию ![image](../../_assets/console-icons/arrows-3-rotate-right.svg) **{{ ui-key.sourcecraft.repo.action_cicd_4jypo }}**.
  1. В списке запусков автоматизаций вы увидите новый запуск. Дождитесь, когда статус изменится на ![image](../../_assets/console-icons/circle-check.svg) **{{ ui-key.sourcecraft.cicd.value_succeeded_3Dd8C }}**.

{% endlist %}

## Проверьте, что контейнер создан {#check-result}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
  1. В списке должен появиться контейнер `demo-serverless-container1`, выберите его.

      В блоке **{{ ui-key.yacloud.serverless-containers.section-revisions }}** должна появиться ревизия контейнера, по времени создания соответствующая времени [запуска CI/CD-процесса](#check-ci-cd).

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
  | bba27hejd69a******** | bba83i1mrb5s******** | {{ registry }}/yc/serverless/demo-serverless-container1     | 2025-10-04 09:38:14 |
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

* [Настроить CI/CD между {{ src-name }} и {{ sf-full-name }}](../../tutorials/serverless/ci-cd-sourcecraft-functions.md)
* [Настроить в {{ src-name }} сервисное подключение к {{ yandex-cloud }}]({{ link-src-docs }}/sourcecraft/operations/service-connections)
* [Интеграция с GitHub Actions в {{ src-name }}]({{ link-src-docs }}/sourcecraft/concepts/gh-actions)
* [Репозиторий serverless-functions в {{ src-name }}]({{ link-src-main }}/yandex-cloud-examples/serverless-functions)
* [Репозиторий yc-ci-cd-serverless в {{ src-name }}]({{ link-src-main }}/sourcecraft/yc-ci-cd-serverless)
* [Использовать пайплайн {{ GL }} в CI/CD {{ src-name }}]({{ link-src-docs }}/sourcecraft/operations/gl-pipelines)