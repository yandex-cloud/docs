# Работа напрямую с API Object Storage без использования SDK

## Описание задачи {#case-description}
Возникла необходимость обмена данными с сервисом Object Storage напрямую без использования SDK для имеющихся языков программирования.

## Решение {#case-resolution}
Формат заголовка `Authorization`  для составления запроса к сервису имеет вид `"Authorization: AWS <id_ключа>:<подпись>"`, где:
- `Authorization: AWS` - неизменяемое значение;
- `<id_ключа>` - идентификатор статического ключа доступа сервисного аккаунта, указывается без угловых скобок;
- `<подпись>` - подпись запроса с использованием механизма HMAC с хэширующей функцией SHA256, также указывается без угловых скобок.

Пример:
`Authorization: AWS YCAJEsU4EP6Dyo6QiHhPHz4dO:/CQuut9oew7fUoKorITnCcg2VlA=`

{%note info %}

Подробнее о [подписи запросов](../../../storage/s3/signing-requests.md) пишем в документации.

{% endnote %}

## Пример запроса к Object Storage средствами утилиты `curl`

Загрузка объекта в бакет:
```
file='имя_файла' ;\
bucket='имя_бакета' ;\
resource="/${bucket}/${file}" ;\
contentType="content-type загружаемого объекта" ;\
dateValue=`date -R` ;\
stringToSign="PUT\n\n${contentType}\n${dateValue}\n${resource}" ;\
s3Key='идентификатор_статического_ключа_доступа' ;\
s3Secret='секретный_ключ' ;\
signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${s3Secret} -binary | base64` ;\
curl -vvv -X PUT -T "${file}" \
  -H "Host: ${bucket}.storage.yandexcloud.net" \
  -H "Date: ${dateValue}" \
  -H "Content-Type: ${contentType}" \
  -H "Authorization: AWS ${s3Key}:${signature}" \
  https://${bucket}.storage.yandexcloud.net/${file}
```

Перед отправкой запроса не забудьте указать следующие параметры:
- `file` - имя файла, который будет загружен в бакет как объект;
- `bucket` - имя бакета, в который будет осуществлена загрузка; 
- `s3Key` и `s3Secret` - идентификатор и секрет [статического ключа доступа](../../../iam/operations/sa/create-access-key.md) сервисного аккаунта;
 - `contentType` - MIME-тип загружаемого объекта, например, `text/plain`.



