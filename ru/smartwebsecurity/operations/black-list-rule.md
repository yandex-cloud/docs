---
title: Как настроить правило для блокировки черных адресов в {{ sws-full-name }}
description: Следуя данной инструкции, вы сможете настроить правило для блокировки черных адресов в {{ sws-name }}.
---

# Правило для блокировки черных адресов

{% include [lists-preview](../../_includes/smartwebsecurity/lists-preview.md) %}

В {{ sws-name }} есть [предустановленные списки](../concepts/lists.md#yc-rules) ненадежных (черных) IP-адресов. Они помогают оптимизировать проверку трафика и блокировать запросы от небезопасных или сомнительных адресов. Также вы можете добавить [пользовательские списки](../concepts/lists#user-rules) черных адресов.

## Настройте правило для блокировки черных адресов {#black-list-rule}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На панели слева нажмите ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}** и выберите нужный профиль.
  1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
  1. Введите имя правила, например `block-by-list`.
  1. Задайте **{{ ui-key.yacloud.smart-web-security.overview.column_priority }}** выше, чем у правил Smart Protection. Например, `9100`.
  1. Включите опцию **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**.
  1. Укажите параметры правила:
  
     * **{{ ui-key.yacloud.smart-web-security.overview.column_type }}** — `{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}`.
     * **{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}** — `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}` или `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-captcha }}`.
     * **Трафик** — `При условии`.
     * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** — `{{ ui-key.yacloud.component.condition-column.condition_name-ip-range }}`.
     * **Условия на IP** — `IP принадлежит списку`.
     * **IP принадлежит списку** — добавьте [предустановленные списки](../concepts/lists.md#yc-rules) для фильтрации или свои списки черных адресов. Запросы с этих адресов будут блокироваться.

     {% note tip %}

     Рекомендуем сразу добавить предустановленные списки: `is_ddoser`, `is_tor` и `is_anonimous`.

     {% endnote %}
  1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

### См. также {#see-also}

* [{#T}](list-create.md)
* [{#T}](profile-create.md)
* [{#T}](rule-add.md)
