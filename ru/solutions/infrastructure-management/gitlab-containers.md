# Непрерывное развертывание контейнеризованных приложений с помощью GitLab

[GitLab](https://about.gitlab.com/) — инструмент [непрерывной интеграции](https://ru.wikipedia.org/wiki/Непрерывная_интеграция). В сценарии описано, как выполнять сборку приложения в Docker-контейнер и развертывать приложение из контейнера на кластере {{ k8s }} через GitLab с помощью инструментов {{ yandex-cloud }}. После каждого коммита в GitLab будет выполняться сценарий, в котором описаны шаги сборки Docker-образа и применение новой конфигурации {{ k8s }}-кластера, в которой будет указано приложение для развертывания. Чтобы настроить необходимую инфраструктуру для хранения исходного кода, сборки Docker-образа и развертывания приложения, выполните следующие шаги:

- [Подготовьте облако к работе](#before-you-begin)
  - [Необходимые платные ресурсы](#paid-resources)
  - [Установите дополнительные зависимости](#prepare)
- [Создайте виртуальную машину из образа GitLab](#create-gitlab)
- [Настройте GitLab](#configure-gitlab)
- [Создайте ресурс {{ container-registry-short-name }}](#cr-create)
- [Создайте ресурсы {{ k8s }}](#k8s-create)
  - [Создайте кластер](#k8s-create-cluster)
  - [Создайте группу узлов](#k8s-create-node-group)
- [Подключите {{ k8s }} кластер к сборкам GitLab](#runners)
- [Настройте сборку и развертывание Docker-образа из CI](#ci)

Если созданные ВМ и кластер больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_solutions_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

- плата за диски и постоянно запущенные виртуальные машины (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
- плата за использование динамического публичного IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md));
- плата за хранение созданных Docker-образов (см. [тарифы {{ container-registry-full-name }}](../../container-registry/pricing.md));
- плата за использование мастера {{ k8s }} (см. [тарифы {{ managed-k8s-full-name }}](../../managed-kubernetes/pricing.md)).

### Установите дополнительные зависимости {#prepare}

Для выполнения сценария установите в локальном окружении:

* [Интерфейс командной строки {{ yandex-cloud }}](../../cli/operations/install-cli.md).
* [jq](https://stedolan.github.io/jq/).
* [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/).

## Создайте виртуальную машину из образа GitLab {#create-gitlab}

Запустите GitLab на виртуальной машине с публичным IP-адресом:

{% include [create-gitlab](../../_includes/gitlab/create.md) %}

## Создайте реестр {{ container-registry-name }} {#cr-create}

Для хранения Docker-образов вам понадобится реестр {{ container-registry-short-name }}.

{% include [create-cluster](../../_includes/container-registry/create-registry.md) %}

Сохраните идентификатор реестра — он понадобится для следующих шагов.

## Настройте GitLab {#configure-gitlab}

{% include [initialize-gitlab](../../_includes/gitlab/initialize.md) %}

## Создайте тестовое приложение

Создайте тестовое приложение, которое можно будет развернуть в {{ k8s }} кластере:

1. Добавьте конфигурацию Docker-образа

   1. На левой панели в GitLab перейдите в раздел **Project** и выберите вкладку **Details**.
   1. На странице проекта нажмите кнопку **New file**.
   1. Назовите файл `Dockerfile`. Добавьте в него конфигурацию Docker-образа:

      ```Dockerfile
      FROM alpine:3.10
      CMD echo "Hello"
      ```

   1. Напишите комментарий к коммиту в поле **Commit message**: `Dockerfile for test application`.
   1. Нажмите кнопку **Commit changes**.

1. Добавьте конфигурацию для разворачивания Docker-образа в {{ k8s }}-кластере:
   1. В панели слева перейдите в раздел **Project** и выберите вкладку **Details**.
   1. Справа от имени проекта нажмите кнопку **+** и в выпадающем меню выберите пункт **New file**.
   1. Назовите файл `k8s.yaml`. Добавьте в него конфигурацию создания [namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) и [deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/):

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

Для выполнения сценариев создайте необходимые ресурсы {{ k8s }}: кластер и группу узлов.

1. Если у вас еще нет сети, [создайте ее](../../vpc/operations/network-create.md).
1. Если у вас еще нет подсетей, [создайте их](../../vpc/operations/subnet-create.md) в зонах доступности, где будут созданы кластер {{ k8s }} и группа узлов.
1. Создайте [сервисные аккаунты](../../iam/operations/sa/create.md):
    - Сервисный аккаунт для ресурсов с ролью [{{ roles-editor }}](../../resource-manager/security/#roles-list) на каталог, в котором создается кластер {{ k8s }}. От его имени будут создаваться ресурсы, необходимые кластеру {{ k8s }}.
    - Сервисный аккаунт для узлов с ролью [{{ roles-cr-pusher }}](../../container-registry/security/index.md#required-roles) на каталог с реестром Docker-образов. От его имени узлы будут загружать в реестр собранные в GitLab Docker-образы.
    
    Вы можете использовать один и тот же сервисный аккаунт для обеих операций.

### Создайте кластер {#k8s-create-cluster}

{% include [create-cluster](../../_includes/managed-kubernetes/cluster-create.md) %}

Сохраните идентификатор кластера - он понадобится для следующих шагов.

### Создайте группу узлов {#k8s-create-node-group}

Создание кластера {{ k8s }} может занять несколько минут. Когда созданный кластер перейдет в статус `RUNNING`, вы можете перейти к созданию группы узлов в этом кластере.

{% include [create-node-group](../../_includes/managed-kubernetes/node-group-create.md) %}

{% include [k8s-get-token](../../_includes/gitlab/k8s-get-token.md) %}

## Подключите кластер {{ k8s }} к сборкам GitLab {#runners}

{% include notitle [k8s-runner-gitlab](../../_includes/gitlab/k8s-runner.md) %}

## Настройте сборку и развертывание Docker-образа из CI {#ci}

{% include [configure-ci-gitlab](../../_includes/gitlab/configure-ci.md) %}

## Удалите созданные ресурсы {#clear-out}

Если вам больше не нужны развернутые приложения и кластер {{ k8s }}:

- Удалите группу узлов и кластер {{ k8s }}.
- [Удалите созданные ВМ](../../compute/operations/vm-control/vm-delete.md).
- Удалите созданные [Docker-образы](../../container-registry/operations/docker-image/docker-image-delete.md) и [реестр {{ container-registry-short-name }}](../../container-registry/operations/registry/registry-delete.md).
- Удалите созданные [подсети](../../vpc/operations/subnet-delete.md) и [сети](../../vpc/operations/network-delete.md).
- Удалите созданные [сервисные аккаунты](../../iam/operations/sa/delete.md).

#### См. также {#see-also}

- [{#T}](../../solutions/testing/ci-for-snapshots.md)
