NOT USED!!!


# Как начать работать с {{ yq-full-name }}

В этом сценарии вы разместите данные в [бакете {{ objstorage-full-name }}](../storage/concepts/bucket.md) и выполните к ним [запрос](concepts/glossary.md#query).
Данные содержат информацию о времени регистрации, адресе электронной почты и IP-адресе пользователя. Запрос вернет количество регистраций за заданный промежуток времени.

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.
{% if product == "yandex-cloud" %}
1. На [странице биллинга]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md).
{% endif %}
1. На [странице облака]({{ link-console-cloud }}) создайте или выберите каталог, в котором будут работать ваш запрос и бакет с данными.

    [Подробнее об облаках и каталогах](../resource-manager/concepts/resources-hierarchy.md).

    {% note info %}

    Все ресурсы этого сценария должны быть созданы в одном каталоге.

    {% endnote %}

## Подготовьте данные для анализа {#create-data}

Создайте файл, например `my-data.csv`, и скопируйте в него следующие данные:

```text
id,registration_dttm,email,ip_address
1,2016-02-03T07:55:29Z,ajordan0@com.com,1.197.201.2
2,2016-02-03T17:04:03Z,afreeman1@is.gd,218.111.175.34
3,2016-02-03T01:09:31Z,emorgan2@altervista.org,7.161.136.94
4,2016-02-03T12:36:21Z,driley3@gmpg.org,140.35.109.83
5,2016-02-03T05:05:31Z,cburns4@miitbeian.gov.cn,169.113.235.40
6,2016-02-03T07:22:34Z,kwhite5@google.com,195.131.81.179
7,2016-02-03T08:33:08Z,sholmes6@foxnews.com,232.234.81.197
8,2016-02-03T06:47:06Z,hhowell7@eepurl.com,91.235.51.73
9,2016-02-03T03:52:53Z,jfoster8@yelp.com,132.31.53.61
10,2016-02-03T18:29:47Z,estewart9@opensource.org,143.28.251.245
```

## Создайте бакет {#create-bucket}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать бакет.
  1. Выберите сервис **{{ objstorage-short-name }}**.
  1. Нажмите кнопку **Создать бакет**.
  1. На странице создания бакета:
      1. Введите имя бакета, например `my-bucket`.
      1. Выберите **Публичный** тип доступа.

          Подробнее о доступе к бакету читайте в [документации {{ objstorage-full-name }}](../storage/concepts/bucket#bucket-access).
      1. Нажмите кнопку **Создать бакет** для завершения операции.

{% endlist %}

## Разместите в бакете данные для анализа {#upload-data}

{% list tabs %}

- Консоль управления

  1. Нажмите на имя созданного бакета.
  1. Нажмите кнопку **Загрузить**.
  1. Выберите [созданный ранее файл](#create-data) и нажмите кнопку **Загрузить**.

{% endlist %}

## Создайте соединение {#connection}

{% list tabs %}

- Консоль управления

  1. Перейдите в [консоль управления]({{ link-console-main }}).
  1. Выберите сервис **{{ yq-name }}**.
  1. Прейдите на вкладку **Connections**.
  1. Нажмите кнопку **Create**.
  1. В поле **Name** введите имя [соединения](concepts/glossary.md#connection), например `my-connection`.
  1. В поле **Type** выберите тип соединения `Object Storage` и задайте параметры:
      * Тип авторизации для бакета в поле **Bucket auth** — **Public**.
      * Имя бакета в поле **Bucket** — `my-bucket`.
  1. Нажмите кнопку **Create**.

{% endlist %}

## Создайте и выполните запрос {#create-query}

{% list tabs %}

- Консоль управления

  1. На верхней панели нажмите кнопку ![pencil](../_assets/query/pensil.svg) и введите имя запроса, например `my-query`.
  1. Скопируйте и вставьте в окно редактора запросов следующий код:

      ```sql
      SELECT
      COUNT(*)
      FROM
        `yq-public`.`yq-tutorial.csv`
      WITH 
      (
        format=csv_with_names,
        SCHEMA (id Int64, registration_dttm String, email String, `ip_address` String)
      )
      WHERE CAST(`registration_dttm` AS DateTime) >= Timestamp('2016-02-03T01:09:31Z')
      AND CAST(`registration_dttm` AS DateTime) <= Timestamp('2016-02-03T07:09:31Z')
      ```

  2. Нажмите кнопку **Run**.

{% endlist %}

Будет создан и выполнен запрос `my-query`. Результат выполнения запроса будет отображен на вкладке **Result**:

```text
# count
1 4
```

## Что дальше {#what-is-next}

* Узнайте больше о возможностях [{{ yq-full-name }}](concepts/index.md).
