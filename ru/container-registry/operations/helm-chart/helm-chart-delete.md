---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Удалить Helm-чарт из реестра

Вы можете удалять чарты [Helm Chart](https://helm.sh/docs/topics/charts/) в репозитории {{ container-registry-name }}. В {{ container-registry-name }} Helm-чарты хранятся так же, как и обычные [Docker-образы](../../concepts/docker-image.md).

## Удалить Helm-чарт локально

{% list tabs %}

- CLI

  Чтобы удалить Helm-чарт локально, выполните команду:

  ```bash
  helm chart remove cr.yandex/<ID реестра>/<имя Helm-чарта>:<версия>
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