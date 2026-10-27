---
title: Отправка тестового письма в {{ postbox-full-name }}
description: Следуя данной инструкции, вы сможете отправить тестовое письмо в {{ postbox-name }}.
---

# Отправка тестового письма

Вы можете отправить тестовое письмо в консоли управления. Чтобы проверить отправку без реального получателя, отправьте письмо на один из адресов [симулятора доставки](../concepts/mail-simulator.md).

## Перед началом работы {#before-begin}

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт в том же каталоге, в котором находится адрес. Если вы создадите сервисный аккаунт и адрес в разных каталогах, при попытке отправить письмо возникнет ошибка.
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту [роль](../security/index.md#postbox-sender) `postbox.sender`.

## Отправка тестового письма

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится адрес.
    1. [Перейдите]({{ link-console-main }}/link/postbox) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/at.svg) **{{ ui-key.yacloud.postbox.label_identities }}**.
    1. Выберите адрес и нажмите кнопку **{{ ui-key.yacloud.postbox.IdentityActions.action_send-test-email_okbHQ }}**.
    1. В поле **{{ ui-key.yacloud.postbox.label_message-details-sender }}** введите имя почтового ящика отправителя — часть адреса до знака `@`. По умолчанию домен совпадает с выбранным адресом. Чтобы отправить письмо с другого адреса в каталоге, выберите его домен в списке. Отправить письмо можно только с адреса, для которого [подтверждено владение доменом](check-domain.md).
    1. В поле **{{ ui-key.yacloud.postbox.SendTestEmailDialog.field_event-scenario_m84Ln }}** выберите получателя:
        * Адрес [симулятора доставки](../concepts/mail-simulator.md), чтобы проверить результат доставки без отправки письма реальному получателю.
        * `{{ ui-key.yacloud.postbox.SendTestEmailDialog.value_scenario-custom-recipient_uodcb }}`, чтобы отправить письмо на любой адрес электронной почты. Укажите адрес в поле **{{ ui-key.yacloud.postbox.label_message-details-recipient }}**.
    1. Введите тему письма в поле **{{ ui-key.yacloud.postbox.label_message-details-subject }}** и текст письма в поле **{{ ui-key.yacloud.postbox.SendTestEmailDialog.field_email-body_fJZZf }}**.
    1. (Опционально) В поле **{{ ui-key.yacloud.postbox.label_configuration-set }}** выберите [конфигурацию](../concepts/configuration.md), которую нужно применить к письму.
    1. В поле **{{ ui-key.yacloud.forms.label_service-account-select }}** выберите сервисный аккаунт с ролью `postbox.sender`.
    1. (Опционально) Включите опцию **{{ ui-key.yacloud.postbox.SendTestEmailDialog.field_additional-parameters_whcy7 }}** и заполните поля:
        * **{{ ui-key.yacloud.postbox.SendTestEmailDialog.field_reply-to-address_poebF }}** — адреса, на которые будут отправляться ответы от получателей тестового письма. Можно указать несколько адресов через запятую.
        * **{{ ui-key.yacloud.postbox.SendTestEmailDialog.field_return-path_1sYNT }}** — адрес, на который будут отправляться уведомления о недоставке тестового письма получателям.
        * **{{ ui-key.yacloud.postbox.SendTestEmailDialog.field_cc-address_gwf1F }}** — адреса, на которые будут отправляться копии тестового письма. Можно указать несколько адресов через запятую.
        * **{{ ui-key.yacloud.postbox.SendTestEmailDialog.field_bcc-address_obufw }}** — адреса, на которые будут отправляться скрытые копии тестового письма. Можно указать несколько адресов через запятую.
    1. Нажмите кнопку **{{ ui-key.yacloud.postbox.SendTestEmailDialog.action_send_tTCff }}**.

{% endlist %}
