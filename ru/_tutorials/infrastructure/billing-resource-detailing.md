# Анализ поресурсной детализации расходов с помощью {{ objstorage-full-name }}

Вы настроите автоматический экспорт данных с детализацией расходов на вашем [платежном аккаунте](../../billing/concepts/billing-account.md) и сформируете отчет, содержащий информацию о сумме расходов на ресурсы в каталоге. Для получения данных из бакета {{ objstorage-name }} будет использоваться язык запросов [S3 Select](../../storage/concepts/s3-select-language.md).

Чтобы проанализировать расходы:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте бакет {{ objstorage-name }}](#create-bucket).
1. [Получите детализацию расходов](#get-billing-detail).
1. [Сформируйте отчет](#create-report).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость анализа детализации входит плата за хранение данных в бакете и операции с ними (см. [тарифы {{ objstorage-name }}](../../storage/pricing.md)).


### Настройте окружение {#setup-environment}

Установите и настройте интерфейс командной строки [AWS CLI](../../storage/tools/aws-cli.md).

## Создайте бакет {{ objstorage-name }} {#create-bucket}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать бакет.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. В поле **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** укажите имя бакета.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

{% endlist %}

## Получите детализацию расходов {#get-billing-detail}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. {% include [move-to-billing-step](../../billing/_includes/move-to-billing-step.md) %}
  1. В списке платежных аккаунтов выберите нужный.
  1. Перейдите на вкладку **{{ ui-key.yacloud_billing.billing.account.switch_detail }}**.
  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud_billing.billing.account.detail.button_export }}** и выберите **{{ ui-key.yacloud_billing.billing.account.detail.button_create-periodic-export }}**.
  1. В открывшемся окне:

     * В поле **{{ ui-key.yacloud_billing.billing.account.exports.field_bucket }}** укажите имя бакета, [созданного ранее](#create-bucket). В нем будет храниться CSV-файл с детализацией.
     * В поле **{{ ui-key.yacloud_billing.billing.account.exports.field_prefix }}** укажите название папки для файла. Последний символ должен быть `/`.
     * В поле **{{ ui-key.yacloud_billing.billing.account.exports.field_locale }}** выберите язык, на котором будут отображаться названия продуктов – **{{ ui-key.yacloud_billing.billing.account.exports.locale_value_en-lang }}** или **{{ ui-key.yacloud_billing.billing.account.exports.locale_value_ru-lang }}**.
     * В поле **{{ ui-key.yacloud_billing.billing.account.exports.field_detail-type }}** выберите тип детализации ***{{ ui-key.yacloud_billing.billing.account.exports.label_include-resources }}**.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Сформируйте отчет {#create-report}

{% list tabs group=programming_language %}

- Bash {#bash}

  1. Выполните запрос в {{ objstorage-name }} и сохраните результат выполнения в файл:

     1. Для удобства работы сохраните:

        * Имя бакета, в котором хранится файл с детализацией, в переменную `$bucket`:

          ```bash
          bucket=<имя_бакета>
          ```

        * [Ключ](../../storage/concepts/object.md#key) объекта с детализацией в переменную `$key`:

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
          --input-serialization 'CSV={FileHeaderInfo=USE,FieldDelimiter=,}' \
          --output-serialization 'CSV={}' \
          "output.csv"
        ```

  1. Чтобы вывести сумму расходов для каждого ресурса, выполните агрегирующий запрос при помощи утилиты `awk`:

     ```bash
     < output.csv awk -F, '{n[$2]+=$6} END{for(i in n){print n[i] "\t" i}}' | sort -nrk1
     ```

     Результат:

     ```bash
     591.206 c8rska9493**********
     254.092 c8rk36jv5n**********
     93.4481 a7l9vsb1bt**********
     ...
     0.742366 fdv0u8gkl**********
     0.694901 c8rhi3km7**********
     0.545707 a7l7fb0at**********
     ```

{% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы остановить работу и перестать платить за созданные ресурсы:

1. [Удалите](../../storage/operations/objects/delete.md) все объекты из бакета.
1. [Удалите](../../storage/operations/buckets/delete.md) бакет.
