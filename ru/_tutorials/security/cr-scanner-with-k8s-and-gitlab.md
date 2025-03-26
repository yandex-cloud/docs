# Сканирование уязвимостей {{ container-registry-name }} при непрерывном развертывании приложений {{ managed-k8s-name }} с помощью {{ GL }}


Вы можете [сканировать уязвимости](../../container-registry/concepts/vulnerability-scanner.md) [Docker-образов](../../container-registry/concepts/docker-image.md) в [{{ container-registry-full-name }}](../../container-registry/) при непрерывном развертывании приложений [{{ managed-k8s-full-name }}](../../managed-kubernetes/) через {{ GL }}.

Для этого с помощью непрерывной интеграции ([Continuous Integration](/blog/posts/2022/10/ci-cd), CI) в {{ GL }} создается специальный сценарий, который запускается после каждого коммита:
1. Сборка приложения в Docker-образ и загрузка образа в {{ container-registry-name }}.
1. Сканирование Docker-образа в {{ container-registry-name }} на наличие уязвимостей.
1. Развертывание приложения из Docker-образа в [кластере {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) с помощью инструментов {{ yandex-cloud }}.

Чтобы настроить сканер уязвимостей:
1. [Создайте инстанс {{ GL }}](#create-gitlab).
1. [Настройте {{ GL }}](#configure-gitlab).
1. [Создайте тестовое приложение](#app-create).
1. [Создайте {{ GLR }}](#runners).
1. [Настройте сценарий CI](#ci).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:

* Плата за [диски](../../compute/concepts/disk.md) и постоянно запущенные ВМ (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за хранение созданных Docker-образов и сканер уязвимостей (см. [тарифы {{ container-registry-name }}](../../container-registry/pricing.md)).
* Плата за использование [мастера {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#master) (см. [тарифы {{ managed-k8s-name }}](../../managed-kubernetes/pricing.md)).
* Плата за использование [публичных IP-адресов](../../vpc/concepts/address.md#public-addresses) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md#prices-public-ip)).

## Перед началом работы {#before-begin}

{% include [deploy-infrastructure](../../_includes/managed-gitlab/deploy-infrastructure.md) %}

Дополнительно [назначьте](../../iam/operations/sa/assign-role-for-sa.md#binding-role-resource) сервисному аккаунту для узлов роль `container-registry.images.scanner`. Она позволяет сканировать Docker-образы на наличие уязвимостей.

{% include [prepare](../../_includes/managed-gitlab/prepare.md) %}

{% include [create-gitlab](../../_includes/managed-gitlab/create-gitlab.md) %}

{% include [Create a project](../../_includes/managed-gitlab/initialize.md) %}

{% include [app-create](../../_includes/managed-gitlab/app-create.md) %}

{% include [create glr](../../_includes/managed-gitlab/k8s-runner.md) %}

## Настройте аутентификацию {{ k8s }} в {{ GL }} {#gitlab-authentication}

Настроить аутентификацию в {{ GL }} можно с помощью токена сервисного аккаунта {{ k8s }} или приложения [{{ GLA }}](/marketplace/products/yc/gitlab-agent):

{% list tabs group=gl_auth %}

- Токен сервисного аккаунта {#token}

  {% include notitle [k8s-get-token](../../_includes/managed-gitlab/k8s-get-token.md) %}

- {{ GLA }} {#gla}

  {% include notitle [create gla](../../_includes/managed-gitlab/k8s-agent.md) %}

{% endlist %}

## Настройте сценарий CI {#ci}

1. Создайте [переменные окружения {{ GL }}]({{ gl.docs }}/ee/ci/variables/):
   1. На панели слева в {{ GL }} перейдите в раздел **Settings** и во всплывающем списке выберите пункт **CI/CD**.
   1. Нажмите кнопку **Expand** напротив пункта **Variables**.
   1. Добавьте переменные окружения в зависимости от способа аутентификации {{ managed-k8s-name }} в {{ GL }}:

      {% list tabs group=gl_auth %}

      - Токен сервисного аккаунта {#token}

        * `KUBE_URL` — адрес [мастера {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#master). Узнайте его с помощью команды:

          ```bash
          yc managed-kubernetes cluster get <имя_или_идентификатор_кластера> --format=json \
             | jq -r .master.endpoints.external_v4_endpoint
          ```

        * `KUBE_TOKEN` — токен, который {{ GL }} будет использовать для применения конфигурации. Используйте токен, полученный ранее.

      - {{ GLA }} {#gla}

      {% endlist %}

      * `CI_REGISTRY` — адрес созданного ранее [реестра](../../container-registry/concepts/registry.md) в формате `{{ registry }}/<идентификатор_реестра>`.
      * `CI_REGISTRY_KEY` — ключ, который {{ GL }} будет использовать для доступа к реестру. Скопируйте содержимое файла статического ключа `key.json` для доступа к реестру, полученного ранее.

      Для добавления переменной:
      * Нажмите кнопку **Add variable**.
      * В появившемся окне в поле **Key** укажите имя переменной, в поле **Value** — значение переменной.
      * Нажмите кнопку **Add variable**.
1. Создайте файл конфигурации сценария CI:
   1. Откройте проект `gitlab-test`.
   1. В строке навигации по репозиторию нажмите кнопку ![image](../../_assets/console-icons/plus.svg) и в выпадающем меню выберите пункт **New file**.
   1. Назовите файл `.gitlab-ci.yml`. Добавьте в него шаги сборки и загрузки Docker-образа, его сканирования на наличие уязвимостей и обновления конфигурации приложения в кластере {{ managed-k8s-name }}. Структура файла зависит от способа аутентификации {{ k8s }} в {{ GL }}:

      {% list tabs group=gl_auth %}

      - Токен сервисного аккаунта {#token}

        {% cut ".gitlab-ci.yml" %}

        ```yaml
        stages:
          - build
          - test
          - deploy

        build_docker_image:
          stage: build
          variables:
            DOCKER_CUSTOM_SUBFOLDER: "" # Specify a custom path (if any) to your folder with docker files.
          image:
            name: gcr.io/kaniko-project/executor:debug
            entrypoint: [""]
          script:
            - mkdir -p /kaniko/.docker
            - echo "{\"auths\":{\"${CI_REGISTRY}\":{\"auth\":\"$(echo -n "json_key:${CI_REGISTRY_KEY}" | base64 | tr -d '\n' )\"}}}" > /kaniko/.docker/config.json
            - >-
              /kaniko/executor
              --context "${CI_PROJECT_DIR}"/"${DOCKER_CUSTOM_SUBFOLDER}"
              --dockerfile "${CI_PROJECT_DIR}/"${DOCKER_CUSTOM_SUBFOLDER}"/Dockerfile"
              --destination "${CI_REGISTRY}/${CI_COMMIT_REF_SLUG}:${CI_COMMIT_SHA}"

        container_scanning_free_yc:
          image: 
            name: pindar/jq
            entrypoint: [""]
          stage: test
          artifacts:
            when: always
            paths:
              - gl-container-scanning-report-yc.json
          script:
            - export CI_COMMIT_SHA=${CI_COMMIT_SHA}
            # Install YC CLI.
            - curl https://{{ s3-storage-host-cli }}{{ yc-install-path }} | bash -s -- -a && cp /root/yandex-cloud/bin/yc /usr/bin/
            # Start scanning.
            - echo "Scanning image $IMAGE_NAME ${CI_REGISTRY}/${CI_COMMIT_REF_SLUG}:${CI_COMMIT_SHA}..."
            - export IMAGE_ID=$(yc container image list --registry-id (${CI_REGISTRY} | cut -d/ -f2) --format=json | jq -r --arg CI_COMMIT_SHA $CI_COMMIT_SHA '.[] | select(.tags[0]==$CI_COMMIT_SHA) | .id ')
            # Make a report.
            - export SCAN_RESULT=$(yc container image scan $IMAGE_ID --format=json)
            - export CRIT_VULN=$(echo $SCAN_RESULT | jq -r '.vulnerabilities.critical // 0')
            - export HIGH_VULN=$(echo $SCAN_RESULT | jq -r '.vulnerabilities.high // 0')
            - export SCAN_ID=$(echo $SCAN_RESULT | jq -r '.id')
            - echo "Scan results:"
            - yc container image list-vulnerabilities --scan-result-id="${SCAN_ID}" --format json | jq -r '.[] | select(.severity=="CRITICAL", .severity=="HIGH")'
            - yc container image list-vulnerabilities --scan-result-id="${SCAN_ID}" --format json | jq -r '.[] | select(.severity=="CRITICAL", .severity=="HIGH")' > gl-container-scanning-report-yc.json
            # Check the result.
            - (( SUM = $CRIT_VULN + $HIGH_VULN )) && (( RES = (SUM >= 1) )) && echo $RES && echo "image has $CRIT_VULN critical vulns and $HIGH_VULN high vulns" && exit 1 || echo "image has no high or crit vulns" exit 0

        deploy:
          image: gcr.io/cloud-builders/kubectl:latest
          stage: deploy
          script:
            - kubectl config set-cluster k8s --server="$KUBE_URL" --insecure-skip-tls-verify=true
            - kubectl config set-credentials admin --token="$KUBE_TOKEN"
            - kubectl config set-context default --cluster=k8s --user=admin
            - kubectl config use-context default
            - sed -i "s,__VERSION__,${CI_REGISTRY}/${CI_COMMIT_REF_SLUG}:${CI_COMMIT_SHA}," k8s.yaml
            - kubectl apply -f k8s.yaml
        ```

        {% endcut %}

      - {{ GLA }} {#gla}

        {% cut ".gitlab-ci.yml" %}

        ```yaml
        stages:
          - build
          - test
          - deploy

        build_docker_image:
          stage: build
          variables:
            DOCKER_CUSTOM_SUBFOLDER: "" # Specify a custom path (if any) to your folder with docker files.
          image:
            name: gcr.io/kaniko-project/executor:debug
            entrypoint: [""]
          script:
            - mkdir -p /kaniko/.docker
            - echo "{\"auths\":{\"${CI_REGISTRY}\":{\"auth\":\"$(echo -n "json_key:${CI_REGISTRY_KEY}" | base64 | tr -d '\n' )\"}}}" > /kaniko/.docker/config.json
            - >-
              /kaniko/executor
              --context "${CI_PROJECT_DIR}"/"${DOCKER_CUSTOM_SUBFOLDER}"
              --dockerfile "${CI_PROJECT_DIR}/"${DOCKER_CUSTOM_SUBFOLDER}"/Dockerfile"
              --destination "${CI_REGISTRY}/${CI_COMMIT_REF_SLUG}:${CI_COMMIT_SHA}"

        container_scanning_free_yc:
          image: 
            name: pindar/jq
            entrypoint: [""]
          stage: test
          artifacts:
            when: always
            paths:
              - gl-container-scanning-report-yc.json
          script:
            - export CI_COMMIT_SHA=${CI_COMMIT_SHA}
            # Install YC CLI.
            - curl https://{{ s3-storage-host-cli }}{{ yc-install-path }} | bash -s -- -a && cp /root/yandex-cloud/bin/yc /usr/bin/
            # Start scanning.
            - echo "Scanning image $IMAGE_NAME ${CI_REGISTRY}/${CI_COMMIT_REF_SLUG}:${CI_COMMIT_SHA}..."
            - export IMAGE_ID=$(yc container image list --registry-id (${CI_REGISTRY} | cut -d/ -f2) --format=json | jq -r --arg CI_COMMIT_SHA $CI_COMMIT_SHA '.[] | select(.tags[0]==$CI_COMMIT_SHA) | .id ')
            # Make a report.
            - export SCAN_RESULT=$(yc container image scan $IMAGE_ID --format=json)
            - export CRIT_VULN=$(echo $SCAN_RESULT | jq -r '.vulnerabilities.critical // 0')
            - export HIGH_VULN=$(echo $SCAN_RESULT | jq -r '.vulnerabilities.high // 0')
            - export SCAN_ID=$(echo $SCAN_RESULT | jq -r '.id')
            - echo "Scan results:"
            - yc container image list-vulnerabilities --scan-result-id="${SCAN_ID}" --format json | jq -r '.[] | select(.severity=="CRITICAL", .severity=="HIGH")'
            - yc container image list-vulnerabilities --scan-result-id="${SCAN_ID}" --format json | jq -r '.[] | select(.severity=="CRITICAL", .severity=="HIGH")' > gl-container-scanning-report-yc.json
            # Check the result.
            - (( SUM = $CRIT_VULN + $HIGH_VULN )) && (( RES = (SUM >= 1) )) && echo $RES && echo "image has $CRIT_VULN critical vulns and $HIGH_VULN high vulns" && exit 1 || echo "image has no high or crit vulns" exit 0

        deploy:
          image: bitnami/kubectl:latest
          stage: deploy
          script:
            - kubectl config use-context ${CI_PROJECT_PATH}:<имя_GitLab_Agent>
            - cat k8s.yaml | sed -e "s,__VERSION__,${CI_REGISTRY}/${CI_COMMIT_REF_SLUG}:${CI_COMMIT_SHA}," | kubectl apply -f -
        ```

        {% endcut %}

        Вместо `<имя_GitLab_Agent>` укажите имя агента в {{ mgl-name }}.

      {% endlist %}

   1. Напишите комментарий к коммиту в поле **Commit message**: `CI scripts`.
   1. Нажмите кнопку **Commit changes**.

   В файле `.gitlab-ci.yml` описаны следующие шаги сценария CI:
   * Сборка Docker-образа с использованием `Dockerfile` и загрузка образа в {{ container-registry-name }}.
   * Сканирование Docker-образа на наличие уязвимостей в {{ container-registry-name }}.
   * Настройка окружения для работы с {{ k8s }} и применение конфигурации `k8s.yaml` к кластеру {{ managed-k8s-name }}. Таким образом приложение развертывается на созданном ранее кластере {{ managed-k8s-name }}.

## Проверьте результат {#check-result}

После сохранения файла конфигурации `.gitlab-ci.yml` запустится сценарий сборки. Чтобы проверить результаты его выполнения, на панели слева в проекте `gitlab-test` выберите пункт **Build**, в выпадающем меню выберите пункт **Pipelines**. Сканирование уязвимостей происходит на втором этапе `test`.

{% include [clear-out](../../_includes/managed-gitlab/clear-out.md) %}
