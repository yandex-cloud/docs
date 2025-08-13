Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}** и в открывшемся окне:

1. Введите имя правила, например `allow-captcha`.
1. Задайте **{{ ui-key.yacloud.smart-web-security.overview.column_priority }}** выше, чем у правил, которые отправляют запросы на капчу.
1. Включите опцию **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**.
1. Укажите параметры правила:

   * **{{ ui-key.yacloud.smart-web-security.overview.column_type }}** — `{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}`.
   * **{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}** — `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}`.
   * **Трафик** — `При условии`.
   * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** — `{{ ui-key.yacloud.component.condition-column.condition_name-requestUri }}`.
   * **Request path** — `Соответствует регулярному выражению`.
   * Введите выражение `/(captcha_smart.*\.(css|js)|showcaptcha|checkcaptcha)`.

1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.