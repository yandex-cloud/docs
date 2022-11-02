---
title: "Удаление кластера Apache Kafka"
description: "Вы можете удалить кластер Apache Kafka®, если он вам больше не нужен. Все данные в кластере будут удалены. В консоли управления выберите каталог, из которого нужно удалить кластер."
---

# Удаление кластера {{ KF }}

Вы можете удалить кластер {{ KF }}, если он вам больше не нужен. Все данные в кластере будут удалены.

## Перед удалением кластера {#before-you-delete}

[Отключите защиту от удаления](cluster-update.md#change-additional-settings) для кластера, если она включена.

## Удалить кластер {#delete}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, из которого нужно удалить кластер.
  1. Выберите сервис **{{ mkf-name }}**.
  1. Нажмите значок ![image](../../_assets/options.svg) для нужного кластера и выберите пункт **Удалить кластер**.
  1. Прочитайте предупреждение. Подтвердите удаление кластера и нажмите кнопку **Удалить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить кластер, выполните команду:
  
  ```
  {{ yc-mdb-kf }} cluster delete <имя или идентификатор кластера>
  ```

- {{ TF }}

  {% include [terraform-delete-mdb-cluster](../../_includes/mdb/terraform-delete-mdb-cluster.md) %}

  {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}


- API

  Воспользуйтесь методом API [delete](../api-ref/Cluster/delete.md): передайте значение идентификатора требуемого кластера в параметре `clusterId` запроса.

  Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  

{% endlist %}
