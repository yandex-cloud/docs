# Непрерывное развертывание контейнеризованных приложений с помощью GitLab

[GitLab](https://about.gitlab.com/) — инструмент [непрерывной интеграции](https://ru.wikipedia.org/wiki/Непрерывная_интеграция). В сценарии описано, как выполнять сборку приложения в Docker-контейнер и применять конфигурацию ресурсов {{ k8s }} в GitLab с помощью инструментов Яндекс.Облака:
- [Перед началом работы](#before-begin)
  - [Создайте виртуальную машину из образа GitLab](#create-gitlab)
  - [Настройте GitLab](#configure-gitlab)
  - [Создайте ресурсы {{ k8s }}](#k8s-create)
  - [Подключите {{ k8s }} кластер к сборкам GitLab](#runners)
- [Настройте сборку Docker-образа из CI](#docker-build)
 - [Аутентифицируйтесь в {{ container-registry-short-name }}](#auth)
- [Настройте автоматическое развертывание {{ k8s }} ресурсов из CI](#k8s-apply)

Если созданные ВМ и кластер больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

Перед тем, как разворачивать приложения, нужно зарегистрироваться в Облаке и создать платежный аккаунт:

{% include [prepare-register-billing](../_solutions_includes/prepare-register-billing.md) %}

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать каталог, в котором будет работать ваша виртуальная машина, на [странице облака](https://console.cloud.yandex.ru/cloud).
 
[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

[Создайте](../../vpc/operations/network-create.md) облачную сеть и подсеть в выбранной зоне доступности.

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

- плата за постоянно запущенные виртуальные машины (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
- плата за использование динамического публичного IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md));
- плата за использование мастера {{ k8s }} (см. [тарифы {{ managed-k8s-full-name }}](../../managed-kubernetes/pricing.md)).

### Создайте виртуальную машину из образа GitLab {#create-gitlab}

Запустите GitLab на виртуальной машине с публичным IP-адресом:

{% include [create-gitlab](../../_includes/gitlab/create.md) %}

### Настройте GitLab {#configure-gitlab}

{% include [create-gitlab](../../_includes/gitlab/initialize.md) %}

### Создайте ресурсы {{ k8s }} {#k8s-create}

Для выполнения сценариев создайте необходимые ресурсы {{ k8s }}:
1. [Создайте кластер {{ k8s }}](../../managed-kubernetes/quickstart.md#kubernetes-cluster-create).
1. [Создайте группу узлов {{ k8s }}](../../managed-kubernetes/quickstart.md#node-group-create).

{% include [k8s-get-token](../../_includes/gitlab/k8s-get-token.md) %}

### Подключите {{ k8s }} кластер к сборкам GitLab {#runners}

{% include notitle [k8s-runner-gitlab](../../_includes/gitlab/k8s-runner.md) %}

{% include [docker-build-gitlab](../../_includes/gitlab/docker-build.md) %}

{% include [kubectl-apply-gitlab](../../_includes/gitlab/kubectl-apply.md) %}

### Удалите созданные ресурсы {#clear-out}

Если вам больше не нужны развернутые приложения и кластер {{ k8s }}:

- [Удалите созданные ВМ](../../compute/operations/vm-control/vm-delete.md).
- Удалите кластер {{ k8s }}.

#### См. также {#see-also}

- [{#T}](../../solutions/testing/ci-for-snapshots.md)
