Чтобы посмотреть дополнительную информацию о правиле контроля безопасности, нажмите на строку таблицы с его именем. Открывшееся окно с подробными сведениями содержит следующие вкладки с информацией:

{% list tabs %}

- {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_overview_s9riS }}

  Вкладка **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_overview_s9riS }}** содержит:

  * идентификатор правила;
  * [набор требований](../../security-deck/concepts/standard-compliance/index.md#security-rule-sets) безопасности, к которому относится данное правило;
  * информацию о дате и времени последней проверки безопасности;
  * способ проверки:

      * `automatic` — проверка на выполнение правила производится автоматически один раз в восемь часов;
      * `manual` — проверку на выполнение правила необходимо выполнить вручную;
  * подробную информацию о контролируемых функциональностях, их параметрах или действиях с ними.

- {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_violations_dkbdT }}

  Вкладка **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_violations_dkbdT }}** содержит список выявленных в результате проверок нарушений правила контроля. Обнаруженные нарушения правила не будут включены в этот список, если они удовлетворяют условиям заданных для правила [исключений](../../security-deck/concepts/cspm.md#exceptions).

- {{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}

  Вкладка **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}** содержит список заданных для правила [исключений](../../security-deck/concepts/cspm.md#exceptions) и элементы [управления](../../security-deck/operations/cspm/manage-exceptions.md) исключениями.

- {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_recommendations_qq61Z }}

  Вкладка **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_recommendations_qq61Z }}** содержит инструкции и решения по выполнению действий, предписанных правилом.

{% endlist %}