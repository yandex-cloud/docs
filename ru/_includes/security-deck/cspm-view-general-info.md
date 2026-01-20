Для каждого правила в таблице отображается следующая информация:

{% note tip %}

При необходимости вы можете изменить отображаемые в таблице столбцы с информацией. Для этого в строке с заголовками столбцов таблицы нажмите значок ![gear](../../_assets/console-icons/gear.svg), выберите столбцы с необходимой вам информацией и нажмите кнопку **{{ ui-key.yacloud_org.common.apply }}**.

{% endnote %}

* {% include [sec-rules-criticality-levels](./sec-rules-criticality-levels.md) %}
* **{{ ui-key.yacloud_org.security.controls.rule-result.controlRule_kr2Bv }}** — название правила и его краткая суть. Чтобы [подробнее узнать](../../security-deck/operations/cspm/view-rules.md#detailed-info) о правиле, нажмите на строку таблицы с его именем.
* **{{ ui-key.yacloud_org.security.controls.rule-result.standards_iv6a5 }}** — значок (значки), соответствующие [стандартам безопасности](../../security-deck/concepts/workspace.md#standards), которые используют данное правило. Если значок цветной, значит, правило проверяется для соответствующего стандарта. Если значок серый — значит, не проверяется.
* **{{ ui-key.yacloud_org.security.controls.rule-result.verificationMethod_dS9B2 }}** — тип проверки на соответствие контролируемой в окружении инфраструктуры данному правилу:

    * `automatic` — проверка на выполнение правила производится автоматически один раз в восемь часов;
    * `manual` — проверку на выполнение правила необходимо выполнить вручную. Нажмите на строку с правилом, чтобы найти инструкцию и узнать подробности.
* **{{ ui-key.yacloud_org.security.controls.ExceptionDrawer.resources_field_id }}** — идентификатор правила в {{ yandex-cloud }}.
* **{{ ui-key.yacloud_org.security.controls.rule-result.violations_q7AcU }}** — количество выявленных нарушений правила.