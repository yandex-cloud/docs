---
title: Добавить шаблон страницы ответа к профилю или правилу
description: Следуя данной инструкции, вы сможете добавить шаблон страницы ответа к профилю безопасности или ARL, а также к правилу в этих профилях.
---

# Добавить шаблон страницы ответа к профилю или правилу

Шаблон страницы ответа можно добавить к профилю безопасности или профилю ARL, а также к отдельным правилам в этих профилях.

Инструкции для CLI и API ниже относятся к профилю безопасности и его правилам. Для профиля ARL и его правил используйте консоль управления.

## Добавление шаблона к профилю {#template-to-profile}

При блокировке запроса используется шаблон, назначенный сработавшему правилу. Если у правила нет своего шаблона, используется шаблон профиля. Если шаблон не назначен ни правилу, ни профилю, клиенту возвращается стандартная страница {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится профиль безопасности или ARL.
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![shield-check](../../_assets/console-icons/shield-check.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}** или ![arl](../../_assets/smartwebsecurity/arl.svg) **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}**.
  1. В строке с нужным профилем нажмите ![options](../../_assets/console-icons/ellipsis.svg) → ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.smart-web-security.overview.action_edit-profile }}**.
  1. В списке **{{ ui-key.yacloud.smart-web-security.CustomPageSelectField.field_custom-page_3Yccb }}** выберите существующий шаблон или [создайте новый](template-create.md).
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды изменения профиля:

     ```bash
     yc smartwebsecurity security-profile update --help
     ```

  1. [Получите идентификатор шаблона](template-manage.md#get-template-info).
  1. Добавьте шаблон к профилю безопасности:

     ```bash
     yc smartwebsecurity security-profile update \
       --id <идентификатор_профиля> \
       --custom-page-id <идентификатор_шаблона> \
       --update-mask custom_page_id
     ```

     Где:

     * `--id` — идентификатор профиля безопасности. Обязательный параметр.
     * `--custom-page-id` — идентификатор шаблона страницы ответа.
     * `--update-mask` — список полей, которые нужно изменить. Значение `custom_page_id` позволяет изменить только привязку шаблона к профилю.

- API {#api}

    Воспользуйтесь методом REST API [update](../api-ref/SecurityProfile/update.md) для ресурса [SecurityProfile](../api-ref/SecurityProfile/index.md) или вызовом gRPC API [SecurityProfileService/Update](../api-ref/grpc/SecurityProfile/update.md).

    В запросе укажите:

    * `securityProfileId` (в gRPC — `security_profile_id`) — идентификатор профиля безопасности.
    * `customPageId` (в gRPC — `custom_page_id`) — [идентификатор шаблона](template-manage.md#get-template-info).
    * `updateMask` — маску обновления со значением `customPageId`. В gRPC укажите путь `custom_page_id` в поле `update_mask`.

    Маска обновления позволяет изменить только привязку шаблона и сохранить остальные настройки профиля.

{% endlist %}

## Добавление шаблона к правилу {#template-to-rule}

{% include [rules-for-template](../../_includes/smartwebsecurity/rules-for-template.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится профиль безопасности или ARL.
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите **{{ ui-key.yacloud.smart-web-security.title_profiles }}** или **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}**.
  1. Выберите профиль, в котором находится нужное правило.
  1. В строке с правилом нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.smart-web-security.overview.action_edit-profile }}**.
  1. В списке **{{ ui-key.yacloud.smart-web-security.CustomPageSelectField.field_custom-page_3Yccb }}** выберите существующий шаблон или [создайте новый](template-create.md).
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды изменения профиля:

     ```bash
     yc smartwebsecurity security-profile update --help
     ```

  1. [Получите идентификатор шаблона](template-manage.md#get-template-info).
  1. Сохраните текущую конфигурацию профиля безопасности в файл:

     ```bash
     yc smartwebsecurity security-profile get \
       --id <идентификатор_профиля> \
       --format yaml > profile.yaml
     ```

  1. Скопируйте из `profile.yaml` поле `security_rules` со всеми правилами в отдельный файл `request.yaml`. В нужном правиле добавьте или измените поле `custom_page_id` на одном уровне с `name` и `priority`:

     ```yaml
     custom_page_id: <идентификатор_шаблона>
     ```

     {% note warning %}

     При обновлении заменяется весь список правил. Правила, которых нет в запросе, будут удалены.

     {% endnote %}

  1. Примените изменения:

     ```bash
     yc smartwebsecurity security-profile update \
       --id <идентификатор_профиля> \
       --request-file request.yaml \
       --update-mask security_rules
     ```

     Параметр `--request-file` задает файл с полным списком правил, а `--update-mask security_rules` ограничивает обновление этим списком.

- API {#api}

    1. Получите текущие правила методом REST API [get](../api-ref/SecurityProfile/get.md) для ресурса [SecurityProfile](../api-ref/SecurityProfile/index.md) или вызовом gRPC API [SecurityProfileService/Get](../api-ref/grpc/SecurityProfile/get.md).
    1. В массиве `securityRules` (в gRPC — `security_rules`) найдите нужное правило и укажите в его поле `customPageId` (в gRPC — `custom_page_id`) [идентификатор шаблона](template-manage.md#get-template-info).
    1. Обновите профиль методом REST API [update](../api-ref/SecurityProfile/update.md) или вызовом gRPC API [SecurityProfileService/Update](../api-ref/grpc/SecurityProfile/update.md). Передайте идентификатор профиля и полный массив правил, включая неизмененные. В поле `updateMask` укажите `securityRules`; для gRPC — путь `security_rules` в поле `update_mask`.

    {% note warning %}

    При обновлении заменяется весь список правил. Правила, которых нет в запросе, будут удалены. Маска обновления позволит сохранить остальные настройки профиля.

    {% endnote %}

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](rule-add.md)
* [{#T}](rule-update.md)
* [{#T}](host-connect.md)
* [{#T}](profile-delete.md)
