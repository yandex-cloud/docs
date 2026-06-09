# Работа со списком правил корреляции

{% note info %}

Функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md). Чтобы получить доступ, обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.

{% endnote %}

В этом разделе описано, как просматривать список правил корреляции, применять фильтры и управлять развертыванием правил.

## Перед началом работы {#before-you-begin}

Раздел {{ yandex-siem-full-name }} появится в интерфейсе {{ cloud-center }} как модуль {{ sd-name }} после одобрения заявки на доступ.

Для работы с сервисом вам потребуется [роль](../../../iam/roles-reference.md#ycdr-admin) `ycem.editor`.

## Просмотр списка правил {#list}

Чтобы просмотреть список правил корреляции:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ sd-name }}]({{ link-sd-main }}).
  1. На панели слева выберите **{{ yandex-siem-full-name }}**.
  1. Перейдите в раздел **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.correlationRules }}**.

  Откроется список всех доступных правил с их статусами и статусами развертывания. Нажмите на заголовок столбца, чтобы отсортировать список по этому столбцу.

{% endlist %}

## Фильтрация правил {#filter}

Чтобы отфильтровать правила корреляции по нужным параметрам:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ sd-name }}]({{ link-sd-main }}).
  1. На панели слева выберите **{{ yandex-siem-full-name }}**.
  1. Перейдите в раздел **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.correlationRules }}**.
  1. Используйте фильтры над списком:
     * **Статус** — отфильтруйте правила по статусу: **Healthy**, **Unhealthy** или **Inactive**;
     * **Тип** — отфильтруйте по типу: **Предустановленные** или **Пользовательские**;
     * **{{ ui-key.yacloud_org.security.siem.CorrelationRuleTable.category }}** — отфильтруйте по категории угрозы;
     * **Критичность** — отфильтруйте по уровню серьезности срабатывания.

  Список обновится и отобразит только правила, соответствующие выбранным условиям.

{% endlist %}

## Отметка правила для развертывания {#mark-for-deploy}

Чтобы применить изменения в правиле, отметьте его для развертывания:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ sd-name }}]({{ link-sd-main }}).
  1. На панели слева выберите **{{ yandex-siem-full-name }}**.
  1. Перейдите в раздел **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.correlationRules }}**.
  1. В строке нужного правила нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_org.security.siem.action_mark-for-deployment_sUf3V }}**.

  Статус развертывания правила изменится на **{{ ui-key.yacloud_org.security.siem.detect-deployment_created_2GEyZ }}**. После завершения развертывания статус изменится на **{{ ui-key.yacloud_org.security.siem.detect-deployment_deployed_ejgvu }}**.

{% endlist %}

## Отмена развертывания правила {#cancel-deploy}

Чтобы отменить запланированное развертывание правила:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ sd-name }}]({{ link-sd-main }}).
  1. На панели слева выберите **{{ yandex-siem-full-name }}**.
  1. Перейдите в раздел **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.correlationRules }}**.
  1. В строке нужного правила нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_org.security.siem.action_not-deploy_sPzwj }}**.

  Статус развертывания правила изменится обратно на **{{ ui-key.yacloud_org.security.siem.deployment_status_changed }}**.

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/correlation-rules.md).
* [{#T}](manage-rules.md).
* [{#T}](../exceptions/manage-exceptions.md).