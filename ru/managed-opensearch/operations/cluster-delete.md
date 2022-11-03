---
title: Удаление кластера Elasticsearch
description: "Вы можете удалить кластер Elasticsearch, если он вам больше не нужен. Все данные в кластере будут удалены. В консоли управления выберите каталог, из которого нужно удалить кластер."
keywords:
  - создание кластера Elasticsearch
  - кластер Elasticsearch
  - Elasticsearch
---

# Удаление кластера

Вы можете удалить кластер {{ ES }}, если он вам больше не нужен. Все данные в кластере будут удалены.

## Перед удалением кластера {#before-you-delete}

* [Отключите защиту от удаления](cluster-update.md#change-additional-settings) для кластера, если она включена.
* [Сохраните идентификатор кластера](cluster-list.md#list-clusters).

  {% include [backups-stored](../../_includes/mdb/backups-stored.md) %}

## Удалить кластер {#delete}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, из которого нужно удалить кластер.
  1. Выберите сервис **{{ mes-name }}**.
  1. Нажмите значок ![image](../../_assets/options.svg) для нужного кластера и выберите пункт **Удалить кластер**.
  1. Подтвердите удаление кластера и нажмите кнопку **Удалить**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы удалить кластер, выполните команду:

    ```bash
    {{ yc-mdb-es }} cluster delete <имя или идентификатор кластера>
    ```

    Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API

  Воспользуйтесь методом API `delete` и передайте идентификатор удаляемого кластера в параметре `clusterId` запроса.

  Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}
