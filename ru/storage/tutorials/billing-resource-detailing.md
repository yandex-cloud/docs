# Анализ поресурсной детализации расходов

В данном сценарии описаны шаги, необходимые для получения отчета с информацией о сумме расходов на ресурсы в каталоге. Для получения данных используется язык запросов [S3 Select](../concepts/s3-select-language.md).

## Перед началом работы {#before-you-begin}

Установите и настройте интерфейс командной строки [AWS CLI](../tools/aws-cli.md).

## Получение детализации расходов {#get-billing-detail}

{% list tabs %}

- Консоль управления

  1. {% include [move-to-billing-step](../../billing/_includes/move-to-billing-step.md) %}
  1. В списке платежных аккаунтов выберите нужный.
  1. Перейдите на вкладку **{{ ui-key.yacloud.billing.account.switch_detail }}**.
  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud.billing.account.detail.button_export }}** и выберите **{{ ui-key.yacloud.billing.account.detail.button_create-periodic-export }}**.
  1. В открывшемся окне:
     * В поле **{{ ui-key.yacloud.billing.account.exports.field_bucket }}** укажите имя бакета, где будет храниться CSV-файл с детализацией.
     * В поле **{{ ui-key.yacloud.billing.account.exports.field_prefix }}** укажите название папки для файла. Последний символ должен быть `/`.
     * В поле **{{ ui-key.yacloud.billing.account.exports.field_locale }}** выберите язык, на котором будут отображаться названия продуктов – **{{ ui-key.yacloud.billing.account.exports.locale_value_en-lang }}** или **{{ ui-key.yacloud.billing.account.exports.locale_value_ru-lang }}**.
     * В поле **{{ ui-key.yacloud.billing.account.exports.field_detail-type }}** выберите тип детализации **{{ ui-key.yacloud.billing.account.exports.label_include-resources }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Формирование отчета {#create-report}

1. Выполните запрос в {{ objstorage-name }} и сохраните результат выполнения в файл:

    1. Для удобства работы сохраните:
      
        * Имя бакета, в котором хранится файл с детализацией, в переменную `$bucket`:
            
            ```bash
            bucket=<имя_бакета>
            ```

        * [Ключ](../concepts/object.md#key) объекта с детализацией в переменную `$key`:
            
            ```bash
            key=<ключ_объекта>
            ```
        
        * Выражение для запроса данных из файла с детализацией на языке S3 Select в переменную `$query`:
            
            ```bash
            query="select service_name,resource_id,sku_id,sku_name,\"date\",cost from S3Object where service_name='Compute Cloud'"
            ```

    1. Выполните команду:

        ```bash
        aws --endpoint https://{{ s3-storage-host }} s3api select-object-content \
          --bucket $bucket \
          --key $key \
          --expression "$query" \
          --expression-type 'SQL' \
          --input-serialization '{"CSV": {"FileHeaderInfo": "USE", "FieldDelimiter":","}}' \
          --output-serialization '{"CSV": {}}' \
          "output.csv"
        ```

1. Чтобы вывести сумму расходов для каждого ресурса, выполните агрегирующий запрос при помощи утилиты `awk`:

    ```bash
    < output.csv awk -F, '{n[$2]+=$6} END{for(i in n){print n[i] "\t" i}}' | sort -nrk1
    ```

    Результат:

    ```bash
    591.206 c8rska9493s55k8bn00n
    254.092 c8rk36jv5nn4k9oo82ai
    93.4481 a7l9vsb1btl6vvlflaig
    ...
    0.742366 fdv0u8gklc23ibhqdna4
    0.694901 c8rhi3km712q3r0r5vrp
    0.545707 a7l7fb0athcsbnqdh4ee
    ```
