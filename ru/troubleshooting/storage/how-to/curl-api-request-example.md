# Как работать напрямую с API {{ objstorage-name }} без использования SDK


## Описание задачи {#case-description}

Необходимо обмениваться данными с сервисом {{ objstorage-name }} напрямую без использования SDK для имеющихся языков программирования.

## Решение {#case-resolution}

Формат заголовка `Authorization`  для составления запроса к сервису имеет вид `"Authorization: AWS <id_ключа>:<подпись>"`, где:

* `Authorization: AWS` - неизменяемое значение;
* `<id_ключа>` - идентификатор статического ключа доступа сервисного аккаунта, указывается без угловых скобок;
* `<подпись>` - подпись запроса с использованием механизма HMAC с хеширующим алгоритмом SHA-256, также указывается без угловых скобок.

Пример:
`Authorization: AWS YCAJEsU4EP6Dyo6QiHhPHz4dO:/CQuut9oew7fUoKorITnCcg2VlA=`

{% note info %}

Подробнее о подписи запросов пишем в [документации](../../../storage/s3/signing-requests.md).

{% endnote %}

## Пример запроса к {{ objstorage-name }} средствами утилиты `curl`

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

* `file` - имя файла, который будет загружен в бакет как объект;
* `bucket` - имя бакета, в который будет осуществлена загрузка; 
* `s3Key` и `s3Secret` - идентификатор и секрет [статического ключа доступа](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) сервисного аккаунта;
* `contentType` - MIME-тип загружаемого объекта, например, `text/plain`.
