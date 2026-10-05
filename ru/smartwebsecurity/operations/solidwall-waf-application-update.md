---
title: Изменить приложение SolidWall WAF в {{ sws-full-name }}
description: Измените имя и описание приложения SolidWall WAF в {{ sws-name }}.
---

# Изменить приложение SolidWall WAF

Изменения правил защиты и способа привязки сессий выполняются через [службу поддержки](../../support/overview.md). В консоли можно изменить имя и описание приложения.

Чтобы изменить приложение:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Убедитесь, что у вашей учетной записи есть роль [smart-web-security.editor](../security/index.md#smart-web-security-editor) на каталог с ресурсами SolidWall WAF.
  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) с профилем SolidWall WAF.
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Откройте профиль с нужным приложением.
  1. В строке с приложением нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. Измените имя или описание приложения.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

{% endlist %}
