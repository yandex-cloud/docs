---
title: Как создать политику аутентификации в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете создать политику аутентификации в {{ org-full-name }}.
---

# Создать политику аутентификации

{% include [note-preview](../../../_includes/note-preview.md) %}

{% include [auth-policy-intro](../../../_includes/organization/auth-policy-intro.md) %}

{% include [auth-policy-role](../../../_includes/organization/auth-policy-role.md) %}

Чтобы создать политику аутентификации:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}** и перейдите на вкладку **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_auth_policies }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud_org.organization.security-settings.auth-policies-create-policy-action }}**.

  1. В поле **{{ ui-key.yacloud.common.name }}** задайте [имя](*policy_name) политики.
  1. (Опционально) В поле **{{ ui-key.yacloud.common.description }}** задайте произвольное описание политики.
  1. (Опционально) В поле **{{ ui-key.yacloud.common.labels }}** задайте [метки](*labels) для политики.
  1. Убедитесь, что опция **{{ ui-key.yacloud_org.form.auth-policy.caption.active }}** включена.
  1. Настройте **{{ ui-key.yacloud_org.organization.security-settings.AuthPolicyForm.section_title_scope_b9vbe }}** политики:

      {% include [auth-policy-and-logic-notice](../../../_includes/organization/auth-policy-and-logic-notice.md) %}

      1. {% include [auth-policy-create-users](../../../_includes/organization/auth-policy-create-users.md) %}
      1. {% include [auth-policy-create-apps](../../../_includes/organization/auth-policy-create-apps.md) %}
      1. {% include [auth-policy-create-ntwrks](../../../_includes/organization/auth-policy-create-ntwrks.md) %}
      1. {% include [auth-policy-create-action](../../../_includes/organization/auth-policy-create-action.md) %}
      1. Нажмите кнопку **{{ ui-key.yacloud_org.form.auth-policy.create.action.create }}**.

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](../../concepts/applications/index.md)
* [{#T}](../../concepts/authentication-policy.md)
* [{#T}](./activate-deactivate.md)
* [{#T}](./update.md)
* [{#T}](./delete.md)

[*policy_name]: Требования к имени:
* длина — от 3 до 63 символов;
* может содержать строчные буквы латинского алфавита, цифры и дефисы;
* первый символ — буква, последний — не дефис.

[*labels]: Метки — это пары `ключ:значение`, которые можно использовать для разделения ресурсов на логические группы. Подробнее читайте в разделе [{#T}](../../../resource-manager/concepts/labels.md).