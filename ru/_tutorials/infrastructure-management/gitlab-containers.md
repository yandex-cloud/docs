[{{ GL }}](https://about.gitlab.com/) — инструмент [непрерывной интеграции (Continuous integration, CI)]({{ links.wiki.ci }}).

В этом руководстве описаны:
* Сборка приложения в Docker-контейнер.
* Развертывание приложения из контейнера в [кластере {{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) через {{ GL }} с помощью инструментов {{ yandex-cloud }}.

После каждого коммита в {{ GL }}:
* Выполнится сценарий, в котором описаны шаги сборки [Docker-образа](../../container-registry/concepts/docker-image.md).
* Применится новая конфигурация кластера {{ k8s }}, в которой будет указано приложение для развертывания.

Чтобы настроить необходимую инфраструктуру для хранения исходного кода, сборки Docker-образа и развертывания приложения:
1. [Подготовьте облако к работе](#before-you-begin).

   
   1. [Изучите список необходимых платных ресурсов](#paid-resources).


   1. [Установите дополнительные зависимости](#prepare).
1. [Создайте ресурсы {{ managed-k8s-name }}](#k8s-create).
1. [Создайте инстанс {{ GL }}](#create-gitlab).
1. [Настройте {{ GL }}](#configure-gitlab).
1. [Создайте реестр {{ container-registry-full-name }}](#cr-create).
1. [Создайте тестовое приложение](#app-create).
1. [Создайте {{ GLR }}](#runners).
1. [Настройте сборку и развертывание Docker-образа из CI](#ci).

Если созданные ресурсы больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит плата за следующие ресурсы:
* [Диски](../../compute/concepts/disk.md) и постоянно запущенные [виртуальные машины](../../compute/concepts/vm.md) (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Использование динамического [публичного IP-адреса](../../vpc/concepts/ips.md) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).
* Хранение созданных Docker-образов (см. [тарифы {{ container-registry-name }}](../../container-registry/pricing.md)).
* Использование [мастера {{ k8s }}](../../managed-kubernetes/concepts/index.md#master) (см. [тарифы {{ managed-k8s-name }}](../../managed-kubernetes/pricing.md)).


### Установите дополнительные зависимости {#prepare}

Для выполнения сценария установите в локальном окружении:
* [Интерфейс командной строки {{ yandex-cloud }} (YC CLI)](../../cli/operations/install-cli.md).
* [Утилиту потоковой обработки JSON-файлов `jq`](https://stedolan.github.io/jq/).
* [Менеджер пакетов Helm]({{ links.helm.install }}).

## Создайте ресурсы {{ k8s }} {#k8s-create}

Для выполнения сценария создайте ресурсы {{ k8s }}: [кластер](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и [группу узлов](../../managed-kubernetes/concepts/index.md#node-group).
1. Если у вас еще нет [сети](../../vpc/concepts/network.md#network), [создайте ее](../../vpc/operations/network-create.md).
1. Если у вас еще нет [подсетей](../../vpc/concepts/network.md#subnet), [создайте их](../../vpc/operations/subnet-create.md) в [зонах доступности](../../overview/concepts/geo-scope.md), где будут созданы кластер {{ k8s }} и группа узлов.
1. [Создайте сервисные аккаунты](../../iam/operations/sa/create.md):
   * С ролью [{{ roles-editor }}](../../iam/concepts/access-control/roles.md#editor) на каталог, в котором создается кластер {{ managed-k8s-name }}. От его имени будут создаваться ресурсы, необходимые кластеру {{ managed-k8s-name }}.
   * С ролями [{{ roles-cr-puller }}](../../iam/concepts/access-control/roles.md#cr-images-puller) и [{{ roles-cr-pusher }}](../../iam/concepts/access-control/roles.md#cr-images-pusher.md). От его имени узлы будут загружать в реестр собранные в {{ GL }} Docker-образы, а также скачивать их для запуска подов.

   {% note tip %}

   Вы можете использовать один и тот же сервисный аккаунт для управления кластером {{ managed-k8s-name }} и его группами узлов.

   {% endnote %}

1. [Создайте кластер {{ managed-k8s-name }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) и [группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md) со следующими настройками:
   * **Сервисный аккаунт для ресурсов** — созданный ранее сервисный аккаунт с ролью `{{ roles-editor }}`.
   * **Сервисный аккаунт для узлов** — созданный ранее сервисный аккаунт с ролями `{{ roles-cr-puller }}` и `{{ roles-cr-pusher }}`.
   * **Версия {{ k8s }}** — не ниже **1.21**.
   * **Публичный адрес** — `Автоматически`.

   Сохраните идентификатор кластера — он понадобится для следующих шагов.

1. {% include [kubectl-install-links](../../_includes/managed-kubernetes/kubectl-install.md) %}

{% include [k8s-get-token](../../_includes/managed-gitlab/k8s-get-token.md) %}

## Создайте инстанс {{ GL }} {#create-gitlab}

{% list tabs %}


- Инстанс {{ mgl-name }}

  Создайте [инстанс {{ mgl-name }}](../../managed-gitlab/concepts/index.md#instance) [согласно инструкции](../../managed-gitlab/quickstart.md#instance-create).


- ВМ с образом {{ GL }}

  Запустите {{ GL }} на ВМ с публичным IP-адресом.

  {% include [create-gitlab](../../_includes/managed-gitlab/create.md) %}

{% endlist %}

## Настройте {{ GL }} {#configure-gitlab}

{% include [Create a project](../../_includes/managed-gitlab/initialize.md) %}

## Создайте реестр {{ container-registry-name }} {#cr-create}

Для хранения Docker-образов вам понадобится [реестр](../../container-registry/concepts/registry.md) {{ container-registry-name }}.
1. [Создайте реестр](../../container-registry/operations/registry/registry-create.md).
1. [Сохраните идентификатор созданного реестра](../../container-registry/operations/registry/registry-list.md#registry-get) — он понадобится для следующих шагов.

## Создайте тестовое приложение {#app-create}

Создайте тестовое приложение, которое можно будет развернуть в кластере {{ k8s }}:
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
* [Удалите кластер {{ k8s }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
* [Удалите созданную ВМ {{ GL }}](../../compute/operations/vm-control/vm-delete.md) или инстанс {{ mgl-name }}.
* [Удалите созданные Docker-образы](../../container-registry/operations/docker-image/docker-image-delete.md) и [реестр {{ container-registry-name }}](../../container-registry/operations/registry/registry-delete.md).
* [Удалите созданные подсети](../../vpc/operations/subnet-delete.md) и [сети](../../vpc/operations/network-delete.md).
* [Удалите созданные сервисные аккаунты](../../iam/operations/sa/delete.md).

## См. также {#see-also}

* [Создание тестовых ВМ через {{ GL }} CI](../../tutorials/testing/ci-for-snapshots.md).