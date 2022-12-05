[{{ GL }}](https://about.gitlab.com/) — инструмент {% if lang == "ru" %}[непрерывной интеграции (Continuous integration, CI)](https://cloud.yandex.ru/blog/posts/2022/10/ci-cd){% else %}непрерывной интеграции (Continuous integration, CI){% endif %}.

В этом руководстве описаны:
* Сборка приложения в {% if lang == "ru" %}[Docker-контейнер](https://cloud.yandex.ru/blog/posts/2022/03/docker-containers){% else %}Docker-контейнер{% endif %}.
* Развертывание приложения из контейнера в [кластере {{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) через {{ GL }} с помощью инструментов {{ yandex-cloud }}.

После каждого коммита в {{ GL }}:
* Выполнится сценарий, в котором описаны шаги сборки [Docker-образа](../../container-registry/concepts/docker-image.md).
* Применится новая конфигурация кластера {{ managed-k8s-name }}, в которой будет указано приложение для развертывания.

Чтобы настроить необходимую инфраструктуру для хранения исходного кода, сборки Docker-образа и развертывания приложения:
1. [Подготовьте облако к работе](#before-you-begin).

   {% if product == "yandex-cloud" %}

   1. [Изучите список необходимых платных ресурсов](#paid-resources).

   {% endif %}

   1. [Установите дополнительные зависимости](#prepare).
1. [Создайте ресурсы {{ managed-k8s-name }} и {{ container-registry-full-name }}](#k8s-cr-create).
1. [Создайте инстанс {{ GL }}](#create-gitlab).
1. [Настройте {{ GL }}](#configure-gitlab).
1. [Создайте тестовое приложение](#app-create).
1. [Создайте {{ GLR }}](#runners).
1. [Настройте сборку и развертывание Docker-образа из CI](#ci).

Если созданные ресурсы больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% if product == "yandex-cloud" %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит плата за следующие ресурсы:
* [Диски](../../compute/concepts/disk.md) и постоянно запущенные [виртуальные машины](../../compute/concepts/vm.md) (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Использование динамического [публичного IP-адреса](../../vpc/concepts/ips.md) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).
* Хранение созданных Docker-образов (см. [тарифы {{ container-registry-name }}](../../container-registry/pricing.md)).
* Использование [мастера {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#master) (см. [тарифы {{ managed-k8s-name }}](../../managed-kubernetes/pricing.md)).

{% endif %}

### Установите дополнительные зависимости {#prepare}

Для выполнения сценария установите в локальном окружении:
* [Интерфейс командной строки {{ yandex-cloud }} (YC CLI)](../../cli/operations/install-cli.md).
* [Утилиту потоковой обработки JSON-файлов `jq`](https://stedolan.github.io/jq/).
* [Менеджер пакетов Helm]({{ links.helm.install }}).

## Создайте ресурсы {{ managed-k8s-name }} и {{ container-registry-name }} {#k8s-cr-create}

1. Создайте кластер {{ managed-k8s-name }} и реестр {{ container-registry-name }}.

   Для выполнения сценария создайте ресурсы {{ managed-k8s-name }}: [кластер](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и [группу узлов](../../managed-kubernetes/concepts/index.md#node-group).

   Для хранения Docker-образов вам понадобится [реестр](../../container-registry/concepts/registry.md) {{ container-registry-name }}.

   {% list tabs %}

   - Вручную

     1. Если у вас еще нет [сети](../../vpc/concepts/network.md#network), [создайте ее](../../vpc/operations/network-create.md).
     1. Если у вас еще нет [подсетей](../../vpc/concepts/network.md#subnet), [создайте их](../../vpc/operations/subnet-create.md) в [зонах доступности](../../overview/concepts/geo-scope.md), где будут созданы кластер {{ managed-k8s-name }} и группа узлов.
     1. [Создайте сервисные аккаунты](../../iam/operations/sa/create.md):
        * С ролью [{{ roles-editor }}](../../iam/concepts/access-control/roles.md#editor) на каталог, в котором создается кластер {{ managed-k8s-name }}. От его имени будут создаваться ресурсы, необходимые кластеру {{ managed-k8s-name }}.
        * С ролями [{{ roles-cr-puller }}](../../iam/concepts/access-control/roles.md#cr-images-puller) и [{{ roles-cr-pusher }}](../../iam/concepts/access-control/roles.md#cr-images-pusher). От его имени узлы будут загружать в реестр собранные в {{ GL }} Docker-образы, а также скачивать их для запуска подов.

        {% note tip %}

        Вы можете использовать один и тот же [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) для управления кластером {{ managed-k8s-name }} и его группами узлов.

        {% endnote %}

     1. [Создайте кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md) со следующими настройками:
        * **Сервисный аккаунт для ресурсов** — созданный ранее сервисный аккаунт с ролью `{{ roles-editor }}`.
        * **Сервисный аккаунт для узлов** — созданный ранее сервисный аккаунт с ролями `{{ roles-cr-puller }}` и `{{ roles-cr-pusher }}`.
        * **Версия {{ k8s }}** — не ниже **1.21**.
        * **Публичный адрес** — `Автоматически`.

        Сохраните идентификатор кластера — он понадобится для следующих шагов.
     1. [Создайте реестр](../../container-registry/operations/registry/registry-create.md).
     1. [Сохраните идентификатор созданного реестра](../../container-registry/operations/registry/registry-list.md#registry-get) — он понадобится для следующих шагов.

   - С помощью {{ TF }}

     1. Если у вас еще нет {{ TF }}, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
     1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
     1. Скачайте в ту же рабочую директорию файл конфигурации кластера [k8s-gl.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/managed-kubernetes/k8s-gl.tf). В файле описаны:
        * [Сеть](../../vpc/concepts/network.md#network).
        * [Подсеть](../../vpc/concepts/network.md#subnet).
        * [Группа безопасности](../../vpc/concepts/security-groups.md) и [правила](../../managed-kubernetes/operations/connect/security-groups.md), необходимые для работы кластера {{ managed-k8s-name }}:
          * Правила для служебного трафика.
          * Правила для доступа к API {{ k8s }} и управления кластером с помощью `kubectl` через порты 443 и 6443.
          * Правила для подключения к Git-репозиторию по протоколу SSH через порт 22.
          * Правила, разрешающие HTTP- и HTTPS-трафик через порты 80 и 443.
          * Правила для подключения к {{ container-registry-name }} через порт 5050.
        * Кластер {{ managed-k8s-name }}.
        * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md), необходимый для работы кластера и группы узлов {{ managed-k8s-name }}.
        * [Реестр {{ container-registry-name }}](../../container-registry/concepts/registry.md).
     1. Укажите в файле конфигурации:
        * [Идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
        * Версию {{ k8s }} для кластера и групп узлов {{ managed-k8s-name }}.
        * CIDR кластера {{ managed-k8s-name }}.
        * Имя сервисного аккаунта кластера.
        * Имя реестра {{ container-registry-name }}.
     1. Выполните команду `terraform init` в директории с конфигурационными файлами. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
     1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Создайте необходимую инфраструктуру:

        % include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

1. {% include [kubectl-install-links](../../_includes/managed-kubernetes/kubectl-install.md) %}

{% include [k8s-get-token](../../_includes/managed-gitlab/k8s-get-token.md) %}

## Создайте инстанс {{ GL }} {#create-gitlab}

{% list tabs %}

{% if product == "yandex-cloud" %}

- Инстанс {{ mgl-name }}

  Создайте [инстанс {{ mgl-name }}](../../managed-gitlab/concepts/index.md#instance) [согласно инструкции](../../managed-gitlab/quickstart.md#instance-create).

{% endif %}

- ВМ с образом {{ GL }}

  Запустите {{ GL }} на ВМ с публичным IP-адресом.

  {% include [create-gitlab](../../_includes/managed-gitlab/create.md) %}

{% endlist %}

## Настройте {{ GL }} {#configure-gitlab}

{% include [Create a project](../../_includes/managed-gitlab/initialize.md) %}

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
                image: {{ registry }}/<идентификатор реестра>/hello:__VERSION__
                imagePullPolicy: Always
      ```

   1. В поле `<идентификатор реестра>` укажите идентификатор созданного ранее реестра.
   1. Напишите комментарий к коммиту в поле **Commit message**: `Docker image deployment config`.
   1. Нажмите кнопку **Commit changes**.

## Создайте {{ GLR }} {#runners}

{% include notitle [create glr](../../_includes/managed-gitlab/k8s-runner.md) %}

## Настройте сборку и развертывание Docker-образа из CI {#ci}

{% include [Setup CI/CD](../../_includes/managed-gitlab/configure-ci.md) %}

## Удалите созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны, удалите их:
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
     1. Удалите конфигурационный файл `k8s-gl.tf`.
     1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `k8s-gl.tf`, будут удалены.

   {% endlist %}

1. [Удалите созданную ВМ {{ GL }}](../../compute/operations/vm-control/vm-delete.md) или инстанс {{ mgl-name }}.

## См. также {#see-also}

* [Создание тестовых ВМ через {{ GL }} CI](../../tutorials/testing/ci-for-snapshots.md).