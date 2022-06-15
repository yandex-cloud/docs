# Удалить Helm-чарт из реестра

Вы можете удалять [Helm-чарты](https://helm.sh/docs/topics/charts/) в репозитории {{ container-registry-name }}. В {{ container-registry-name }} Helm-чарты хранятся так же, как и обычные [Docker-образы](../../concepts/docker-image.md).

## Удалить Helm-чарт локально

{% list tabs %}

- CLI

  Чтобы удалить Helm-чарт локально, выполните команду:

  ```bash
  helm repo remove {{ registry }}/<ID реестра>/<имя Helm-чарта>:<версия>
  ```

{% endlist %}

## Удалить Helm-чарт в реестре

{% list tabs %}

- CLI

  Чтобы удалить Helm-чарт, загруженный в {{ container-registry-name }}, выполните команду, как и для [удаления](../docker-image/docker-image-delete.md) Docker-образов:

  ```bash
  yc container image delete <ID образа>
  ```

{% endlist %}