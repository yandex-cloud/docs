# Working with {{ KF }} topics using PySpark jobs in {{ dataproc-full-name }}

{{ dataproc-name }} clusters support integration with {{ mkf-name }} clusters. You can write and read messages to and from {{ KF }} topics using [PySpark jobs](../../../data-proc/operations/jobs-pyspark.md). Reading supports both batch processing and stream processing.

To configure integration between {{ mkf-name }} and {{ dataproc-name }} clusters:

1. [Prepare your infrastructure](#infra).
1. [Create PySpark jobs](#create-jobs).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare the infrastructure {#infra}

{% list tabs group=instructions %}

* Manually {#manual}

   1. [Create a cloud network](../../../vpc/operations/network-create.md) named `dataproc-network`, without subnets.
   1. [Create a subnet](../../../vpc/operations/subnet-create.md) named `dataproc-subnet-b` in the `{{ region-id }}-b` availability zone.
   1. [Set up a NAT gateway](../../../vpc/operations/create-nat-gateway.md) for the `dataproc-subnet-b` subnet.
   1. [Create a security group](../../../vpc/operations/security-group-create.md) named `dataproc-security-group` in the `dataproc-network` network.
   1. [Configure the security group](../../../data-proc/operations/cluster-create.md#change-security-groups).
   1. [Create a service account](../../../iam/operations/sa/create.md) named `dataproc-sa` with the following roles:

      * `storage.viewer`
      * `storage.uploader`
      * `dataproc.agent`
      * `dataproc.user`

   1. [Create a bucket](../../../storage/operations/buckets/create.md) named `dataproc-bucket`.
   1. [Grant the `dataproc-sa` service account](../../../storage/operations/buckets/edit-acl.md) the `FULL_CONTROL` permission for `dataproc-bucket`.
   1. [Create a {{ dataproc-name }} cluster](../../../data-proc/operations/cluster-create.md#create) with the following parameters:

      * **{{ ui-key.yacloud.mdb.forms.base_field_name }}**: `dataproc-cluster`.
      * **{{ ui-key.yacloud.mdb.forms.config_field_version }}**: `2.1`.
      * **{{ ui-key.yacloud.mdb.forms.config_field_services }}**:

         * `HDFS`
         * `LIVY`
         * `SPARK`
         * `TEZ`
         * `YARN`

      * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}**: `dataproc-sa`.
      * **{{ ui-key.yacloud.mdb.forms.config_field_zone }}**: `{{ region-id }}-b`.
      * **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}**: `dataproc-bucket`.
      * **{{ ui-key.yacloud.mdb.forms.config_field_network }}**: `dataproc-network`.
      * **{{ ui-key.yacloud.mdb.forms.field_security-group }}**: `dataproc-security-group`.
      * **{{ ui-key.yacloud.mdb.forms.section_subclusters }}**: Master, one subcluster named `Data` and one subcluster named `Compute`.

   1. [Create a {{ mkf-name }} cluster](../../../managed-kafka/operations/cluster-create.md#create-cluster) with the following parameters:

      * **{{ ui-key.yacloud.mdb.forms.base_field_name }}**: `dataproc-kafka`.
      * **{{ ui-key.yacloud.mdb.forms.base_field_environment }}**: `PRODUCTION`.
      * **{{ ui-key.yacloud.mdb.forms.base_field_version }}**: `3.5`.
      * **{{ ui-key.yacloud.mdb.forms.config_field_zone }}**: `{{ region-id }}-b`.
      * **{{ ui-key.yacloud.mdb.forms.config_field_network }}**: `dataproc-network`.
      * **{{ ui-key.yacloud.mdb.forms.field_security-group }}**: `dataproc-security-group`.
      * **Subnet**: `dataproc-subnet-b`.

   1. [Create a {{ KF }} topic](../../../managed-kafka/operations/cluster-topics.md#create-topic) with the following parameters:

      * **Name**: `dataproc-kafka-topic`.
      * **{{ ui-key.yacloud.kafka.label_partitions }}**: `1`.
      * **{{ ui-key.yacloud.kafka.label_replication-factor }}**: `1`.

   1. [Create a {{ KF }} user](../../../managed-kafka/operations/cluster-accounts.md#create-user) with the following parameters:

      * **Name**: `user1`.
      * **Password**: `password1`.
      * **Topics the user gets permissions for**: `*` (all topics).
      * **Permissions for the topics**: `ACCESS_ROLE_CONSUMER`, `ACCESS_ROLE_PRODUCER`, and `ACCESS_ROLE_ADMIN`.

* {{ TF }} {#tf}

   1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
   1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
   1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}
   1. Download the [kafka-and-data-proc.tf](https://github.com/yandex-cloud-examples/yc-data-proc-spark-kafka/blob/main/kafka-and-data-proc.tf) configuration file to the same working directory.

      This file describes:

      * [Network](../../../vpc/concepts/network.md#network).
      * [NAT gateway](../../../vpc/concepts/gateways.md) and route table required for {{ dataproc-name }}.
      * [Subnet](../../../vpc/concepts/network.md#subnet).
      * [Security group](../../../vpc/concepts/security-groups.md) required for the {{ dataproc-name }} and {{ mkf-name }} clusters.
      * [Service account](../../../iam/concepts/users/service-accounts.md) required for the {{ dataproc-name }} cluster.
      * Service account for managing the {{ objstorage-full-name }} bucket.
      * [{{ objstorage-full-name }} bucket](../../../storage/concepts/bucket.md).
      * [Static access key](../../../iam/concepts/authorization/access-key.md) required to grant the service account the required permissions for the bucket.
      * {{ dataproc-name }} cluster.
      * {{ mkf-name }} cluster.
      * {{ KF }} user.
      * {{ KF }} topic.

   1. Specify the following in the `kafka-and-data-proc.tf` file:

      * `folder_id`: Cloud folder ID, same as in the provider settings.
      * `dp_ssh_key`: Absolute path to the public key for the {{ dataproc-name }} cluster. For more information, see [{#T}](../../../data-proc/operations/connect.md#data-proc-ssh).

   1. Check that the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Create PySpark jobs {#create-jobs}

1. On a local computer, save the following scripts:

   {% cut "`kafka-write.py`" %}

   Script for writing messages to an {{ KF }} topic:

   ```python
   #!/usr/bin/env python3

   from pyspark.sql import SparkSession, Row
   from pyspark.sql.functions import to_json, col, struct

   def main():
      spark = SparkSession.builder.appName("dataproc-kafka-write-app").getOrCreate()

      df = spark.createDataFrame([
         Row(msg="Test message #1 from dataproc-cluster"),
         Row(msg="Test message #2 from dataproc-cluster")
      ])
      df = df.select(to_json(struct([col(c).alias(c) for c in df.columns])).alias('value'))
      df.write.format("kafka") \
         .option("kafka.bootstrap.servers", "<host_FQDN>:9091") \
         .option("topic", "dataproc-kafka-topic") \
         .option("kafka.security.protocol", "SASL_SSL") \
         .option("kafka.sasl.mechanism", "SCRAM-SHA-512") \
         .option("kafka.sasl.jaas.config",
                 "org.apache.kafka.common.security.scram.ScramLoginModule required "
                 "username=user1 "
                 "password=password1 "
                 ";") \
         .save()

   if __name__ == "__main__":
      main()
   ```

   {% endcut %}

   {% cut "`kafka-read-batch.py`" %}

   Script for reading from a topic and batch processing:

   ```python
   #!/usr/bin/env python3

   from pyspark.sql import SparkSession, Row
   from pyspark.sql.functions import to_json, col, struct

   def main():
      spark = SparkSession.builder.appName("dataproc-kafka-read-batch-app").getOrCreate()

      df = spark.read.format("kafka") \
         .option("kafka.bootstrap.servers", "<host_FQDN>:9091") \
         .option("subscribe", "dataproc-kafka-topic") \
         .option("kafka.security.protocol", "SASL_SSL") \
         .option("kafka.sasl.mechanism", "SCRAM-SHA-512") \
         .option("kafka.sasl.jaas.config",
                 "org.apache.kafka.common.security.scram.ScramLoginModule required "
                 "username=user1 "
                 "password=password1 "
                 ";") \
         .option("startingOffsets", "earliest") \
         .load() \
         .selectExpr("CAST(value AS STRING)") \
         .where(col("value").isNotNull())

      df.write.format("text").save("s3a://dataproc-bucket/kafka-read-batch-output")

   if __name__ == "__main__":
      main()
   ```

   {% endcut %}

   {% cut "`kafka-read-stream.py`" %}

   Script for reading from a topic and stream processing:

   ```python
   #!/usr/bin/env python3

   from pyspark.sql import SparkSession, Row
   from pyspark.sql.functions import to_json, col, struct

   def main():
      spark = SparkSession.builder.appName("dataproc-kafka-read-stream-app").getOrCreate()

      query = spark.readStream.format("kafka")\
         .option("kafka.bootstrap.servers", "<host_FQDN>:9091") \
         .option("subscribe", "dataproc-kafka-topic") \
         .option("kafka.security.protocol", "SASL_SSL") \
         .option("kafka.sasl.mechanism", "SCRAM-SHA-512") \
         .option("kafka.sasl.jaas.config",
                 "org.apache.kafka.common.security.scram.ScramLoginModule required "
                 "username=user1 "
                 "password=password1 "
                 ";") \
         .option("startingOffsets", "earliest")\
         .load()\
         .selectExpr("CAST(value AS STRING)")\
         .where(col("value").isNotNull())\
         .writeStream\
         .trigger(once=True)\
         .queryName("received_messages")\
         .format("memory")\
         .start()

      query.awaitTermination()

      df = spark.sql("select value from received_messages")

      df.write.format("text").save("s3a://dataproc-bucket/kafka-read-stream-output")

   if __name__ == "__main__":
      main()
   ```

   {% endcut %}

1. [Get the {{ KF }}](../../../managed-kafka/operations/connect/index.md#get-fqdn) host FQDN and specify it in each script.
1. [Upload](../../../storage/operations/objects/upload.md) the prepared scripts to the bucket root.
1. [Create a PySpark job](../../../data-proc/operations/jobs-pyspark.md#create) for writing a message to the {{ KF }} topic. In the **{{ ui-key.yacloud.dataproc.jobs.field_main-python-file }}** field, specify the `s3a://dataproc-bucket/kafka-write.py` script path.
1. Wait for the [job status](../../../data-proc/operations/jobs-pyspark.md#get-info) to change to `Done`.
1. Make sure the data is successfully written to the topic. To do this, create a new PySpark job for reading data from the topic and batch processing. In the **{{ ui-key.yacloud.dataproc.jobs.field_main-python-file }}** field, specify the `s3a://dataproc-bucket/kafka-read-batch.py` script path.
1. Wait for the new job status to change to `Done`.
1. [Download](../../../storage/operations/objects/download.md) the file with the read data from the bucket:

   {% cut "part-00000" %}

   ```text
   {"msg":"Test message #1 from dataproc-cluster"}
   {"msg":"Test message #2 from dataproc-cluster"}
   ```

   {% endcut %}

   The file resides in the new folder named `kafka-read-batch-output` in the bucket.

1. Read messages from the topic during stream processing. To do this, create another PySpark job. In the **{{ ui-key.yacloud.dataproc.jobs.field_main-python-file }}** field, specify the `s3a://dataproc-bucket/kafka-read-stream.py` script path.
1. Wait for the new job status to change to `Done`.
1. Download the files with the read data from the bucket:

   {% cut "part-00000" %}

   ```text
   {"msg":"Test message #1 from dataproc-cluster"}
   ```

   {% endcut %}

   {% cut "part-00001" %}

   ```text
   {"msg":"Test message #2 from dataproc-cluster"}
   ```

   {% endcut %}

   The files reside in the new folder named `kafka-read-stream-output` in the bucket.

{% include [get-logs-info](../../../_includes/data-processing/note-info-get-logs.md) %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

1. [Delete the objects](../../../storage/operations/objects/delete.md) from the bucket.
1. Delete the other resources depending on how they were created:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [{{ dataproc-name }} cluster](../../../data-proc/operations/cluster-delete.md).
        1. [{{ mkf-name }} cluster](../../../managed-kafka/operations/cluster-delete.md).
        1. [Bucket](../../../storage/operations/buckets/delete.md).
        1. [Security group](../../../vpc/operations/security-group-delete.md).
        1. [Subnet](../../../vpc/operations/subnet-delete.md).
        1. [Route table](../../../vpc/operations/delete-route-table.md).
        1. [NAT gateway](../../../vpc/operations/delete-nat-gateway.md).
        1. [Network](../../../vpc/operations/network-delete.md).
        1. [Service account](../../../iam/operations/sa/delete.md).

    - {{ TF }} {#tf}

        {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}
