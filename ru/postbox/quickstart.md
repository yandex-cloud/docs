# Как начать работать с {{ postbox-full-name }}

С помощью этой инструкции вы создадите свой адрес и отправите проверочное письмо.

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Создайте сервисный аккаунт {#service-account}

[Создайте](../iam/operations/sa/create.md) сервисный аккаунт `postbox-user` и [назначьте](../iam/operations/sa/assign-role-for-sa.md) ему [роль](security/index.md#postbox-sender) `postbox.sender`.

## Создайте адрес {#create-address}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создали сервисный аккаунт.

        {% note warning %}

        Если вы создадите сервисный аккаунт и адрес в разных каталогах, при попытке отправить письмо возникнет ошибка.

        {% endnote %}

    1. [Перейдите]({{ link-console-main }}/link/postbox) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.postbox.button_create-identity }}**.
    1. Укажите **{{ ui-key.yacloud.postbox.label_address }}**, с которого будете отправлять письма. Домен может быть любого уровня.
    1. В блоке **{{ ui-key.yacloud.postbox.section_dkim }}** выберите **{{ ui-key.yacloud.postbox.label_signing-type-internal }}**.
    1. (Опционально) [Настройте логирование](operations/logs-write.md).
    1. Нажмите кнопку **{{ ui-key.yacloud.postbox.button_create-identity }}**.

{% endlist %}

## Пройдите проверку владения доменом {#verify-domain}

{% include [check-domain-intro](../_includes/postbox/check-domain-intro.md) %}

**Пример создания ресурсных записей в {{ dns-full-name }}**

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% include [check-domain-simple](../_includes/postbox/check-domain-simple.md) %}

    Ответы DNS-сервера кешируются, поэтому возможны задержки при обновлении ресурсных записей. Если статус проверки не изменится в течение 24 часов, нажмите кнопку **{{ ui-key.yacloud.postbox.button_run-verification }}**.

{% endlist %}

## Отправьте проверочное письмо {#send-test-email}

Отправьте проверочное письмо в консоли управления. Подробнее о других способах [отправки письма](operations/send-email.md).

{% include [tls](../_includes/postbox/tls.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится адрес.
    1. [Перейдите]({{ link-console-main }}/link/postbox) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
    1. Выберите адрес и нажмите кнопку **{{ ui-key.yacloud.postbox.IdentityActions.action_send-test-email_okbHQ }}**.
    1. В поле **{{ ui-key.yacloud.postbox.label_message-details-sender }}** введите имя почтового ящика отправителя — часть адреса до знака `@`. По умолчанию домен совпадает с выбранным адресом. Отправить письмо можно только с адреса, для которого [подтверждено владение доменом](#verify-domain).
    1. В поле **{{ ui-key.yacloud.postbox.SendTestEmailDialog.field_event-scenario_m84Ln }}** выберите `{{ ui-key.yacloud.postbox.SendTestEmailDialog.value_scenario-delivery_axWEt }}`.
    1. Введите тему письма в поле **{{ ui-key.yacloud.postbox.label_message-details-subject }}** и текст письма в поле **{{ ui-key.yacloud.postbox.SendTestEmailDialog.field_email-body_fJZZf }}**.
    1. В поле **{{ ui-key.yacloud.forms.label_service-account-select }}** выберите сервисный аккаунт `postbox-user`.
    1. Нажмите кнопку **{{ ui-key.yacloud.postbox.SendTestEmailDialog.action_send_tTCff }}**.

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](concepts/notification.md)
* [{#T}](operations/send-email.md)

[*api-key-scope]: {% include notitle [api-key-scope](../_popups/iam/api-key-scope.md) %}
