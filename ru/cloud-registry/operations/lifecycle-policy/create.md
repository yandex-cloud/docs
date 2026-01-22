---
title: Создание политики жизненного цикла в {{ cloud-registry-full-name }}
description: Следуя данной инструкции, вы сможете создать политику жизненного цикла в {{ cloud-registry-name }}.
---

# Создание политики жизненного цикла

{% note info %}

В настоящее время создать политику жизненного цикла можно только с помощью [{{ yandex-cloud }} CLI](../../../cli/quickstart.md) и через API. Создание политик через консоль управления пока недоступно.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    1. Подготовьте [правила политики жизненного цикла](../../concepts/lifecycle-policy.md#rule-types) и сохраните их в файл `rules.json`.

       Пример файла `rules.json` с правилом мягкого удаления Docker-образов с тегами старше 30 дней (с периодом ожидания 10 дней):

       ```json
       [
         {
           "path_prefix": "ubuntu.*",
           "delete": {
             "type": "SOFT_DELETE",
             "cooldown_period_days": 10,
             "older_than_days": 30
           },
           "docker_filters": {
             "tag_status": "TAGGED"
           }
         }
       ]
       ```

    1. Создайте политику жизненного цикла:

       ```bash
       yc cloud-registry registry lifecycle-policy create \
         --name <имя_политики> \
         --description <описание_политики> \
         --registry-id <идентификатор_реестра> \
         --state <состояние_политики> \
         --rules <путь_к_rules.json>
       ```

       Где:
       * `--name` — имя политики.
       * `--description` — описание политики (необязательно).
       * `--registry-id` — идентификатор реестра, в котором создается политика.
       * `--state` — состояние политики после создания: `disabled` или `enabled`.
       * `--rules` — путь к файлу с правилами политики в формате JSON.

       {% note info %}

       В реестре может быть включена только **одна** политика жизненного цикла. Чтобы избежать ошибок, рекомендуется создавать политику в состоянии `DISABLED` и включать ее после проверки правил.

       {% endnote %}

       Результат:

       ```text
       done (1s)
       id: e5oq6cd3fuuei1bqmon5
       name: mylp
       description: MyDescr
       rules:
         - path_prefix: ubuntu.*
           delete:
             type: SOFT_DELETE
             cooldown_period_days: "10"
             older_than_days: "30"
           docker_filters:
             tag_status: TAGGED
       state: DISABLED
       registry_id: e5o6a2blpkb6f7j3p3j2
       created_at: "2026-01-21T14:47:01.061840Z"
       modified_at: "2026-01-21T14:47:01.061840Z"
       created_by: bfb7vsfljr3jq6s25o12
       modified_by: bfb7vsfljr3jq6s25o12
       ```

- API {#api}

    Чтобы создать политику жизненного цикла, воспользуйтесь методом REST API [Create](../../api-ref/LifecyclePolicy/create.md) для ресурса [LifecyclePolicy](../../api-ref/LifecyclePolicy/index.md) или вызовом gRPC API [LifecyclePolicyService/Create](../../api-ref/grpc/LifecyclePolicy/create.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../tutorials/lifecycle-policy-examples.md)
* [{#T}](../../concepts/lifecycle-policy.md)

