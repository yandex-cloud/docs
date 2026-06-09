# Проверить соответствие инфраструктуры стандартам безопасности

{% note info %}

Функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}

[Интерфейс соответствия требованиям](../../concepts/standard-compliance/index.md) позволяет просматривать, какие [наборы требований](../../concepts/standard-compliance/index.md#security-rule-sets) активированы в [окружении](../../concepts/workspace.md) в текущий момент, просматривать списки [правил контроля](../../concepts/standard-compliance/index.md#security-rule-sets), входящих в наборы требований, а также управлять исключениями.

Чтобы проверить соответствие инфраструктуры стандартам (наборам требований) безопасности, активированным в текущий момент в окружении:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![seal-check](../../../_assets/console-icons/seal-check.svg) **{{ ui-key.yacloud_org.security-center.label_comp }}**.
     
     В открывшемся окне отобразится список с информацией о наборах требований безопасности, на соответствие которым в текущий момент проверяется инфраструктура в выбранном окружении. Список содержит следующие сведения:
     
     * **{{ ui-key.yacloud_org.security.comp.SetsTable.field_set_title }}** — имя отраслевого стандарта безопасности или нормативного акта, которому соответствует набор требований.
     * **{{ ui-key.yacloud_org.security.comp.SetsTable.field_count_rules }}** — количество правил контроля, входящих в набор требований.
     * **{{ ui-key.yacloud_org.security.comp.SetsTable.field_execution }}** — процентное соотношение выполненных правил к общему количеству правил в наборе требований. Значение `100%` означает полное выполнение требований соответствующего стандарта безопасности или нормативного акта. 
     
         Если проверка ресурсов окружения на соответствие набору требований отключена, поле содержит значение `{{ ui-key.yacloud_org.security.comp.SetsTable.not_verified }}`.
     
         {% note tip %}
         
         В интерфейсе соответствия требованиям вы можете включить или отключить для текущего [окружения](../../concepts/workspace.md) проверку на соответствие тому или иному набору требований. Для этого убедитесь, что вы находитесь в нужном окружении, в строке с нужным набором требований нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите соответственно ![check](../../../_assets/console-icons/check.svg) **{{ ui-key.yacloud_org.security.comp.SetsTable.action_enable_9LUFt }}** или ![xmark](../../../_assets/console-icons/xmark.svg) **{{ ui-key.yacloud_org.security.comp.SetsTable.action_disable_5hgkz }}**.
         
         {% endnote %}
  1. Чтобы посмотреть список правил контроля {{ k8s }}, входящих в набор требований, нажмите на строку с этим набором требований. В открывшемся окне:

      * Дашборд сверху содержит сводку с результатами проверок — в ней указываются наиболее частые нарушения, а также диаграмма критичности выявленных нарушений требований стандарта безопасности или нормативного акта.
      * Ниже дашборда приведена таблица со списком правил контроля, входящих в выбранный набор требований. Для каждого правила в таблице отображается следующая информация:

          * ![traffic-light](../../../_assets/console-icons/traffic-light.svg) — уровень критичности правила: значок, информирующий о том, насколько критичным для безопасности является нарушение правила:
            
            * ![cspm-rule-notice-icon](../../../_assets/security-deck/cspm-rule-notice-icon.svg) — {{ ui-key.yacloud_org.shared.components.severity_info_biSRh }};
            * ![cspm-low-severity-icon](../../../_assets/security-deck/cspm-low-severity-icon.svg) — {{ ui-key.yacloud_org.shared.components.severity_low_tqf9A }}.
            * ![cspm-moderate-severity-icon](../../../_assets/security-deck/cspm-moderate-severity-icon.svg) — {{ ui-key.yacloud_org.shared.components.severity_medium_8LZ4w }}.
            * ![cspm-high-severity-icon](../../../_assets/security-deck/cspm-high-severity-icon.svg) — {{ ui-key.yacloud_org.shared.components.severity_high_cahHH }}.
          * **{{ ui-key.yacloud_org.security.controls.rule-result.controlRule_kr2Bv }}** — имя правила контроля.
          * **{{ ui-key.yacloud_org.security.controls.rule-result.module_63uuk }}** — модуль {{ sd-name }}, который проверяет соответствие инфраструктуры данному правилу: `{{ ui-key.yacloud_org.security.workspaces.module-cspm_gozhj }}` или `Контроль {{ k8s }}® ({{ kspm-name }})`.
          * **{{ ui-key.yacloud_org.security.controls.rule-result.violations_q7AcU }}** — количество нарушений правила, выявленных в выбранном [окружении](../../concepts/workspace.md).

          Чтобы посмотреть подробную информацию о конкретном правиле контроля {{ k8s }}, нажмите на строку таблицы с его именем. Открывшееся окно с подробными сведениями содержит следующие вкладки с информацией:
          
          {% list tabs %}
          
          - {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_overview_s9riS }}
          
            Вкладка **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_overview_s9riS }}** содержит:
          
            * идентификатор правила;
            * [набор требований](../../concepts/standard-compliance/index.md#security-rule-sets) безопасности, к которому относится данное правило;
            * информацию о дате и времени последней проверки безопасности;
            * способ проверки:
          
                * `runtime` — тип правил, применяемый к средам выполнения контейнеров и узлам {{ k8s }};
                * `admission` — тип правил, применяемый к ресурсам кластера {{ k8s }}.
            * подробную информацию о контролируемых функциональностях, их параметрах или действиях с ними.
          
          - {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_violations_dkbdT }}
          
            Вкладка **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_violations_dkbdT }}** содержит список выявленных в результате проверок нарушений правила контроля. Обнаруженные нарушения правила не будут включены в этот список, если они удовлетворяют условиям заданных для правила [исключений](../../concepts/cspm.md#exceptions).
          
          - {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_recommendations_qq61Z }}
          
            Вкладка **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_recommendations_qq61Z }}** содержит инструкции и решения по выполнению действий, предписанных правилом.
          
          {% endlist %}

      {% note tip %}

      Чтобы настроить исключения, которые будут применяться при проверке контролируемой инфраструктуры на соответствие правилу, воспользуйтесь инструкцией [{#T}](manage-exceptions.md).

      {% endnote %}

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/standard-compliance/index.md)