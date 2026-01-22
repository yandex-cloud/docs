# Настройки обмена данными между клиентами и CDN

Когда клиент запрашивает через ваш сервис файл, опубликованный через {{ cdn-name }}, между клиентом и CDN-балансировщиком устанавливается HTTP- или HTTPS-соединение, в зависимости от схемы в URI: `http://cdn.example.com/styles/common.css` или `https://cdn.example.com/styles/common.css`.

Только CDN-ресурс со статусом `Active` может распространять контент, доступный пользователям. Подробнее см. в разделе [{#T}](../concepts/resource.md#status).

Для соединений между клиентами и CDN вы можете настроить:

* переадресацию клиентов с HTTP на HTTPS или наоборот (см. [инструкцию](../operations/resources/configure-basics.md));
* [использование сертификата](clients-to-servers-tls.md) для HTTPS-соединений;
* HTTP-заголовки в ответах CDN-серверов клиентам (см. [инструкцию](../operations/resources/configure-headers.md));
* [обработку кросс-доменных запросов](cors.md) по механизму CORS;
* HTTP-методы, которые разрешено использовать клиентам в запросах к CDN (см. [инструкцию](../operations/resources/configure-http.md));
* [отправку контента в сжатом виде](compression.md) с использованием HTTP-заголовка `Content-Encoding: gzip`.
