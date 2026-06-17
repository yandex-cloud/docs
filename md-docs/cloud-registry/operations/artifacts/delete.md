# Удалить артефакт из реестра

Вы можете удалить [артефакт](../../concepts/artifacts/index.md) из [реестра](../../concepts/registry.md) Cloud Registry.

Для удаления артефакта необходима [роль](../../security/index.md) `cloud-registry.admin` или выше.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится реестр.
    1. Перейдите в сервис **Cloud Registry**.
    1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Реестры**.
    1. Выберите реестр, из которого хотите удалить артефакт.
    1. На панели слева выберите ![cube](../../../_assets/console-icons/cubes-3.svg) **Артефакты**.
    1. Нажмите на ![folder](../../../_assets/console-icons/folder-open.svg) имя артефакта.
    1. Найдите нужную версию артефакта в списке.
    1. Напротив артефакта нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.
    1. В открывшемся окне нажмите **Удалить**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

Для автоматического удаления старых версий артефактов используйте [политики жизненного цикла](../../concepts/lifecycle-policy.md). Подробнее в разделе [Настройка политик жизненного цикла](../../tutorials/lifecycle-policy-examples.md).

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