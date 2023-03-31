# Построение пайплайна CI/CD в {{ GL }} с использованием serverless-продуктов

Вы можете построить пайплайн [непрерывной интеграции и непрерывной поставки (CI/CD)](/blog/posts/2022/10/ci-cd) с использованием serverless-продуктов.

В качестве примера проекта будет использовано веб-приложение, реализованное на [Django](https://www.djangoproject.com/), которое имитирует корзину товаров интернет-магазина. В базе данных хранятся описания товаров, а состояние корзины товаров сервис хранит в сессии пользователя. Django-приложение разворачивается в [serverless-контейнере](../../serverless-containers/concepts/container.md), при этом секреты безопасно доставляются в приложение с помощью сервиса [{{ lockbox-name }}](../../lockbox/). [{{ api-gw-full-name }}](../../api-gateway/) принимает запросы от пользователей и перенаправляет их в контейнер приложения.

{% note info %}

Сервис {{ lockbox-name }} находится на стадии [Preview](../../overview/concepts/launch-stages.md). Доступ предоставляется по запросу. Обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.

{% endnote %}

Для проекта используются два окружения:
* `prod` — продакшн, доступный пользователям.
* `testing` — тестовое, используется для проверки приложения перед релизом в `prod`.

Для каждого из окружений создается отдельный [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) в {{ yandex-cloud }}, а так же отдельный набор статических ресурсов — БД, [сервисные аккаунты](../../iam/concepts/users/service-accounts.md) и т. д. Таким образом все окружения изолированы друг от друга на уровне настроек [{{ iam-full-name }}](../../iam/).

Дополнительно используется общий каталог `infra` с [реестром](../../container-registry/concepts/registry.md) [{{ container-registry-full-name }}](../../container-registry/) — в него публикуются все собранные [Docker-образы](../../container-registry/concepts/docker-image.md) приложения. Публикация образов осуществляется от отдельного сервисного аккаунта `builder`. Сервисные аккаунты окружений `prod` и `testing` имеют ограниченные права в каталоге `infra` и могут только [скачивать Docker-образы](../../container-registry/operations/docker-image/docker-image-pull.md).

Чтобы построить пайплайн CI/CD с использованием serverless-продуктов:
1. [Создайте инстанс {{ GL }}](#create-gitlab).
1. [Настройте {{ GL }}](#configure-gitlab).
1. [Создайте {{ GLR }}](#runner).
1. [Загрузите файлы в репозиторий {{ GL }}](#add-files).
1. [Создайте переменные окружения {{ GL }}](#add-variables).
1. [Создайте файл конфигурации сценария CI](#add-ci).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-begin}

### Скачайте проект {#download-project}

Скопируйте файлы проекта из директории [cicddemo-gitlab](https://github.com/yandex-cloud/examples/tree/master/serverless/cicddemo-gitlab) или клонируйте [репозиторий examples](https://github.com/yandex-cloud/examples) с помощью Git:

```bash
git clone https://github.com/yandex-cloud/examples.git
```

### Установите дополнительные зависимости {#prepare}

Установите в локальном окружении:
* [Интерфейс командной строки {{ yandex-cloud }}](../../cli/operations/install-cli.md).
* [Утилиту потоковой обработки JSON-файлов `jq`](https://stedolan.github.io/jq/download/).
* [Утилиту потоковой обработки YAML-файлов `yq`](https://github.com/mikefarah/yq#install).
* [Python версии 3.8 или выше](https://www.python.org/downloads/).
* Библиотеки Python, перечисленные в файле проекта `application/requirements.txt`:

  ```bash
  python -m pip install -r ./application/requirements.txt
  ```

### Подготовьте инфраструктуру {#deploy-infrastructure}

1. Перейдите в директорию с проектом и запустите скрипт `bootstrap.sh`, указав идентификатор вашего [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud):

   ```bash
   YC_CLOUD_ID=<идентификатор облака> ./bootstrap.sh
   ```

   Этот скрипт развернет базовую инфраструктуру и создаст YAML-файлы в директории `config` с описанием созданных ресурсов. Вы можете отредактировать скрипт, чтобы создать дополнительные каталоги с нужными ресурсами. Например, добавить еще одно тестовое окружение.

   {% note warning %}

   В конце выполнения скрипт выведет переменные окружения для {{ GL }} и их значения. Сохраните их, они потребуются в дальнейшем.

   {% endnote %}

1. [Создайте сервисные аккаунты](../../iam/operations/sa/create.md):
   * Сервисный аккаунт для ресурсов с [ролью](../../iam/concepts/access-control/roles.md) [{{ roles-editor }}](../../resource-manager/security/index.md#roles-list) на каталог, в котором создается [кластер {{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster). От его имени будут создаваться ресурсы, необходимые кластеру {{ managed-k8s-name }}.
   * Сервисный аккаунт для [узлов](../../managed-kubernetes/concepts/index.md#node-group) с ролью [{{ roles-cr-puller }}](../../container-registry/security/index.md#required-roles) на каталог с реестром Docker-образов. От его имени узлы будут скачивать из реестра необходимые Docker-образы.

   Вы можете использовать один и тот же сервисный аккаунт для обеих операций.
1. [Создайте кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md). При создании кластера укажите ранее созданные сервисные аккаунты для ресурсов и узлов.
1. [Настройте группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) для работы кластера {{ managed-k8s-name }}.
1. [Настройте группу безопасности по умолчанию](../../managed-gitlab/operations/connect.md) для работы [инстанса {{ mgl-full-name }}](../../managed-gitlab/concepts/index.md#instance).

## Создайте инстанс {{ GL }} {#create-gitlab}

Создайте инстанс {{ mgl-name }} или [виртуальную машину](../../compute/concepts/vm.md) с [образом](../../compute/concepts/image.md) {{ GL }} в той же [облачной сети](../../vpc/concepts/network.md#network), где расположен кластер {{ managed-k8s-name }}.

{% list tabs %}


- Инстанс {{ mgl-name }}

  Создайте инстанс {{ mgl-name }} [согласно инструкции](../../managed-gitlab/quickstart.md#instance-create).


- ВМ с образом {{ GL }}

  Запустите {{ GL }} на ВМ с [публичным IP-адресом](../../vpc/concepts/address.md#public-addresses).

  {% include [create-gitlab](../../_includes/managed-gitlab/create.md) %}

{% endlist %}

## Настройте {{ GL }} {#configure-gitlab}

{% include [Create a project](../../_includes/managed-gitlab/initialize.md) %}

## Создайте {{ GLR }} {#runner}

Установите приложение {{ GLR }} согласно [инструкции](../../managed-kubernetes/operations/applications/gitlab-runner.md).

## Загрузите файлы в репозиторий {{ GL }} {#add-files}

1. [Добавьте SSH-ключ для безопасного доступа к {{ GL }}](https://docs.gitlab.com/ee/user/ssh.html).
1. [Склонируйте репозиторий](https://docs.gitlab.com/ee/gitlab-basics/start-using-git.html#clone-with-ssh) `gitlab-test` с помощью [SSH](../../glossary/ssh-keygen.md).
1. Скопируйте все файлы из директории `cicddemo-gitlab` в `gitlab-test`.
1. Перейдите в директорию `gitlab-test`.
1. Проиндексируйте новые файлы:

   ```bash
   git add .
   ```

1. Сделайте коммит:

   ```bash
   git commit -m "Add project files"
   ```

1. Отправьте изменения в репозиторий `gitlab-test`:

   ```bash
   git push
   ```

## Создайте переменные окружения {{ GL }} {#add-variables}

1. На панели слева в {{ GL }} перейдите в раздел **Settings** и во всплывающем списке выберите пункт **CI/CD**.
1. Нажмите кнопку **Expand** напротив пункта **Variables**.
1. Добавьте переменные окружения с выключенной опцией защиты. Все необходимые переменные и их значения были выведены в конце выполнения скрипта `bootstrap.sh`:
   * `cloud_id` — идентификатор вашего облака.
   * `CI_REGISTRY` — идентификатор реестра {{ container-registry-name }} в каталоге `infra` с префиксом `cr.yandex/`.
   * `CI_REGISTRY_KEY` — [ключ](../../iam/concepts/users/service-accounts.md#sa-key) сервисного аккаунта `builder`.
   * `cart_prod` — имя продакшн каталога в {{ yandex-cloud }}.
   * `DOCAPI_ENDPOINT_prod` — Document API эндпоинт БД [{{ ydb-full-name }}](../../ydb/) в каталоге `prod`.
   * `PROD_SA_ID` — идентификатор сервисного аккаунта `deployer` в каталоге `prod`.
   * `SA_PROD_DEPLOYER_PRIVATE_KEY` — ключ сервисного аккаунта `deployer` в каталоге `prod`.
   * `prod_container_id` — идентификатор контейнера {{ serverless-containers-name }} в каталоге `prod`.
   * `cart_testing` — имя тестового каталога в {{ yandex-cloud }}.
   * `DOCAPI_ENDPOINT_testing` — Document API эндпоинт БД {{ ydb-name }} в каталоге `testing`.
   * `TESTING_SA_ID` — идентификатор сервисного аккаунта `deployer` в каталоге `testing`.
   * `SA_TESTING_DEPLOYER_PRIVATE_KEY` — ключ сервисного аккаунта `deployer` в каталоге `testing`.

   Для добавления переменной:
   1. Нажмите кнопку **Add variable**.
   1. В появившемся окне в поле **Key** укажите имя переменной, в поле **Value** — значение переменной.
   1. Выключите опцию **Protect variable**.
   1. Нажмите кнопку **Add variable**.

## Создайте файл конфигурации сценария CI {#add-ci}

1. На панели слева в {{ GL }} перейдите в раздел **Repository** и выберите вкладку **Files**.
1. Справа от имени проекта нажмите кнопку ![image](../../_assets/plus.svg) и в выпадающем меню выберите пункт **New file**.
1. Назовите файл `.gitlab-ci.yml` и добавьте в него этапы сборки:

   {% cut ".gitlab-ci.yml" %}

   ```yaml
   stages:
     - build
     - deploy-test-env
     - test
     - delete-test-env
     - release

   # Сборка образа контейнера.
   build-job:
     stage: build
   # Использование kaniko для создания контейнера внутри контейнера для большей безопасности.
     image:
       name: gcr.io/kaniko-project/executor:debug
       entrypoint: [""]
     script:
       - mkdir -p /kaniko/.docker
   # Отправка образа контейнера в реестр. Образ отмечен хэшем коммита.
       - echo "{\"auths\":{\"$CI_REGISTRY\":{\"auth\":\"$(echo -n "json_key:${CI_REGISTRY_KEY}" | base64 | tr -d '\n' )\"}}}" > /kaniko/.docker/config.json
       - >-
         /kaniko/executor
         --context "${CI_PROJECT_DIR}/application"
         --dockerfile "${CI_PROJECT_DIR}/application/Dockerfile"
         --destination "${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}"

   # Развертывание тестовой среды с использованием встроенного образа контейнера.
   deploy-test-env-job:
     stage: deploy-test-env
     image: alpine:3.15
     script:
   # Установка инструментов.
       - apk add -q --no-cache bash curl jq gettext
       - apk add yq --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community
       - curl -f -s -LO https://storage.yandexcloud.net/yandexcloud-yc/install.sh
       - bash install.sh -i /usr/local/yandex-cloud -n
       - ln -s /usr/local/yandex-cloud/bin/yc /usr/local/bin/yc
    # Аутентификация с помощью ключа сервисного аккаунта.
       - echo "$SA_TESTING_DEPLOYER_PRIVATE_KEY" > key.json
       - yc config profile create sa-profile
       - yc config set service-account-key key.json
   # Установка переменных для развертывания {{ api-gw-name }} и создание контейнера.
       - export sa_id=$TESTING_SA_ID
       - export container_id=$(yc serverless container create --name testing --cloud-id ${cloud_id} --folder-name ${cart_testing} | yq .id)
   # Развертывание ревизии.
       - yc serverless container revision deploy --container-name testing --image "${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}" --cores 1 --memory 512mb --concurrency 1 --execution-timeout 10s --cloud-id ${cloud_id} --folder-name ${cart_testing} --service-account-id ${TESTING_SA_ID} --environment DOCAPI_ENDPOINT=${DOCAPI_ENDPOINT_testing},DB_TABLE_PREFIX='' --secret environment-variable=AWS_ACCESS_KEY_ID,name=cart-app,key=AWS_ACCESS_KEY_ID --secret environment-variable=AWS_SECRET_ACCESS_KEY,name=cart-app,key=AWS_SECRET_ACCESS_KEY --secret environment-variable=SECRET_KEY,name=cart-app,key=SECRET_KEY
   # Настройка шаблона и развертывание {{ api-gw-name }}.
       - (cat ${CI_PROJECT_DIR}/apigw.yaml.j2 | envsubst) > apigw.yaml
       - cat apigw.yaml
       - yc serverless api-gateway create --name testing --spec=apigw.yaml --description "created from gitlab CI" --cloud-id ${cloud_id} --folder-name ${cart_testing}
       - mkdir output
       - export gwdomain=$(yc serverless api-gateway get testing --cloud-id ${cloud_id} --folder-name ${cart_testing} | yq .domain)
       - echo "https://"$gwdomain>output/gwurl
     artifacts:
       paths: [output/]

   e2e-test-job:
     stage: test
     image: alpine:3.15
     script:
       - apk add -q --no-cache bash curl
       - apk add yq --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community
       - cat output/gwurl
       - export gwurlvar=$(cat output/gwurl)
       - curl $gwurlvar

   load-test-job:
     stage: test
     image: alpine:3.15
     script:
       - echo "Here goes load testing commands"
       - echo "Might even invoke bash with prepared bash script"
       - echo "Hello!"

   delete-test-env-job:
     stage: delete-test-env
     image: alpine:3.15
     script:
       - apk add -q --no-cache bash curl jq gettext yq
       - curl -f -s -LO https://storage.yandexcloud.net/yandexcloud-yc/install.sh
       - bash install.sh -i /usr/local/yandex-cloud -n
       - ln -s /usr/local/yandex-cloud/bin/yc /usr/local/bin/yc
       - echo "$SA_TESTING_DEPLOYER_PRIVATE_KEY" > key.json
       - yc config profile create sa-profile
       - yc config set service-account-key key.json
       - yc serverless api-gateway delete testing --cloud-id ${cloud_id} --folder-name ${cart_testing}
       - yc serverless container delete testing --cloud-id ${cloud_id} --folder-name ${cart_testing}

   release-job:
     stage: release
     image: alpine:3.15
     script:
       - apk add -q --no-cache bash curl jq gettext
       - curl -f -s -LO https://storage.yandexcloud.net/yandexcloud-yc/install.sh
       - bash install.sh -i /usr/local/yandex-cloud -n
       - ln -s /usr/local/yandex-cloud/bin/yc /usr/local/bin/yc
       - echo "$SA_PROD_DEPLOYER_PRIVATE_KEY" > key.json
       - yc config profile create sa-profile
       - yc config set service-account-key key.json
       - yc serverless container revision deploy --container-name prod --image "${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}" --cores 1 --memory 512mb --concurrency 1 --execution-timeout 10s --cloud-id ${cloud_id} --folder-name ${cart_prod} --service-account-id ${PROD_SA_ID} --environment DOCAPI_ENDPOINT=${DOCAPI_ENDPOINT_prod},DB_TABLE_PREFIX='' --secret environment-variable=AWS_ACCESS_KEY_ID,name=cart-app,key=AWS_ACCESS_KEY_ID --secret environment-variable=AWS_SECRET_ACCESS_KEY,name=cart-app,key=AWS_SECRET_ACCESS_KEY --secret environment-variable=SECRET_KEY,name=cart-app,key=SECRET_KEY
       - container_id=${prod_container_id}
   # Создание продакшн среды.
     environment:
       name: production/$CI_COMMIT_SHORT_SHA
   ```

   {% endcut %}

1. Напишите комментарий к коммиту в поле **Commit message**: `CI scripts`.
1. Нажмите кнопку **Commit changes**.

В файле `.gitlab-ci.yml` описаны следующие этапы сценария CI:
* **build** — сборка Docker-образа с использованием `Dockerfile` и загрузка образа в {{ container-registry-name }}.
* **deploy-test-env** — тестовое развертывание приложения. Дополнительно описан, но не использован механизм [artifacts](https://docs.gitlab.com/ee/ci/pipelines/job_artifacts.html) для передачи данных из одного этапа в другой. При необходимости настройте его.
* **test** — тестирование приложения. В качестве тестов приведены имитации e2e и нагрузочного тестирования. Опишите и настройте собственные тесты.
* **delete-test-env** — удаление тестового приложения.
* **release** — продакшн развертывание приложения. Дополнительно на этом этапе используются [среды развертывания](https://docs.gitlab.com/ee/ci/environments/). Они создаются и сохраняются при каждом успешном выполнении пайплайна. Воспользуйтесь ими, чтобы восстановить и развернуть прошлую версию приложения.

После сохранения файла конфигурации `.gitlab-ci.yml` запустится сценарий сборки.

## Проверьте результат {#check-result}

Чтобы проверить результаты выполнения сценария сборки, на панели слева в {{ GL }} выберите в выпадающем меню пункт **CI/CD** → **Pipelines**. Все пять этапов должны успешно завершиться.

Приложение будет доступно по адресу служебного домена API-шлюза {{ api-gw-name }} в каталоге `prod`. Адрес можно посмотреть в [консоли управления]({{ link-console-main }}) или в значении поля `domain` в логе выполнения скрипта `bootstrap.sh`.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, во избежание списания средств за них:
1. [Удалите каталоги](../../resource-manager/operations/folder/delete.md) `prod`, `testing` и `infra` вместе с ресурсами в них.
1. [Удалите инстанс {{ mgl-name }}](../../managed-gitlab/operations/instance/instance-delete.md) или [созданную ВМ с образом {{ GL }}](../../compute/operations/vm-control/vm-delete.md).
1. [Удалите кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. Если вы зарезервировали для кластера публичный статический IP-адрес, [удалите его](../../vpc/operations/address-delete.md).
1. [Удалите сервисные аккаунты](../../iam/operations/sa/delete.md).