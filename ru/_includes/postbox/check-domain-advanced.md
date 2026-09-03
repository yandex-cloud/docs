1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находятся адрес и ваша доменная зона.

    Если у вас еще нет [публичной зоны](../../dns/concepts/dns-zone.md#public-zones) DNS, [создайте](../../dns/operations/zone-create-public.md) ее.

1. [Перейдите]({{ link-console-main }}/link/dns) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
1. Выберите вашу доменную зону.
1. Нажмите кнопку **{{ ui-key.yacloud.dns.button_record-set-create }}**.
1. В поле **{{ ui-key.yacloud.common.name }}** укажите часть имени, сгенерированного при создании адреса, без домена в формате `<селектор>._domainkey`. Например `postbox._domainkey`.

    {% note info %}

    Для других DNS-сервисов может потребоваться скопировать запись целиком. Итоговая запись должна иметь вид `<селектор>._domainkey.<домен>.`, например `postbox._domainkey.example.com.`.

    {% endnote %}

1. В поле **{{ ui-key.yacloud.common.type }}** выберите `TXT`.
1. В поле **{{ ui-key.yacloud.dns.label_records }}** скопируйте содержимое поля **{{ ui-key.yacloud.postbox.label_dns-record-value }}** из блока **{{ ui-key.yacloud.postbox.section_dkim }}** необходимого адреса. Обратите внимание, что значение записи нужно взять в кавычки, например:

    ```text
    "v=DKIM1;h=sha256;k=rsa;p=M1B...aCA8"
    ```

    {% note info %}

    В других DNS-сервисах могут быть другие требования к оформлению ресурсных записей. Подробнее читайте в документации того DNS-сервиса, в котором создаете ресурсную запись.

    {% endnote %}

1. В поле **{{ ui-key.yacloud.dns.label_form-ttl }}** укажите время жизни записи.
1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
1. [Перейдите]({{ link-console-main }}/link/postbox) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
1. Выберите созданный адрес.
1. Дождитесь, когда {{ postbox-name }} проверит настройки DKIM-подписи. Если запись верна, статус проверки на странице адреса изменится на `Success`.