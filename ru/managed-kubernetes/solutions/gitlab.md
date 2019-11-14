# Работа с {{ k8s }} из GitLab

[GitLab](https://about.gitlab.com/) — инструмент [непрерывной интеграции](https://ru.wikipedia.org/wiki/Непрерывная_интеграция). GitLab позволяет собирать, тестировать и запускать контейнеризованные приложения.

Вы можете работать с {{ k8s }} в GitLab двумя способами:
- [Подключить {{ k8s }} кластер к сборкам GitLab](#runners).
- [Автоматически развертывать {{ k8s }} ресурсы из CI](#k8s-apply).

Для любого из способов необходимо выполнить подготовительную работу.

## Перед началом работы {#before-begin}

### Создайте виртуальную машину из образа GitLab {#create-gitlab}

Запустите GitLab на виртуальной машине с публичным IP-адресом:

{% include [create-gitlab](../../_includes/gitlab/create.md) %}

### Настройте GitLab {#configure-gitlab}

{% include [create-gitlab](../../_includes/gitlab/initialize.md) %}

### Создайте ресурсы {{ k8s }} {#k8s-create}

Для выполнения сценариев создайте необходимые ресурсы {{ k8s }}:
1. [Создайте кластер {{ k8s }}](../quickstart.md#kubernetes-cluster-create).
1. [Создайте группу узлов {{ k8s }}](../quickstart.md#node-group-create).

{% include [k8s-get-token](../../_includes/gitlab/k8s-get-token.md) %}

{% include [k8s-runner-gitlab](../../_includes/gitlab/k8s-runner.md) %}

{% include [kubectl-apply-gitlab](../../_includes/gitlab/kubectl-apply.md) %}

#### См. также {#see-also}

- [{#T}](../../container-registry/solutions/gitlab.md)
- [{#T}](../../solutions/testing/ci-for-snapshots.md)
- [{#T}](../../solutions/infrastructure-management/gitlab-containers.md)
