[Документация Yandex Cloud](../../index.md) > [Yandex Identity Hub](../index.md) > [Пошаговые инструкции](index.md) > Управление организациями > Изменить данные организации

# Изменить данные организации

{% note info %}

Изменить данные организации может пользователь с ролью `organization-manager.admin` или `organization-manager.organizations.owner`. О том, как назначить пользователю роль, читайте в разделе [Роли](../security/index.md#add-role).

{% endnote %}

Чтобы изменить данные вашей организации:

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Cloud Center](https://center.yandex.cloud) с учетной записью администратора или владельца организации.

      На открывшейся главной странице сервиса Cloud Center приведены основные сведения о вашей организации.

      Если у вас несколько организаций, вы можете [переключиться](manage-organizations.md#switch-to-another-org) на нужную. Для этого в левом верхнем углу экрана рядом с названием текущей организации нажмите значок ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите нужную организацию.

  1. Чтобы изменить название и описание текущей организации, нажмите ![pencil](../../_assets/console-icons/pencil.svg) **Редактировать** в блоке с названием организации в центральной части экрана.

  1. В открывшемся окне измените название, техническое название, размер и описание организации.

  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды:

      ```bash
      yc organization-manager organization update --help
      ```

  1. Измените данные организации:

      ```bash
      yc organization-manager organization update \
        --id <идентификатор_организации> \
        --new-name <техническое_название> \
        --title "<название_организации>" \
        --description "<описание_организации>"
      ```

      `--id` — [идентификатор организации](organization-get-id.md). Передайте только те из необязательных параметров `--new-name`, `--title` и `--description`, которые хотите изменить.

- API {#api}

    Воспользуйтесь методом REST API [update](../api-ref/Organization/update.md) для ресурса [Organization](../api-ref/Organization/index.md) или вызовом gRPC API [OrganizationService/Update](../api-ref/grpc/Organization/update.md).

{% endlist %}

{% note info %}

Изменить данные плательщика можно при редактировании [платежного аккаунта](../../billing/operations/change-data.md) в [сервисе Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts).

{% endnote %}