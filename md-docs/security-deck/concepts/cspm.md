# Контроль конфигурации ({{ cspm-name }})

{% note info %}

Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}

[Контроль конфигурации ({{ cspm-name }})](cspm.md) — это инструмент, контролирующий уровень безопасности инфраструктуры на основе стандартов безопасности, таких как [Стандарт по защите облачной инфраструктуры {{ yandex-cloud }}](../../security/standard/all.md).

Контроль конфигурации ({{ cspm-name }}) в заданном [окружении](workspace.md) выполняет проверки соответствия облачной инфраструктуры и приложений, развернутых на платформе {{ yandex-cloud }}, комплексным требованиям и лучшим практикам в сфере безопасности. [Правила](cspm.md#rules) и [исключения](cspm.md#exceptions) модуля позволяют обеспечить соответствие политикам безопасности и защиту от общих угроз и уязвимостей в облачной среде.

Проверка возобновляется каждые 8 часов. По завершении обновляются данные о количестве нарушений, применяются созданные исключения и отправляются алерты.

## Стандарты {#standards}

В настоящий момент модуль Контроль конфигурации ({{ cspm-name }}) поддерживает проверку инфраструктуры на соответствие следующим стандартам безопасности:

* ![base-standard-yc](../../_assets/security-deck/cspm-base-yc.svg) [Базовые правила безопасности облачной платформы {{ yandex-cloud }}](standard-compliance/yc-security-baseline.md) — минимальный набор требований безопасности, обеспечивающих базовую защиту облачной инфраструктуры и приложений, развернутых на платформе {{ yandex-cloud }}.
* ![cspm-standard-yc](../../_assets/security-deck/cspm-standard-yc.svg) [Стандарт по защите облачной инфраструктуры {{ yandex-cloud }}](standard-compliance/yc-cloud-security-standard.md) — [стандарт](../../security/standard/all.md) предоставляет комплексные требования безопасности и лучшие практики для защиты облачной инфраструктуры и приложений, развернутых на платформе {{ yandex-cloud }}. Эти элементы помогают обеспечить соответствие политикам безопасности и защиту от общих угроз и уязвимостей в облачной среде.
* ![pci-dss-standard](../../_assets/security-deck/cspm-pci-dss.svg) [PCI DSS](https://yandex.cloud/ru/security/standards/pci) (Payment Card Industry Data Security Standard) — стандарт безопасности данных платежных карт, включающий требования к управлению безопасностью, правилам, процедурам, сетевой архитектуре, разработке программного обеспечения и другим критически важным мерам защиты.
* ![152-fz-standard](../../_assets/security-deck/cspm-152-fz.svg) Требования [ФСТЭК (Приказ № 21) для защиты персональных данных](https://fstec.ru/dokumenty/vse-dokumenty/prikazy/prikaz-fstek-rossii-ot-18-fevralya-2013-g-n-21) — стандарт содержит меры по защите персональных данных от неправомерного или случайного доступа, уничтожения, изменения, блокирования, копирования, предоставления, распространения, а также от иных неправомерных действий в отношении персональных данных.

## Правила {#rules}

[Посмотреть](../operations/cspm/view-rules.md) сведения о действующих для [окружения](workspace.md) правилах контроля безопасности модуля {{ cspm-name }} и об обнаруженных в инфраструктуре окружения нарушениях таких правил вы можете на странице **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** на вкладке **{{ ui-key.yacloud_org.security.controls.ControlsPageLayout.configuration_w7Kw7 }}**. Этот раздел содержит список правил контроля, которые входят в состав заданных для текущего окружения [стандартов безопасности](#standards).

### Общая информация о правилах {#general-info}

Для каждого правила в таблице отображается следующая информация:

{% note tip %}

При необходимости вы можете изменить отображаемые в таблице столбцы с информацией. Для этого в строке с заголовками столбцов таблицы нажмите значок ![gear](../../_assets/console-icons/gear.svg), выберите столбцы с необходимой вам информацией и нажмите кнопку **{{ ui-key.yacloud_org.common.apply }}**.

{% endnote %}

* ![traffic-light](../../_assets/console-icons/traffic-light.svg) — уровень критичности правила: значок, информирующий о том, насколько критичным для безопасности является нарушение правила:
  
  * ![cspm-rule-notice-icon](../../_assets/security-deck/cspm-rule-notice-icon.svg) — {{ ui-key.yacloud_org.shared.components.severity_info_biSRh }};
  * ![cspm-low-severity-icon](../../_assets/security-deck/cspm-low-severity-icon.svg) — {{ ui-key.yacloud_org.shared.components.severity_low_tqf9A }}.
  * ![cspm-moderate-severity-icon](../../_assets/security-deck/cspm-moderate-severity-icon.svg) — {{ ui-key.yacloud_org.shared.components.severity_medium_8LZ4w }}.
  * ![cspm-high-severity-icon](../../_assets/security-deck/cspm-high-severity-icon.svg) — {{ ui-key.yacloud_org.shared.components.severity_high_cahHH }}.
* **{{ ui-key.yacloud_org.security.controls.rule-result.controlRule_kr2Bv }}** — название правила и его краткая суть. Чтобы [подробнее узнать](../operations/cspm/view-rules.md#detailed-info) о правиле, нажмите на строку таблицы с его именем.
* **{{ ui-key.yacloud_org.security.controls.rule-result.standards_iv6a5 }}** — значок (значки), соответствующие [стандартам безопасности](workspace.md#standards), которые используют данное правило. Если значок цветной, значит, правило проверяется для соответствующего стандарта. Если значок серый — значит, не проверяется.
* **{{ ui-key.yacloud_org.security.controls.rule-result.violations_q7AcU }}** — количество выявленных нарушений правила.
* **{{ ui-key.yacloud_org.security.controls.rule-result.verificationMethod_dS9B2 }}** — тип проверки на соответствие контролируемой в окружении инфраструктуры данному правилу:

    * `Automatic` — проверка на выполнение правила производится автоматически один раз в восемь часов;
    * `Manual` — проверку на выполнение правила необходимо выполнить вручную. Нажмите на строку с правилом, чтобы найти инструкцию и узнать подробности.
* **{{ ui-key.yacloud_org.security.controls.ExceptionDrawer.resources_field_id }}** — идентификатор правила в {{ yandex-cloud }}.

### Подробная информация о правиле {#detailed-info}

Чтобы посмотреть дополнительную информацию о правиле контроля безопасности, нажмите на строку таблицы с его именем. Открывшееся окно с подробными сведениями содержит следующие вкладки с информацией:

{% list tabs %}

- {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_overview_s9riS }}

  Вкладка **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_overview_s9riS }}** содержит:

  * категорию правила — идентификатор модуля {{ sd-name }}, который использует данное правило;
  * идентификатор правила;
  * [набор требований](standard-compliance/index.md#security-rule-sets) безопасности, к которому относится данное правило;
  * информацию о дате и времени последней проверки безопасности;
  * тип правила — способ проверки:

      * `Automatic` — проверка на выполнение правила производится автоматически один раз в восемь часов;
      * `Manual` — проверку на выполнение правила необходимо выполнить вручную;
  * подробную информацию о контролируемых функциональностях, их параметрах или действиях с ними.

- {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_violations_dkbdT }}

  Вкладка **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_violations_dkbdT }}** содержит список выявленных в результате проверок нарушений правила контроля. Обнаруженные нарушения правила не будут включены в этот список, если они удовлетворяют условиям заданных для правила [исключений](cspm.md#exceptions).

- {{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}

  Вкладка **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}** содержит список заданных для правила [исключений](cspm.md#exceptions) и элементы [управления](../operations/cspm/manage-exceptions.md) исключениями.

- {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_recommendations_qq61Z }}

  Вкладка **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_recommendations_qq61Z }}** содержит инструкции и решения по выполнению действий, предписанных правилом.

