# Непрерывное развертывание контейнеризованных приложений с помощью GitLab
[GitLab](https://about.gitlab.com/) — инструмент 
[непрерывной интеграции](https://ru.wikipedia.org/wiki/Непрерывная_интеграция). В сценарии описано, как выполнять сборку
приложения в Docker-контейнер и применять конфигурацию ресурсов {{ k8s }} в GitLab с помощью инструментов Яндекс.Облака:
* [Перед началом работы](#before-begin)
  * [Создайте виртуальную машину из образа GitLab](#create-gitlab)
  * [Настройте GitLab](#configure-gitlab)
  * [Создайте ресурсы {{ k8s }}](#k8s-create)
  * [Подключите {{ k8s }} кластер к сборкам GitLab](#runners)
* [Настройте сборку Docker-образа из CI](#docker-build)
 * [Аутентифицируйтесь в {{ container-registry-short-name }}](#auth)
* [Настройте автоматическое развертывание {{ k8s }} ресурсов из CI](#k8s-apply)

## Перед началом работы {#before-begin}
### Создайте виртуальную машину из образа GitLab {#create-gitlab}
Запустите GitLab на виртуальной машине с публичным IP адресом:

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

#### См. также {#see-also}
* [{#T}](../../solutions/testing/ci-for-snapshots.md)