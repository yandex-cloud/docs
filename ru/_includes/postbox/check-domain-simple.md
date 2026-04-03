1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находятся адрес и ваша доменная зона.

   Если у вас еще нет [публичной зоны](../../dns/concepts/dns-zone.md#public-zones) DNS, [создайте](../../dns/operations/zone-create-public.md) ее.
1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
1. Выберите созданный адрес и откройте блок **{{ ui-key.yacloud.postbox.section_dkim }}**.
1. Для каждой из двух CNAME-записей выполните следующие шаги:

    1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
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
1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
1. Выберите созданный адрес.
1. Дождитесь, когда {{ postbox-name }} проверит настройки DKIM-подписи. Если записи верны, статус проверки на странице адреса изменится на `Success`.
