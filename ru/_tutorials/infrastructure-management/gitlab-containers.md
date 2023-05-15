[{{ GL }}](https://about.gitlab.com/) — инструмент [непрерывной интеграции (Continuous integration, CI)](/blog/posts/2022/10/ci-cd).

В этом руководстве описаны:
* Сборка приложения в [Docker-контейнер](/blog/posts/2022/03/docker-containers).
* Развертывание приложения из контейнера в [кластере {{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) через {{ GL }} с помощью инструментов {{ yandex-cloud }}.

После каждого коммита в {{ GL }}:
* Выполнится сценарий, в котором описаны шаги сборки [Docker-образа](../../container-registry/concepts/docker-image.md).
* Применится новая конфигурация кластера {{ managed-k8s-name }}, в которой будет указано приложение для развертывания.

Чтобы настроить необходимую инфраструктуру для хранения исходного кода, сборки Docker-образа и развертывания приложения:
1. [Создайте инстанс {{ GL }}](#create-gitlab).
1. [Настройте {{ GL }}](#configure-gitlab).
1. [Создайте тестовое приложение](#app-create).
1. [Создайте {{ GLR }}](#runner).
1. [Настройте сценарий CI](#ci).
1. [Проверьте результат](#check-result).

Если созданные ресурсы больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит плата за следующие ресурсы:
* [Диски](../../compute/concepts/disk.md) и постоянно запущенные [виртуальные машины](../../compute/concepts/vm.md) (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Использование динамического [публичного IP-адреса](../../vpc/concepts/ips.md) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).
* Хранение созданных Docker-образов (см. [тарифы {{ container-registry-name }}](../../container-registry/pricing.md)).
* Использование [мастера {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#master) (см. [тарифы {{ managed-k8s-name }}](../../managed-kubernetes/pricing.md)).


{% include [deploy-infrastructure](../../_includes/managed-gitlab/deploy-infrastructure.md) %}

{% include [prepare](../../_includes/managed-gitlab/prepare.md) %}

{% include [k8s-get-token](../../_includes/managed-gitlab/k8s-get-token.md) %}

{% include [create-gitlab](../../_includes/managed-gitlab/create-gitlab.md) %}

{% include [Create a project](../../_includes/managed-gitlab/initialize.md) %}

{% include [app-create](../../_includes/managed-gitlab/app-create.md) %}

{% include [create glr](../../_includes/managed-gitlab/k8s-runner.md) %}

## Настройте сценарий CI {#ci}

1. Создайте [переменные окружения {{ GL }}](https://docs.gitlab.com/ee/ci/variables/README.html):
   1. На панели слева в {{ GL }} перейдите в раздел **Settings** и во всплывающем списке выберите пункт **CI/CD**.
   1. Нажмите кнопку **Expand** напротив пункта **Variables**.
   1. Добавьте две переменные окружения:
      * `KUBE_URL` — адрес [мастера {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#master). Узнайте его с помощью команды:

        ```bash
        yc managed-kubernetes cluster get <идентификатор или имя кластера {{ k8s }}> --format=json \
           | jq -r .master.endpoints.external_v4_endpoint
        ```

      * `KUBE_TOKEN` — токен, который будет использовать {{ GL }} для применения конфигурации. Используйте токен, полученный ранее.

      Для добавления переменной:
      * Нажмите кнопку **Add variable**.
      * В появившемся окне в поле **Key** укажите имя переменной, в поле **Value** — значение переменной.
      * Нажмите кнопку **Add variable**.
1. Создайте файл конфигурации сценария CI:
   1. На панели слева в {{ GL }} перейдите в раздел **Repository** и выберите вкладку **Files**.
   1. Справа от имени проекта нажмите кнопку ![image](../../_assets/plus.svg) и в выпадающем меню выберите пункт **New file**.
   1. Назовите файл `.gitlab-ci.yml`. Добавьте в него шаги сборки и загрузки [Docker-образа](../../container-registry/concepts/docker-image.md) и обновления конфигурации приложения в кластере {{ managed-k8s-name }}:

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
          # Install jq.
          - wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 && chmod +x ./jq && cp jq /kaniko
          # Get a service account token from metadata.
          - wget --header Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token && cp token /kaniko
          - echo "{\"auths\":{\"cr.yandex\":{\"auth\":\"$(printf "%s:%s" "iam" "$(cat /kaniko/token | ./jq -r '.access_token')" | base64 | tr -d '\n')\"}}}" > /kaniko/.docker/config.json
          - >-
            /kaniko/executor
            --context "${CI_PROJECT_DIR}"
            --dockerfile "${CI_PROJECT_DIR}/Dockerfile"
            --destination "cr.yandex/<идентификатор реестра>/hello:gitlab-$CI_COMMIT_SHORT_SHA"
          # Delete the metadata file.
          - rm /kaniko/token

      deploy:
        image: gcr.io/cloud-builders/kubectl:latest
        stage: deploy
        script:
          - kubectl config set-cluster k8s --server="$KUBE_URL" --insecure-skip-tls-verify=true
          - kubectl config set-credentials admin --token="$KUBE_TOKEN"
          - kubectl config set-context default --cluster=k8s --user=admin
          - kubectl config use-context default
          - sed -i "s/__VERSION__/gitlab-$CI_COMMIT_SHORT_SHA/" k8s.yaml
          - kubectl apply -f k8s.yaml
      ```

      {% endcut %}

   1. Вместо `<идентификатор реестра>` укажите идентификатор созданного ранее реестра {{ container-registry-name }}.
   1. Напишите комментарий к коммиту в поле **Commit message**: `CI scripts`.
   1. Нажмите кнопку **Commit changes**.

   В файле `.gitlab-ci.yml` описаны два шага сборки проекта:
   * Сборка Docker-образа с использованием `Dockerfile` и загрузка образа в {{ container-registry-name }}.
   * Настройка окружения для работы с {{ k8s }} и применение конфигурации `k8s.yaml` к кластеру {{ managed-k8s-name }}. Таким образом приложение развертывается на созданном ранее кластере.

## Проверьте результат {#check-result}

1. После сохранения файла конфигурации `.gitlab-ci.yml` запустится сценарий сборки. Чтобы проверить результаты его выполнения, на панели слева в {{ GL }} выберите в выпадающем меню пункт **CI/CD** → **Pipelines** и дождитесь успешного завершения обоих этапов сборки.
1. Чтобы проверить работу созданного приложения в кластере {{ managed-k8s-name }}, посмотрите логи контейнера в кластере {{ k8s }}:

   ```bash
   kubectl logs deployment/hello-world-deployment -n hello-world
   ```

   Результат:

   ```text
   Hello
   ```

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:
1. [Удалите созданные Docker-образы](../../container-registry/operations/docker-image/docker-image-delete.md).
1. Удалите кластер {{ managed-k8s-name }} и реестр {{ container-registry-name }}:

   {% list tabs %}

   - Вручную

     1. [Удалите кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
     1. [Удалите реестр {{ container-registry-name }}](../../container-registry/operations/registry/registry-delete.md).
     1. [Удалите созданные подсети](../../vpc/operations/subnet-delete.md) и [сети](../../vpc/operations/network-delete.md).
     1. [Удалите созданные сервисные аккаунты](../../iam/operations/sa/delete.md).

   - С помощью {{ TF }}

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