{% endlist %}

## Исключения из правил {#exceptions}

Исключения позволяют гибко настраивать, когда и для каких объектов нужно игнорировать результаты проверки на соответствие правилам контроля безопасности модуля {{ cspm-name }}. [Посмотреть список](../operations/cspm/manage-exceptions.md#view-exceptions-list) заданных для окружения исключений вы можете в [интерфейсе {{ sd-name }}]({{ link-sd-main }}) в разделе **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.

При [создании исключения](../operations/cspm/manage-exceptions.md#create-exception) вы можете задать для него следующие настройки:

* **{{ ui-key.yacloud_org.security.controls.ExceptionOverview.info_type_1dxbZ }}** — вариант действия для создаваемого исключения:

    * `{{ ui-key.yacloud_org.security.controls.ResourceExceptionForm.title_reportCompliance_re4wo }}` — при соответствии заданным в исключении условиям ресурс будет генерировать только сигналы о соответствии правилу.
    * `{{ ui-key.yacloud_org.security.controls.ResourceExceptionForm.title_exclude_uK4FD }}` — при соответствии заданным в исключении условиям ресурс не будет генерировать никакие сигналы: ни о соответствии, ни о нарушении правила.

* **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.scopeOfControl_aRkwB }}** — ресурсы, которые требуется исключить при проверке правил безопасности:

    * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.allResources_2ax5E }}` — чтобы исключить из проверки все ресурсы, контролируемые в [окружении](workspace.md).
    * `Выбранные ресурсы` — чтобы исключить из проверки только явно заданную часть ресурсов.
* **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.section-title }}** — правила контроля безопасности модуля, для которых не должны проводиться проверки выбранных ресурсов:

    * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_all }}` — чтобы исключить для выбранных ресурсов проверку на соответствие всем правилам безопасности.
    * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_selected }}` — чтобы исключить для выбранных ресурсов проверку на соответствие явно заданному набору правил.
* **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.section-title_3YcSF }}** — причина, по которой создается исключение. Указывается в свободной текстовой форме.

Чтобы отменить заданные исключением ограничения для проверок на соответствие правилам, [удалите](../operations/cspm/manage-exceptions.md#delete-exception) это исключение.

#### См. также {#see-also}

* [{#T}](workspace.md)
* [{#T}](../operations/cspm/view-rules.md)
* [{#T}](../operations/cspm/manage-exceptions.md)