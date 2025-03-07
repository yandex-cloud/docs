# Как начать работать с {{ postbox-full-name }}

С помощью этой инструкции вы создадите свой адрес и отправите проверочное письмо.

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Создайте сервисный аккаунт и ключи {#service-account-and-keys}

1. [Создайте](../iam/operations/sa/create.md) сервисный аккаунт `postbox-user` и [назначьте](../iam/operations/sa/assign-role-for-sa.md) ему [роль](security/index.md#postbox-sender) `postbox.sender`.
1. Создайте ключ для сервисного аккаунта:
   * Для отправки письма с помощью AWS CLI [создайте](../iam/operations/authentication/manage-access-keys.md#create-access-key) статический ключ доступа. Надежно сохраните идентификатор и секретный ключ. После того как вы закроете окно, параметры секретного ключа станут недоступны.
   * Для отправки письма по протоколу SMTP [создайте](../iam/operations/authentication/manage-api-keys.md#create-api-key) API-ключ. При создании API-ключа задайте область действия `yc.postbox.send`. Надежно сохраните полученный секретный ключ. После того как вы закроете окно, параметры секретного ключа станут недоступны.
1. Сгенерируйте ключ для создания DKIM-подписи:

    ```
    openssl genrsa -out privatekey.pem 2048
    ```

## Создайте адрес {#create-address}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создали сервисный аккаунт. Если вы создадите сервисный аккаунт и адрес в разных каталогах, при попытке отправить письмо возникнет ошибка.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.postbox.button_create-identity }}**.
    1. Укажите **{{ ui-key.yacloud.postbox.label_address }}**, с которого будете отправлять письма. Домен может быть любого уровня.
    1. Укажите **{{ ui-key.yacloud.postbox.label_selector }}**: `postbox`.

        {% note info %}

        Вы можете указать селектор, отличный от `postbox`. Указанный селектор должен использоваться только в одной ресурсной записи — той, которую вы создадите на шаге [Пройдите проверку владения доменом](#verify-domain).

        {% endnote %}

    1. Скопируйте в поле **{{ ui-key.yacloud.postbox.label_private-key }}** содержимое файла приватного ключа `privatekey.pem`, [созданного ранее](#service-account-and-keys).
    1. (Опционально) [Настройте логирование](operations/logs-write.md).
    1. Нажмите кнопку **{{ ui-key.yacloud.postbox.button_create-identity }}**.

{% endlist %}

## Пройдите проверку владения доменом {#verify-domain}

{% include [check-domain](../_includes/postbox/check-domain.md) %}

## Отправьте проверочное письмо {#send-test-email}

Отправить проверочное письмо можно с помощью [AWS CLI](#aws-cli-send) или из почтового клиента по [протоколу SMTP](#smtp-send).

### AWS CLI {#aws-cli-send}

{% include [send-email-aws](../_includes/postbox/send-email-aws.md) %}

### SMTP {#smtp-send}

{% include [smtp-send-api](../_includes/postbox/smtp-send-api.md) %}

#### См. также {#see-also}

* [{#T}](concepts/notification.md)
* [{#T}](operations/send-email.md)
