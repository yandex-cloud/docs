---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Получить информацию об имеющихся Helm-чартах

Вы можете получить список чартов [Helm Chart](https://helm.sh/docs/topics/charts/) в репозитории {{ container-registry-name }}. В {{ container-registry-name }} Helm-чарты хранятся так же, как и обычные [Docker-образы](../../concepts/docker-image.md).

## Получить информацию о локальных Helm-чартах

{% list tabs %}

- CLI

  Чтобы посмотреть список Helm-чартов локально, выполните команду:

  ```bash
  helm chart list
  ```

{% endlist %}

## Получить информацию о Helm-чартах в реестре

{% list tabs %}

- CLI

  Чтобы посмотреть список Helm-чартов, загруженных в {{ container-registry-name }}, выполните команду, как и для [просмотра](../docker-image/docker-image-list.md#docker-image-list) списка Docker-образов:

  ```bash
  yc container image list --repository-name <ID реестра>/<имя Helm-чарта>
  ```

{% endlist %}