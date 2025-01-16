В блоке **{{ ui-key.yacloud.smart-web-security.arl.column_rule-conditions }}** определите трафик, для анализа которого будет использоваться правило:
* `{{ ui-key.yacloud.component.condition-column.condition_full-trafic }}` — правило будет использоваться для анализа всего трафика.
* `При условии` — правило будет использоваться для анализа трафика, заданного в поле **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}**:
    * `{{ ui-key.yacloud.component.condition-column.condition_name-ip-range }}` — IP-адрес, диапазон адресов, регион адресов или [список адресов](../../smartwebsecurity/concepts/lists.md);
    * `{{ ui-key.yacloud.component.condition-column.condition_name-header }}` — строка в заголовке HTTP;
    * `{{ ui-key.yacloud.component.condition-column.condition_name-requestUri }}` — путь запроса;
    * `{{ ui-key.yacloud.component.condition-column.condition_name-host }}` — домен, на который пришел запрос;
    * `{{ ui-key.yacloud.component.condition-column.condition_name-httpMethod }}` — метод запроса;
    * `{{ ui-key.yacloud.component.condition-column.condition_name-cookie }}` — строка в заголовке cookie.

    Вы можете задать несколько условий. Для этого в поле **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** выберите все необходимые типы условий.

    Вы также можете задать несколько условий одного типа. Для этого в секции с нужным условием нажмите кнопку ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.condition-column.condition_and }}** или ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.condition-column.condition_or }}**.

    Чтобы удалить условие, нажмите ![options](../../_assets/console-icons/trash-bin.svg).