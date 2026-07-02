[Документация Yandex Cloud](../../index.md) > [Yandex Cloud CDN](../index.md) > [Концепции](index.md) > Обмен данными между клиентами и CDN > CORS

# CORS в Cloud CDN

Yandex Cloud CDN поддерживает [кросс-доменные запросы](../../glossary/cors.md) по механизму CORS (cross-origin resource sharing).

В настройках ресурса вы можете:

* Разрешить CORS-запросы с любыми источниками (значениями заголовка `Origin`): выбрать для заголовка `Access-Control-Allow-Origin` значение `*` или как в заголовке `Origin` запроса.
* Разрешить CORS-запросы с определенными источниками: выбрать для заголовка `Access-Control-Allow-Origin` значение, как в заголовке `Origin` запроса, но только если оно входит в список разрешенных значений из настроек.
* Запретить CORS-запросы: отключить добавление заголовка `Access-Control-Allow-Origin` к ответам.

Настройки CORS действуют для всех файлов ресурса.

{% note info %}

Чтобы кросс-доменные запросы работали корректно, дополнительно настройте CORS на источнике, если источник поддерживает этот механизм. Например, настройка CORS потребуется для [бакетов Object Storage](../../storage/operations/buckets/cors.md).

{% endnote %}


#### Полезные ссылки {#see-also}

* [Инструкция по настройке CORS](../operations/resources/configure-cors.md).