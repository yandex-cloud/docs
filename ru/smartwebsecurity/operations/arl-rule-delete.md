---
title: Удалить правило из профиля ARL
description: Следуя данной инструкции, вы сможете удалить правило из профиля ARL.
---

# Удалить правило из профиля ARL

Базовые правила, а также правила Smart Protection и WAF [удаляются из профиля безопасности](rule-delete.md). 

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль ARL](../concepts/arl.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/arl.svg) **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}**.
  1. Выберите профиль, в котором вы хотите удалить правило.
  1. В блоке **{{ ui-key.yacloud.smart-web-security.arl.section_rules }}** в строке с нужным правилом нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите удаление.

{% endlist %}