# Работа с {{ container-registry-short-name }} из GitLab
[GitLab](https://about.gitlab.com/) — инструмент 
[непрерывной интеграции](https://ru.wikipedia.org/wiki/Непрерывная_интеграция). GitLab позволяет собирать, тестировать и
запускать контейнеризованные приложения. Вы можете настроить GitLab на использование {{ container-registry-short-name }}
для хранения и получения Docker-образов ваших приложений при выполнении сценария сборки.

Чтобы собрать Docker-образ при выполнении сценария GitLab:
* [Перед началом работы](#before-begin)
  * [Создайте виртуальную машину из образа GitLab](#create-gitlab)
  * [Настройте GitLab](#configure-gitlab)
* [Настройте сборку Docker-образа из CI](#docker-build)
 * [Аутентифицируйтесь в {{ container-registry-short-name }}](#auth)

## Перед началом работы {#before-begin}
### Создайте виртуальную машину из образа GitLab {#create-gitlab}
Запустите GitLab на виртуальной машине с публичным IP-адресом:

{% include [create-gitlab](../../_includes/gitlab/create.md) %}

### Настройте GitLab {#configure-gitlab}

{% include [create-gitlab](../../_includes/gitlab/initialize.md) %}

{% include [docker-build-gitlab](../../_includes/gitlab/docker-build.md) %}

#### См. также {#see-also}
* [{#T}](../../managed-kubernetes/solutions/gitlab.md)
* [{#T}](../../solutions/testing/ci-for-snapshots.md)
* [{#T}](../../solutions/infrastructure-management/gitlab-containers.md)