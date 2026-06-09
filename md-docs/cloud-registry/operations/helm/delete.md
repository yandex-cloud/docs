# Удалить Helm-чарт из реестра

Вы можете удалить [Helm-чарт](https://helm.sh/docs/topics/charts/) из [реестра](../../concepts/registry.md) {{ cloud-registry-name }}. В {{ cloud-registry-name }} Helm-чарты хранятся как [Docker-образы](../../concepts/artifacts/docker.md).

## Удалить Helm-чарт локально {#helm-delete-local}

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы удалить Helm-чарт локально, выполните команду:

  ```bash
  helm repo remove {{ cloud-registry }}/<идентификатор_реестра>/<имя_Helm-чарта>:<версия>
  ```

{% endlist %}

## Удалить Helm-чарт в реестре {#helm-delete-registry}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы удалить Helm-чарт, загруженный в {{ cloud-registry-name }}, выполните команду для удаления Docker-образов:

  ```bash
  yc container image delete <идентификатор_образа>
  ```

{% endlist %}