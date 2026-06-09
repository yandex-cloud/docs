# Проверка владения доменом

Чтобы отправлять письма, подтвердите владение доменом. После создания адреса на его странице сформируются настройки DKIM-подписи. Их нужно указать в качестве значений [ресурсных записей](../../glossary/dns.md#dns-server), которые необходимо добавить в вашу доменную зону. Вы можете добавить записи у вашего регистратора или в сервисе [{{ dns-full-name }}](../../dns/index.md), если вы делегировали ваш домен {{ yandex-cloud }}.

{% list tabs group=dkim %}

- Простая настройка {#easy}

    При простой настройке {{ postbox-name }} самостоятельно генерирует ключи DKIM. На странице адреса в блоке **{{ ui-key.yacloud.postbox.section_dkim }}** отображаются две CNAME-записи, которые нужно добавить в DNS-провайдер.

    **Пример создания ресурсных записей в {{ dns-full-name }}**

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находятся адрес и ваша доменная зона.
    
       Если у вас еще нет [публичной зоны](../../dns/concepts/dns-zone.md#public-zones) DNS, [создайте](../../dns/operations/zone-create-public.md) ее.
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

- Расширенная настройка {#advanced}

    При расширенной настройке вы самостоятельно [генерируете ключ](create-address.md) для создания DKIM-подписи. На странице адреса в блоке **{{ ui-key.yacloud.postbox.section_dkim }}** отображается одна TXT-запись, которую нужно добавить в DNS-провайдер.

    **Пример создания ресурсных записей в {{ dns-full-name }}**
    
    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находятся адрес и ваша доменная зона.

        Если у вас еще нет [публичной зоны](../../dns/concepts/dns-zone.md#public-zones) DNS, [создайте](../../dns/operations/zone-create-public.md) ее.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
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
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
    1. Выберите созданный адрес.
    1. Дождитесь, когда {{ postbox-name }} проверит настройки DKIM-подписи. Если запись верна, статус проверки на странице адреса изменится на `Success`.

{% endlist %}

Ответы DNS-сервера кешируются, поэтому возможны задержки при обновлении ресурсной записи. Если статус проверки не изменится в течение 24 часов, нажмите кнопку **{{ ui-key.yacloud.postbox.button_run-verification }}**.