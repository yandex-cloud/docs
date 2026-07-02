[Документация Yandex Cloud](../../index.md) > [Yandex Audit Trails](../index.md) > [Пошаговые инструкции](index.md) > Получение информации о трейле > Получить список трейлов

# Получить список трейлов

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите посмотреть список [трейлов](../concepts/trail.md).
  1. Перейдите в сервис **Audit Trails**.
  1. На странице **Трейлы** отобразится список трейлов.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../../cli/index.md) для просмотра списка [трейлов](../concepts/trail.md):

      ```bash
      yc audit-trails trail list --help
      ```

  1. Получите список трейлов:
     
     ```bash
     yc audit-trails trail list
     ```
     
     Результат:
     
     ```text
     +----------------------+--------------+--------+-------------------+
     |          ID          |     NAME     | STATUS |      FILTERS      |
     +----------------------+--------------+--------+-------------------+
     | cnp82sb0phnm******** | trailfromapi | ACTIVE | storage compute   |
     |                      |              |        | management.events |
     | cnp8v52idttr******** | tf-trail     | ACTIVE | storage compute   |
     |                      |              |        | mdb.postgresql    |
     | cnpnkcubr529******** | test-2       | ACTIVE | compute           |
     +----------------------+--------------+--------+-------------------+
     ```

- API {#api}

  Чтобы посмотреть список [трейлов](../concepts/trail.md), воспользуйтесь методом REST API [list](../api-ref/Trail/list.md) для ресурса [Trail](../api-ref/Trail/index.md) или вызовом gRPC API [TrailService/List](../api-ref/grpc/Trail/list.md).

{% endlist %}