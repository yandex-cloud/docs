Чтобы отправлять письма, подтвердите владение доменом. После создания адреса на его странице сформируются настройки DKIM-подписи. Их нужно указать в качестве значений [ресурсной записи](../../glossary/dns#dns-server), которую необходимо добавить в вашу доменную зону. Вы можете добавить запись у вашего регистратора или в сервисе [{{ dns-full-name }}](../../dns/), если вы делегировали ваш домен. 

**Пример создания ресурсной записи в {{ dns-name }}**

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находятся адрес и ваша доменная зона.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
    1. Выберите вашу доменную зону.
    1. Нажмите кнопку **{{ ui-key.yacloud.dns.button_record-set-create }}**.
    1. В поле **{{ ui-key.yacloud.common.name }}** укажите сгенерированное при создании адреса имя вида `postbox._domainkey.example.com`.
    1. В списке **{{ ui-key.yacloud.common.type }}** выберите `TXT`.
    1. В поле **{{ ui-key.yacloud.dns.label_records }}** скопируйте содержимое поля **{{ ui-key.yacloud.postbox.label_dns-record-value }}** из блока **{{ ui-key.yacloud.postbox.label_signature-verification }}**. Обратите внимание, что значение записи нужно разбить на отдельные строки, например:

        ```text
        ( "v=DKIM1;h=sha256;k=rsa; "

        "p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAui6NEIfZdLfcbcJV4oqY5lWyYXV1ht1zYdrSHCVCWWBaOZ2mIGVzycDKPicLSDZBlN4I8HO2ajclFfQn3013klP7i6VrDSXMmO9hRGgVU+ZhoFJrsMRdbDK/1SIU1k7xiJIudB+YPcc69Y/jHQJk32q7b"

        "UC617oEwSL/sQHeueS0rMLrmPyOtXELLLHrx9IiHM8ACb6zFY/lWx3AnuOLOv4JXYPAQe+b2zvERpHA+AbaCUHi8dJVm1aY/TceakHkUMlWzh4YeSfuQkaNI1PEnLGA3u0WIGyvtTdA3FWhT3w3BFsVWCTFPIxjORvaY/eZMMcj3WM7GUtORbebAOUyBwIDAQAB" )
        ```

    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
    1. Выберите созданный адрес.
    1. Нажмите кнопку **{{ ui-key.yacloud.postbox.button_validate }}**. Если запись верна, статус проверки на странице адреса изменится на `Success`.

    Ответы DNS-сервера кешируются, поэтому возможны задержки при обновлении ресурсной записи.

{% endlist %}
