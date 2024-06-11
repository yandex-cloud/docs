---
title: "Изменить основные параметры профиля безопасности"
description: "Следуя данной инструкции, вы сможете изменить основные параметры профиля безопасности."
---

# Изменить основные параметры профиля безопасности

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите изменить основные параметры [профиля безопасности](../concepts/profiles.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Напротив профиля, основные параметры которого вы хотите изменить, нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.smart-web-security.overview.action_edit-profile }}**.
  1. В открывшемся окне измените параметры:
      * **{{ ui-key.yacloud.common.name }}**.
      * **{{ ui-key.yacloud.common.description }}**.
      * [**{{ ui-key.yacloud.component.label-set.label_labels }}**](../../resource-manager/concepts/labels.md). Чтобы добавить новую метку, нажмите кнопку **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
      * **{{ ui-key.yacloud.smart-web-security.form.label_default-action }}** — `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}` или `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}`.
      * [{{ captcha-name }}](../../smartcaptcha/).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- API {#api}

  {% include [api-profile-update](../../_includes/smartwebsecurity/api-profile-update.md) %}

{% endlist %}

### См. также {#see-also}

* [{#T}](rule-add.md)
* [{#T}](rule-update.md)
* [{#T}](host-connect.md)
* [{#T}](profile-delete.md)
