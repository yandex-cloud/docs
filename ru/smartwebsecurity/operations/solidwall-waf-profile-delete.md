---
title: Удалить профиль SolidWall WAF
description: Следуя данной инструкции, вы сможете удалить профиль SolidWall WAF.
---

# Удалить профиль SolidWall WAF

Перед удалением профиля SolidWall WAF [удалите все приложения](solidwall-waf-application-delete.md). Перед удалением каждого приложения отключите от него все домены. Профиль с приложениями удалить нельзя.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. В строке с нужным профилем нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.
  1. Если открылось окно с предупреждением о приложениях, удалите их и снова вызовите удаление.
  1. В окне **Удаление профиля SolidWall WAF** введите имя профиля.
  1. Нажмите **Удалить**.

{% endlist %}
