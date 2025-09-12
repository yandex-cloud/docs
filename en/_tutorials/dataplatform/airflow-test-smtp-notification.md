# Configuring an SMTP server to send e-mail notifications

Use a [directed acyclic graph (DAG)](../../managed-airflow/concepts/index.md#about-the-service) to configure your SMTP server to send e-mail notifications. Data for connecting to the DB is stored in {{ lockbox-name }} and automatically inserted into the graph.

To configure an SMTP server to send e-mail notifications, follow these steps:

1. [Set up your infrastructure](#create-infrastracture).
1. [Create a {{ lockbox-name }} secret](#create-lockbox-secret).
1. [Prepare the DAG file and run the graph](#dag).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).

## Set up your infrastructure {#create-infrastracture}

1. [Create a service account](../../iam/operations/sa/create.md#create-sa) named `airflow-sa` with the following roles:
   * `{{ roles.maf.integrationProvider }}`
   * `lockbox.payloadViewer`

   {% note info }

   There is no need to assign the `lockbox.payloadViewer` role for the whole folder. It is enough to [assign it for a specific {{ lockbox-name }} secret](../../lockbox/operations/secret-access.md) once you create it.

   {% endnote %}

1. [Create an {{ objstorage-name }} bucket](../../storage/operations/buckets/create.md) in any configuration.
1. {% include [aiflow-sa-bucket-acl](../../_includes/managed-airflow/aiflow-sa-bucket-acl.md) %}
1. [Create a {{ maf-name }} cluster](../../managed-airflow/operations/cluster-create.md#create-cluster) with the following parameters:
   * **Service account**: `airflow-sa`.
   * **Bucket name**: Name of the new bucket.
   * **{{ ui-key.yacloud.airflow.field_lockbox }}**: Make sure to enable this option.

   Under **{{ ui-key.yacloud.airflow.section_airflow-configuration }}**, set up [additional {{ AF }} properties](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html) to configure the SMTP server:

   | Key | Value |
   | ----- | ----- |
   | `smtp.smtp_host` | `smtp.yandex.ru` |
   | `smtp.smtp_port` | `465` |
   | `smtp.smtp_starttls` | `False` |
   | `smtp.smtp_ssl` | `True` |
   | `smtp.smtp_mail_from` | `user@yandex.ru` |

   Fill in the fields manually or import the settings from a configuration file (see [a configuration file example](https://{{ s3-storage-host }}/doc-files/managed-airflow/airflow.cfg)).


### Required paid resources {#paid-resources}

The support cost includes:

* {{ maf-name }} cluster fee: using computing resources allocated to hosts and disk space (see [{{ maf-name }} pricing](../../managed-airflow/pricing.md)).
* Fee for using public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* Fee for an {{ objstorage-name }} bucket: data storage and operations with it (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).
* {{ lockbox-name }} fee: storing secrets (see [{{ lockbox-name }} pricing](../../lockbox/pricing.md)).


## Create a {{ lockbox-full-name }} secret {#create-lockbox-secret}

[Create a {{ lockbox-name }} secret](../../lockbox/operations/secret-create.md) named `airflow/connections/smtp_default`, containing `json.dumps(conn)`, where `conn` is a connection to an SMTP server.

```json
conn = {
         "conn_type": "smtp",
         "login": "user@yandex.ru",
         "password": "<password_for_external_apps>"
}
```

The `airflow/connections/smtp_default` secret will store the data for connecting to the SMTP server.

## Prepare the DAG file and run the graph {#dag}

1. Create a local file named `test_smtp_notification.py` and paste the following script to it:

   ```python
   from airflow.decorators import dag, task

   default_args = {
    "email": ["user@yandex.ru"],
    "email_on_failure": True,
    "email_on_retry": True
   }


   @dag(schedule=None, default_args=default_args)
   def test_smtp_notification():
       @task
       def failing_task():
           raise RuntimeError("some test error")

       failing_task()


   test_smtp_notification()
   ```

1. Upload the `test_smtp_notification.py` DAG file to the bucket you created earlier. This will automatically create a graph with the same name in the {{ AF }} web interface.

1. [Open the {{ AF }} web interface](../../managed-airflow/operations/af-interfaces.md#web-gui).
1. Make sure a new graph named `test_smtp_notification` has appeared in the **DAGs** section.

   It may take a few minutes to load a DAG file from the bucket.

1. To run the graph, click ![image](../../_assets/managed-airflow/trigger-dag.png =18x) in the line with its name.

## Check the result {#check-result}

To check the result in the {{ AF }} web interface:

1. In the **DAGs** section, open the `test_smtp_notification` graph.
1. Go to the **Graph** section.
1. Select **failing_task**.
1. Go to **Logs**.
1. Make sure the logs do not contain the `some test error` line. This means the query was successful.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

1. [Service account](../../iam/operations/sa/delete.md).
1. [{{ objstorage-name }} bucket](../../storage/operations/buckets/delete.md).
1. [{{ maf-name }} cluster](../../managed-airflow/operations/cluster-delete.md#delete).
1. [{{ lockbox-name }} secret](../../lockbox/operations/secret-delete.md).