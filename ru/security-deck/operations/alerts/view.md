---
title: Просмотр алертов в {{ sd-full-name }}
description: В данном разделе вы узнаете, как в {{ sd-full-name }} можно посмотреть алерты.
---

# Посмотреть алерты

## Посмотреть общую информацию об алертах {#general-info}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. В верхней части окна выберите [окружение](../../concepts/workspace.md).

      Открывшийся раздел содержит список [алертов](../../concepts/alerts.md).

      Для каждого алерта в таблице отображается следующая информация:

      {% note tip %}

      Вы можете изменить отображаемые в таблице столбцы с информацией. Для этого в строке с заголовками столбцов таблицы нажмите значок ![gear](../../../_assets/console-icons/gear.svg), выберите столбцы и нажмите кнопку **{{ ui-key.yacloud_org.common.apply }}**.

      {% endnote %}

      * ![traffic-light](../../../_assets/console-icons/traffic-light.svg) — уровень критичности алерта:
          * ![cspm-rule-notice-icon](../../../_assets/security-deck/cspm-rule-notice-icon.svg) — {{ ui-key.yacloud_org.shared.components.severity_info_biSRh }};
          * ![cspm-low-severity-icon](../../../_assets/security-deck/cspm-low-severity-icon.svg) — {{ ui-key.yacloud_org.shared.components.severity_low_tqf9A }}.
          * ![cspm-moderate-severity-icon](../../../_assets/security-deck/cspm-moderate-severity-icon.svg) — {{ ui-key.yacloud_org.shared.components.severity_medium_8LZ4w }}.
          * ![cspm-high-severity-icon](../../../_assets/security-deck/cspm-high-severity-icon.svg) — {{ ui-key.yacloud_org.shared.components.severity_high_cahHH }}.

      * **{{ ui-key.yacloud_org.security-center.alerts.caption_title }}** — заголовок алерта.
      * **{{ ui-key.yacloud_org.security-center.alerts.caption_category }}** — угроза, с которой связан алерт.
      * **{{ ui-key.yacloud_org.security-center.alerts.caption_sensor }}** — модуль, от которого поступил алерт.
      * **{{ ui-key.yacloud_org.security-center.alerts.caption_status }}** — статус алерта.
      * **{{ ui-key.yacloud_org.security-center.alerts.caption_classification }}** — классификация активности.
      * **{{ ui-key.yacloud_org.security-center.alerts.caption_assignee }}** — пользователь, назначенный ответственным за алерт.
      * **{{ ui-key.yacloud_org.security-center.alerts.caption_created-by }}** и **{{ ui-key.yacloud_org.security-center.alerts.caption_modified-at }}** — даты и время создания и изменения алерта.
      * **{{ ui-key.yacloud_org.security-center.alerts.caption_incident }}** — инцидент, с которым связан алерт.

{% endlist %}


## Найти алерты {#search}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. В верхней части окна выберите [окружение](../../concepts/workspace.md), для которого хотите найти алерты.
  1. Нажмите ![sliders](../../../_assets/console-icons/sliders.svg) **{{ ui-key.yacloud_org.security.alerts.filters-button }}**, чтобы раскрыть панель фильтров.

      Для поиска и анализа вы можете использовать:

      * Текстовый поиск по заголовкам и описаниям алертов.
      * Визуальную группировку по типу алерта.
      * Сортировку по датам и уровню критичности.
      * Фильтры.

          {% note tip %}

          Вы можете изменить отображаемые фильтры. Для этого в строке с фильтрами нажмите значок ![gear](../../../_assets/console-icons/plus.svg) и выберите фильтры.

          {% endnote %}

{% endlist %}


## Посмотреть подробную информацию об алерте {#detailed-info}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. В верхней части окна выберите [окружение](../../concepts/workspace.md).
  1. Чтобы посмотреть дополнительную информацию об алерте, нажмите на строку таблицы с его именем. Открывшееся окно с подробными сведениями содержит следующие вкладки с информацией:

      {% list tabs %}

      - {{ ui-key.yacloud_org.security-center.alerts.title_alert_overview }}

        Вкладка **{{ ui-key.yacloud_org.security-center.alerts.title_alert_overview }}** содержит:
        * Базовую информацию.
        * Список фактов.
        * Список затронутых ресурсов.

      - {{ ui-key.yacloud_org.security-center.alerts.title_alert_details }}

        Вкладка **{{ ui-key.yacloud_org.security-center.alerts.title_alert_details }}** содержит информацию в формате JSON в зависимости от типа угрозы. Например, идентификаторы ресурсов и количество находок по типам данных.

      - {{ ui-key.yacloud_org.security-center.alerts.title_alert_recommendations }}

        Вкладка **{{ ui-key.yacloud_org.security-center.alerts.title_alert_recommendations }}** содержит рекомендации для устранения угрозы.

      - {{ ui-key.yacloud_org.security-center.alerts.title_alert_comments }}

        Вкладка **{{ ui-key.yacloud_org.security-center.alerts.title_alert_comments }}** содержит обсуждение алерта.

      - {{ ui-key.yacloud_org.security-center.alerts.title_alert_history }}

        Вкладка **{{ ui-key.yacloud_org.security-center.alerts.title_alert_history }}** содержит информацию об изменениях, происходивших с алертом.

      {% endlist %}

{% endlist %}