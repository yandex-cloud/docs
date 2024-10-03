# Устранение проблем с некорректным MIME-типов объектов при их загрузке в {{ objstorage-short-name }}


## Описание проблемы {#issue-description}

* Возникают ошибки при обращении к объектам, загруженным в {{ objstorage-short-name }}, например, не отображаются картинки, не работают скрипты;
* В JavaScript-консоли браузера отображаются ошибки о некорректных MIME-типах объектов, загружаемых из бакета.

## Решение {#issue-resolution}

{{ objstorage-short-name }} сообщает для загруженных в бакеты объектов тот `Content-Type`, который был указан при их загрузке.
Если `Content-Type` не указан при загрузке, по умолчанию для объектов выставляется `Content-Type` `binary/octet-stream`.

Проверьте конфигурацию S3-клиента, с помощью которого вы ранее загружали объекты в бакет, на предмет указания корректного `Content-Type`. Его необходимо явно указывать при загрузке файла в бакет. Можно также указать его для уже загруженных объектов через удобный вам [S3-клиент или SDK](../../../storage/tools/index.md):

{% list tabs %}

- AWS CLI
    
    aws s3 cp --endpoint-url=https://storage.yandexcloud.net \
    s3://<bucket-name>/ \
    s3://<bucket-name>/ \
    --exclude '*' \
    --include '*.js' \
    --no-guess-mime-type \
    --content-type="application/javascript" \
    --metadata-directive="REPLACE" \
    --recursive

- s3cmd
    
    s3cmd put --recursive \
    --exclude "*" \
    --include "*.js" \
    --no-mime-magic \
    --add-header="Content-Type: application/javascript" \
    --no-preserve \
    --acl-public \
    /path/to/local/directory \
    s3://<bucket-name>/

{% endlist %}

## Если проблема осталась {#if-issue-still-persists}

Если вышеописанные действия не помогли решить проблему, [создайте запрос в техническую поддержку]({{ link-console-support }}). При создании запроса укажите следующую информацию:

1. Идентификатор бакета в {{ objstorage-short-name }}.
1. Ссылку на проблемный объект.
1. Вывод из JavaScript-консоли браузера с ошибкой или [HAR-файл](../../../support/create-har.md).