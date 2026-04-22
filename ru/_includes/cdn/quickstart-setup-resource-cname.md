1. На странице CDN-ресурса на вкладке ![image](../../_assets/console-icons/flag.svg) **{{ ui-key.yacloud.common.overview }}** в разделе **{{ ui-key.yacloud.cdn.label_dns-settings_title }}** скопируйте в буфер обмена сгенерированное сервисом доменное имя вида `{{ cname-example-yc }}`.
1. Перейдите в настройки DNS вашего домена на сайте компании, которая предоставляет вам услуги DNS-хостинга.
1. Измените нужную CNAME-запись таким образом, чтобы она указывала на скопированный ранее адрес в домене `.topology.gslb.yccdn.ru`. Например, если при создании CDN-ресурса вы указали доменное имя для раздачи контента `cdn.example.com`, вам нужно создать следующую CNAME-запись или заменить ею уже существующую запись для `cdn`:

    ```http
    cdn CNAME {{ cname-example-yc }}.
    ```

    {% include [note-dns-aname](./note-dns-aname.md) %}
