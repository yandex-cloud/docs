1. В блоке **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.rulesSectionTitle_i1Fuw }}** выберите типы правил:

   * **{{ ui-key.yacloud.smart-web-security.baseRulesTitle_xcJEe }}**.
   * **{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}**.
   * **{{ ui-key.yacloud.smart-web-security.overview.label_waf-rule }}**.
   * **{{ ui-key.yacloud.smart-web-security.arlTitle_e3MD8 }}**.

1. В блоке **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.requestsSectionTitle_jMc7W }}** выберите вердикты:

   * **Разрешено (ALLOW)**.
   * **Заблокировано (DENY)**.
   * **Направлено на проверку** — **CAPTCHA** или **JS-проверка**.

1. Для запросов с вердиктом `ALLOW` укажите долю пропускаемых логов в поле **{{ ui-key.yacloud.smart-web-security.SecurityProfileForm.LoggingSection.allowPercentageTitle_3334 }}**: `0%` — записывать все, `100%` — не записывать.
