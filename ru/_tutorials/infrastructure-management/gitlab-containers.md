# Непрерывное развертывание контейнеризованных приложений с помощью GitLab

[GitLab](https://about.gitlab.com/) — инструмент [непрерывной интеграции (continuous integration)](https://ru.wikipedia.org/wiki/Непрерывная_интеграция). В сценарии описано, как выполнять сборку приложения в Docker-контейнер и развертывать приложение из контейнера на [кластере {{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster)) через GitLab с помощью инструментов {{ yandex-cloud }}. После каждого коммита в GitLab будет выполняться сценарий, в котором описаны шаги сборки [Docker-образа](../../container-registry/concepts/docker-image.md). Так же будет происходить применение новой конфигурации кластера {{ k8s }}, в которой будет указано приложение для развертывания. Чтобы настроить необходимую инфраструктуру для хранения исходного кода, сборки Docker-образа и развертывания приложения, выполните следующие шаги:
1. [Подготовьте облако к работе](#before-you-begin)
   1. [Необходимые платные ресурсы](#paid-resources)
   1. [Установите дополнительные зависимости](#prepare)
1. [Создайте виртуальную машину из образа GitLab](#create-gitlab)
1. [Настройте GitLab](#configure-gitlab)
1. [Создайте ресурс {{ container-registry-full-name }}](#cr-create)
1. [Создайте ресурсы {{ k8s }}](#k8s-create)
   1. [Создайте кластер](#k8s-create-cluster)
   1. [Создайте группу узлов](#k8s-create-node-group)
1. [Подключите {{ k8s }} кластер к сборкам GitLab](#runners)
1. [Настройте сборку и развертывание Docker-образа из CI](#ci)

Если созданные ВМ и кластер больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит плата за следующие ресурсы:
* [Диски](../../compute/concepts/disk.md) и постоянно запущенные [ВМ](../../compute/concepts/vm.md) (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Использование динамического [публичного IP-адреса](../../vpc/concepts/ips.md) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).
* Хранение созданных Docker-образов (см. [тарифы {{ container-registry-name }}](../../container-registry/pricing.md)).
* Использование [мастера {{ k8s }}](../../managed-kubernetes/concepts/index.md#master) (см. [тарифы {{ managed-k8s-name }}](../../managed-kubernetes/pricing.md)).

### Установите дополнительные зависимости {#prepare}

Для выполнения сценария установите в локальном окружении:
* [Интерфейс командной строки {{ yandex-cloud }} (YC CLI)](../../cli/operations/install-cli.md).
* [jq](https://stedolan.github.io/jq/).
* [{{ k8s }} CLI (kubectl)](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl/).
* [Helm](https://helm.sh/).

## Создайте виртуальную машину из образа GitLab {#create-gitlab}

Запустите GitLab на ВМ с публичным IP-адресом.

{% include [create-gitlab](../../_includes/gitlab/create.md) %}

## Создайте реестр {{ container-registry-name }} {#cr-create}

Для хранения Docker-образов вам понадобится [реестр](../../container-registry/concepts/registry.md) {{ container-registry-name }}.

{% include [create-cluster](../../_includes/container-registry/create-registry.md) %}

Сохраните идентификатор реестра — он понадобится для следующих шагов.

## Настройте GitLab {#configure-gitlab}

{% include [initialize-gitlab](../../_includes/gitlab/initialize.md) %}

## Создайте тестовое приложение

Создайте тестовое приложение, которое можно будет развернуть в кластере {{ k8s }}:
1. Добавьте конфигурацию Docker-образа.
   1. На левой панели в GitLab перейдите в раздел **Repository** и выберите вкладку **Files**.
   1. На странице проекта нажмите кнопку **New file**.
   1. Назовите файл `Dockerfile`. Добавьте в него конфигурацию Docker-образа:

      ```Dockerfile
      FROM alpine:3.10
      CMD echo "Hello"
      ```

   1. Напишите комментарий к коммиту в поле **Commit message**: `Dockerfile for test application`.
   1. Нажмите кнопку **Commit changes**.
1. Добавьте конфигурацию для разворачивания Docker-образа в кластере {{ k8s }}:
   1. В панели слева перейдите в раздел **Repository** и выберите вкладку **Files**.
   1. Справа от имени проекта нажмите кнопку **+** и в выпадающем меню выберите пункт **New file**.
   1. Назовите файл `k8s.yaml`. Добавьте в него конфигурацию создания [пространства имен](../../managed-kubernetes/concepts/index.md#namespace) и [deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/):

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
                image: cr.yandex/<ID реестра>/hello:__VERSION__
                imagePullPolicy: Always
      ```

   1. Замените в приведенном файле `<ID реестра>` на идентификатор вашего реестра, созданного ранее.
   1. Напишите комментарий к коммиту в поле **Commit message**: `Docker image deployment config`.
   1. Нажмите кнопку **Commit changes**.

## Создайте ресурсы {{ k8s }} {#k8s-create}

Для выполнения сценариев создайте необходимые ресурсы {{ k8s }}: кластер и [группу узлов](../../managed-kubernetes/concepts/index.md#node-group).
1. Если у вас еще нет [сети](../../vpc/concepts/network.md#network), [создайте ее](../../vpc/operations/network-create.md).
1. Если у вас еще нет [подсетей](../../vpc/concepts/network.md#subnet), [создайте их](../../vpc/operations/subnet-create.md) в [зонах доступности](../../overview/concepts/geo-scope.md), где будут созданы кластер {{ k8s }} и группа узлов.
1. Создайте [сервисные аккаунты](../../iam/operations/sa/create.md):
   * Сервисный аккаунт для ресурсов с ролью [{{ roles-editor }}](../../resource-manager/security/#roles-list) на каталог, в котором создается кластер {{ k8s }}. От его имени будут создаваться ресурсы, необходимые кластеру {{ k8s }}.
   * Сервисный аккаунт для узлов с ролью [{{ roles-cr-pusher }}](../../container-registry/security/index.md#required-roles) на каталог с реестром Docker-образов. От его имени узлы будут загружать в реестр собранные в GitLab Docker-образы.

   Вы можете использовать один и тот же сервисный аккаунт для обеих операций.

### Создайте кластер {#k8s-create-cluster}

{% include [create-cluster](../../_includes/managed-kubernetes/cluster-create.md) %}

Сохраните идентификатор кластера - он понадобится для следующих шагов.

### Создайте группу узлов {#k8s-create-node-group}

Создание кластера {{ k8s }} может занять несколько минут. Когда созданный кластер перейдет в статус `RUNNING`, вы можете перейти к созданию группы узлов в этом кластере.

{% include [create-node-group](../../_includes/managed-kubernetes/node-group-create.md) %}

{% include [k8s-get-token](../../_includes/gitlab/k8s-get-token.md) %}

## Создайте {{ GL }} Runner {#runners}

{% include notitle [k8s-runner-gitlab](../../_includes/gitlab/k8s-runner.md) %}

## Настройте сборку и развертывание Docker-образа из CI {#ci}

{% include [configure-ci-gitlab](../../_includes/gitlab/configure-ci.md) %}

## Удалите созданные ресурсы {#clear-out}

Если вам больше не нужны развернутые приложения и кластер {{ k8s }}:
* [Удалите группу узлов {{ k8s }}](../../managed-kubernetes/operations/node-group/node-group-delete.md) и [кластер {{ k8s }}](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
* [Удалите созданные ВМ](../../compute/operations/vm-control/vm-delete.md).
* [Удалите созданные Docker-образы](../../container-registry/operations/docker-image/docker-image-delete.md) и [реестр {{ container-registry-name }}](../../container-registry/operations/registry/registry-delete.md).
* [Удалите созданные подсети](../../vpc/operations/subnet-delete.md) и [сети](../../vpc/operations/network-delete.md).
* [Удалите созданные сервисные аккаунты](../../iam/operations/sa/delete.md).

#### См. также {#see-also}

* [Создание тестовых ВМ через GitLab CI](../../tutorials/testing/ci-for-snapshots.md)