[Правила](../../smartwebsecurity/concepts/rules.md), которым можно назначить шаблон страницы:

* Правила профиля безопасности:
  * **{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}** с действием **{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}**.
  * **{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}** с действием **{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}** или **{{ ui-key.yacloud.smart-web-security.overview.cell_mode-api }}**.
  * **{{ ui-key.yacloud.smart-web-security.overview.label_waf-rule }}** с действием **{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}** или **{{ ui-key.yacloud.smart-web-security.overview.cell_mode-api }}**.
* Правила профиля ARL с действиями **{{ ui-key.yacloud.smart-web-security.arl.label_rule-action-deny_3kenc }}** или **Временно блокировать все запросы**.

Дополнительно можно изменить внешний вид окна с проверкой {{ captcha-name }}. Для этого [создайте новую](../../smartcaptcha/operations/create-captcha.md) или измените уже существующую капчу, привязанную к профилю безопасности.