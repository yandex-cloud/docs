Выберите раздел **{{ ui-key.yacloud.common.logs }}**:

* Выберите количество сообщений на одной странице и период, например, `1 час`.

* В строке **Запрос** укажите запрос на [языке фильтрующих выражений](../../logging/concepts/filter.md) и нажмите кнопку **Выполнить**.

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