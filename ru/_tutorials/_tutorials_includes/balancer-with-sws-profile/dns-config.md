1. Добавьте ресурсную [А-запись](../../../dns/concepts/resource-record.md#a) в публичную DNS-зону вашего домена, указав в ней значения:

    * `Имя записи` — адрес вашего домена, заканчивающийся на точку. Например: `example.com.` или `my.first.example.com.`.
    * `Значение` — IP-адрес L7-балансировщика. Чтобы узнать IP-адрес, воспользуйтесь инструкцией [{#T}](../../../application-load-balancer/operations/application-load-balancer-get.md).

    Эта запись перенаправит запросы, которые будут поступать на ваш домен, на IP-адрес L7-балансировщика.

    {% include [create-record-instruction-notice](../../../_includes/dns/create-record-instruction-notice.md) %}

1. {% include [limit-traffic-to-yc](../../../_includes/smartwebsecurity/limit-traffic-to-yc.md) %}