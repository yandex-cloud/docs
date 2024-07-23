---
title: "Удалить правило-исключение WAF"
description: "Следуя данной инструкции, вы сможете удалить правило-исключение для WAF."
---

# Удалить правило-исключение WAF

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с профилем WAF.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Перейдите на вкладку ![image](../../_assets/smartwebsecurity/waf.svg) **Профили WAF**.
  1. Выберите профиль, в котором вы хотите удалить [правило-исключение](../concepts/waf.md#exclusion-rules).
  1. Перейдите на вкладку ![image](../../_assets/console-icons/file-xmark.svg) **Правила-исключения**.
  1. Напротив правила нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите удаление.
   
{% endlist %}
