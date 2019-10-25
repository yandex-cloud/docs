# Квоты и лимиты

В сервисах Яндекс.Облака могут действовать квоты и лимиты:

{% include [quotes-limits-def.md](../../_includes/quotes-limits-def.md) %}

Проектируя инфраструктуру в Облаке, учитывайте лимиты как предел возможностей, которые Облако может вам предоставить. Квоты — изменяемые ограничения, которые потенциально могут быть увеличены до значения лимитов.


## Зачем нужны квоты {#quotas}

Квоты служат мягким ограничением для запроса ресурсов, и позволяют Облаку гарантировать стабильность работы сервиса: новые пользователи не могут занять слишком много ресурсов в тестовых целях. Если вы готовы использовать большее количество ресурсов, обратитесь в [техническую поддержку](https://console.cloud.yandex.ru/support) и расскажите, какие именно квоты нужно увеличить, и каким образом.

Техническая поддержка принимает решение увеличивать или не увеличивать квоты в индивидуальном порядке.

## Квоты и лимиты по умолчанию для сервисов Облака 

Квоты приведены со значениями по умолчанию, которые совпадают с квотами на время [пробного периода](../../free-trial/).


### {{ compute-full-name }} {#compute}

{% include [compute-limits.md](../../_includes/compute-limits.md) %}


### {{ objstorage-full-name }} {#storage}

{% include [storage-limits.md](../../_includes/storage-limits.md) %}


### {{ vpc-full-name }} {#vpc}

{% include [vpc-limits.md](../../_includes/vpc-limits.md) %}


### {{ resmgr-full-name }} {#resource-manager}

{% include [resource-manager-limits.md](../../_includes/resource-manager-limits.md) %}


### {{ load-balancer-full-name }} {#load-balancer}

{% include [load-balancer-limits.md](../../_includes/load-balancer-limits.md) %}


### {{ mch-full-name }} {#mch}

{% include [mch-limits.md](../../_includes/mdb/mch-limits.md) %}


### {{ mmg-full-name }} {#mmg}

{% include [mmg-limits.md](../../_includes/mdb/mmg-limits.md) %}


### {{ mmy-full-name }} {#mmy}

{% include [mmy-limits.md](../../_includes/mdb/mmy-limits.md) %}


### {{ mpg-full-name }} {#mpg}

{% include [mpg-limits.md](../../_includes/mdb/mpg-limits.md) %}


### {{ mrd-full-name }} {#mrd}

{% include [mrd-limits.md](../../_includes/mdb/mrd-limits.md) %}


### {{ message-queue-full-name }} {#mq}

{% include [ymq-limits.md](../../_includes/message-queue/ymq-limits.md) %}


### {{ speechkit-full-name }} {#speechkit}

{% include [speechkit-limits](../../_includes/speechkit-limits.md) %}


### {{ translate-full-name }} {#translate}

{% include [translate-limits](../../_includes/translate-limits.md) %}


### {{ vision-full-name }} {#vision}

{% include [vision-limits](../../_includes/vision-limits.md) %}