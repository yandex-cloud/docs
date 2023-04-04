# Создать кластер GPU

{% note info %}

Чтобы использовать кластеры GPU, обратитесь к своему аккаунт-менеджеру.

{% endnote %}

В этом разделе приведена инструкция для создания кластера GPU.

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания кластера GPU:

      ```
      yc compute gpu-cluster create --help
      ```
      
     Обратите внимание, что сейчас создаются только кластеры с типом соединения `infiniband`.

  1. Создайте кластер в зоне доступности по умолчанию:
      
      ```
      yc compute gpu-cluster create --interconnect-type infiniband
      ```

{% endlist %}

После создания кластера вы сможете [создавать в нем виртуальные машины](gpu-add-to-cluster.md), указывая идентификатор или имя кластера во флагах `--gpu-cluster-id` и `--gpu-cluster-name`. 