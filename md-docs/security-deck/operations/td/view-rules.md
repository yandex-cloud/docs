# Посмотреть правила контроля безопасности модуля {{ td-full-name }} ({{ td-name }})

[Правила](../../concepts/threat-detector.md#rules) контроля безопасности модуля {{ td-full-name }} используются в [окружениях](../../concepts/workspace.md) {{ sd-name }}. Если у вас еще нет окружения, [создайте](../workspaces/create.md) его.

## Посмотреть общую информацию о правилах контроля безопасности {#general-info}

Чтобы посмотреть общую информацию о действующих правилах контроля безопасности модуля {{ td-full-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. В верхней части окна выберите [окружение](../../concepts/workspace.md), для которого хотите посмотреть информацию о правилах.
  1. На открывшейся странице **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** перейдите на вкладку **{{ td-full-name }}**. Открывшийся раздел содержит список правил контроля модуля {{ td-full-name }} для текущего окружения.

      Для каждого правила в таблице отображается следующая информация:
      
      {% note tip %}
      
      При необходимости вы можете изменить отображаемые в таблице столбцы с информацией. Для этого в строке с заголовками столбцов таблицы нажмите значок ![gear](../../../_assets/console-icons/gear.svg), выберите столбцы с необходимой вам информацией и нажмите кнопку **{{ ui-key.yacloud_org.common.apply }}**.
      
      {% endnote %}
      
      * ![traffic-light](../../../_assets/console-icons/traffic-light.svg) — уровень критичности правила: значок, информирующий о том, насколько критичным для безопасности является нарушение правила:
        
        * ![cspm-rule-notice-icon](../../../_assets/security-deck/cspm-rule-notice-icon.svg) — {{ ui-key.yacloud_org.shared.components.severity_info_biSRh }};
        * ![cspm-low-severity-icon](../../../_assets/security-deck/cspm-low-severity-icon.svg) — {{ ui-key.yacloud_org.shared.components.severity_low_tqf9A }}.
        * ![cspm-moderate-severity-icon](../../../_assets/security-deck/cspm-moderate-severity-icon.svg) — {{ ui-key.yacloud_org.shared.components.severity_medium_8LZ4w }}.
        * ![cspm-high-severity-icon](../../../_assets/security-deck/cspm-high-severity-icon.svg) — {{ ui-key.yacloud_org.shared.components.severity_high_cahHH }}.
      * **{{ ui-key.yacloud_org.security.controls.rule-result.controlRule_kr2Bv }}** — название правила и его краткая суть. Чтобы [подробнее узнать](view-rules.md#detailed-info) о правиле, нажмите на строку таблицы с его именем.
      * **{{ ui-key.yacloud_org.security.controls.rule-result.standards_iv6a5 }}** — значок (значки), соответствующие [стандартам безопасности](../../concepts/workspace.md#standards), которые используют данное правило. Если значок цветной, значит, правило проверяется для соответствующего стандарта. Если значок серый — значит, не проверяется.
      * **{{ ui-key.yacloud_org.security.controls.rule-result.verificationMethod_dS9B2 }}** — тип проверки на соответствие контролируемой в окружении инфраструктуры данному правилу:
      
          * `Automatic` — проверка на выполнение правила производится автоматически один раз в восемь часов;
          * `Manual` — проверку на выполнение правила необходимо выполнить вручную. Нажмите на строку с правилом, чтобы найти инструкцию и узнать подробности.
      * **{{ ui-key.yacloud_org.security.controls.ExceptionDrawer.resources_field_id }}** — идентификатор правила в {{ yandex-cloud }}.

{% endlist %}

## Посмотреть подробную информацию о правилах контроля безопасности {#detailed-info}

Чтобы посмотреть подробную информацию о конкретном правиле контроля безопасности модуля {{ td-full-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. В верхней части окна выберите [окружение](../../concepts/workspace.md), для которого хотите посмотреть информацию о правилах.
  1. На открывшейся странице **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** перейдите на вкладку **{{ td-full-name }}**. Открывшийся раздел содержит список правил контроля модуля {{ td-full-name }} для текущего окружения.
  1. Чтобы посмотреть дополнительную информацию о правиле контроля безопасности, нажмите на строку таблицы с его именем. Открывшееся окно с подробными сведениями содержит следующие вкладки с информацией:
     
     {% list tabs %}
     
     - {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_overview_s9riS }}
     
       Вкладка **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_overview_s9riS }}** содержит:
     
       * категорию правила — идентификатор модуля {{ sd-name }}, который использует данное правило;
       * идентификатор правила;
       * [набор требований](../../concepts/standard-compliance/index.md#security-rule-sets) безопасности, к которому относится данное правило;
       * информацию о дате и времени последней проверки безопасности;
       * тип правила — способ проверки:
     
           * `Automatic` — проверка на выполнение правила производится автоматически один раз в восемь часов;
           * `Manual` — проверку на выполнение правила необходимо выполнить вручную;
       * подробную информацию о контролируемых функциональностях, их параметрах или действиях с ними.
     
     - {{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}
     
       Вкладка **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}** содержит список заданных для правила [исключений](../../concepts/threat-detector.md#exceptions) и элементы [управления](manage-exceptions.md) исключениями.
     
     - {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_recommendations_qq61Z }}
     
       Вкладка **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_recommendations_qq61Z }}** содержит инструкции и решения по выполнению действий, предписанных правилом.
     
     {% endlist %}

{% endlist %}

#### См. также {#see-also}

* [{#T}](manage-exceptions.md)
* [{#T}](../../concepts/threat-detector.md)
* [{#T}](../../concepts/workspace.md)