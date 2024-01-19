[{{ GL }}](https://about.gitlab.com/) — инструмент [непрерывной интеграции (Continuous integration, CI)](/blog/posts/2022/10/ci-cd).

В этом руководстве описаны:
* Сборка приложения в [Docker-контейнер](/blog/posts/2022/03/docker-containers).
* Развертывание приложения из контейнера в [кластере {{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) через {{ GL }} с помощью инструментов {{ yandex-cloud }}.

После каждого коммита в {{ GL }}:
* Выполнится сценарий, в котором описаны шаги сборки [Docker-образа](../../container-registry/concepts/docker-image.md).
* Применится новая конфигурация кластера {{ managed-k8s-name }}, в которой будет указано приложение для развертывания.

Чтобы настроить необходимую инфраструктуру для хранения исходного кода, сборки Docker-образа и развертывания приложения:
1. [Подготовьте облако к работе](#before-you-begin).

   
   1. [Изучите список необходимых платных ресурсов](#paid-resources).


1. [Подготовьте инфраструктуру](#deploy-infrastructure).
1. [Создайте инстанс {{ GL }}](#create-gitlab).
1. [Настройте {{ GL }}](#configure-gitlab).
1. [Создайте тестовое приложение](#app-create).
1. [Создайте {{ GLR }}](#runner).
1. [Настройте аутентификацию {{ k8s }} в {{ GL }}](#gitlab-authentication).
1. [Настройте сценарий CI](#ci).
1. [Проверьте результат](#check-result).

Если созданные ресурсы больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит плата за следующие ресурсы:
* [Диски](../../compute/concepts/disk.md) и постоянно запущенные [виртуальные машины](../../compute/concepts/vm.md) (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Использование динамического [публичного IP-адреса](../../vpc/concepts/ips.md) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).
* Хранение созданных Docker-образов (см. [тарифы {{ container-registry-name }}](../../container-registry/pricing.md)).
* Использование [мастера {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#master) (см. [тарифы {{ managed-k8s-name }}](../../managed-kubernetes/pricing.md)).


{% include [deploy-infrastructure](../../_includes/managed-gitlab/deploy-infrastructure.md) %}

{% include [prepare](../../_includes/managed-gitlab/prepare.md) %}

{% include [create-gitlab](../../_includes/managed-gitlab/create-gitlab.md) %}

{% include [Create a project](../../_includes/managed-gitlab/initialize.md) %}

{% include [app-create](../../_includes/managed-gitlab/app-create.md) %}

{% include [create glr](../../_includes/managed-gitlab/k8s-runner.md) %}

## Настройте аутентификацию {{ k8s }} в {{ GL }} {#gitlab-authentication}

Настроить аутентификацию в {{ GL }} можно с помощью токена сервисного аккаунта {{ k8s }} или приложения [{{ GLA }}](/marketplace/products/yc/gitlab-agent):

{% list tabs %}

- Токен сервисного аккаунта

   {% include notitle [k8s-get-token](../../_includes/managed-gitlab/k8s-get-token.md) %}

- {{ GLA }}

   {% include notitle [create gla](../../_includes/managed-gitlab/k8s-agent.md) %}

{% endlist %}

## Настройте сценарий CI {#ci}

1. Создайте [переменные окружения {{ GL }}](https://docs.gitlab.com/ee/ci/variables/README.html):
   1. На панели слева в {{ GL }} перейдите в раздел **Settings** и во всплывающем списке выберите пункт **CI/CD**.
   1. Нажмите кнопку **Expand** напротив пункта **Variables**.
   1. Добавьте переменные окружения в зависимости от способа аутентификации {{ k8s }} в {{ GL }}:

      {% list tabs %}

      - Токен сервисного аккаунта

        * `KUBE_URL` — адрес мастера {{ managed-k8s-name }}. Узнайте его с помощью команды:

          ```bash
          yc managed-kubernetes cluster get <идентификатор_или_имя_кластера> --format=json \
             | jq -r .master.endpoints.external_v4_endpoint
          ```

        * `KUBE_TOKEN` — токен, который {{ GL }} будет использовать для применения конфигурации. Используйте токен, полученный ранее.

      - {{ GLA }}

      {% endlist %}

      * `CI_REGISTRY` — адрес созданного ранее реестра в формате `{{ registry }}/<идентификатор_реестра>`.
      * `CI_REGISTRY_KEY` — ключ, который {{ GL }} будет использовать для доступа к реестру. Скопируйте содержимое файла статического ключа `key.json` для доступа к реестру, полученного ранее.

      Для добавления переменной:
      * Нажмите кнопку **Add variable**.
      * В появившемся окне в поле **Key** укажите имя переменной, в поле **Value** — значение переменной.
      * Нажмите кнопку **Add variable**.
1. Создайте файл конфигурации сценария CI:
   1. На панели слева в {{ GL }} перейдите в раздел **Repository** и выберите вкладку **Files**.
   1. Справа от имени проекта нажмите кнопку ![image](../../_assets/console-icons/plus.svg) и в выпадающем меню выберите пункт **New file**.
   1. Назовите файл `.gitlab-ci.yml`. Добавьте в него шаги сборки и загрузки Docker-образа и обновления конфигурации приложения в кластере {{ managed-k8s-name }}. Структура файла зависит от способа аутентификации {{ k8s }} в {{ GL }}:

      {% list tabs %}

      - Токен сервисного аккаунта

        * Для сборки контейнера с помощью `kaniko` без использования привилегированного режима {{ GLR }}:

          {% cut ".gitlab-ci.yml" %}

          ```yaml
          stages:
            - build
            - deploy

          build:
            stage: build
            image:
              name: gcr.io/kaniko-project/executor:debug
              entrypoint: [""]
            script:
              - mkdir -p /kaniko/.docker
              - echo "{\"auths\":{\"${CI_REGISTRY}\":{\"auth\":\"$(echo -n "json_key:${CI_REGISTRY_KEY}" | base64 | tr -d '\n' )\"}}}" > /kaniko/.docker/config.json
              - >-
                /kaniko/executor
                --context "${CI_PROJECT_DIR}"
                --dockerfile "${CI_PROJECT_DIR}/Dockerfile"
                --destination "${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}"

          deploy:
            image: gcr.io/cloud-builders/kubectl:latest
            stage: deploy
            script:
              - kubectl config set-cluster k8s --server="$KUBE_URL" --insecure-skip-tls-verify=true
              - kubectl config set-credentials admin --token="$KUBE_TOKEN"
              - kubectl config set-context default --cluster=k8s --user=admin
              - kubectl config use-context default
              - sed -i "s,__VERSION__,${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}," k8s.yaml
              - kubectl apply -f k8s.yaml
          ```

          {% endcut %}

        * Для сборки контейнера с помощью `docker:dind` c использованием привилегированного режима {{ GLR }}:

          {% cut ".gitlab-ci.yml" %}

          ```yaml
          stages:
            - build
            - deploy

          image: docker:20.10.16

          variables:
            DOCKER_HOST: tcp://docker:2376
            DOCKER_TLS_CERTDIR: "/certs"
            DOCKER_TLS_VERIFY: 1
            DOCKER_CERT_PATH: "$DOCKER_TLS_CERTDIR/client"
            DOCKER_DRIVER: overlay2

          services:
            - docker:20.10.16-dind

          before_script:
            - for try in {1..10}; do sleep 0.5; docker info && break ; done

          build:
            stage: build
            script:
              - echo "${CI_REGISTRY_KEY}" | docker login ${CI_REGISTRY} -u json_key --password-stdin
              - >-
                docker build
                "${CI_PROJECT_DIR}"
                --file "${CI_PROJECT_DIR}/Dockerfile"
                --tag "${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}"
              - docker push "${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}"

          deploy:
            image: gcr.io/cloud-builders/kubectl:latest
            stage: deploy
            script:
              - kubectl config set-cluster k8s --server="$KUBE_URL" --insecure-skip-tls-verify=true
              - kubectl config set-credentials admin --token="$KUBE_TOKEN"
              - kubectl config set-context default --cluster=k8s --user=admin
              - kubectl config use-context default
              - sed -i "s,__VERSION__,${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}," k8s.yaml
              - kubectl apply -f k8s.yaml
          ```

          {% endcut %}

      - {{ GLA }}

        * Для сборки контейнера с помощью `kaniko` без использования привилегированного режима {{ GLR }}:

          {% cut ".gitlab-ci.yml" %}

          ```yaml
          stages:
            - build
            - deploy

          build:
            stage: build
            image:
              name: gcr.io/kaniko-project/executor:debug
              entrypoint: [""]
            script:
              - mkdir -p /kaniko/.docker
              - echo "{\"auths\":{\"${CI_REGISTRY}\":{\"auth\":\"$(echo -n "json_key:${CI_REGISTRY_KEY}" | base64 | tr -d '\n' )\"}}}" > /kaniko/.docker/config.json
              - >-
                /kaniko/executor
                --context "${CI_PROJECT_DIR}"
                --dockerfile "${CI_PROJECT_DIR}/Dockerfile"
                --destination "${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}"

          deploy:
            image: bitnami/kubectl:latest
            stage: deploy
            script:
              - kubectl config use-context ${CI_PROJECT_PATH}:<имя_GitLab_Agent>
              - cat k8s.yaml | sed -e "s,__VERSION__,${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}," | kubectl apply -f -
          ```

          {% endcut %}

        * Для сборки контейнера с помощью `docker:dind` с использованием привилегированного режима {{ GLR }}:

          {% cut ".gitlab-ci.yml" %}

          ```yaml
          stages:
            - build
            - deploy

          image: docker:20.10.16

          variables:
            DOCKER_HOST: tcp://docker:2376
            DOCKER_TLS_CERTDIR: "/certs"
            DOCKER_TLS_VERIFY: 1
            DOCKER_CERT_PATH: "$DOCKER_TLS_CERTDIR/client"
            DOCKER_DRIVER: overlay2

          services:
            - docker:20.10.16-dind

          before_script:
            - for try in {1..10}; do sleep 0.5; docker info && break ; done

          build:
            stage: build
            script:
              - echo "${CI_REGISTRY_KEY}" | docker login ${CI_REGISTRY} -u json_key --password-stdin
              - >-
                docker build
                "${CI_PROJECT_DIR}"
                --file "${CI_PROJECT_DIR}/Dockerfile"
                --tag "${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}"
              - docker push "${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}"

          deploy:
            image: bitnami/kubectl:latest
            stage: deploy
            script:
              - kubectl config use-context ${CI_PROJECT_PATH}:<имя_GitLab_Agent>
              - cat k8s.yaml | sed -e "s,__VERSION__,${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}," | kubectl apply -f -
          ```

          {% endcut %}

        Вместо `<имя_GitLab_Agent>` укажите имя агента в {{ mgl-name }}.

      {% endlist %}

   1. Напишите комментарий к коммиту в поле **Commit message**: `CI scripts`.
   1. Нажмите кнопку **Commit changes**.

   В файле `.gitlab-ci.yml` описаны два шага сборки проекта:
   * Сборка Docker-образа с использованием `Dockerfile` и загрузка образа в {{ container-registry-name }}.
   * Настройка окружения для работы с {{ k8s }} и применение конфигурации `k8s.yaml` к кластеру {{ managed-k8s-name }}. Таким образом приложение развертывается на созданном ранее кластере {{ managed-k8s-name }}.

## Проверьте результат {#check-result}

1. После сохранения файла конфигурации `.gitlab-ci.yml` запустится сценарий сборки. Чтобы проверить результаты его выполнения, на панели слева в {{ GL }} выберите в выпадающем меню пункт **CI/CD** → **Pipelines** и дождитесь успешного завершения обоих этапов сборки.
1. Чтобы проверить работу созданного приложения в кластере {{ managed-k8s-name }}, посмотрите логи контейнера в кластере:

   ```bash
   kubectl logs deployment/hello-world-deployment -n hello-world
   ```

   Результат:

   ```text
   Hello
   ```

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, во избежание списания средств за них:
1. [Удалите созданные Docker-образы](../../container-registry/operations/docker-image/docker-image-delete.md).
1. Удалите кластер {{ managed-k8s-name }} и реестр {{ container-registry-name }}:

   {% list tabs group=instructions %}

   - Вручную {#manual}

     1. [Удалите кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
     1. [Удалите реестр {{ container-registry-name }}](../../container-registry/operations/registry/registry-delete.md).
     1. [Удалите созданные подсети](../../vpc/operations/subnet-delete.md) и [сети](../../vpc/operations/network-delete.md).
     1. [Удалите созданные сервисные аккаунты](../../iam/operations/sa/delete.md).

   - {{ TF }} {#tf}

     1. В командной строке перейдите в директорию, в которой расположен актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
     1. Удалите конфигурационный файл `k8s-and-registry-for-gitlab.tf`.
     1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `k8s-and-registry-for-gitlab.tf`, будут удалены.

   {% endlist %}

1. [Удалите созданную ВМ {{ GL }}](../../compute/operations/vm-control/vm-delete.md) или инстанс {{ mgl-name }}.

## См. также {#see-also}

* [Создание тестовых ВМ через {{ GL }} CI](../../tutorials/testing/ci-for-snapshots.md).