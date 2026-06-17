---
title: Как изменить политику аутентификации в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете изменить политику аутентификации в {{ org-full-name }}.
---

# Изменить политику аутентификации

{% include [note-preview](../../../_includes/note-preview.md) %}

{% include [auth-policy-intro](../../../_includes/organization/auth-policy-intro.md) %}

{% include [auth-policy-role](../../../_includes/organization/auth-policy-role.md) %}

Чтобы изменить политику аутентификации:

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева выберите ![shield](../../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud_org.pages.securitySettings }}** и перейдите на вкладку **{{ ui-key.yacloud_org.organization.security-settings.SecuritySettingsPageLayout.tab_auth_policies }}**.
  1. В строке с нужной политикой аутентификации нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. (Опционально) В поле **{{ ui-key.yacloud.common.name }}** измените [имя](*policy_name) политики.
  1. (Опционально) В поле **{{ ui-key.yacloud.common.description }}** измените описание политики.
  1. (Опционально) В поле **{{ ui-key.yacloud.common.labels }}** задайте [метки](*labels) для политики.
  1. (Опционально) Отключите или включите опцию **{{ ui-key.yacloud_org.form.auth-policy.caption.active }}**, чтобы соответственно деактивировать или активировать политику.
  1. (Опционально) Настройте **{{ ui-key.yacloud_org.organization.security-settings.AuthPolicyForm.section_title_scope_b9vbe }}** политики:

      {% include [auth-policy-and-logic-notice](../../../_includes/organization/auth-policy-and-logic-notice.md) %}

      1. {% include [auth-policy-create-users](../../../_includes/organization/auth-policy-create-users.md) %}
      1. {% include [auth-policy-create-apps](../../../_includes/organization/auth-policy-create-apps.md) %}
      1. {% include [auth-policy-create-ntwrks](../../../_includes/organization/auth-policy-create-ntwrks.md) %}
      1. {% include [auth-policy-create-action](../../../_includes/organization/auth-policy-create-action.md) %}
      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](../../concepts/applications.md)
* [{#T}](../../concepts/authentication-policy.md)
* [{#T}](./create.md)
* [{#T}](./activate-deactivate.md)
* [{#T}](./delete.md)

[*policy_name]: Требования к имени:
* длина — от 3 до 63 символов;
* может содержать строчные буквы латинского алфавита, цифры и дефисы;
* первый символ — буква, последний — не дефис.

[*labels]: Метки — это пары `ключ:значение`, которые можно использовать для разделения ресурсов на логические группы. Подробнее читайте в разделе [{#T}](../../../resource-manager/concepts/labels.md).
