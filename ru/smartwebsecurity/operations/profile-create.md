# Создать профиль безопасности

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать [профиль безопасности](../concepts/profiles.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.action_empty }}**.
  1. Выберите один из вариантов создания:
      * **{{ ui-key.yacloud.smart-web-security.title_default-template }}** (рекомендуется). Преднастроенный профиль содержит:
        * [базовое правило](../concepts/rules.md#base-rules) по умолчанию, включенное для всего трафика с [типом действия](../concepts/rules.md#rule-action) — `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}`;
        * [правило Smart Protection](../concepts/rules.md#smart-protection-rules), включенное для всего трафика, с типом действия — `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}`.
      * **{{ ui-key.yacloud.smart-web-security.title_no-template }}**. Профиль содержит только базовое правило по умолчанию, включенное для всего трафика.

  1. Введите имя профиля.
  1. (опционально) Введите описание.
  1. (опционально) Добавьте профилю [метку](../../resource-manager/concepts/labels.md).
  1. В поле **{{ ui-key.yacloud.smart-web-security.form.label_default-action }}** выберите, что делать с трафиком, который не попал под условия других правил: `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}` или `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}`.
  1. Выберите или создайте [профиль ARL](../operations/arl-profile-create.md), чтобы установить лимиты на количество запросов.
  1. Выберите или создайте капчу [{{ captcha-full-name }}](../../smartcaptcha/) для проверки подозрительных запросов:

        {% include [captcha-integration](../../_includes/smartwebsecurity/captcha-integration.md) %}

  1. Нажмите кнопку ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
  1. В окне создания правила:

      {% include [add-rule](../../_includes/smartwebsecurity/add-rule.md) %}

  1. Последовательно добавьте все правила, которые вы хотите задействовать в профиле.

      В блоке **{{ ui-key.yacloud.smart-web-security.form.section_security-rules }}** в таблице появятся созданные вами правила.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- API {#api}

  Воспользуйтесь методом REST API [create](../api-ref/SecurityProfile/create.md) для ресурса [SecurityProfile](../api-ref/SecurityProfile/) или вызовом gRPC API [SecurityProfileService/Create](../api-ref/grpc/security_profile_service.md#Create).

{% endlist %}

### См. также {#see-also}

* [{#T}](host-connect.md)
* [{#T}](profile-update.md)
* [{#T}](profile-delete.md)