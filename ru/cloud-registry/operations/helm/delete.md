# Удалить Helm-чарт из реестра

Вы можете удалить [Helm-чарт](https://helm.sh/docs/topics/charts/) из [реестра](../../concepts/registry.md) {{ cloud-registry-name }}. В {{ cloud-registry-name }} Helm-чарты хранятся как [Docker-образы](../../concepts/docker-image.md).

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

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Чтобы удалить Helm-чарт, загруженный в {{ cloud-registry-name }}, выполните команду для удаления Docker-образов:

  ```bash
  yc container image delete <идентификатор_образа>
  ```

{% endlist %}