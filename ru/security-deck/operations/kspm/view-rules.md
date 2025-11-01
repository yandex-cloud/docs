---
title: Просмотр правил контроля {{ k8s }}
description: В данном разделе вы узнаете, как можно посмотреть задействованные правила контроля {{ k8s }}.
---

# Посмотреть правила контроля {{ k8s }}

{% include [note-preview-kspm](../../../_includes/security-deck/note-preview-kspm.md) %}

Чтобы посмотреть задействованные правила контроля {{ k8s }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. В верхней части окна нажмите кнопку **{{ ui-key.yacloud_components.cloud-center.action_more }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и выберите [окружение](../../concepts/workspace.md), для которого хотите посмотреть информацию о правилах. При необходимости воспользуйтесь поиском.
  1. На открывшейся странице **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** перейдите на вкладку **{{ ui-key.yacloud_org.security.controls.ControlsPage.kubernetes_jRCmt }}**. Открывшийся раздел содержит список правил контроля, которые входят в состав заданных для текущего окружения [стандартов безопасности](../../concepts/workspace.md#standards).

      Для каждого правила в таблице отображается следующая информация:
      
      {% note tip %}
      
      При необходимости вы можете изменить отображаемые в таблице столбцы с информацией. Для этого в строке с заголовками столбцов таблицы нажмите значок ![gear](../../../_assets/console-icons/gear.svg), выберите столбцы с необходимой вам информацией и нажмите кнопку **{{ ui-key.yacloud_org.common.apply }}**.
      
      {% endnote %}
      
      * ![traffic-light](../../../_assets/console-icons/traffic-light.svg) — уровень критичности правила: значок, информирующий о том, насколько критичным для безопасности является нарушение правила:
      
          * ![cspm-rule-notice-icon](../../../_assets/security-deck/cspm-rule-notice-icon.svg) — {{ ui-key.yacloud_org.shared.components.severity_info_biSRh }};
          * ![cspm-low-severity-icon](../../../_assets/security-deck/cspm-low-severity-icon.svg) — {{ ui-key.yacloud_org.shared.components.severity_low_tqf9A }}.
          * ![cspm-moderate-severity-icon](../../../_assets/security-deck/cspm-moderate-severity-icon.svg) — {{ ui-key.yacloud_org.shared.components.severity_medium_8LZ4w }}.
          * ![cspm-high-severity-icon](../../../_assets/security-deck/cspm-high-severity-icon.svg) — {{ ui-key.yacloud_org.shared.components.severity_high_cahHH }}.
      * **{{ ui-key.yacloud_org.security.controls.rule-result.controlRule_kr2Bv }}** — название правила и его краткая суть.
      * **{{ ui-key.yacloud_org.security.controls.rule-result.standards_iv6a5 }}** — значок (значки), соответствующие [стандартам безопасности](../../../security-deck/concepts/workspace.md#standards), которые используют данное правило. Если значок цветной, значит, правило проверяется для соответствующего стандарта. Если значок серый — значит, не проверяется.
      * **{{ ui-key.yacloud_org.security.controls.rule-result.verificationMethod_dS9B2 }}** — тип проверки на соответствие контролируемой в окружении инфраструктуры данному правилу:      
          * `automatic`;
          * `manual`.
      * **{{ ui-key.yacloud_org.security.controls.ExceptionDrawer.resources_field_id }}** — идентификатор правила в {{ yandex-cloud }}.
      * **{{ ui-key.yacloud_org.security.controls.rule-result.violations_q7AcU }}** — количество выявленных нарушений правила.

  1. Чтобы посмотреть подробную информацию о конкретном правиле, нажмите на строку таблицы с его именем. Открывшееся окно с подробными сведениями содержит следующие вкладки с информацией:

      {% list tabs %}

      - {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_overview_s9riS }}

        В дополнение к сведениям, указанным в таблице с общей информацией о правилах, вкладка **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_overview_s9riS }}** содержит:
        * информацию о дате и времени последней проверки безопасности;
        * подробную информацию о контролируемых функциональностях, их параметрах или действиях с ними.

      - {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_violations_dkbdT }}

        Вкладка **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_violations_dkbdT }}** содержит список выявленных в результате проверок нарушений правила безопасности. Обнаруженные нарушения правила не будут включены в этот список, если они удовлетворяют условиям заданных для правила [исключений](../../concepts/cspm.md#exceptions).

      - {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_recommendations_qq61Z }}

        Вкладка **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_recommendations_qq61Z }}** содержит инструкции и решения по выполнению действий, предписанных правилом.

      {% endlist %}

{% endlist %}