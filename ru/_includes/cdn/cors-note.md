{% note info %}

Настройка CORS для CDN-ресурса управляет только заголовком `Access-Control-Allow-Origin` в ответах CDN-сервера. Она не добавляет другие CORS-заголовки и не формирует вместо источника ответ на предварительный запрос `OPTIONS`.

Если браузер выполняет предварительный запрос, [разрешите метод](../../cdn/operations/resources/configure-http.md) `OPTIONS` в настройках CDN-ресурса и настройте источник так, чтобы он корректно обрабатывал этот запрос и возвращал необходимые CORS-заголовки, например `Access-Control-Allow-Methods` и `Access-Control-Allow-Headers`. Для [бакета {{ objstorage-name }}](../../storage/operations/buckets/cors.md) настройте CORS в параметрах бакета.

{% endnote %}
