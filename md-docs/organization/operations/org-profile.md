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

{% endlist %}

{% note info %}

Изменить данные плательщика можно при редактировании [платежного аккаунта](../../billing/operations/change-data.md) в [сервисе Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts).

{% endnote %}