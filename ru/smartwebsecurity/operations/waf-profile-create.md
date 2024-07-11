# Создать профиль WAF

{% include [note-preview-waf](../../_includes/smartwebsecurity/note-preview-waf.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите создать профиль WAF.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Перейдите на вкладку ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}** и нажмите кнопку **{{ ui-key.yacloud.smart-web-security.waf.label_create-profile }}**.
  1. Опишите, как вы планируете использовать WAF, и нажмите кнопку **Отправить заявку**.

      После одобрения заявки вы сможете перейти к созданию профиля WAF.
  1. Введите имя профиля.
  1. (опционально) Введите описание.
  1. (опционально) Добавьте профилю [метку](../../resource-manager/concepts/labels.md).
  1. По умолчанию в профиле WAF включен набор базовых правил [OWASP Core Rule Set](https://coreruleset.org/). Чтобы посмотреть правила, которые включены в набор, нажмите на строку с его описанием.
  1. Нажмите кнопку **Создать**.

{% endlist %}

### См. также {#see-also}

* [{#T}](rule-add.md)
* [{#T}](profile-update.md)
* [{#T}](waf-profile-delete.md)