Выберите раздел ![receipt](../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.common.logs }}**:

* Выберите период показа логов одним из способов:

  * Нажмите обозначение интервала, например **Последний час**, и выберите один из вариантов: от **Последние 5 минут** до **Последний день**.
  * Выберите предустановленный период: **Сейчас**, **5m**, **30m**, **1h**, **1d**, **2d** или укажите свой.
  * На временной шкале переместите индикаторы начала и конца периода.

* В строке **Запрос** укажите запрос на [языке фильтрующих выражений](../../logging/concepts/filter.md) и нажмите **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**.

  **Примеры запросов**

  * Показать запросы, для которых сработало правило Smart Protection с отправкой на капчу (в режиме логирования):

    ```
    json_payload.smartwebsecurity.dry_run_matched_rule.rule_type = SMART_PROTECTION and json_payload.smartwebsecurity.dry_run_matched_rule.verdict = CAPTCHA
    ```

  * Аналогичный запрос без режима логирования:

    ```
    json_payload.smartwebsecurity.matched_rule.rule_type = SMART_PROTECTION and json_payload.smartwebsecurity.matched_rule.verdict = CAPTCHA
    ```

  * Показать запросы, заблокированные базовыми правилами с любыми условиями (в режиме логирования):

    ```
    json_payload.smartwebsecurity.dry_run_matched_rule.rule_type = RULE_CONDITION and json_payload.smartwebsecurity.matched_rule.verdict = DENY
    ```

  * Аналогичный запрос без режима логирования:

    ```
    json_payload.smartwebsecurity.matched_rule.rule_type = RULE_CONDITION and json_payload.smartwebsecurity.matched_rule.verdict = DENY
    ```