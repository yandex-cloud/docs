# Сканирование уязвимостей {{ container-registry-name }} при непрерывном развертывании приложений {{ managed-k8s-name }} с помощью {{ GL }}

Вы можете [сканировать уязвимости](../container-registry/concepts/vulnerability-scanner.md) Docker-образов в [{{ container-registry-full-name }}](../container-registry/) при непрерывном развертывании приложений [{{ managed-k8s-full-name }}](../managed-kubernetes/) через {{ GL }}.

Для этого с помощью непрерывной интеграции ([Continuous Integration](/blog/posts/2022/10/ci-cd), CI) в {{ GL }} создается специальный сценарий, который запускается после каждого коммита:
1. Сборка приложения в [Docker-образ](../container-registry/concepts/docker-image.md) и загрузка образа в {{ container-registry-name }}.
1. Сканирование Docker-образа в {{ container-registry-name }} на наличие уязвимостей.
1. Развертывание приложения из Docker-образа в кластере {{ managed-k8s-name }} с помощью инструментов {{ yandex-cloud }}.

Чтобы настроить сканер уязвимостей:
1. [Создайте инстанс {{ GL }}](#create-gitlab).
1. [Настройте {{ GL }}](#configure-gitlab).
1. [Создайте тестовое приложение](#app-create).
1. [Создайте {{ GLR }}](#runner).
1. [Настройте сценарий CI](#ci).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-begin}

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs %}

- Вручную

  1. [Создайте сервисные аккаунты](../iam/operations/sa/create.md) и [назначьте](../iam/operations/sa/assign-role-for-sa.md) им роли:
     * [Сервисный аккаунт](../iam/concepts/users/service-accounts.md) для ресурсов с ролью [{{ roles-editor }}](../resource-manager/security/index.md#roles-list) на [каталог](../resource-manager/concepts/resources-hierarchy.md#folder), в котором создается [кластер {{ managed-k8s-name }}](../managed-kubernetes/concepts/index.md#kubernetes-cluster). От его имени будут создаваться ресурсы, необходимые кластеру {{ managed-k8s-name }}.
     * Сервисный аккаунт для [узлов](../managed-kubernetes/concepts/index.md#node-group) с [ролями](../container-registry/security/index.md#service-roles) `{{ roles-cr-puller }}` и `{{ roles-cr-pusher }}` на каталог с [реестром](../container-registry/concepts/registry.md) Docker-образов. От его имени узлы будут скачивать из реестра необходимые Docker-образы.

     Вы можете использовать один и тот же сервисный аккаунт для обеих операций.
  1. [Создайте кластер {{ managed-k8s-name }}](../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) и [группу узлов](../managed-kubernetes/operations/node-group/node-group-create.md). При создании кластера укажите ранее созданные сервисные аккаунты для ресурсов и узлов.
  1. [Настройте группы безопасности](../managed-kubernetes/operations/connect/security-groups.md) для работы кластера {{ managed-k8s-name }}.
  1. [Настройте группу безопасности по умолчанию](../managed-gitlab/operations/connect.md) для работы [инстанса {{ mgl-full-name }}](../managed-gitlab/concepts/index.md#instance).
  1. [Создайте реестр {{ container-registry-name }}](../container-registry/operations/registry/registry-create.md).

- С помощью {{ TF }}

  1. Если у вас еще нет {{ TF }}, [установите и настройте его](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
  1. Скачайте в ту же рабочую директорию файл конфигурации [cr-scanner-with-k8s-and-gitlab.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/cr-scanner-with-k8s-and-gitlab.tf).

     В этом файле описаны:
     * [Сеть](../vpc/concepts/network.md#network).
     * [Подсеть](../vpc/concepts/network.md#subnet).
     * [Группа безопасности по умолчанию](../vpc/concepts/security-groups.md) и правила, необходимые для работы инстанса {{ mgl-name }}.
     * [Группа безопасности](../vpc/concepts/security-groups.md) и правила, необходимые для работы кластера {{ managed-k8s-name }}:
       * Правила для служебного трафика.
       * Правила для доступа к API {{ k8s }} и управления кластером с помощью `kubectl` через порты 443 и 6443.
     * Кластер {{ managed-k8s-name }}.
     * Сервисный аккаунт, необходимый для работы кластера и группы узлов {{ managed-k8s-name }}.
     * Реестр {{ container-registry-name }}.
  1. Укажите в файле `cr-scanner-with-k8s-and-gitlab.tf`:
     * [Идентификатор каталога](../resource-manager/operations/folder/get-id.md).
     * [Версию {{ k8s }}](../managed-kubernetes/concepts/release-channels-and-updates.md) для кластера и групп узлов {{ managed-k8s-name }}.
     * CIDR кластера {{ managed-k8s-name }}.
     * Имя сервисного аккаунта кластера {{ managed-k8s-name }}.
     * Имя реестра {{ container-registry-name }}.
  1. Выполните команду `terraform init` в директории с конфигурационным файлом. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
  1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

     ```bash
     terraform validate
     ```

     Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Создайте необходимую инфраструктуру:

     {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

     {% include [explore-resources](../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Установите дополнительные зависимости {#prepare}

Установите в локальном окружении:
* [Интерфейс командной строки {{ yandex-cloud }} (YC CLI)](../cli/operations/install-cli.md).
* [Утилиту потоковой обработки JSON-файлов `jq`](https://stedolan.github.io/jq/).
* [Менеджер пакетов Helm]({{ links.helm.install }}).
* [Инструмент командной строки {{ k8s }} kubectl]({{ k8s-docs }}/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../managed-kubernetes/operations/connect/index.md#kubectl-connect).

## Получите токен сервисного аккаунта {{ k8s }} для аутентификации в {{ GL }} {#k8s-get-token}

{% include notitle [k8s-get-token](../_includes/managed-gitlab/k8s-get-token.md) %}

## Создайте инстанс {{ GL }} {#create-gitlab}

Создайте инстанс {{ mgl-name }} или [виртуальную машину](../compute/concepts/vm.md) с [образом](../compute/concepts/image.md) {{ GL }} в той же облачной сети, где расположен кластер {{ managed-k8s-name }}.

{% list tabs %}


- Инстанс {{ mgl-name }}

  Создайте инстанс {{ mgl-name }} [согласно инструкции](../managed-gitlab/quickstart.md#instance-create).


- ВМ с образом {{ GL }}

  Запустите {{ GL }} на ВМ с публичным IP-адресом.

  {% include [create-gitlab](../_includes/managed-gitlab/create.md) %}

{% endlist %}

## Настройте {{ GL }} {#configure-gitlab}

{% include [Create a project](../_includes/managed-gitlab/initialize.md) %}

## Создайте тестовое приложение {#app-create}

Создайте тестовое приложение, которое можно будет развернуть в кластере {{ managed-k8s-name }}:
1. Добавьте в проект `Dockerfile`:
   1. Авторизуйтесь в {{ GL }}.
   1. На главной странице выберите репозиторий.
   1. Выберите раздел **Repository** → **Files**.
   1. Нажмите кнопку **+** и в выпадающем меню выберите пункт **New file**.
   1. Назовите файл `Dockerfile` и добавьте в него код:

      ```Dockerfile
      FROM alpine:3.10
      CMD echo "Hello"
      ```

   1. Напишите комментарий к коммиту в поле **Commit message**: `Dockerfile for test application`.
   1. Нажмите кнопку **Commit changes**.
1. Добавьте в проект манифест ресурсов кластера {{ managed-k8s-name }}:
   1. Выберите раздел **Repository** → **Files**.
   1. Нажмите кнопку **+** и в выпадающем меню выберите пункт **New file**.
   1. Назовите файл `k8s.yaml`:

      {% cut "k8s.yaml" %}

      ```yaml
      apiVersion: v1
      kind: Namespace
      metadata:
        name: hello-world
      ---
      apiVersion: apps/v1
      kind: Deployment
      metadata:
        name: hello-world-deployment
        namespace: hello-world
      spec:
        replicas: 1
        selector:
          matchLabels:
            app: hello
        template:
          metadata:
            namespace: hello-world
            labels:
              app: hello
          spec:
            containers:
              - name: hello-world
                image: {{ registry }}/<идентификатор реестра>/__VERSION__
                imagePullPolicy: Always
       ```

      {% endcut %}

   1. Вместо `<идентификатор реестра>` укажите идентификатор созданного ранее реестра {{ container-registry-name }}.
   1. Напишите комментарий к коммиту в поле **Commit message**: `Docker image deployment config`.
   1. Нажмите кнопку **Commit changes**.

## Создайте {{ GLR }} {#runner}

{% include notitle [create glr](../_includes/managed-gitlab/k8s-runner.md) %}

## Настройте сценарий CI {#ci}

1. Создайте [переменные окружения {{ GL }}](https://docs.gitlab.com/ee/ci/variables/README.html):
   1. На панели слева в {{ GL }} перейдите в раздел **Settings** и во всплывающем списке выберите пункт **CI/CD**.
   1. Нажмите кнопку **Expand** напротив пункта **Variables**.
   1. Добавьте две переменные окружения:
      * `KUBE_URL` — адрес [мастера {{ managed-k8s-name }}](../managed-kubernetes/concepts/index.md#master). Узнайте его с помощью команды:

        ```bash
        yc managed-kubernetes cluster get <идентификатор или имя кластера {{ k8s }}> --format=json \
          | jq -r .master.endpoints.external_v4_endpoint
        ```

      * `KUBE_TOKEN` — токен, который будет использовать {{ GL }} для применения конфигурации. Используйте токен, полученный ранее.

      Для добавления переменной:
      1. Нажмите кнопку **Add variable**.
      1. В появившемся окне в поле **Key** укажите имя переменной, в поле **Value** — значение переменной.
      1. Нажмите кнопку **Add variable**.
1. Создайте файл конфигурации сценария CI:
   1. На панели слева в {{ GL }} перейдите в раздел **Repository** и выберите вкладку **Files**.
   1. Справа от имени проекта нажмите кнопку **+** и в выпадающем меню выберите пункт **New file**.
   1. Назовите файл `.gitlab-ci.yml`. Добавьте в него шаги сборки и загрузки Docker-образа, его сканирования на наличие уязвимостей и обновления конфигурации приложения в кластере {{ managed-k8s-name }}:

      {% cut ".gitlab-ci.yml" %}

      ```yaml
      stages:
        - build
        - test
        - deploy

      build_docker_image:
        stage: build
        variables:
          YC_REGISTRY_ID: "<идентификатор реестра>" # Set your registry ID.
          DOCKER_CUSTOM_SUBFOLDER: "" # Specify a custom path (if any) to your folder with docker files.
        image:
          name: gcr.io/kaniko-project/executor:debug
          entrypoint: [""]
        script:
          - mkdir -p /kaniko/.docker
          # Install jq.
          - wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 && chmod +x ./jq && cp jq /kaniko
          # Get a service account token from metadata.
          - wget --header Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token && cp token /kaniko
          - echo "{\"auths\":{\"{{ registry }}\":{\"auth\":\"$(printf "%s:%s" "iam" "$(cat /kaniko/token | ./jq -r '.access_token')" | base64 | tr -d '\n')\"}}}" > /kaniko/.docker/config.json
          - >-
            /kaniko/executor
            --context "${CI_PROJECT_DIR}"/"${DOCKER_CUSTOM_SUBFOLDER}"
            --dockerfile "${CI_PROJECT_DIR}/"${DOCKER_CUSTOM_SUBFOLDER}"/Dockerfile"
            --destination "{{ registry }}/${YC_REGISTRY_ID}/${CI_COMMIT_REF_SLUG}:${CI_COMMIT_SHA}"
          # Delete the metadata file.
          - rm /kaniko/token

      container_scanning_free_yc:
        image: 
          name: pindar/jq
          entrypoint: [""]
        stage: test
        artifacts:
          when: always
          paths:
            - gl-container-scanning-report-yc.json
        variables:
          YC_REGISTRY_ID: "<идентификатор реестра>" # Set your registry ID.
        script:
          - export CI_COMMIT_SHA=${CI_COMMIT_SHA}
          # Install YC CLI.
          - curl https://{{ s3-storage-host }}{{ yc-install-path }} | bash -s -- -a && cp /root/yandex-cloud/bin/yc /usr/bin/
          # Start scanning.
          - echo "Scanning image $IMAGE_NAME {{ registry }}/${YC_REGISTRY_ID}/${CI_COMMIT_REF_SLUG}:${CI_COMMIT_SHA}..."
          - export IMAGE_ID=$(yc container image list --registry-id $YC_REGISTRY_ID --format=json | jq -r --arg CI_COMMIT_SHA $CI_COMMIT_SHA '.[] | select(.tags[0]==$CI_COMMIT_SHA) | .id ')
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
          - sed -i "s/__VERSION__/${CI_COMMIT_REF_SLUG}:${CI_COMMIT_SHA}/" k8s.yaml
          - kubectl apply -f k8s.yaml
      ```

      {% endcut %}

   1. Вместо `<идентификатор реестра>` укажите идентификатор созданного ранее реестра {{ container-registry-name }}.
   1. Напишите комментарий к коммиту в поле **Commit message**: `CI scripts`.
   1. Нажмите кнопку **Commit changes**.

   В файле `.gitlab-ci.yml` описаны следующие шаги сценария CI:
   * Сборка Docker-образа с использованием `Dockerfile` и загрузка образа в {{ container-registry-name }}.
   * Сканирование Docker-образа на наличие уязвимостей в {{ container-registry-name }}.
   * Настройка окружения для работы с {{ k8s }} и применение конфигурации `k8s.yaml` к кластеру {{ managed-k8s-name }}. Таким образом приложение развертывается на созданном ранее кластере.

## Проверьте результат {#check-result}

После сохранения файла конфигурации `.gitlab-ci.yml` запустится сценарий сборки. Чтобы проверить результаты его выполнения, на панели слева в {{ GL }} выберите в выпадающем меню пункт **CI/CD** → **Pipelines**. Сканирование уязвимостей происходит на втором этапе `test`.

## Как удалить созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:
1. [Удалите инстанс {{ mgl-name }}](../managed-gitlab/operations/instance/instance-delete.md) или [созданную ВМ с образом {{ GL }}](../compute/operations/vm-control/vm-delete.md).
1. [Удалите все Docker-образы](../container-registry/operations/docker-image/docker-image-delete.md) из реестра {{ container-registry-name }}.

Остальные ресурсы удалите в зависимости от способа их создания:

{% list tabs %}

- Вручную

  1. [Удалите кластер {{ managed-k8s-name }}](../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
  1. Если вы зарезервировали для кластера публичный статический IP-адрес, [удалите его](../vpc/operations/address-delete.md).
  1. [Удалите сервисные аккаунты](../iam/operations/sa/delete.md).
  1. [Удалите реестр {{ container-registry-name }}](../container-registry/operations/registry/registry-delete.md).

- С помощью {{ TF }}

  Чтобы удалить инфраструктуру, [созданную с помощью {{ TF }}](#deploy-infrastructure):
  1. В терминале перейдите в директорию с планом инфраструктуры.
  1. Удалите конфигурационный файл `cr-scanner-with-k8s-and-gitlab.tf`.
  1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

     ```bash
     terraform validate
     ```

     Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
    1. Подтвердите изменение ресурсов.

       {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

       Все ресурсы, которые были описаны в конфигурационном файле `cr-scanner-with-k8s-and-gitlab.tf`, будут удалены.

{% endlist %}