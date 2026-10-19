# Configuring an SMTP server to send e-mail notifications

Use a [directed acyclic graph (DAG)](../../managed-airflow/concepts/index.md#about-the-service) to configure your SMTP server to send e-mail notifications. In this setup, the SMTP server parameters are stored in the {{ AF }} configuration, while the sender's credentials are stored in a [{{ lockbox-full-name }} secret](../../lockbox/concepts/secret.md#secret).

This guide features Yandex Mail (`smtp.yandex.ru`) as the SMTP server. To verify notification delivery, a DAG file is used in which the task is intentionally made to fail. If an error occurs, a notification is sent to the email address specified in the DAG file.

Before sending notifications, prepare the sender's mailbox:

* Allow access to the mailbox for email clients.
* Create a password for external applications.

To configure the SMTP server for sending email notifications:

1. [Set up your infrastructure](#create-infrastructure).
1. [Create a {{ lockbox-name }} secret](#create-lockbox-secret).
1. [Prepare the DAG file and run the graph](#dag).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

* {{ maf-name }} cluster: computing resources of cluster components (see [{{ maf-name }} pricing](../../managed-airflow/pricing.md)).
* {{ objstorage-full-name }} bucket: use of storage, data operations (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).
* {{ lockbox-name }} secret: number of stored secret versions and requests to them (see [{{ lockbox-name }} pricing](../../lockbox/pricing.md)).


## Set up your infrastructure {#create-infrastructure}

1. [Create a service account](../../iam/operations/sa/create.md#create-sa) named `airflow-sa` with the following roles:
   * `{{ roles.maf.integrationProvider }}`
   * `lockbox.payloadViewer`

   {% note info %}

   There is no need to assign the `lockbox.payloadViewer` role for the whole folder. It is enough to [assign it for a specific {{ lockbox-name }} secret](../../lockbox/operations/secret-access.md) once you create it.

   {% endnote %}

1. [Create an {{ objstorage-name }} bucket](../../storage/operations/buckets/create.md) in any configuration.
1. {% include [aiflow-sa-bucket-acl](../../_includes/managed-airflow/aiflow-sa-bucket-acl.md) %}
1. [Create a {{ maf-name }} cluster](../../managed-airflow/operations/cluster-create.md#create-cluster) with the following parameters:
   * **Service account**: `airflow-sa`.
   * **Bucket name**: Name of the new bucket.
   * **{{ ui-key.yacloud.airflow.field_lockbox }}**: Make sure to enable this option.

   Under **{{ ui-key.yacloud.airflow.section_airflow-configuration }}**, set up additional {{ AF }} properties to configure the SMTP server:

   | Key | Value |
   | ----- | ----- |
   | `smtp.smtp_host` | `smtp.yandex.ru` |
   | `smtp.smtp_port` | `465` |
   | `smtp.smtp_starttls` | `False` |
   | `smtp.smtp_ssl` | `True` |
   | `smtp.smtp_mail_from` | `<sender_email_address>` |

   Fill in the fields manually or upload a configuration from a file. To upload a configuration from a file, click **{{ ui-key.yacloud.airflow.action_button-load-config-from-file }}** and select the **{{ ui-key.yacloud.component.file-content-dialog.value_manual }}** uploading method. Copy the following configuration into the **{{ ui-key.yacloud.component.file-content-dialog.field_content }}** field:
   
   {% cut "SMTP server configuration" %}

   ```text
   [smtp]
   smtp_host = smtp.yandex.ru
   smtp_port = 465
   smtp_starttls = False
   smtp_ssl = True
   smtp_mail_from = <sender_email_address>
   ```

   {% endcut %}

   Read more about the SMTP server configuration parameters in the [relevant {{ AF }} guide](https://airflow.apache.org/docs/apache-airflow/2.2.4/configurations-ref.html#smtp).

1. [Configure a NAT gateway](../../vpc/operations/create-nat-gateway.md) for the {{ maf-name }} cluster's subnets.

## Create a {{ lockbox-name }} secret {#create-lockbox-secret}

[Create a {{ lockbox-name }} secret](../../lockbox/operations/secret-create.md) with the following settings:

* **{{ ui-key.yacloud.common.name }}**: `airflow/connections/smtp_default`.
* **{{ ui-key.yacloud.lockbox.SecretInfoSection.title_secret-type }}**: `Custom`.
* **{{ ui-key.yacloud.lockbox.SecretVersionsList.label_key }}**: `conn`.
* **{{ ui-key.yacloud.lockbox.SecretVersionsList.label_value }}**: Select **{{ ui-key.yacloud.lockbox.SecretVersionsInputs.value_payload-entry-value-type-text }}** and specify the following contents:

  ```json
  {
    "conn_type": "smtp",
    "login": "<sender_email_address>",
    "password": "<password_for_external_apps>"
  }
  ```

## Prepare the DAG file and run the graph {#dag}

1. Create a local file named `test_smtp_notification.py` and paste the following script to it:

   ```python
   from airflow.decorators import dag, task

   default_args = {
    "email": ["<recipient_email_address>"],
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

   It may take a few minutes to upload a DAG file from the bucket.

1. To run the graph, click ![image](../../_assets/managed-airflow/trigger-dag.png =18x) in the line with its name.
1. Wait for the task to fail. A notification will be sent to the specified email address.

    {% note warning %}

    If the SMTP server parameters specified in the {{ AF }} configuration are incorrect, notifications will not be sent.

    {% endnote %}

## Check the result {#check-result}

To check the result in the {{ AF }} `2.11` web interface:

1. In the **DAGs** section, open the `test_smtp_notification` graph.
1. Select the `failing_task`.
1. On the **Task Instance Duration** chart, select a task launch.
1. Navigate to the **Logs** tab.
1. Make sure the logs contain a `Sent an alert email to ['<recipient_email_address>']` line.

To check the result in the {{ AF }} `3.1` web interface:

1. In the **DAGs** section, open the `test_smtp_notification` graph.
1. Navigate to the **Tasks** tab and select the `failing_task`.
1. Navigate to the **Task Instances** tab and select a task launch.
1. Navigate to the **Logs** tab.
1. Make sure the logs contain a `Sent an alert email to ['<recipient_email_address>']` line.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

1. [Service account](../../iam/operations/sa/delete.md).
1. [{{ objstorage-name }} bucket](../../storage/operations/buckets/delete.md).
1. [{{ maf-name }} cluster](../../managed-airflow/operations/cluster-delete.md#delete).
1. [{{ lockbox-name }} secret](../../lockbox/operations/secret-delete.md).