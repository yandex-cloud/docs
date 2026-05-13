# Посмотреть роли, назначенные в организации

Вы можете посмотреть все [роли](../security/index.md), назначенные субъектам в организации:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.

  1. На панели слева выберите ![persons-lock](../../_assets/console-icons/persons-lock.svg) **Права доступа**.

  1. На странице **Права доступа** отобразится информация о пользователях и ролях, которые им назначены.

     Если у вас несколько организаций, вы можете [переключиться](manage-organizations.md#switch-to-another-org) на нужную. Для этого в левом верхнем углу экрана рядом с названием текущей организации нажмите значок ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите нужную организацию.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Получите список доступных организаций:
     
     ```bash
     yc organization-manager organization list
     ```
     
     Результат:
     
     ```text
     +----------------------+-----------------------------+-------------------------+--------+
     |          ID          |            NAME             |          TITLE          | LABELS |
     +----------------------+-----------------------------+-------------------------+--------+
     | bpf1smsil5q0******** | org1-technical-name         | Organization One        |        |
     | bpf2c65rqcl8******** | org2-technical-name         | Organization Two        |        |
     | bpfaidqca8vd******** | org3-technical-name         | Organization Three      |        |
     +----------------------+-----------------------------+-------------------------+--------+
     ```
     
     Из колонки `ID` скопируйте идентификатор нужной организации.

  1. Посмотрите описание команды CLI для получения списка ролей, назначенных в организации:

     ```bash
     yc organization-manager organization list-access-bindings --help
     ```

  1. Получите перечень ролей, назначенных в организации, указав ее имя или идентификатор:

     ```bash
     yc organization-manager organization list-access-bindings <идентификатор_организации>
     ```

     Результат:

     ```text
     +------------------------------------------+----------------+----------------------+
     |                 ROLE ID                  |  SUBJECT TYPE  |      SUBJECT ID      |
     +------------------------------------------+----------------+----------------------+
     | auditor                                  | serviceAccount | ajefbjkmgjt1******** |
     | admin                                    | userAccount    | asefbskmgjt1******** |
     | organization-manager.organizations.owner | userAccount    | ajcfabjkmgjt******** |
     +------------------------------------------+----------------+----------------------+
     ```

- API {#api}

  Воспользуйтесь методом REST API [ListAccessBindings](../api-ref/Organization/listAccessBindings.md) для ресурса [Organization](../api-ref/Organization/index.md) или вызовом gRPC API [OrganizationService/ListAccessBindings](../api-ref/grpc/Organization/listAccessBindings.md).

{% endlist %}