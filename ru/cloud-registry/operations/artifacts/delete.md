---
title: Удалить артефакт из реестра {{ cloud-registry-name }}
description: Следуя данной инструкции, вы удалите артефакт из реестра {{ cloud-registry-name }}.
---

# Удалить артефакт из реестра

Вы можете удалить [артефакт](../../concepts/artifacts/index.md) из [реестра](../../concepts/registry.md) {{ cloud-registry-name }}.

Для удаления артефакта необходима [роль](../../security/index.md) `cloud-registry.admin` или выше.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится реестр.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-registry }}**.
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud.cloud-registry.title_registries }}**.
    1. Выберите реестр, из которого хотите удалить артефакт.
    1. На панели слева выберите ![cube](../../../_assets/console-icons/cubes-3.svg) **{{ ui-key.yacloud.cloud-registry.title_registry-artifacts }}**.
    1. Нажмите на ![folder](../../../_assets/console-icons/folder-open.svg) имя артефакта.
    1. Найдите нужную версию артефакта в списке.
    1. Напротив артефакта нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
    1. В открывшемся окне нажмите **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. Получите список артефактов в реестре:

        ```bash
        yc cloud-registry registry list-artifacts --id <идентификатор_реестра>
        ```

        Результат:

        ```text
        +----------------------+-------------+--------+------+---------------------+
        |          ID          |    NAME     |  KIND  | PATH |     MODIFIED AT     |
        +----------------------+-------------+--------+------+---------------------+
        | cn172c0ldnh2******** | my-package1 | FOLDER |      | 2026-04-13 14:53:52 |
        | cn1j1rh7k416******** | my-package2 | FOLDER |      | 2026-04-13 14:53:53 |
        | cn1n0ufa7mcq******** | my-package3 | FOLDER |      | 2026-04-13 14:53:54 |
        +----------------------+-------------+--------+------+---------------------+
        ```

    1. Удалите артефакт:

        ```bash
        yc cloud-registry artifact delete --id <идентификатор_артефакта>
        ```

        Результат:

        ```text
        done (1s)
        ```

    1. Проверьте, что артефакт удален:

        ```bash
        yc cloud-registry artifact get --id <идентификатор_артефакта>
        ```   

- API {#api}

    Чтобы удалить артефакт, воспользуйтесь методом REST API [delete](../../api-ref/Artifact/delete.md) для ресурса [Artifact](../../api-ref/Artifact/index.md) или вызовом gRPC API [ArtifactService/Delete](../../api-ref/grpc/Artifact/delete.md).

{% endlist %}

## Автоматическое удаление старых версий {#lifecycle-policy}

Для автоматического удаления старых версий артефактов используйте [политики жизненного цикла](../../concepts/lifecycle-policy.md). Подробнее в разделе [{#T}](../../tutorials/lifecycle-policy-examples.md).

Пример политики:

```json
[
  {
    "path_prefix": ".*",
    "delete": {
      "type": "SOFT_DELETE",
      "cooldown_period_days": 10,
      "version_condition": {
        "versions_count_greater_than": 5
      }
    }
  }
]
```
