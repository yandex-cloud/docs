# Анализ поресурсной детализации расходов с помощью Yandex Object Storage

Вы настроите автоматический экспорт данных с детализацией расходов на вашем [платежном аккаунте](../concepts/billing-account.md) и сформируете отчет, содержащий информацию о сумме расходов на ресурсы в каталоге. Для получения данных из бакета Object Storage будет использоваться язык запросов [S3 Select](../../storage/concepts/s3-select-language.md).

Чтобы проанализировать расходы:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте бакет Object Storage](#create-bucket).
1. [Получите детализацию расходов](#get-billing-detail).
1. [Сформируйте отчет](#create-report).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../quickstart/index.md) и [привяжите](../operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость анализа детализации входит плата за хранение данных в бакете и операции с ними (см. [тарифы Object Storage](../../storage/pricing.md)).


### Настройте окружение {#setup-environment}

Установите и настройте интерфейс командной строки [AWS CLI](../../storage/tools/aws-cli.md).

## Создайте бакет Object Storage {#create-bucket}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать бакет.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Object Storage**.
  1. Справа сверху нажмите кнопку **Создать бакет**.
  1. В поле **Имя** укажите имя бакета.
  1. Нажмите кнопку **Создать бакет**.

{% endlist %}

## Получите детализацию расходов {#get-billing-detail}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts).
  1. В списке платежных аккаунтов выберите нужный.
  1. Перейдите на вкладку **Детализация**.
  1. Справа сверху нажмите кнопку **Экспорт детализации** и выберите **Регулярный экспорт**.
  1. В открывшемся окне:

     * В поле **Бакет** укажите имя бакета, [созданного ранее](#create-bucket). В нем будет храниться CSV-файл с детализацией.
     * В поле **Папка** укажите название папки для файла. Последний символ должен быть `/`.
     * В поле **Язык** выберите язык, на котором будут отображаться названия продуктов – **English** или **Русский**.
     * В поле **Детализация** выберите тип детализации ***Поресурсная**.

  1. Нажмите кнопку **Создать**.

{% endlist %}

## Сформируйте отчет {#create-report}

{% list tabs group=programming_language %}

- Bash {#bash}

  1. Выполните запрос в Object Storage и сохраните результат выполнения в файл:

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
        aws --endpoint https://storage.yandexcloud.net s3api select-object-content \
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