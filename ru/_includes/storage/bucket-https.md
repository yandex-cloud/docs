{% note info %}

При использовании URL в формате `http(s)://<имя_бакета>.{{ s3-storage-host }}` протокол HTTPS доступен для бакета только в том случае, если имя бакета не содержит точек. Например:

* `https://example.{{ s3-storage-host }}` — для этого бакета протокол HTTPS доступен.
* `http://example.ru.{{ s3-storage-host }}` — для этого бакета HTTPS недоступен.

Это связано с тем, что в {{ objstorage-name }} используются [сертификаты Wildcard](https://en.wikipedia.org/wiki/Wildcard_certificate), которые поддерживают только один уровень поддоменов.

Чтобы поддержать для бакета с точкой в имени протокол HTTPS, [загрузите собственный сертификат безопасности](../../storage/operations/hosting/certificate.md) в {{ objstorage-name }}.

{% endnote %}