# Устранение ошибки `no_route` при открытии адреса


## Описание проблемы {#issue-description}

В балансировщике {{ alb-name }} настроено несколько обработчиков по SNI. Если открыть в браузере первый адрес, а в новой вкладке второй, то возвращается ошибка `"error_details""no_route"`. Через 30 секунд ошибка пропадает и ресурс становится доступен. 

## Решение {#issue-resolution}

Это происходит из-за переиспользования TLS-соединения браузером. Домены разрешаются в один и тот же адрес, при этом в сертификате указан *wildcard* ко всему домену. Из-за этого обработчик не выбирается заново, и трафик направляется на неправильный HTTP-роутер, вследствие чего и появляется ошибка `no_route`.

Предлагаем следующие варианты решения:

1. Использовать разные сертификаты для основного и дополнительных обработчиков.
1. Использовать один HTTP-роутер и настроить несколько виртуальных хостов для распределения трафика между доменными именами одного сертификата.

Подробнее о поведении обработчиков мы пишем [здесь](../../../application-load-balancer/concepts/application-load-balancer.md#listener).
