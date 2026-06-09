# Работа со списком исключений

{% note info %}

Функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md). Чтобы получить доступ, обратитесь в [техническую поддержку]({{ link-console-support }}) или к вашему аккаунт-менеджеру.

{% endnote %}

В этом разделе описано, как просматривать список исключений, применять фильтры и управлять развертыванием исключений.

## Перед началом работы {#before-you-begin}

Раздел {{ yandex-siem-full-name }} появится в интерфейсе {{ cloud-center }} как модуль {{ sd-name }} после одобрения заявки на доступ.

Для работы с сервисом вам потребуется [роль](../../../iam/roles-reference.md#ycdr-admin) `ycem.editor`.

## Просмотр списка исключений {#list}

Чтобы просмотреть список исключений:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ sd-name }}]({{ link-sd-main }}).
  1. На панели слева выберите **{{ yandex-siem-full-name }}**.
  1. Перейдите в раздел **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.exceptions }}**.

  Откроется список всех доступных исключений с их статусами и статусами развертывания.

{% endlist %}

## Фильтрация исключений {#filter}

Чтобы отфильтровать исключения по нужным параметрам:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ sd-name }}]({{ link-sd-main }}).
  1. На панели слева выберите **{{ yandex-siem-full-name }}**.
  1. Перейдите в раздел **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.exceptions }}**.
  1. Используйте фильтры над списком:
     * **Статус** — отфильтруйте исключения по статусу: **Healthy**, **Unhealthy** или **Inactive**;
     * **Привязанное правило** — отфильтруйте по правилу корреляции, к которому привязано исключение.

  Список обновится и отобразит только исключения, соответствующие выбранным условиям.

{% endlist %}

## Отметка исключения для развертывания {#mark-for-deploy}

Чтобы применить изменения в исключении, отметьте его для развертывания:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ sd-name }}]({{ link-sd-main }}).
  1. На панели слева выберите **{{ yandex-siem-full-name }}**.
  1. Перейдите в раздел **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.exceptions }}**.
  1. В строке нужного исключения нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_org.security.siem.action_mark-for-deployment_sUf3V }}**.

  Статус развертывания исключения изменится на **{{ ui-key.yacloud_org.security.siem.detect-deployment_created_2GEyZ }}**. После завершения развертывания статус изменится на **{{ ui-key.yacloud_org.security.siem.detect-deployment_deployed_ejgvu }}**.

{% endlist %}

## Отмена развертывания исключения {#cancel-deploy}

Чтобы отменить запланированное развертывание исключения:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ sd-name }}]({{ link-sd-main }}).
  1. На панели слева выберите **{{ yandex-siem-full-name }}**.
  1. Перейдите в раздел **{{ ui-key.yacloud_org.security.siem.SiemPageLayout.exceptions }}**.
  1. В строке нужного исключения нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_org.security.siem.action_not-deploy_sPzwj }}**.

  Статус развертывания исключения изменится обратно на **{{ ui-key.yacloud_org.security.siem.deployment_status_changed }}**.

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/correlation-rules.md).
* [{#T}](manage-exceptions.md).
* [{#T}](../correlation-rules/manage-rules.md).