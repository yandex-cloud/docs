# Как начать работать с {{ postbox-full-name }}

С помощью этой инструкции вы создадите свой адрес и отправите проверочное письмо.

## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md) и [привяжите](../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../resource-manager/concepts/resources-hierarchy.md).

## Создайте сервисный аккаунт и ключи {#service-account-and-keys}

1. [Создайте](../iam/operations/sa/create.md) сервисный аккаунт `postbox-user` и [назначьте](../iam/operations/sa/assign-role-for-sa.md) ему [роль](security/index.md#postbox-sender) `postbox.sender`.
1. Создайте ключ для сервисного аккаунта:
   * Для отправки письма с помощью AWS CLI [создайте](../iam/operations/authentication/manage-access-keys.md#create-access-key) статический ключ доступа. Надежно сохраните идентификатор и секретный ключ. После того как вы закроете окно, параметры секретного ключа станут недоступны.
   * Для отправки письма по протоколу SMTP [создайте](../iam/operations/authentication/manage-api-keys.md#create-api-key) API-ключ. При создании API-ключа задайте область действия `yc.postbox.send`. Надежно сохраните полученный секретный ключ. После того как вы закроете окно, параметры секретного ключа станут недоступны.

## Создайте адрес {#create-address}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создали сервисный аккаунт. Если вы создадите сервисный аккаунт и адрес в разных каталогах, при попытке отправить письмо возникнет ошибка.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.postbox.button_create-identity }}**.
    1. Укажите **{{ ui-key.yacloud.postbox.label_address }}**, с которого будете отправлять письма. Домен может быть любого уровня.
    1. В блоке **{{ ui-key.yacloud.postbox.section_dkim }}** выберите **{{ ui-key.yacloud.postbox.label_signing-type-internal }}**.
    1. (Опционально) [Настройте логирование](operations/logs-write.md).
    1. Нажмите кнопку **{{ ui-key.yacloud.postbox.button_create-identity }}**.

{% endlist %}

## Пройдите проверку владения доменом {#verify-domain}

Чтобы отправлять письма, подтвердите владение доменом. После создания адреса на его странице сформируются настройки DKIM-подписи. Их нужно указать в качестве значений [ресурсных записей](../glossary/dns.md#dns-server), которые необходимо добавить в вашу доменную зону. Вы можете добавить записи у вашего регистратора или в сервисе [{{ dns-full-name }}](../dns/index.md), если вы делегировали ваш домен {{ yandex-cloud }}.

**Пример создания ресурсных записей в {{ dns-full-name }}**

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находятся адрес и ваша доменная зона.
    
       Если у вас еще нет [публичной зоны](../dns/concepts/dns-zone.md#public-zones) DNS, [создайте](../dns/operations/zone-create-public.md) ее.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
    1. Выберите созданный адрес и откройте блок **{{ ui-key.yacloud.postbox.section_dkim }}**.
    1. Для каждой из двух CNAME-записей выполните следующие шаги:
    
        1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
        1. Выберите вашу доменную зону.
        1. Нажмите кнопку **{{ ui-key.yacloud.dns.button_record-set-create }}**.
        1. В поле **{{ ui-key.yacloud.common.type }}** выберите `CNAME`.
        1. В поле **{{ ui-key.yacloud.common.name }}** скопируйте имя записи из блока **{{ ui-key.yacloud.postbox.section_dkim }}** на странице адреса (без домена).
    
           {% note info %}
    
           Для других DNS-сервисов может потребоваться скопировать имя записи целиком, включая домен.
    
           {% endnote %}
    
        1. В поле **{{ ui-key.yacloud.dns.label_records }}** скопируйте значение записи из блока **{{ ui-key.yacloud.postbox.section_dkim }}** на странице адреса.
        1. В поле **{{ ui-key.yacloud.dns.label_form-ttl }}** укажите время жизни записи.
        1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
    1. Выберите созданный адрес.
    1. Дождитесь, когда {{ postbox-name }} проверит настройки DKIM-подписи. Если записи верны, статус проверки на странице адреса изменится на `Success`.

    Ответы DNS-сервера кешируются, поэтому возможны задержки при обновлении ресурсных записей. Если статус проверки не изменится в течение 24 часов, нажмите кнопку **{{ ui-key.yacloud.postbox.button_run-verification }}**.

{% endlist %}

## Отправьте проверочное письмо {#send-test-email}

Отправить проверочное письмо можно с помощью [AWS CLI](#aws-cli-send) или из почтового клиента по [протоколу SMTP](#smtp-send).

{% note info %}

Для обеспечения безопасности передачи данных сервис {{ postbox-name }} поддерживает версии протокола TLS 1.2 и 1.3.

{% endnote %}

### AWS CLI {#aws-cli-send}

1. [Установите](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) утилиту командной строки AWS CLI.
1. Настройте AWS CLI:
    1. Запустите интерактивную настройку профиля:
        ```
        aws configure
        ```
    1. Укажите полученный ранее идентификатор ключа сервисного аккаунта `postbox-user`:
        ```
        AWS Access Key ID [****************ver_]: <идентификатор_ключа_сервисного_аккаунта>
        ```
    1. Укажите полученный ранее секретный ключ сервисного аккаунта `postbox-user`:
        ```
        AWS Secret Access Key [****************w5lb]: <секретный_ключ_сервисного_аккаунта>
        ```
    1. Укажите имя региона по умолчанию {{ region-id }}:
        ```
        Default region name [{{ region-id }}]: {{ region-id }}
        ```
    1. Укажите формат выходных данных по умолчанию json:
        ```
        Default output format [None]: json
        ```

1. Подготовьте два JSON-файла:

    * `destination.json` — файл со списком адресов назначения:

        ```json
        {
          "ToAddresses": ["test@example.com"]
        }
        ```

    * `message.json` — файл с темой и содержимым письма:

       ```json
       {
         "Simple": {
           "Subject": {
             "Data": "Test message",
             "Charset": "UTF-8"
           },
           "Body": {
             "Text": {
               "Data": "Test message. Hello!",
               "Charset": "UTF-8"
             }
           }
         }
       }
       ```

1. Отправьте письмо с помощью AWS CLI:

    ```bash
    aws sesv2 send-email \
      --from-email-address mail@example.com \
      --destination file://destination.json \
      --content file://message.json \
      --endpoint-url {{ postbox-endpoint }}
    ```

1. Проверьте почтовый ящик, указанный в `destination.json`, — туда должно прийти письмо.

### SMTP {#smtp-send}

1. В настройках SMTP-сервера вашего почтового клиента укажите следующие параметры:

    #|
    || | **Почтовый клиент поддерживает STARTTLS** | **Почтовый клиент не поддерживает STARTTLS, но поддерживает SMTPS** ||
    || **Имя сервера** | `{{ postbox-host }}` {align="center"} | > ||
    || **Порт** | `587` | `465` ||
    || **Имя пользователя** | Идентификатор созданного API-ключа {align="center"} | > ||
    || **Пароль** | Секретная часть созданного API-ключа {align="center"} | > ||
    |#

1. Отправьте письмо с помощью вашего почтового клиента и убедитесь, что оно пришло на указанные адреса.

#### См. также {#see-also}

* [{#T}](concepts/notification.md)
* [{#T}](operations/send-email.md)