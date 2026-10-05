---
title: Изменить профиль SolidWall WAF в {{ sws-full-name }}
description: Измените имя, описание, тариф и полосу RPS профиля SolidWall WAF в {{ sws-name }}.
---

# Изменить профиль SolidWall WAF

В профиле можно изменить имя, описание, тариф и [полосу RPS](../concepts/solidwall-waf.md#tariffs).

До появления первого трафика тариф можно изменить сразу. После появления трафика изменение тарифа вступает в силу с первого числа следующего месяца.

Чтобы изменить профиль:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Убедитесь, что у вашей учетной записи есть роль [smart-web-security.editor](../security/index.md#smart-web-security-editor) на каталог с ресурсами SolidWall WAF.
  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) с профилем SolidWall WAF.
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. В строке с нужным профилем нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.smart-web-security.overview.action_edit-profile }}**.
  1. Измените имя, описание, тариф или значение **{{ ui-key.yacloud.smart-web-security.SolidWallProfileForm.titleRpsLimit_b67eQ }}**.
  1. Проверьте выбранные параметры и стоимость в калькуляторе.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}
