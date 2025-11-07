# Настройка хостинга статического сайта в бакете {{ objstorage-full-name }} с доступом через {{ cdn-full-name }}



В этом руководстве вы создадите статический сайт в [бакете](../../storage/concepts/bucket.md) [{{ objstorage-full-name }}](../../storage/) и опубликуете его в качестве источника контента в [{{ cdn-full-name }}](../../cdn/). Соединение между клиентом и CDN-сервером может осуществляться по протоколу TLS версий 1.0 и 1.1, а между CDN-сервером и {{ objstorage-name }} — по протоколу TLS версии 1.2 или выше. Сайт будет доступен по доменному имени, делегированному в [{{ dns-full-name }}](../../dns/), для которого в [{{ certificate-manager-full-name }}](../../certificate-manager/) будет выпущен TLS-сертификат. Доменное имя сайта будет связано с CDN-ресурсом с помощью [CNAME](../../dns/concepts/resource-record.md#cname) записи в [DNS](../../glossary/dns.md).

В качестве примера будет использовано доменное имя `cdn.yandexcloud.example`.
