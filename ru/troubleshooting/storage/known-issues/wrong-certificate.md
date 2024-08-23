# Устранение ошибки сертификата


## Описание проблемы {#issue-description}

При использовании бакета возникает ошибка сертификата `err_cert_common_name_invalid` или `ssl_error_bad_cert_domain`.

## Решение {#issue-resolution}

Возможно, в панели управления доменом создана CNAME-запись, указывающая на поддомен `<bucket-name>.storage.yandexcloud.net`. Нужно изменить ее содержимое на `<bucket-name>.website.yandexcloud.net`, где `<bucket-name>` – имя вашего бакета.

О настройке собственного домена пишем в [документации](../../../storage/operations/hosting/own-domain.md).