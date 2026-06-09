# Удалить Helm-чарт из реестра

Вы можете удалять [Helm-чарты](https://helm.sh/docs/topics/charts/) в репозитории Container Registry. В Container Registry Helm-чарты хранятся так же, как и обычные [Docker-образы](../../concepts/docker-image.md).

## Удалить Helm-чарт локально

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы удалить Helm-чарт локально, выполните команду:

  ```bash
  helm repo remove cr.yandex/<идентификатор_реестра>/<имя_Helm-чарта>:<версия>
  ```

{% endlist %}

## Удалить Helm-чарт в реестре

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы удалить Helm-чарт, загруженный в Container Registry, выполните команду, как и для [удаления](../docker-image/docker-image-delete.md) Docker-образов:

  ```bash
  yc container image delete <идентификатор_образа>
  ```

{% endlist %}