---
title: Удалить приложение SolidWall WAF в {{ sws-full-name }}
description: Отключите домены и удалите приложение из профиля SolidWall WAF в {{ sws-name }}.
---

# Удалить приложение SolidWall WAF

Перед удалением приложения отключите от него все домены. Приложение с подключенными доменами удалить нельзя. При удалении приложения удаляются все данные о нем в профиле SolidWall WAF.

Чтобы удалить приложение:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Убедитесь, что у вашей учетной записи есть роль [smart-web-security.editor](../security/index.md#smart-web-security-editor) на каталог с ресурсами SolidWall WAF.
  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) с профилем SolidWall WAF.
  1. [Перейдите]({{ link-console-main }}/link/smartwebsecurity) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Откройте профиль и нужное приложение.
  1. В строке каждого подключенного домена нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.smart-web-security.SolidWallDomainsActions.label_disable_7HM58 }}**.
  1. Подтвердите отключение домена. Повторите действие для всех доменов приложения.
  1. Вернитесь на страницу профиля. В строке с приложением нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. В окне **{{ ui-key.yacloud.smart-web-security.SolidWallApplicationActions.popup_delete-application-title_eC8hf }}** подтвердите удаление приложения.

{% endlist %}

Отключение доменов от приложения сохраняет сами домены и их профили безопасности в {{ sws-name }}. После удаления всех приложений можно [удалить профиль](solidwall-waf-profile-delete.md).
