# Хранение Docker-образов из {{ mgl-full-name }} в {{ container-registry-full-name }}

В {{ GL }} интегрирован сервис [{{ container-registry-name }}](https://docs.gitlab.com/ee/user/packages/container_registry/). Он позволяет хранить Docker-образы для каждого проекта в {{ GL }}.

Вместо {{ GL }} {{ container-registry-name }} вы можете использовать [{{ container-registry-full-name }}](../../container-registry/index.yaml). Этот сервис позволяет хранить Docker-образы в облаке и распространять их между управляемыми сервисами {{ yandex-cloud }}, например, [{{ managed-k8s-full-name }}](../../managed-kubernetes/index.yaml) или [{{ mgl-full-name }}](../../managed-gitlab/index.yaml).

Использование {{ container-registry-full-name }} для хранения образов из проектов {{ GL }} обладает несколькими преимуществами:

* {{ GL }} {{ container-registry-name }} хранит образы и теги на диске [инстанса {{ GL }}](../../managed-gitlab/concepts/index.md#instance). Когда место на диске заканчивается, возникает ошибка с HTTP-кодом 500, инстанс становится недоступным. Восстановить его можно только через обращение в техническую поддержку.

   {{ container-registry-full-name }} хранит образы и теги в [реестрах](../../container-registry/concepts/registry.md), для которых выделяются [отдельные квоты](../../container-registry/concepts/limits.md). Поэтому накопление Docker-образов и тегов не влияет на место на диске инстанса.

* Образы в {{ container-registry-full-name }} остаются доступными, даже если {{ mgl-name }} недоступен.

* {{ container-registry-full-name }} поддерживает [сканер уязвимостей Docker-образов](../../container-registry/concepts/vulnerability-scanner.md). С его помощью можно обнаружить уязвимости и устранить их до развертывания приложения. Подробнее о сканировании см. в [блоге {{ yandex-cloud }}](/blog/posts/2023/04/vulnerability-scanner-and-yandex-container-registry).

Чтобы настроить хранение Docker-образов из {{ mgl-name }} в {{ container-registry-full-name }}:

1. [Создайте инстанс {{ GL }}](#create-gitlab).
1. [Настройте {{ GL }}](#configure-gitlab).
1. [Создайте тестовое приложение](#app-create).
1. [Создайте {{ GLR }}](#runner).
1. [Создайте переменные окружения {{ GL }}](#add-variables).
1. [Создайте файл конфигурации сценария CI](#add-ci).
1. [Проверьте результат](#check-result).
1. [Включите политику автоматического удаления Docker-образов](#lifecycle-policy).
1. (Опционально) [Отсканируйте Docker-образы на наличие уязвимостей](#vulnerability-scanner).

Если инстанс {{ mgl-full-name }} уже настроен для непрерывной интеграции ([Continuous Integration](/blog/posts/2022/10/ci-cd), CI), убедитесь, что [инфраструктура для хранения Docker-образов](#deploy-infrastructure) подготовлена. Затем начните настройку с [создания переменных окружения](#add-variables).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

{% note info %}

По умолчанию {{ GL }} {{ container-registry-name }} отключен при создании инстанса {{ mgl-name }}.

{% endnote %}

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит плата за следующие ресурсы:

* Диски и постоянно запущенные виртуальные машины (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Использование динамического публичного IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).
* Хранение созданных Docker-образов и сканер уязвимостей, если вы его [активируете](#vulnerability-scanner) (см. [тарифы {{ container-registry-name }}](../../container-registry/pricing.md)).
* Использование мастера {{ managed-k8s-name }} (см. [тарифы {{ managed-k8s-name }}](../../managed-kubernetes/pricing.md)).


### Подготовьте инфраструктуру {#deploy-infrastructure}

{% list tabs %}

- Вручную

   1. Если у вас еще нет [сети](../../vpc/concepts/network.md#network), [создайте ее](../../vpc/operations/network-create.md).
   1. Если у вас еще нет [подсетей](../../vpc/concepts/network.md#subnet), [создайте их](../../vpc/operations/subnet-create.md) в [зонах доступности](../../overview/concepts/geo-scope.md), где будут созданы [кластер {{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и [группа узлов](../../managed-kubernetes/concepts/index.md#node-group).
   1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) `account-for-container-registry` с [ролями](../../iam/concepts/access-control/roles.md) на каталог:

      * `{{ roles-editor }}`
      * `{{ roles-cr-pusher }}`
      * `{{ roles-cr-puller }}`

   1. [Создайте кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) с зональным мастером и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md). При создании кластера укажите созданный ранее сервисный аккаунт.
   1. Настройте группу безопасности для работы [кластера {{ managed-k8s-name }}](../../managed-kubernetes/operations/connect/security-groups.md) и [инстанса {{ mgl-name }}](../../managed-gitlab/operations/connect.md).

  1. [Создайте реестр {{ container-registry-full-name }}](../../container-registry/operations/registry/registry-create.md).

- С помощью {{ TF }}

   1. Если у вас еще нет {{ TF }}, [установите и настройте его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и укажите значения параметров.
   1. Скачайте в ту же рабочую директорию файл конфигурации [container-registry-and-gitlab.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/managed-gitlab/container-registry-and-gitlab.tf).

      В этом файле описаны:

      * [Сеть](../../vpc/concepts/network.md#network).
      * [Подсеть](../../vpc/concepts/network.md#subnet).
      * [Группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для работы инстанса {{ mgl-name }} и [кластера {{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).
      * Кластер {{ managed-k8s-name }} с зональным мастером.
      * [Группа узлов для кластера](../../managed-kubernetes/concepts/index.md#node-group).
      * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md), необходимый для работы кластера и группы узлов {{ managed-k8s-name }}.
      * Реестр {{ container-registry-full-name }}.

   1. Укажите в файле `container-registry-and-gitlab.tf`:

      * [Идентификатор облака](../../resource-manager/operations/cloud/get-id.md).
      * [Идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
      * [Версию {{ k8s }}](../../managed-kubernetes/concepts/release-channels-and-updates.md) для кластера и групп узлов {{ managed-k8s-name }}.

   1. Выполните команду `terraform init` в директории с конфигурационным файлом. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.

   1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

      ```bash
      terraform validate
      ```

      Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

   1. Создайте необходимую инфраструктуру:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

{% include [create-gitlab](../../_includes/managed-gitlab/create-gitlab.md) %}

{% include [configure-gitlab](../../_includes/managed-gitlab/initialize.md) %}

## Создайте тестовое приложение {#app-create}

Создайте тестовое приложение, которое можно будет развернуть в кластере {{ managed-k8s-name }}. Для этого добавьте в проект `Dockerfile`:

   1. Авторизуйтесь в {{ GL }}.
   1. На главной странице выберите репозиторий.
   1. Выберите раздел **Repository** → **Files**.
   1. Нажмите кнопку ![image](../../_assets/plus.svg) и в выпадающем меню выберите пункт **New file**.
   1. Назовите файл `Dockerfile` и добавьте в него код:

      ```Dockerfile
      FROM alpine:3.10
      CMD echo "Hello"
      ```

   1. Напишите комментарий к коммиту в поле **Commit message**: `Dockerfile for a test application`.
   1. Нажмите кнопку **Commit changes**.

{% include [create glr](../../_includes/managed-gitlab/k8s-runner.md) %}

## Создайте переменные окружения {{ GL }} {#add-variables}

Чтобы разрешить сервису {{ mgl-name }} сохранять Docker-образы и их теги в {{ container-registry-full-name }}, создайте [переменные окружения {{ GL }}](https://docs.gitlab.com/ee/ci/variables/index.html):

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. Создайте [статический ключ](../../iam/concepts/authorization/access-key.md) для сервисного аккаунта `account-for-container-registry`:

   ```bash
   yc iam key create --service-account-name account-for-container-registry -o key.json
   ```

   Ключ сохраняется в файле `key.json` в папке, где была запущена команда.

1. Откройте свой проект в {{ GL }}.

1. На панели слева перейдите в раздел **Settings** и во всплывающем списке выберите пункт **CI/CD**.

1. Нажмите кнопку **Expand** напротив пункта **Variables**.

1. Добавьте переменные окружения с выключенной опцией защиты:

   | **Переменная**        | **Ее значение**                    |
   | --------------------- | ---------------------------------- |
   | `CI_REGISTRY`         | `cr.yandex/<идентификатор реестра>`. Укажите идентификатор созданного ранее реестра {{ container-registry-full-name }}. |
   | `CI_REGISTRY_KEY`     | Содержимое файла `key.json`.       |

   Для добавления переменной:

   1. Нажмите кнопку **Add variable**.
   1. В появившемся окне в поле **Key** укажите имя переменной, в поле **Value** — значение переменной.
   1. Выключите опцию **Protect variable**.
   1. Нажмите кнопку **Add variable**.

## Создайте файл конфигурации сценария CI {#add-ci}

Чтобы публиковать Docker-образы из проекта {{ GL }} в {{ container-registry-full-name }}, создайте сценарий CI:

1. Откройте проект {{ GL }}.
1. На панели слева перейдите в раздел **Repository** и выберите вкладку **Files**.
1. Справа от имени проекта нажмите кнопку ![image](../../_assets/plus.svg) и в выпадающем меню выберите пункт **New file**.
1. Назовите файл `.gitlab-ci.yml`. Добавьте в него шаги сборки Docker-образа и его загрузки в {{ container-registry-full-name }}:

   {% cut ".gitlab-ci.yml" %}

   ```yaml
   build:
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
            --context "${CI_PROJECT_DIR}"
            --dockerfile "${CI_PROJECT_DIR}/Dockerfile"
            --destination "${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}"
   ```

   {% endcut %}

   Файл содержит переменные:

   * `CI_REGISTRY` и `CI_REGISTRY_KEY` — добавлены в GitLab на [предыдущем шаге](#add-variables).
   * `CI_PROJECT_DIR`, `CI_PROJECT_PATH` и `CI_COMMIT_SHORT_SHA` — [предопределены в GitLab](https://docs.gitlab.com/ee/ci/variables/predefined_variables.html).

1. Напишите комментарий к коммиту в поле **Commit message**: `Create a CI pipeline`.
1. Нажмите кнопку **Commit changes**.

## Проверьте результат {#check-result}

После каждого коммита запускается сценарий сборки. Чтобы проверить результаты его выполнения:

1. На панели слева в {{ GL }} выберите в выпадающем меню пункт **CI/CD** → **Pipelines**.

1. Убедитесь, что этап `build` принимает статус `passed`. Это означает, что сценарий CI выполнился успешно.

1. Перейдите в [консоль управления](https://console.cloud.yandex.ru/), затем откройте реестр {{ container-registry-full-name }}.

   При успешном выполнении сценария появляется новый репозиторий в реестре. Он пополняется Docker-образами из проекта {{ GL }} при каждом коммите.

## Включите политику автоматического удаления Docker-образов {#lifecycle-policy}

Чтобы не хранить устаревшие Docker-образы и их теги, используйте [политику автоматического удаления Docker-образов](../../container-registry/concepts/lifecycle-policy.md). Она применяется к образам в [репозитории {{ container-registry-name }}](../../container-registry/concepts/repository.md) и позволяет своевременно очищать место в нем. Так вы не переплачиваете за [хранение устаревших образов](../../container-registry/pricing.md#prices-storage).

Чтобы создать политику, [следуйте инструкции](../../container-registry/operations/lifecycle-policy/lifecycle-policy-create.md).

Особенности работы с политикой:

* Внешние {{ container-registry-name }} и политика удаления образов [влияют на производительность сценариев CI](https://docs.gitlab.com/ee/user/packages/container_registry/reduce_container_registry_storage.html#use-with-external-container-registries).

* Для политики действует [лимит](../../container-registry/concepts/limits.md#container-registry-limits) на максимальное количество образов, которые можно проверить за один запуск политики. Если количество образов в репозитории {{ container-registry-name }} превышает этот лимит, запустите политику несколько раз. Так будут проверены все образы.

## Отсканируйте Docker-образы на наличие уязвимостей {#vulnerability-scanner}

Чтобы отслеживать уязвимости Docker-образов, вы можете дополнительно активировать [сканер уязвимостей](../../container-registry/concepts/vulnerability-scanner.md) в {{ container-registry-full-name }}. Сканер сравнивает версии пакетов, установленных в образах, с базами уязвимостей [CVE](https://cve.mitre.org/).

Чтобы включить сканирование, дополните сценарий CI в своем проекте {{ GL }}:

1. Откройте проект.
1. На панели слева в {{ GL }} перейдите в раздел **Repository** и выберите вкладку **Files**.
1. Откройте файл `.gitlab-ci.yml`.
1. Добавьте в него шаги сканирования Docker-образа на наличие уязвимостей:

   {% cut ".gitlab-ci.yml" %}

   ```yaml
   stages:
      - build
      - test
   
   <блок build, добавленный ранее в файл>

   container_scanning_free_yc:
      stage: test
      # Использование утилиты jq для поиска идентификатора и записи логов.
      image: 
         name: pindar/jq
         entrypoint: [""]
      artifacts:
         when: always
         paths:
            - gl-container-scanning-report-yc.json
      variables:
         # Укажите идентификатор созданного ранее реестра.
         CI_REGISTRY_ID: "<идентификатор реестра>"
      script:
         - export CI_COMMIT_SHORT_SHA=${CI_COMMIT_SHORT_SHA}
         # Установка Yandex Cloud CLI.
         - curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash -s -- -a && cp /root/yandex-cloud/bin/yc /usr/bin/
         # Начало сканирования.
         - echo "Scanning image ${CI_REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHORT_SHA}..."
         - export IMAGE_ID=$(yc container image list --registry-id $CI_REGISTRY_ID --format=json | jq -r --arg CI_COMMIT_SHORT_SHA $CI_COMMIT_SHORT_SHA '.[] | select(.tags[0]==$CI_COMMIT_SHORT_SHA) | .id ')
         # Запись логов.
         - export SCAN_RESULT=$(yc container image scan $IMAGE_ID --format=json)
         - export CRIT_VULN=$(echo $SCAN_RESULT | jq -r '.vulnerabilities.critical // 0')
         - export HIGH_VULN=$(echo $SCAN_RESULT | jq -r '.vulnerabilities.high // 0')
         - export SCAN_ID=$(echo $SCAN_RESULT | jq -r '.id')
         - echo "Scan results:"
         - yc container image list-vulnerabilities --scan-result-id="${SCAN_ID}" --format json | jq -r '.[] | select(.severity=="CRITICAL", .severity=="HIGH")'
         - yc container image list-vulnerabilities --scan-result-id="${SCAN_ID}" --format json | jq -r '.[] | select(.severity=="CRITICAL", .severity=="HIGH")' > gl-container-scanning-report-yc.json
         # Проверка результата.
         - (( SUM = $CRIT_VULN + $HIGH_VULN )) && (( RES = (SUM >= 1) )) && echo $RES && echo "image has $CRIT_VULN critical vulnerabilities and $HIGH_VULN high vulnerabilities" && exit 1 || echo "image has no high or critical vulnerabilities" exit 0
   ```

   {% endcut %}

1. Напишите комментарий к коммиту в поле **Commit message**: `Turn on a vulnerability scanner`.
1. Нажмите кнопку **Commit changes**. После этого запустится обновленный сценарий.

Чтобы убедиться, что сканирование образов прошло успешно:

1. На панели слева в {{ GL }} выберите в выпадающем меню пункт **CI/CD** → **Pipelines**.
1. Убедитесь, что этапы `build` и `test` принимают статус `passed`. Это означает, что сценарий CI выполнился успешно.
1. Перейдите в [консоль управления](https://console.cloud.yandex.ru/), затем откройте реестр {{ container-registry-full-name }}.
1. Откройте репозиторий с Docker-образами из проекта {{ GL }}.
1. Перейдите в папку с названием проекта {{ GL }}.
1. Убедитесь, что в столбце **{{ ui-key.yacloud.cr.image.label_scan-status }}** указано **{{ ui-key.yacloud.cr.image.label_scan-status-READY }}**.
1. В столбце **{{ ui-key.yacloud.cr.image.label_last-scan-time }}** нажмите ссылку со временем сканирования.

   Откроются результаты сканирования. Если в образе выявлены уязвимости, они отображаются в полученных результатах.

## Удалите созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны, удалите их:

1. [Удалите инстанс {{ mgl-name }}](../../managed-gitlab/operations/instance/instance-delete.md) или [созданную виртуальную машину с образом {{ GL }}](../../compute/operations/vm-control/vm-delete.md).
1. [Удалите все Docker-образы](../../container-registry/operations/docker-image/docker-image-delete.md) из реестра {{ container-registry-name }}.

Остальные ресурсы удалите в зависимости от способа их создания:

{% list tabs %}

- Вручную

   1. [Удалите кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
   1. Если вы зарезервировали для кластера {{ managed-k8s-name }} публичный IP-адрес, [удалите его](../../vpc/operations/address-delete.md).
   1. [Удалите сервисные аккаунты](../../iam/operations/sa/delete.md).
   1. [Удалите реестр {{ container-registry-name }}](../../container-registry/operations/registry/registry-delete.md).
   1. [Удалите подсети](../../vpc/operations/subnet-delete.md) и [сеть](../../vpc/operations/network-delete.md).

- С помощью {{ TF }}

   Чтобы удалить инфраструктуру, [созданную с помощью {{ TF }}](#deploy-infrastructure):

   1. В терминале перейдите в директорию с планом инфраструктуры.
   1. Удалите конфигурационный файл `container-registry-and-gitlab.tf`.
   1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

      ```bash
      terraform validate
      ```

      Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

   1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      Все ресурсы, которые были описаны в конфигурационном файле `container-registry-and-gitlab.tf`, будут удалены.

{% endlist %}
