# Построение пайплайна CI/CD с использованием serverless-продуктов

# Построение пайплайна CI/CD в GitLab с использованием serverless-продуктов


Вы можете построить пайплайн [непрерывной интеграции и непрерывной поставки (CI/CD)](https://yandex.cloud/ru/blog/ci-cd-pipeline) с использованием serverless-продуктов.

В качестве примера проекта будет использовано веб-приложение, реализованное на [Django](https://www.djangoproject.com/), которое имитирует корзину товаров интернет-магазина. В базе данных хранятся описания товаров, а состояние корзины товаров сервис хранит в сессии пользователя. Django-приложение разворачивается в [контейнере Serverless Containers](../../serverless-containers/concepts/container.md), при этом секреты безопасно доставляются в приложение с помощью сервиса [Yandex Lockbox](../index.md). [Yandex API Gateway](../../api-gateway/index.md) принимает запросы от пользователей и перенаправляет их в [контейнер приложения](../../glossary/containerization.md#containers-apps).

Для проекта используются два окружения:
* `prod` — продакшн, доступный пользователям.
* `testing` — тестовое, используется для проверки приложения перед релизом в `prod`.

Для каждого из окружений создается отдельный [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) в Yandex Cloud, а так же отдельный набор статических ресурсов — БД, [сервисные аккаунты](../../iam/concepts/users/service-accounts.md) и т. д. Таким образом все окружения изолированы друг от друга на уровне настроек [Yandex Identity and Access Management](../../iam/index.md).

Дополнительно используется общий каталог `infra` с [реестром](../../container-registry/concepts/registry.md) [Yandex Container Registry](../../container-registry/index.md) — в него публикуются все собранные [Docker-образы](../../container-registry/concepts/docker-image.md) приложения. Публикация образов осуществляется от отдельного сервисного аккаунта `builder`. Сервисные аккаунты окружений `prod` и `testing` имеют ограниченные права в каталоге `infra` и могут только [скачивать Docker-образы](../../container-registry/operations/docker-image/docker-image-pull.md).

Чтобы построить пайплайн CI/CD с использованием serverless-продуктов:
1. [Создайте инстанс GitLab](#create-gitlab).
1. [Настройте GitLab](#configure-gitlab).
1. [Создайте GitLab Runner](#runners).
1. [Загрузите файлы в репозиторий GitLab](#add-files).
1. [Создайте переменные окружения GitLab](#add-variables).
1. [Создайте файл конфигурации сценария CI](#add-ci).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:

* Плата за [диски](../../compute/concepts/disk.md) и постоянно запущенные ВМ (см. [тарифы Yandex Compute Cloud](../../compute/pricing.md)).
* Плата за использование [мастера Yandex Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#master) (см. [тарифы Managed Service for Kubernetes](../../managed-kubernetes/pricing.md)).
* Плата за хранение созданных Docker-образов (см. [тарифы Container Registry](../../container-registry/pricing.md)).
* Плата за хранение секретов (см. [тарифы Yandex Lockbox](../pricing.md)).
* Плата за количество вызовов контейнера, вычислительные ресурсы, выделенные для выполнения приложения, и исходящий трафик (см. [тарифы Serverless Containers](../../serverless-containers/pricing.md)).
* Плата за запросы к API-шлюзу (см. [тарифы API Gateway](../../api-gateway/pricing.md)).
* Плата за использование [публичных IP-адресов](../../vpc/concepts/address.md#public-addresses) (см. [тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md#prices-public-ip)).

## Перед началом работы {#before-begin}

### Скачайте проект {#download-project}

Клонируйте [репозиторий yc-serverless-gitlab-ci-cd](https://github.com/yandex-cloud-examples/yc-serverless-gitlab-ci-cd) с помощью Git:

```bash
git clone https://github.com/yandex-cloud-examples/yc-serverless-gitlab-ci-cd.git
```

### Установите дополнительные зависимости {#prepare}

Установите в локальном окружении:
* [Интерфейс командной строки Yandex Cloud](../../cli/operations/install-cli.md).
* [Утилиту потоковой обработки JSON-файлов `jq`](https://jqlang.org/download/).
* [Утилиту потоковой обработки YAML-файлов `yq`](https://github.com/mikefarah/yq#install).
* [Python версии 3.8 или выше](https://www.python.org/downloads/).
* Библиотеки Python, перечисленные в файле проекта `application/requirements.txt`:

  ```bash
  python -m pip install -r ./application/requirements.txt
  ```

### Подготовьте инфраструктуру {#deploy-infrastructure}

1. Перейдите в директорию с проектом и запустите скрипт `bootstrap.sh`, указав идентификатор вашего [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud):

   ```bash
   YC_CLOUD_ID=<идентификатор_облака> ./bootstrap.sh
   ```

   Этот скрипт развернет базовую инфраструктуру и создаст YAML-файлы в директории `config` с описанием созданных ресурсов. Вы можете отредактировать скрипт, чтобы создать дополнительные каталоги с нужными ресурсами. Например, добавить еще одно тестовое окружение.

   {% note warning %}

   В конце выполнения скрипт выведет переменные окружения для GitLab и их значения. Сохраните их, они потребуются в дальнейшем.

   {% endnote %}

1. [Создайте сервисные аккаунты](../../iam/operations/sa/create.md):
   * Сервисный аккаунт для ресурсов с [ролью](../../iam/concepts/access-control/roles.md) [editor](../../iam/roles-reference.md#editor) на каталог, в котором создается [кластер Yandex Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#kubernetes-cluster). От его имени будут создаваться ресурсы, необходимые кластеру Managed Service for Kubernetes.
   * Сервисный аккаунт для [узлов](../../managed-kubernetes/concepts/index.md#node-group) с ролью [container-registry.images.puller](../../container-registry/security/index.md#choosing-roles) на каталог с реестром Docker-образов. От его имени узлы будут скачивать из реестра необходимые Docker-образы.

   Вы можете использовать один и тот же сервисный аккаунт для обеих операций.
1. [Создайте кластер Managed Service for Kubernetes](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md). При создании кластера укажите ранее созданные сервисные аккаунты для ресурсов и узлов.
1. [Настройте группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) для работы кластера Managed Service for Kubernetes.
1. [Настройте группу безопасности](../../managed-gitlab/operations/configure-security-group.md) для работы [инстанса Yandex Managed Service for GitLab](../../managed-gitlab/concepts/index.md#instance).

## Создайте инстанс GitLab {#create-gitlab}

Создайте инстанс Managed Service for GitLab или [виртуальную машину](../../compute/concepts/vm.md) с [образом](../../compute/concepts/image.md) GitLab в той же [облачной сети](../../vpc/concepts/network.md#network), где расположен кластер Managed Service for Kubernetes.

{% list tabs group=gl_installation %}

- Инстанс Managed Service for GitLab {#instance-mgl}

  Создайте инстанс Managed Service for GitLab [согласно инструкции](../../managed-gitlab/quickstart.md#instance-create).

- ВМ с образом GitLab {#gl-image-vm}

  Запустите GitLab на ВМ с [публичным IP-адресом](../../vpc/concepts/address.md#public-addresses).

  1. На странице [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления](https://console.yandex.cloud) нажмите кнопку **Создать ресурс** и выберите `Виртуальная машина`.
  1. В блоке **Образ загрузочного диска** в поле **Поиск продукта** введите `Gitlab` и выберите публичный образ [GitLab](https://yandex.cloud/ru/marketplace/products/yc/gitlab).
  1. В блоке **Расположение** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой будет находиться ВМ. Если вы не знаете, какая зона доступности вам нужна, оставьте выбранную по умолчанию.
  1. В блоке **Вычислительные ресурсы** перейдите на вкладку `Своя конфигурация` и укажите необходимую [платформу](../../compute/concepts/vm-platforms.md), количество vCPU и объем RAM:
  
      * **Платформа** — `Intel Ice Lake`.
      * **vCPU** — `4`.
      * **Гарантированная доля vCPU** — `100%`.
      * **RAM** — `8 ГБ`.
  
  1. В блоке **Сетевые настройки**:
      
      * В поле **Подсеть** выберите сеть и подсеть, к которым нужно подключить ВМ. Если нужной [сети](../../vpc/concepts/network.md#network) или [подсети](../../vpc/concepts/network.md#subnet) еще нет, [создайте их](../../vpc/operations/subnet-create.md).
      * В поле **Публичный IP-адрес** оставьте значение `Автоматически`, чтобы назначить ВМ случайный внешний IP-адрес из пула Yandex Cloud, или выберите статический адрес из списка, если вы зарезервировали его заранее.
  
  1. В блоке **Доступ** выберите вариант **SSH-ключ** и укажите данные для доступа на ВМ:
  
      * В поле **Логин** введите имя пользователя. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
      * В поле **SSH-ключ** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../organization/concepts/membership.md).
        
        Если в вашем профиле нет сохраненных SSH-ключей или вы хотите добавить новый ключ:
        
        1. Нажмите кнопку **Добавить ключ**.
        1. Задайте имя SSH-ключа.
        1. Выберите вариант:
        
            * `Ввести вручную` — вставьте содержимое открытого [SSH](../../glossary/ssh-keygen.md)-ключа. Пару SSH-ключей необходимо [создать](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) самостоятельно.
            * `Загрузить из файла` — загрузите открытую часть SSH-ключа. Пару SSH-ключей необходимо создать самостоятельно.
            * `Сгенерировать ключ` — автоматическое создание пары SSH-ключей.
            
              При добавлении сгенерированного SSH-ключа будет создан и загружен архив с парой ключей. В ОС на базе Linux или macOS распакуйте архив в папку `/home/<имя_пользователя>/.ssh`. В ОС Windows распакуйте архив в папку `C:\Users\<имя_пользователя>/.ssh`. Дополнительно вводить открытый ключ в консоли управления не требуется.
        
        1. Нажмите кнопку **Добавить**.
        
        SSH-ключ будет добавлен в ваш профиль пользователя организации. Если в организации [отключена](../../organization/operations/os-login-access.md) возможность добавления пользователями SSH-ключей в свои профили, добавленный открытый SSH-ключ будет сохранен только в профиле пользователя внутри создаваемого ресурса.
  
  1. В блоке **Общая информация** задайте имя ВМ: `ci-tutorial-gitlab`.
  1. Нажмите кнопку **Создать ВМ**.
  
  Создание ВМ может занять несколько минут. Когда ВМ перейдет в статус `RUNNING` и запустится GitLab, настройте его.

{% endlist %}

## Настройте GitLab {#configure-gitlab}

Чтобы настроить GitLab и подготовить процесс непрерывной интеграции ([Continuous Integration](https://yandex.cloud/ru/blog/posts/2022/10/ci-cd), CI), создайте новый проект и введите параметры для аутентификации в CI:

{% list tabs group=gl_installation %}

- Инстанс Managed Service for GitLab {#instance-mgl}

  1. Авторизуйтесь в веб-интерфейсе [инстанса Managed Service for GitLab](../../managed-gitlab/concepts/index.md#instance).
  1. Нажмите кнопку **Create a project**.
  1. Нажмите кнопку **Create blank project**.
  1. Заполните поля:
     * **Project name** — `gitlab-test`.
     * **Project URL** — выберите пользователя-администратора в поле рядом с FQDN инстанса Managed Service for GitLab.

     Остальные поля оставьте без изменений.
  1. Нажмите кнопку **Create project**.

- ВМ с образом GitLab {#gl-image-vm}

  1. На странице сервиса Yandex Compute Cloud выберите созданную [ВМ](../../compute/concepts/vm.md) и скопируйте ее [публичный IP-адрес](../../vpc/concepts/address.md#public-addresses).
  1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к ВМ по протоколу SSH.
  1. Получите пароль администратора GitLab с помощью команды ВМ:

     ```bash
     sudo cat /etc/gitlab/initial_root_password
     ```

  1. Скопируйте пароль из строки `Password` (исключая пробелы) в буфер обмена или отдельный файл.
  1. Откройте в браузере ссылку `http://<публичный_IP-адрес_ВМ>`. Откроется веб-интерфейс GitLab.
  1. Войдите в систему с учетной записью администратора:
     * **Username or email** — `root`.
     * **Password** — пароль, скопированный ранее.

     Если вы не можете войти, [сбросьте пароль учетной записи администратора](https://docs.gitlab.com/security/reset_user_password/#reset-your-root-password).
  1. [Смените пароль учетной записи администратора](https://docs.gitlab.com/user/profile/user_passwords/#change-your-password).
  1. Повторно войдите в систему с учетной записью администратора, используя новый пароль.
  1. Выберите **Create a project**.
  1. Задайте имя проекта: `gitlab-test`.
  1. Нажмите кнопку **Create project**.

{% endlist %}

## Создайте GitLab Runner {#runners}

Чтобы запускать задачи сборки в [кластере Yandex Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), создайте [GitLab Runner](https://docs.gitlab.com/runner/install/kubernetes/). Для этого установите приложение GitLab Runner согласно [инструкции](../../managed-kubernetes/operations/applications/gitlab-runner.md).

После установки вы можете запускать автоматизированные сборки внутри своего [кластера Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).

Подробнее про установку и настройку GitLab Runner читайте в [документации GitLab](https://docs.gitlab.com/runner/install/).

## Загрузите файлы в репозиторий GitLab {#add-files}

1. [Добавьте SSH-ключ для безопасного доступа к GitLab](https://docs.gitlab.com/user/ssh/).
1. [Склонируйте репозиторий](https://docs.gitlab.com/topics/git/clone/) `gitlab-test` с помощью [SSH](../../glossary/ssh-keygen.md).
1. Скопируйте все файлы из репозитория `yc-serverless-gitlab-ci-cd` в `gitlab-test`.
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

## Создайте переменные окружения GitLab {#add-variables}

1. На панели слева в GitLab перейдите в раздел **Settings** и во всплывающем списке выберите пункт **CI/CD**.
1. Нажмите кнопку **Expand** напротив пункта **Variables**.
1. Добавьте переменные окружения с выключенной опцией защиты. Все необходимые переменные и их значения были выведены в конце выполнения скрипта `bootstrap.sh`:
   * `cloud_id` — идентификатор вашего облака.
   * `CI_REGISTRY` — идентификатор реестра Container Registry в каталоге `infra` с префиксом `cr.yandex/`.
   * `CI_REGISTRY_KEY` — [ключ](../../iam/concepts/users/service-accounts.md#sa-key) сервисного аккаунта `builder`.
   * `cart_prod` — имя продакшн каталога в Yandex Cloud.
   * `DOCAPI_ENDPOINT_prod` — Document API эндпоинт БД [Yandex Managed Service for YDB](../../ydb/index.md) в каталоге `prod`.
   * `PROD_SA_ID` — идентификатор сервисного аккаунта `deployer` в каталоге `prod`.
   * `SA_PROD_DEPLOYER_PRIVATE_KEY` — ключ сервисного аккаунта `deployer` в каталоге `prod`.
   * `prod_container_id` — идентификатор контейнера Serverless Containers в каталоге `prod`.
   * `cart_testing` — имя тестового каталога в Yandex Cloud.
   * `DOCAPI_ENDPOINT_testing` — Document API эндпоинт БД Managed Service for YDB в каталоге `testing`.
   * `TESTING_SA_ID` — идентификатор сервисного аккаунта `deployer` в каталоге `testing`.
   * `SA_TESTING_DEPLOYER_PRIVATE_KEY` — ключ сервисного аккаунта `deployer` в каталоге `testing`.

   Для добавления переменной:
   1. Нажмите кнопку **Add variable**.
   1. В появившемся окне в поле **Key** укажите имя переменной, в поле **Value** — значение переменной.
   1. Выключите опцию **Protect variable**.
   1. Нажмите кнопку **Add variable**.

## Создайте файл конфигурации сценария CI {#add-ci}

1. Откройте проект `gitlab-test`.
1. В строке навигации по репозиторию нажмите кнопку ![image](../../_assets/console-icons/plus.svg) и в выпадающем меню выберите пункт **New file**.
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
       - curl --fail -silent --location --remote-name https://storage.yandexcloud.net/yandexcloud-yc/install.sh
       - bash install.sh -i /usr/local/yandex-cloud -n
       - ln -s /usr/local/yandex-cloud/bin/yc /usr/local/bin/yc
    # Аутентификация с помощью ключа сервисного аккаунта.
       - echo "$SA_TESTING_DEPLOYER_PRIVATE_KEY" > key.json
       - yc config profile create sa-profile
       - yc config set service-account-key key.json
   # Установка переменных для развертывания API Gateway и создание контейнера.
       - export sa_id=$TESTING_SA_ID
       - export container_id=$(yc serverless container create --name testing --cloud-id ${cloud_id} --folder-name ${cart_testing} | yq .id)
   # Развертывание ревизии.
       - yc serverless container revision deploy --container-name testing --image "${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}" --cores 1 --memory 512mb --concurrency 1 --execution-timeout 10s --cloud-id ${cloud_id} --folder-name ${cart_testing} --service-account-id ${TESTING_SA_ID} --environment DOCAPI_ENDPOINT=${DOCAPI_ENDPOINT_testing},DB_TABLE_PREFIX='' --secret environment-variable=AWS_ACCESS_KEY_ID,name=cart-app,key=AWS_ACCESS_KEY_ID --secret environment-variable=AWS_SECRET_ACCESS_KEY,name=cart-app,key=AWS_SECRET_ACCESS_KEY --secret environment-variable=SECRET_KEY,name=cart-app,key=SECRET_KEY
   # Настройка шаблона и развертывание API Gateway.
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
       - curl --fail --silent --location --remote-name https://storage.yandexcloud.net/yandexcloud-yc/install.sh
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
       - curl --fail --silent --location --remote-name https://storage.yandexcloud.net/yandexcloud-yc/install.sh
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
* **build** — сборка Docker-образа с использованием `Dockerfile` и загрузка образа в Container Registry.
* **deploy-test-env** — тестовое развертывание приложения. Дополнительно описан, но не использован механизм [artifacts](https://docs.gitlab.com/ci/jobs/job_artifacts/) для передачи данных из одного этапа в другой. При необходимости настройте его.
* **test** — тестирование приложения. В качестве тестов приведены имитации e2e и нагрузочного тестирования. Опишите и настройте собственные тесты.
* **delete-test-env** — удаление тестового приложения.
* **release** — продакшн развертывание приложения. Дополнительно на этом этапе используются [среды развертывания](https://docs.gitlab.com/ci/environments/). Они создаются и сохраняются при каждом успешном выполнении пайплайна. Воспользуйтесь ими, чтобы восстановить и развернуть прошлую версию приложения.

После сохранения файла конфигурации `.gitlab-ci.yml` запустится сценарий сборки.

## Проверьте результат {#check-result}

Чтобы проверить результаты выполнения сценария сборки, на панели слева в проекте `gitlab-test` выберите пункт **Build**, в выпадающем меню выберите пункт **Pipelines**. Все пять этапов должны успешно завершиться.

Приложение будет доступно по адресу служебного домена API-шлюза API Gateway в каталоге `prod`. Адрес можно посмотреть в [консоли управления](https://console.yandex.cloud) или в значении поля `domain` в логе выполнения скрипта `bootstrap.sh`.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:
1. [Удалите каталоги](../../resource-manager/operations/folder/delete.md) `prod`, `testing` и `infra` вместе с ресурсами в них.
1. [Удалите инстанс Managed Service for GitLab](../../managed-gitlab/operations/instance/instance-delete.md) или [созданную ВМ с образом GitLab](../../compute/operations/vm-control/vm-delete.md).
1. [Удалите кластер Managed Service for Kubernetes](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. Если вы зарезервировали для кластера публичный статический IP-адрес, [удалите его](../../vpc/operations/address-delete.md).
1. [Удалите сервисные аккаунты](../../iam/operations/sa/delete.md).