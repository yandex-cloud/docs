# Собственный домен

Для публикации сайта вы можете использовать собственный домен, например, `example.com`.

Чтобы поддержать собственный домен:

1. [Создайте](../buckets/create.md) бакет. Назовите его так же, как домен.

1. {% include [setup-bucket.md](../../../_includes/storage/setup-bucket.md) %}

1. Создайте на своем {% if lang == "ru" and audience != "internal" %}[DNS-сервере](../../../glossary/dns.md#dns-server){% else %}DNS-сервере{% endif %}, например в {% if audience != "internal" %}[{{ dns-full-name }}](../../../dns/operations/resource-record-create.md){% else %}{{ dns-full-name }}{% endif %}, ресурсную запись, которая привязывает ваше доменное имя к бакету. В {{ dns-name }} рекомендуется использовать {% if audience != "internal" %}[записи ANAME](../../../dns/concepts/resource-record.md#aname){% else %}записи ANAME{% endif %}: 

    ```
    example.com ANAME example.com.{{ s3-web-host }}
    ```

    Записи ANAME позволяют использовать для хостинга домены второго уровня и, в отличие от CNAME, не ограничивают использование других типов записей в одной с ними зоне. 

    Если вы создаете для бакета запись CNAME на внешнем DNS-сервере, ваше доменное имя должно быть в домене не ниже третьего уровня — это связано с особенностями обработки CNAME-записей на DNS-хостингах. Подробнее см. п. 2.4 [RFC 1912](https://www.ietf.org/rfc/rfc1912.txt).

1. Чтобы сайт был доступен по протоколу HTTPS:

    1. {% include [create-cert.md](../../../_includes/storage/create-cert.md) %}
    1. {% include [add-cert.md](../../../_includes/storage/add-cert.md) %}

{% include [objects-access.md](../../../_includes/storage/objects-access.md) %}


