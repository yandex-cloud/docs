# CORS в {{ cdn-name }}

{{ cdn-full-name }} поддерживает [кросс-доменные запросы](../../glossary/cors.md) по механизму CORS (cross-origin resource sharing).

В настройках ресурса вы можете:

* Разрешить CORS-запросы с любыми источниками (значениями заголовка `Origin`): выбрать для заголовка `Access-Control-Allow-Origin` значение `*` или как в заголовке `Origin` запроса.
* Разрешить CORS-запросы с определенными источниками: выбрать для заголовка `Access-Control-Allow-Origin` значение, как в заголовке `Origin` запроса, но только если оно входит в список разрешенных значений из настроек.
* Запретить CORS-запросы: отключить добавление заголовка `Access-Control-Allow-Origin` к ответам.

Настройки CORS действуют для всех файлов ресурса.

{% include [cors-note](../../_includes/cdn/cors-note.md) %}

#### См. также {#see-also}

* [Инструкция по настройке CORS](../operations/resources/configure-cors.md).