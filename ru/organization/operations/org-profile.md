---
title: Изменить данные организации в {{ org-full-name }}
description: Из этой статьи вы узнаете, как изменить данные организации в {{ org-full-name }}.
---

# Изменить данные организации

{% note info %}

Изменить данные организации может пользователь с ролью `organization-manager.admin` или `organization-manager.organizations.owner`. О том, как назначить пользователю роль, читайте в разделе [Роли](../security/index.md#add-role).

{% endnote %}

Чтобы изменить данные вашей организации:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ cloud-center }}]({{ cloud-center-link }}) с учетной записью администратора или владельца организации.

      На открывшейся главной странице сервиса {{ cloud-center }} приведены основные сведения о вашей организации.

      {% include [switch-org-note](../../_includes/organization/switch-org-note.md) %}

  1. Чтобы изменить название и описание текущей организации, нажмите ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud_org.dashboard.organization.action.edit-button }}** в блоке с названием организации в центральной части экрана.

  1. В открывшемся окне измените название, техническое название, размер и описание организации.

  1. Нажмите кнопку **{{ ui-key.yacloud_org.forms.action.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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

{% include [where-change-billing-info](../../_includes/organization/where-change-billing-info.md) %}