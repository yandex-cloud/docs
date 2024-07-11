---
title: "Изменить основные параметры профиля ARL"
description: "Следуя данной инструкции, вы сможете изменить основные параметры профиля ARL."
---

# Изменить основные параметры профиля ARL

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите изменить основные параметры [профиля ARL](../concepts/arl.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Перейдите на вкладку ![image](../../_assets/smartwebsecurity/arl.svg) **Профили ARL**.
  1. Напротив профиля нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.smart-web-security.overview.action_edit-profile }}**.
  1. В открывшемся окне измените параметры:
      * **{{ ui-key.yacloud.common.name }}**.
      * **{{ ui-key.yacloud.common.description }}**.
      * [**{{ ui-key.yacloud.component.label-set.label_labels }}**](../../resource-manager/concepts/labels.md). Чтобы добавить новую метку, нажмите кнопку **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### См. также {#see-also}

* [{#T}](arl-profile-delete.md)
* [{#T}](arl-rule-add.md)
* [{#T}](arl-rule-update.md)

