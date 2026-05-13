# Получить список OIDC-приложений в Yandex Identity Hub


{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
  1. На панели слева выберите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **Приложения**.

     Отобразятся все [OIDC-приложения](../../concepts/applications.md#oidc), доступные в вашей организации.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения списка [OIDC-приложений](../../concepts/applications.md#oidc):

     ```bash
     yc organization-manager idp application oauth application list --help
     ```

  1. Выполните команду:

     ```bash
     yc organization-manager idp application oauth application list --organization-id <идентификатор_организации>
     ```

     Где `--organization-id` — [идентификатор организации](../organization-get-id.md), в которой нужно получить список OIDC-приложений.

     Результат:

     ```text
     +----------------------+--------------------+----------------------+--------------------------------+--------+-----------------------------------------+----------------------------------+--------+---------------------+---------------------+
     |          ID          |        NAME        |   ORGANIZATION ID    |          DESCRIPTION           | STATUS |          GROUP CLAIMS SETTINGS          |           CLIENT GRANT           | LABELS |     CREATED AT      |     UPDATED AT      |
     +----------------------+--------------------+----------------------+--------------------------------+--------+-----------------------------------------+----------------------------------+--------+---------------------+---------------------+
     | ek0o663g4rs2******** | oidc-app           | bpf2c65rqcl8******** |                                | ACTIVE | group_distribution_type:NONE            | client_id:"ajeqqip130i1********" |        | 2025-10-21 10:51:28 | 2025-10-22 11:53:21 |
     +----------------------+--------------------+----------------------+--------------------------------+--------+-----------------------------------------+----------------------------------+--------+---------------------+---------------------+
     ```

- API {#api}

  Воспользуйтесь методом REST API [Application.List](../../idp/application/oauth/api-ref/Application/list.md) для ресурса [Application](../../idp/application/oauth/api-ref/Application/index.md) или вызовом gRPC API [ApplicationService/List](../../idp/application/oauth/api-ref/grpc/Application/list.md).

{% endlist %}