# Диапазоны публичных IP-адресов {{ yandex-cloud }}

{% include [ip-intro](../../_includes/public-ip/ip-intro.md) %}


## Адреса ресурсов сервисов {{ yandex-cloud }}, доступные клиентам {#yandex-resource-ips}

### {{ vpc-name }}


{% include [vpc-ip-ru](../../_includes/public-ip/ru/vpc-ipv4.md) %}



Примеры ресурсов, которым назначаются вышеуказанные диапазоны адресов:

* Виртуальные машины {{ compute-name }};
* Хосты баз данных;
* NAT-инстансы;
* Балансировщики нагрузки {{ network-load-balancer-name }} и {{ alb-name }}.



### {{ baremetal-name }}

{% include [baremetal-ip-ru](../../_includes/public-ip/ru/baremetal.md) %}


### {{ cdn-name }}

{% include [cdn-ip-ru](../../_includes/public-ip/ru/cdn.md) %}


### {{ captcha-name }} {#smartcaptcha-ips}

{% include [smartcaptcha-ip-list](../../_includes/smartcaptcha-ips.md) %}

Эти адреса нельзя назначить пользовательским ресурсам. Они нужны только для корректной работы запроса к API, отправленного на `/validate`.



## Адреса, используемые {{ yandex-cloud }} для работы сервисов {#yandex-cloud-ips}

Ресурсам, которые обеспечивают работу {{ yandex-cloud }}, назначаются следующие диапазоны адресов:


{% include [yc-ip-ru](../../_includes/public-ip/ru/vpc-ipv6.md) %}



Такие диапазоны адресов недоступны пользователям.


#### См. также {#see-also}

* [{#T}](../../smartcaptcha/concepts/ips.md)
* [Диапазоны IP-адресов, используемых Яндексом]({{ link-yandex }}/ips)