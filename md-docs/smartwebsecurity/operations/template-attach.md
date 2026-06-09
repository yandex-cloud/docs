# Добавить шаблон страницы ответа к профилю или правилу

Шаблон страницы ответа можно добавить к профилю безопасности или профилю ARL, а также к отдельным правилам в этих профилях.

## Добавление шаблона к профилю {#template-to-profile}

Шаблон профиля отображается при блокировке любым правилом этого профиля. Если для конкретного правила выбран другой шаблон, будет использоваться он. Если профилю или правилам шаблон не назначен, используется шаблон по умолчанию.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится профиль безопасности или ARL.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите **{{ ui-key.yacloud.smart-web-security.title_profiles }}** или **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}**.
  1. В строке с нужным профилем нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.smart-web-security.overview.action_edit-profile }}**.
  1. В списке **Шаблон страницы ответа** выберите существующий шаблон или [создайте новый](template-create.md).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Добавление шаблона к правилу {#template-to-rule}

[Правила](../concepts/rules.md), которым можно назначить шаблон страницы:

* Правила профиля безопасности:
  * **{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}** с действием **{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}**.
  * **{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}** с действием **{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}** или **{{ ui-key.yacloud.smart-web-security.overview.cell_mode-api }}**.
  * **{{ ui-key.yacloud.smart-web-security.overview.label_waf-rule }}** с действием **{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}** или **{{ ui-key.yacloud.smart-web-security.overview.cell_mode-api }}**.
* Правила профиля ARL с действиями **{{ ui-key.yacloud.smart-web-security.arl.label_rule-action-deny_3kenc }}** или **Временно блокировать все запросы**.

Дополнительно можно изменить внешний вид окна с проверкой {{ captcha-name }}. Для этого [создайте новую](../../smartcaptcha/operations/create-captcha.md) или измените уже существующую капчу, привязанную к профилю безопасности.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится профиль безопасности или ARL.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите **{{ ui-key.yacloud.smart-web-security.title_profiles }}** или **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}**.
  1. Выберите профиль, в котором находится нужное правило.
  1. В строке с правилом нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.smart-web-security.overview.action_edit-profile }}**.
  1. В списке **Шаблон страницы ответа** выберите существующий шаблон или [создайте новый](template-create.md).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

#### См. также {#see-also}

* [{#T}](rule-add.md)
* [{#T}](rule-update.md)
* [{#T}](host-connect.md)
* [{#T}](profile-delete.md)