---
title: "Удалить профиль WAF"
description: "Следуя данной инструкции, вы сможете удалить профиль WAF."
---

# Удалить профиль WAF

Перед удалением профиля WAF потребуется удалить все правила WAF из связанных профилей безопасности.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с [профилем WAF](../concepts/waf.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Перейдите на вкладку ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Выберите профиль, который вы хотите удалить. Запомните его идентификатор.
  1. В разделе **{{ ui-key.yacloud.smart-web-security.waf.title_connected-profiles }}** выберите профиль безопасности.
  1. На вкладке **{{ ui-key.yacloud.smart-web-security.overview.title_security-rules }}** удалите правила профиля WAF:
     1. В фильтре **{{ ui-key.yacloud.smart-web-security.label_search-rule-type }}** выберите **Web Application Firewall**.
     1. Напротив правила, которое относится к профилю WAF с нужным идентификатором, нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
     1. Подтвердите удаление.
  1. Таким же образом удалите правила WAF из всех связанных профилей безопасности.
  1. Вернитесь на страницу профиля WAF.
  1. Справа сверху нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите удаление.

{% endlist %}
