---
title: "Как получить информацию об источнике в {{ cdn-full-name }}"
---

# Получение информации об источниках

Вы можете узнать информацию об отдельном [источнике](#get-origin) или о [группе источников](#get-origin-group).

## Получение информации об источнике {#get-origin}

Чтобы получить URL и другую информацию об источнике:

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации об источнике:

      ```bash
      yc cdn origin get --help
      ```

  1. Получите информацию об источнике, указав его идентификатор или имя:
      
      ```bash
      yc cdn origin get <идентификатор_источника>
      ```

      Результат:

      ```bash
      id: "152152********"
      origin_group_id: "2128********"
      source: test-cdn-1.storage.yandexcloud.net
      enabled: true
      meta:
        bucket:
          name: test-cdn-1
      ```

{% endlist %}

## Получение информации о группе источников {#get-origin-group}

Чтобы получить имя, состав группы и другую информацию о группе источников:

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о группе источников:

      ```bash
      yc cdn origin-group get --help
      ```

  1. Получите информацию о группе источников, указав ее идентификатор или имя:
      
      ```bash
      yc cdn origin-group get <идентификатор_группы_источников>
      ```

      Результат:

      ```bash
      id: "2149********"
      folder_id: b1ggmp8es27t********
      name: test-cdn-group
      use_next: true
      origins:
      - id: "2741********"
        origin_group_id: "2149********"
        source: test-cdn-1-2.storage.yandexcloud.net
        enabled: true
        backup: true
        meta:
          bucket:
            name: test-cdn-1-2
      - id: "2742********"
        origin_group_id: "2149********"
        source: test-cdn-1-1.storage.yandexcloud.net
        enabled: true
        meta:
          bucket:
            name: test-cdn-1-1
      ```

{% endlist %}
