# Создать профиль WAF

{% note info %}

Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md). Чтобы получить к ней доступ, при создании первого профиля WAF опишите, как вы планируете использовать WAF, и нажмите кнопку **{{ ui-key.yacloud_components.request-alpha-flag-dialog.button_send }}**.

После одобрения заявки вы сможете перейти к созданию профиля WAF.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать [профиль WAF](../concepts/waf.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}** и нажмите кнопку **{{ ui-key.yacloud.smart-web-security.waf.label_create-profile }}**.
  1. Введите имя профиля.
  1. (опционально) Введите описание.
  1. (опционально) Добавьте профилю [метки](../../resource-manager/concepts/labels.md).
  1. По умолчанию в профиле WAF включен набор базовых правил [OWASP Core Rule Set](https://coreruleset.org/). Нажмите на строку с набором правил, чтобы посмотреть правила, которые в него входят.

  1. {% include [waf-inspect-request](../../_includes/smartwebsecurity/waf-inspect-request.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### См. также {#see-also}

* [{#T}](rule-add.md)
* [{#T}](profile-update.md)
* [{#T}](waf-profile-delete.md)
