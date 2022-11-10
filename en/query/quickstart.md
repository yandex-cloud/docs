NOT USED!!!


# Getting started with {{ yq-full-name }}

In this scenario, you'll place data in a [{{ objstorage-full-name }} bucket](../storage/concepts/bucket.md) and run a [query](concepts/glossary.md#query) to it.
The data contains a user's sign-up time, email address, and IP. The query returns the number of sign-ups for the specified period.

## Before you begin {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or register if you don't have an account yet.
   {% if product == "yandex-cloud" %}
1. On the [billing page]({{ link-console-billing }}), make sure you linked a [billing account](../billing/concepts/billing-account.md) and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../billing/quickstart/index.md).
   {% endif %}
1. On the [cloud page]({{ link-console-cloud }}), create or select a folder for your query and data bucket to run in.

   [Learn more about clouds and folders](../resource-manager/concepts/resources-hierarchy.md).

   {% note info %}

   Make sure all resources in this scenario are created in the same folder.

   {% endnote %}

## Create data to be analyzed {#create-data}

Create a file, such as `my-data.csv`, and copy the following data to it:

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

## Create a bucket {#create-bucket}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a bucket.
   1. Select **{{ objstorage-short-name }}**.
   1. Click **Create bucket**.
   1. On the bucket creation page:
      1. Name the bucket like `my-bucket`.
      1. Select the **Public** access type.

         For more information about bucket access, see the [{{ objstorage-full-name }} documentation](../storage/concepts/bucket#bucket-access).
      1. Click **Create bucket** to complete the operation.

{% endlist %}

## Place the data to analyze in the bucket {#upload-data}

{% list tabs %}

- Management console

   1. Click on the name of the created bucket.
   1. Click **Upload**.
   1. Select the [previously created file](#create-data) and click **Upload**.

{% endlist %}

## Create a connection {#connection}

{% list tabs %}

- Management console

   1. Go to the [management console]({{ link-console-main }}).
   1. Select **{{ yq-name }}**.
   1. Open the **Connections** tab.
   1. Click **Create**.
   1. In the **Name** field, name the [connection](concepts/glossary.md#connection) like `my-connection`.
   1. In the **Type** field, select the `Object Storage` connection type and specify the following parameters:
      * Bucket authorization type in the **Bucket auth** field: **Public**.
      * Bucket name in the **Bucket** field: `my-bucket`.
   1. Click **Create**.

{% endlist %}

## Create and run a query {#create-query}

{% list tabs %}

- Management console

   1. Click ![pencil](../_assets/query/pensil.svg) in the top panel and enter a name for your query, such as `my-query`.
   1. Copy and paste the following code in the query editor window:

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

   2. Click **Run**.

{% endlist %}

This creates and executes the `my-query` query. You can see the query execution result in the **Result** tab:

```text
# count
1 4
```

## What's next {#what-is-next}

* Learn more about the [{{ yq-full-name }}](concepts/index.md) features.
