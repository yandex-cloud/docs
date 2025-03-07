---
title: Как управлять метками очередей в {{ message-queue-full-name }}
description: Следуя данной инструкции, вы сможете добавлять и удалять метки очередей.
---

# Управление метками очередей

[Метки](../concepts/tags.md) — это пары ключ-значение для логической маркировки очередей.

## Добавить метки при создании очереди {#add-edit-tags-new-queue}

{% list tabs group=instructions %}

- AWS CLI {#cli}

  1. [Установите и настройте](configuring-aws-cli.md) AWS CLI.
  1. При создании очереди укажите необходимые метки:

      ```bash
      aws sqs create-queue \
        --queue-name <имя_очереди> \
        --endpoint <эндпоинт>
        --tags <метки>
      ```

     Где:

     * `--queue-name` — имя создаваемой очереди, например `sample-queue`.
     * `--endpoint` — эндпоинт в значении `https://message-queue.{{ api-host }}/`.
     * `--tags` — список меток очереди, например `key1=string,key2=string`.

     Результат:

     ```json
     {
         "QueueUrl": "https://message-queue.{{ api-host }}/aoeaql9r10cd********/000000000000********/sample-queue"
     }
     ```

{% endlist %}

## Добавить или изменить метки существующей очереди {#add-edit-tags-existing-queue}

{% list tabs group=instructions %}

- AWS CLI {#cli}

  1. [Установите и настройте](configuring-aws-cli.md) AWS CLI.
  1. [Создайте](message-queue-new-queue.md) очередь сообщений.
  1. Добавьте метки:

      ```bash
      aws sqs tag-queue \
        --queue-url <URL_очереди> \
        --endpoint <эндпоинт>
        --tags <метки>
      ```

      Где:

      * `--queue-url` — URL очереди, для которой нужно добавить или изменить метки.
      * `--endpoint` — эндпоинт в значении `https://message-queue.{{ api-host }}/`.
      * `--tags` — список меток очереди, например `key1=string,key2=string`.

{% endlist %}

## Удалить метки очереди {#delete-tags}

{% list tabs group=instructions %}

- AWS CLI {#cli}

  1. Удалите метки существующей очереди:

      ```bash
      aws sqs untag-queue \
        --queue-url <URL_очереди> \
        --endpoint <эндпоинт>
        --tag-keys <ключи меток>
      ```

      Где:

      * `--queue-url` — URL очереди, метки которой нужно удалить.
      * `--endpoint` — эндпоинт в значении `https://message-queue.{{ api-host }}/`.
      * `--tag-keys` — список ключей меток очереди, например `key1 key2`.

{% endlist %}

## Просмотр меток очереди {#list-tags}

{% list tabs group=instructions %}

- AWS CLI {#cli}

  1. Просмотр меток существующей очереди:

      ```bash
      aws sqs list-queue-tags \
        --queue-url <URL_очереди> \
        --endpoint <эндпоинт>
      ```

      Где:

      * `--queue-url` — URL очереди, метки которой нужно получить.
      * `--endpoint` — эндпоинт в значении `https://message-queue.{{ api-host }}/`.

     Результат:

     ```json
     {
         "Tags": {
             "key1": "value1"
         }
     }
     ```


{% endlist %}
