# Получить информацию об имеющихся Helm-чартах

Вы можете получить список [Helm-чартов](https://helm.sh/docs/topics/charts/) в [реестре](../../concepts/registry.md) {{ cloud-registry-name }}. В {{ cloud-registry-name }} Helm-чарты хранятся как [Docker-образы](../../concepts/artifacts/docker.md).

## Получить информацию о локальных Helm-чартах {#helm-list-local}

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы посмотреть список Helm-чартов локально, выполните команду:

  ```bash
  helm repo list
  ```

{% endlist %}

## Получить информацию о Helm-чартах в реестре {#helm-list-registry}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы посмотреть список Helm-чартов, загруженных в {{ cloud-registry-name }}, выполните команду для просмотра списка [Docker-образов](../../concepts/artifacts/docker.md):

  ```bash
  yc container image list
  ```

{% endlist %}