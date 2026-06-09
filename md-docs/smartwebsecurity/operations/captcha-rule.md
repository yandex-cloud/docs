# Правило для {{ captcha-full-name }}

Настройте правило, чтобы направлять запросы на проверку в [{{ captcha-name }}](../../smartcaptcha/index.md).

{% note info %}

Если для базового правила по умолчанию установлено действие `Запретить` и запросы отправляются на проверку в {{ captcha-name }}, добавьте базовое правило, разрешающее запросы к капче. Адрес разрешенного запроса соответствует регулярному выражению: `{{ allowed-captcha-request }}`. Установите для правила приоритет выше, чем у правил, которые отправляют запросы на капчу.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева нажмите ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}** и выберите нужный профиль.
  1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}** и в открывшемся окне:
     
     1. Введите имя правила, например `allow-captcha`.
     1. Задайте **{{ ui-key.yacloud.smart-web-security.overview.column_priority }}** выше, чем у правил, которые отправляют запросы на капчу.
     1. Включите опцию **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**.
     1. Укажите параметры правила:
     
        * **{{ ui-key.yacloud.smart-web-security.overview.column_type }}** — `{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}`.
        * **{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}** — `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}`.
        * **Трафик** — `При условии`.
        * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** — `{{ ui-key.yacloud.component.condition-column.condition_name-requestUri }}`.
        * **Request path** — `Соответствует регулярному выражению`.
        * Введите выражение `{{ allowed-captcha-request }}`.
     
     1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

### См. также {#see-also}

* [{#T}](profile-create.md)
* [{#T}](rule-add.md)