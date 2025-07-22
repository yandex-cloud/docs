1. В поле **{{ ui-key.yacloud.baremetal.field_password }}** воспользуйтесь одним из вариантов создания пароля для root-пользователя:

    * Чтобы сгенерировать пароль для root-пользователя, выберите опцию `{{ ui-key.yacloud.baremetal.label_password-plain }}` и нажмите кнопку **{{ ui-key.yacloud.component.password-input.label_button-generate }}**.

        {% include [server-lease-access-password-warning](server-lease-access-password-warning.md) %}

    * Чтобы использовать пароль root-пользователя, сохраненный в [секрете](../../lockbox/concepts/secret.md) {{ lockbox-full-name }}, выберите опцию `{{ ui-key.yacloud.baremetal.label_password-lockbox }}`:

        В полях **{{ ui-key.yacloud.baremetal.label_lockbox-name }}**, **{{ ui-key.yacloud.baremetal.label_lockbox-version }}** и **{{ ui-key.yacloud.baremetal.label_lockbox-key }}** выберите соответственно секрет, его версию и ключ, в которых сохранен ваш пароль.
        
        Если у вас еще нет секрета {{ lockbox-name }}, нажмите кнопку **{{ ui-key.yacloud.common.create }}**, чтобы создать его.

        Этот вариант позволяет вам как задать собственный пароль (тип секрета `{{ ui-key.yacloud.lockbox.forms.title_secret-type-custom }}`), так и использовать пароль, сгенерированный автоматически (тип секрета `{{ ui-key.yacloud.lockbox.forms.title_secret-type-generated }}`).

1. В поле **{{ ui-key.yacloud.baremetal.field_ssh-public-key }}** выберите SSH-ключ, сохраненный в вашем профиле [пользователя организации](../../organization/concepts/membership.md).

    {% include [ssh-key-variants](../../_includes/compute/create/ssh-key-variants.md) %}