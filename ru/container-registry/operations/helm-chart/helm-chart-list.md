# Получить информацию об имеющихся Helm-чартах

Вы можете получить список [Helm-чартов](https://helm.sh/docs/topics/charts/) в репозитории {{ container-registry-name }}. В {{ container-registry-name }} Helm-чарты хранятся так же, как и обычные [Docker-образы](../../concepts/docker-image.md).

## Получить информацию о локальных Helm-чартах

{% list tabs %}

- CLI

  Чтобы посмотреть список Helm-чартов локально, выполните команду:

  ```bash
  helm repo list
  ```

{% endlist %}

## Получить информацию о Helm-чартах в реестре

{% list tabs %}

- CLI

  Чтобы посмотреть список Helm-чартов, загруженных в {{ container-registry-name }}, выполните команду, как и для [просмотра](../docker-image/docker-image-list.md#docker-image-list) списка [Docker-образов](../../concepts/docker-image.md)):

  ```bash
  yc container image list
  ```

{% endlist %}