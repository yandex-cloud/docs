---
title: "Как получить информацию о секрете в {{ lockbox-full-name }}"
---

# Получить информацию о секрете, его содержимом и правах доступа

Вы можете получить подробную [информацию о секрете](#secret-info), [содержимое секрета](#secret-contents), а также [просмотреть права доступа к секрету](#secret-access).

## Получить информацию о секрете {#secret-info}

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о секрете:

      ```bash
      yc lockbox secret get --help
      ```

  1. Получите информацию о секрете, указав его имя или идентификатор:

      ```bash
      yc lockbox secret get <имя_или_идентификатор_секрета>
      ```

     Результат:

      ```bash
      id: e6qi98vtdva1********
      folder_id: b1go79qlt1tp********
      created_at: "2023-11-03T15:28:18.909Z"
      name: test-secret
      kms_key_id: abj765aos682********
      status: ACTIVE
      current_version:
        id: e6q7nvojsgmk********
        secret_id: e6qi98vtdva1********
        created_at: "2023-11-03T15:28:18.909Z"
        status: ACTIVE
        payload_entry_keys:
          - example-key
      ```

{% endlist %}

## Получить содержимое секрета {#secret-contents}

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения содержимого секрета:

      ```bash
      yc lockbox payload get --help
      ```

  1. Получите содержимое секрета, указав его имя или идентификатор:

      ```bash
      yc lockbox payload get <имя_или_идентификатор_секрета>
      ```

     Результат:

      ```bash
      version_id: e6q7nvojsgmk********
      entries:
        - key: example-key
          text_value: example-value
      ```

{% endlist %}

## Просмотреть права доступа к секрету {#secret-access}

{% list tabs %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для просмотра прав доступа к секрету:

      ```bash
      yc lockbox secret list-access-bindings --help
      ```

  1. Просмотрите права доступа к секрету, указав его имя или идентификатор:

      ```bash
      yc lockbox secret list-access-bindings <имя_или_идентификатор_секрета>
      ```

     Результат:

      ```bash
      +---------+---------------+----------------------+
      | ROLE ID | SUBJECT TYPE  |      SUBJECT ID      | 
      +---------+---------------+----------------------+
      | viewer  | federatedUser | ajej2i98kcjd******** | 
      +---------+---------------+----------------------+
      ```

{% endlist %}