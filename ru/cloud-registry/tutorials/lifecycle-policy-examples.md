---
title: Настройка политик жизненного цикла в {{ cloud-registry-full-name }}
description: В этом руководстве приведены примеры настройки политик жизненного цикла для автоматического управления артефактами в реестре.
---

# Настройка политик жизненного цикла

[Политики жизненного цикла](../concepts/lifecycle-policy.md) позволяют автоматически управлять хранением и удалением артефактов в реестре. В этом руководстве приведены примеры настройки политик для различных сценариев использования.

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Пример 1: Политика для Docker-образов Ubuntu {#ubuntu-example}

В этом примере создается политика для управления Docker-образами с префиксом пути `ubuntu.*`. Политика содержит три правила:

1. Жесткое удаление всех Docker-образов без тегов старше 7 дней.
1. Мягкое удаление Docker-образов с тегами, если их количество превышает 10 (период ожидания — 7 дней).
1. Сохранение последних 5 версий образов с тегами.

### Подготовьте правила {#ubuntu-rules}

Создайте файл `ubuntu-policy-rules.json` со следующим содержимым:

```json
[
  {
    "path_prefix": "ubuntu.*",
    "delete": {
      "type": "HARD_DELETE",
      "older_than_days": 7
    },
    "docker_filters": {
      "tag_status": "UNTAGGED"
    }
  },
  {
    "path_prefix": "ubuntu.*",
    "delete": {
      "type": "SOFT_DELETE",
      "cooldown_period_days": 7,
      "version_condition": {
        "versions_count_greater_than": 10
      }
    },
    "docker_filters": {
      "tag_status": "TAGGED"
    }
  },
  {
    "path_prefix": "ubuntu.*",
    "keep_by_version": {
      "keep_versions_count": 5
    },
    "docker_filters": {
      "tag_status": "TAGGED"
    }
  }
]
```

1. Первое правило (`HARD_DELETE`) безвозвратно удаляет все Docker-образы без тегов, которые старше 7 дней. Это помогает очистить реестр от промежуточных образов, созданных в процессе сборки.

1. Второе правило (`SOFT_DELETE`) помечает для удаления Docker-образы с тегами, если количество Docker-образов превышает 10. Docker-образы остаются в реестре в течение 7 дней (период ожидания), после чего удаляются безвозвратно. Это позволяет сохранить историю версий, но ограничивает их количество.

1. Третье правило (`keep_by_version`) защищает от удаления последние 5 версий Docker-образов с тегами, даже если они попадают под условия второго правила. Это гарантирует, что всегда будут доступны последние рабочие версии.

{% note info %}

Правила применяются в порядке приоритета: сначала правила сохранения (`keep_by_version`), затем правила удаления. Поэтому последние 5 версий будут защищены от удаления вторым правилом.

{% endnote %}

### Создайте политику {#ubuntu-policy}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Создайте политику жизненного цикла:

    ```bash
    yc cloud-registry registry lifecycle-policy create \
      --name ubuntu-lifecycle-policy \
      --description "Политика для управления Docker-образами Ubuntu" \
      --registry-id <идентификатор_реестра> \
      --state DISABLED \
      --rules ubuntu-policy-rules.json
    ```

    Где:

    `--name` — имя политики.
    `--description` — описание политики.
    `--registry-id` — идентификатор реестра, для которого создается политика.
    `--state` — состояние политики после создания (`DISABLED` — выключена).
    `--rules` — путь к файлу `ubuntu-policy-rules.json`.

- API {#api}

    Чтобы создать политику жизненного цикла, воспользуйтесь методом REST API [Create](../api-ref/LifecyclePolicy/create.md) для ресурса [LifecyclePolicy](../api-ref/LifecyclePolicy/index.md) или вызовом gRPC API [LifecyclePolicyService/Create](../api-ref/grpc/LifecyclePolicy/create.md).

{% endlist %}

## Пример 2: Политика для Java-артефактов {#maven-example}

В этом примере создается политика для управления Java-артефактами с префиксом пути `com/example/myapp/.*`. Политика содержит два правила:

1. Жесткое удаление всех снапшотов.
1. Сохранение последних 2 снапшотов.

### Подготовьте правила {#mavem-rules}

Создайте файл `maven-policy-rules.json` со следующим содержимым:

```json
[
  {
    "path_prefix": "com/example/myapp/.*",
    "delete": {
      "type": "HARD_DELETE",
      "always": true
    },
    "maven_filters": {
      "version_type": "SNAPSHOT"
    }
  },
  {
    "path_prefix": "com/example/myapp/.*",
    "keep_by_version": {
      "keep_versions_count": 2
    },
    "maven_filters": {
      "version_type": "SNAPSHOT"
    }
  }
]
```

1. Первое правило (`HARD_DELETE`) удаляет все снапшоты Java-артефактов, соответствующих префиксу пути. Это помогает автоматически очищать реестр от устаревших снапшотов, которые обычно используются только для разработки и тестирования.

1. Второе правило (`keep_by_version`) защищает от удаления последние 2 снапшота. Это гарантирует, что разработчики всегда имеют доступ к последним собранным снапшотам, даже если они будут удалены первым правилом.

{% note info %}

Правило сохранения (`keep_by_version`) имеет более высокий приоритет, чем правило удаления. Поэтому последние 2 снапшота будут сохранены, несмотря на первое правило, которое удаляет все снапшоты.

{% endnote %}

### Создайте политику {#maven-policy}

{% list tabs group=instructions %}

- CLI {#cli}

    Создайте политику жизненного цикла:

    ```bash
    yc cloud-registry registry lifecycle-policy create \
      --name maven-snapshot-policy \
      --description "Политика для управления снапшотами Java-артефактов" \
      --registry-id <идентификатор_реестра> \
      --state DISABLED \
      --rules maven-policy-rules.json
    ```

    Где:

    `--name` — имя политики.
    `--description` — описание политики.
    `--registry-id` — идентификатор реестра, для которого создается политика.
    `--state` — состояние политики после создания (`DISABLED` — выключена).
    `--rules` — путь к файлу `maven-policy-rules.json`.

- API {#api}

    Чтобы создать политику жизненного цикла, воспользуйтесь методом REST API [Create](../api-ref/LifecyclePolicy/create.md) для ресурса [LifecyclePolicy](../api-ref/LifecyclePolicy/index.md) или вызовом gRPC API [LifecyclePolicyService/Create](../api-ref/grpc/LifecyclePolicy/create.md).

{% endlist %}

## Рекомендации {#recommendations}

* Создавайте политики в состоянии `DISABLED` — это позволит проверить правила перед их применением.
* Используйте мягкое удаление (`SOFT_DELETE`) для важных артефактов, чтобы иметь возможность восстановить их в течение периода ожидания.
* Используйте правила сохранения (`KEEP`) для явной защиты артефактов от удаления — правила `keep_by_version` и `keep_by_age` имеют более высокий приоритет, чем правила удаления, и гарантируют сохранение указанных артефактов.
* Комбинируйте правила сохранения и удаления для гибкого управления артефактами.

#### См. также {#see-also}

* [{#T}](../operations/lifecycle-policy/create.md)
* [{#T}](../concepts/lifecycle-policy.md)
* [{#T}](../concepts/registry.md)
