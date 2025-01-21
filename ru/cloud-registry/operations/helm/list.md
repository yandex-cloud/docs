# Получить информацию об имеющихся Helm-чартах

Вы можете получить список [Helm-чартов](https://helm.sh/docs/topics/charts/) в [реестре](../../concepts/registry.md) {{ cloud-registry-name }}. В {{ cloud-registry-name }} Helm-чарты хранятся как [Docker-образы](../../concepts/docker-image.md).

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

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Чтобы посмотреть список Helm-чартов, загруженных в {{ cloud-registry-name }}, выполните команду для просмотра списка [Docker-образов](../../concepts/docker-image.md):

  ```bash
  yc container image list
  ```

{% endlist %}