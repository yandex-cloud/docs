# Как перенести данные из бакета {{ objstorage-name }} в ледяное хранилище


## Описание задачи {#case-description}

Необходимо перенести данные из бакета {{ objstorage-name }} из стандартного или холодного хранилища в ледяное хранилище.

## Решение {#case-resolution}

С помощью правил жизненных циклов изменить класс хранения объектов в бакете {{ objstorage-name }} на ледяной не получится. Сменить класс хранения можно двумя способами:

* Через копирование объектов;
* Через установку жизненного цикла с помощью AWS CLI. 

{% list tabs %}

- Копирование утилитой AWS CLI

    Для копирования объектов в другой бакет с помощью утилиты AWS CLI выполните следующие действия:

    1. [Измените тип хранилища](../../../storage/concepts/storage-class.md#changing-storage-class) для вашего бакета на ледяное.
    2. [Установите и настройте утилиту AWS CLI](../../../storage/tools/aws-cli.md).
    3. Выполните команду `aws --endpoint-url=https://storage.yandexcloud.net s3 cp --recursive s3://*\$OLD_BUCKET_NAME\ s3://*\$NEW_BUCKET_NAME\`.

    {% note tip %}

    Замените `$OLD_BUCKET_NAME` на наименование бакета-источника, а `$NEW_BUCKET_NAME` – на наименование бакета-приемника в предоставленном примере.

    {% endnote %}

    В этом случае перемещение данных из одного типа хранилища в другое произойдет на стороне {{ objstorage-name }} без необходимости локальной загрузки объектов на хост с установленным AWS CLI. Также вы можете задать тип хранения для объекта с помощью опции `--storage-class` в AWS CLI:
    ```
    aws --endpoint-url=https://storage.yandexcloud.net s3 cp --recursive s3://*\$OLD_BUCKET_NAME\ s3://*\$NEW_BUCKET_NAME\ --storage-class GLACIER
    ```

    При использовании любого из указанных вариантов смены типа хранения, у объектов в бакете изменится только тип хранилища. Дубликаты объектов в бакете в результате этой операции созданы не будут.

- Установка жизненного цикла утилитой AWS CLI

    Для установки жизненного цикла через AWS CLI выполните следующие действия:

    1. Создайте жизненный циклю с типом `transition` из веб-интерфейса [Консоли управления]({{ link-console-main }}).
    1. Сохраните текущую конфигурацию правил жизненного цикла в файл `lifecycles.json` утилитой AWS CLI:  

        ```bash
        aws s3api get-bucket-lifecycle-configuration \
        --endpoint-url=https://storage.yandexcloud.net \
        --bucket <$BUCKET_NAME> > lifecycles.json  
        ```

        Замените `$BUCKET_NAME` на наименование вашего бакета {{ objstorage-name }} в предоставленном примере.
    
    1. Отредактируйте полученный файл `lifecycles.json`, указав тип хранения `ICE` вместо `COLD`.
    1. Примените новую конфигурацию с помощью утилиты AWS CLI:

        ```bash
        aws s3api put-bucket-lifecycle-configuration \
        --bucket <$BUCKET_NAME> \
        --endpoint-url=https://storage.yandexcloud.net \
        --lifecycle-configuration file://lifecycles.json
        ```

        Замените `$BUCKET_NAME` на наименование вашего бакета {{ objstorage-name }} в предоставленном примере.

{% endlist %}