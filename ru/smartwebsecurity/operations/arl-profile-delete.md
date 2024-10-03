---
title: Удалить профиль ARL
description: Следуя данной инструкции, вы сможете удалить профиль ARL.
---

# Удалить профиль ARL

Прежде чем удалить профиль ARL, необходимо удалить его из всех связанных [профилей безопасности](../concepts/profiles.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль ARL](../concepts/arl.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/arl.svg) **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}**.
  1. В строке с нужным профилем ARL в поле **{{ ui-key.yacloud.smart-web-security.arl.label_connected-security-profiles }}** выберите профиль безопасности, в котором используется данный профиль ARL.
  1. Справа сверху нажмите **{{ ui-key.yacloud.smart-web-security.overview.action_edit-profile }}**. В открывшемся окне:

      1. В списке **{{ ui-key.yacloud.smart-web-security.arl.title_profile }}** выберите другой профиль ARL или нажмите **{{ ui-key.yacloud.common.clear }}**.
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
  1. Таким же способом удалите профиль ARL из всех других связанных профилей безопасности.
  1. Вернитесь на страницу профиля ARL, который вы хотите удалить.
  1. Справа сверху нажмите ![recycle-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}** и подтвердите удаление.

{% endlist %}
