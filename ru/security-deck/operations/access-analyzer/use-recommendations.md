---
title: Работа с рекомендациями в {{ sd-full-name }} {{ access-analyzer-name }}
description: В данном разделе вы узнаете, как в {{ sd-full-name }} {{ access-analyzer-name }} можно получить и применить рекомендации, касающиеся неиспользуемых и избыточно выданных прав доступа к ресурсам организации.
---

# Работа с рекомендациями в модуле {{ access-analyzer-name }}

{% include [access-analyzer-recommendations-preview-notice](../../../_includes/security-deck/access-analyzer-recommendations-preview-notice.md) %}

[Модуль {{ access-analyzer-name }}]({{ link-sd-main }}access-analyzer/) выявляет неиспользуемые и избыточно выданные привилегии и выдает [рекомендации](../../concepts/access-analyzer.md#recommendations) по замене или отзыву избыточных ролей. Если какие-то рекомендации вам не подходят, вы можете скрыть их.

Принимать рекомендации могут пользователи, обладающие одной из ролей: `admin`, `resource-manager.admin`, `organization-manager.admin`, `resource-manager.clouds.owner`, `organization-manager.organizations.owner`.

Чтобы использовать функциональность рекомендаций, [включите](../workspaces/update.md) модуль {{ access-analyzer-name }} в настройках [окружения](../../concepts/workspace.md).

{% include [access-analyzer-recommendations-responsibility-alert](../../../_includes/security-deck/access-analyzer-recommendations-responsibility-alert.md) %}

## Смотреть рекомендации {#view}

{% include [access-analyzer-recommendations-view-role-notice](../../../_includes/security-deck/access-analyzer-recommendations-view-role-notice.md) %}

Чтобы посмотреть рекомендации {{ access-analyzer-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Войдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. Убедитесь, что модуль {{ access-analyzer-name }} включен в вашем [окружении](../../concepts/workspace.md).
  1. На панели слева выберите ![person-gear](../../../_assets/console-icons/person-gear.svg) **{{ ui-key.yacloud_org.ui.label_access-analyzer_4bfVo }}** и в верхней части экрана выберите нужное окружение.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.security.access-analyzer.AccessAnalyzerPageLayout.recommendations_24yZa }}**.

{% endlist %}

В результате откроется страница со списком рекомендаций {{ access-analyzer-name }}. В верхней части экрана расположена строка фильтра, который позволяет выбирать рекомендации по [типу](../../concepts/access-analyzer.md#recommendation-types), проверяемым [субъектам](../../../iam/concepts/access-control/index.md#subject), контролируемым ресурсам и ролям, а также в зависимости от заданной [видимости](#manage-visibility).

Под строкой фильтра отображаются дата и время выполнения последнего анализа.

Список рекомендаций содержит поля:

* **{{ ui-key.yacloud_org.security.access-analyzer.recommendations.subject }}** — имя и тип субъекта, в отношении которого выдана рекомендация.

    Субъектом может быть пользователь, [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), [группа пользователей](../../../organization/concepts/groups.md), а также [системная](../../../iam/concepts/access-control/system-group.md) или [публичная](../../../iam/concepts/access-control/public-group.md) группа.
* **{{ ui-key.yacloud_org.security.access-analyzer.recommendations.resource }}** — имя и тип ресурса, в отношении доступа к которому выдана рекомендация.

    Ресурсом может быть [каталог](*folder_definition), [облако](*cloud_definition) или [организация](*organization_definition). {{ access-analyzer-name }} не выдает рекомендации в отношении ролей, которые выданы субъектам на отдельные ресурсы сервисов {{ yandex-cloud }}, такие как виртуальные машины, сервисные аккаунты, кластеры управляемых баз данных и т.п.
* **{{ ui-key.yacloud_org.security.access-analyzer.recommendations.role }}** — роль, которая назначена субъекту на ресурс и в отношении которой {{ access-analyzer-name }} выдал рекомендацию.
* **{{ ui-key.yacloud_org.security.access-analyzer.recommendations.recommendation }}** — действие, которое рекомендуется выполнить: [заменить](#replace) или [отозвать](#revoke) текущую роль.

    Если роль рекомендуется заменить, в этом поле также отображается список (до пяти) новых ролей, которые будут присвоены субъекту в результате замены.

### Управлять видимостью рекомендаций {#manage-visibility}

Вы можете управлять видимостью рекомендаций, чтобы скрывать в списке те из них, которые вам не подходят.

#### Скрыть рекомендацию {#hide}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. [Откройте](#view) список рекомендаций {{ access-analyzer-name }}.
  1. Убедитесь, что в строке фильтра выбрана опция `{{ ui-key.yacloud_org.security.access-analyzer.recommendations.active }}`.
  1. В строке с рекомендацией, которую вы хотите скрыть, нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![eye-slash](../../../_assets/console-icons/eye-slash.svg) **{{ ui-key.yacloud_org.security.access-analyzer.recommendations.hide }}**.

      В результате рекомендация будет скрыта из списка активных рекомендаций и появится в списке скрытых.

{% endlist %}

#### Вернуть рекомендацию {#restore}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. [Откройте](#view) список рекомендаций {{ access-analyzer-name }}.
  1. В строке фильтра в верхней части экрана выберите опцию `{{ ui-key.yacloud_org.security.access-analyzer.recommendations.hidden }}`.
  1. В строке с рекомендацией, которую вы хотите вернуть в активный список, нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![arrow-uturn-cw-right](../../../_assets/console-icons/arrow-uturn-cw-right.svg) **{{ ui-key.yacloud_org.security.access-analyzer.recommendations.restore }}**.

      В результате рекомендация будет удалена из списка скрытых и вновь появится в списке активных рекомендаций.

{% endlist %}

## Заменить роль {#replace}

Чтобы принять рекомендацию по замене роли:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. [Откройте](#view) список рекомендаций {{ access-analyzer-name }}.
  1. В строке с рекомендацией по замене роли, которую вы хотите принять, нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![arrows-rotate-right](../../../_assets/console-icons/arrows-rotate-right.svg) **{{ ui-key.yacloud_org.security.access-analyzer.recommendations.replace-role }}**.

      В открывшемся окне ознакомьтесь с подробностями предлагаемой замены и в случае вашего согласия нажмите кнопку **{{ ui-key.yacloud_org.security.access-analyzer.ApplyRecommendationDialog.replace_tQxKb }}**.

{% endlist %}

В результате исходная роль, выданная субъекту на ресурс, будет заменена новой ролью или набором ролей на этот же ресурс.

## Отозвать роль {#revoke}

Чтобы принять рекомендацию по отзыву роли:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. [Откройте](#view) список рекомендаций {{ access-analyzer-name }}.
  1. В строке с рекомендацией по отзыву роли, которую вы хотите принять, нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![circle-xmark](../../../_assets/console-icons/circle-xmark.svg) **{{ ui-key.yacloud_org.security.access-analyzer.recommendations.revoke }}**.

      В открывшемся окне ознакомьтесь с подробностями предлагаемого действия и в случае вашего согласия нажмите кнопку **{{ ui-key.yacloud_org.security.access-analyzer.ApplyRecommendationDialog.revoke_dTPYb }}**.

{% endlist %}

В результате роль, выданная субъекту на ресурс, будет отозвана.

#### Полезные ссылки {#see-also}

* [{#T}](../../concepts/access-analyzer.md)
* [{#T}](./analyze-permissions.md)

[*folder_definition]: {% include [folder-definition](../../../_popups/resource-manager/folder-definition.md) %}

[*cloud_definition]: {% include [cloud-definition](../../../_popups/resource-manager/cloud-definition.md) %}

[*organization_definition]: {% include [organization-definition](../../../_popups/identity-hub/organization-definition.md) %}
