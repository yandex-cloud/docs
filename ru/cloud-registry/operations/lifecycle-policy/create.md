---
title: Создание политики жизненного цикла в {{ cloud-registry-full-name }}
description: Следуя данной инструкции, вы сможете создать политику жизненного цикла в {{ cloud-registry-name }}.
---

# Создание политики жизненного цикла

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. Подготовьте [правила политики жизненного цикла](../../concepts/lifecycle-policy.md#rule-types) и сохраните их в файл `rules.json`.

       Пример файла `rules.json`, который содержит правило мягкого удаления Docker-образов с тегами старше 30 дней (период ожидания — 10 дней):

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
       * `--description` — описание политики. Необязательный параметр.
       * `--registry-id` — идентификатор реестра, для которого создается политика. На количество политик жизненного цикла для одного реестра действуют [квоты и лимиты](../../concepts/limits.md).
       * `--state` — состояние политики после создания: выключена (`DISABLED`) или включена (`ENABLED`).

         {% note info %}
        
          Чтобы избежать ошибок, рекомендуем создавать политику в состоянии `DISABLED` и включать ее после проверки правил.
        
          {% endnote %}

       * `--rules` — путь к файлу с правилами политики в формате JSON.

       Результат:

       ```text
       done (1s)
       id: e5oq6cd3fuue********
       name: my-lifecycle-policy
       description: Моя политика жизненного цикла
       rules:
         - path_prefix: ubuntu.*
           delete:
             type: SOFT_DELETE
             cooldown_period_days: "10"
             older_than_days: "30"
           docker_filters:
             tag_status: TAGGED
       state: DISABLED
       registry_id: e5o6a2blpkb6********
       created_at: "2026-01-21T14:47:01.061840Z"
       modified_at: "2026-01-21T14:47:01.061840Z"
       created_by: bfb7vsfljr3j********
       modified_by: bfb7vsfljr3********
       ```

- API {#api}

    Чтобы создать политику жизненного цикла, воспользуйтесь методом REST API [Create](../../api-ref/LifecyclePolicy/create.md) для ресурса [LifecyclePolicy](../../api-ref/LifecyclePolicy/index.md) или вызовом gRPC API [LifecyclePolicyService/Create](../../api-ref/grpc/LifecyclePolicy/create.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../tutorials/lifecycle-policy-examples.md)
* [{#T}](../../concepts/lifecycle-policy.md)

