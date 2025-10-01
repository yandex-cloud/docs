[Создайте профиль безопасности](../../../smartwebsecurity/operations/profile-create.md) {{ sws-name }}, выбрав вариант создания **{{ ui-key.yacloud.smart-web-security.title_default-template }}**.

При создании профиля задайте настройки:

* В поле **{{ ui-key.yacloud.smart-web-security.form.label_default-action }}** выберите `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}`.
* Для правила **{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}** включите опцию **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry run)**.

С этими настройками информация о трафике будет логироваться, но к трафику не будут применяться никакие действия. Это позволит снизить риск отключения пользователей из-за проблем в настройке профиля. В дальнейшем вы сможете отключить опцию **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry run)** и настроить правила с запрещающими действиями в профиле безопасности для вашего сценария.
