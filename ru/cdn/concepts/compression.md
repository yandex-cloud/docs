# Сжатие контента

Контент с CDN-серверов может передаваться клиентам в сжатом виде. Сжатие можно включить в настройках ресурса.

Для сжатия используется формат [gzip](https://ru.wikipedia.org/wiki/Gzip). Контент отправляется в сжатом виде, только если в запросе клиента есть HTTP-заголовок с указанием на поддержку gzip: `Accept-Encoding: gzip`. В противном случае файл отправляется без сжатия.

[Включение сжатия контента](../operations/resources/enable-compression.md) также помогает избежать ситуации, когда сжатые файлы получают пользователи, которые не запрашивали сжатый контент. Подробнее см. в разделе [Решение проблем в {{ cdn-name }}](../troubleshooting.md#compressed-files).

Сжимаются файлы следующих MIME-типов:

* `application/javascript`;
* `application/json`;
* `application/x-javascript`;
* `application/xml`;
* `application/xml+rss`;
* `image/svg+xml`;
* `text/css`;
* `text/html`;
* `text/javascript`;
* `text/plain`;
* `text/xml`.

MIME-тип определяется по значению HTTP-заголовка `Content-Type` в ответе источника на запрос CDN-сервера.

#### См. также {#see-also}

* [Инструкция по включению сжатия](../operations/resources/enable-compression.md).