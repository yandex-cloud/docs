# Impersonation in {{ maf-name }}

_Impersonation_ in {{ maf-short-name }} is when an {{ AF }} cluster performs actions with user resources on behalf of a service account.

By default, an {{ AF }} cluster does not have permissions to access user resources. To provide access to such resources, [create a service account](../../iam/operations/sa/create.md#create-sa) with the required roles and link it to the {{ AF }} cluster when [creating](../operations/cluster-create.md#create-cluster) or [updating](../operations/cluster-update.md) the cluster. After that, you will be able to authenticate on behalf of the service account from the code of DAG files.

Impersonation enables an {{ AF }} cluster to support integration with other {{ yandex-cloud }} services. These include [{{ cloud-logging-full-name }}](../../logging/index.yaml), [{{ lockbox-full-name }}](../../lockbox/concepts/index.md), and [{{ monitoring-full-name }}](../../monitoring/concepts/index.md).

 For a cluster to be able to work with the services, assign the `managed-airflow.integrationProvider` [role](../security/index.md#managed-airflow-integrationProvider) to its service account. With this role, a cluster can write logs to {{ cloud-logging-name }}, access {{ lockbox-name }} secrets, and send metrics to {{ monitoring-name }}.

{{ maf-name }} supports integration with other services via the [{{ yandex-cloud }} Python SDK](https://github.com/yandex-cloud/python-sdk) or [Airflow Yandex Provider](https://airflow.apache.org/docs/apache-airflow-providers-yandex/stable/index.html).

## Services available for integration {#services}

### {{ cloud-logging-name }} {#cloud-logging-integration}

{{ cloud-logging-name }} is a service that stores and reads logs for {{ yandex-cloud }} services. If a {{ maf-name }} cluster has logging enabled, its logs are saved to a selected {{ cloud-logging-name }} log group.

For more information about logging configuration, see [Transferring cluster logs](../operations/af-logging.md).

### {{ monitoring-name }} {#monitoring-integration}

{{ monitoring-name }} is a service that collects and stores metrics for {{ yandex-cloud }} services. Metrics are displayed as charts on the cluster page under **{{ ui-key.yacloud.common.monitoring }}**. They show the current state and health of the cluster. Metrics are available by default in all {{ maf-name }} clusters. For a list of available metrics, see the relevant [reference](../metrics.md).

### {{ lockbox-name }} {#lockbox-integration}

{{ lockbox-name }} is a service for centralized storage of secrets. In {{ lockbox-name }}, you can store data to use in DAG files, such as configuration data, variables and {{ AF }} connection parameters. You can see the example of such data in [Automating {{ dataproc-name }} operations](../tutorials/data-processing-automation.md#dag).

By default, {{ AF }} stores sensitive data in a metadata storage. In this case, you have to manage secrets for every {{ AF }} cluster manually via the UI or API. To automate management of secrets, store them in {{ lockbox-name }}. For more information, see the [{{ AF }} documentation](https://airflow.apache.org/docs/apache-airflow/stable/security/secrets/secrets-backend/index.html).

To use {{ lockbox-name }} features in an {{ AF }} cluster, [create a secret](../../lockbox/operations/secret-create.md) with the required data and [provide the permission to access it](../../lockbox/operations/secret-access.md) to the service account attached to the cluster. After that, you will be able to use data from the secret in the cluster's DAG files.


#### Use cases {#examples-lockbox}

* [{#T}](../tutorials/test-smtp-notification.md)
* [{#T}](../operations/lockbox-secrets-in-maf-cluster.md)


## Tools available for integration with {{ yandex-cloud }} {#instruments}

### Python SDK {#yc-python-sdk-integration}

The [{{ yandex-cloud }} Python SDK](https://github.com/yandex-cloud/python-sdk) allows you to manage {{ yandex-cloud }} resources from DAG files of the {{ AF }} cluster on behalf of a [service account](../../functions/operations/function-sa.md). To do this, create the `yandexcloud.SDK()` object in a DAG file without specifying authentication parameters. The DAG file will be authenticated using the [IAM token](../../iam/concepts/authorization/iam-token.md) of the service account attached to the cluster.


#### Use cases {#examples-python}

* [{#T}](../tutorials/using-python-sdk.md)


### Airflow Yandex Provider {#yc-airflow-provider-integration}

{{ maf-short-name }} clusters with enabled impersonation have an automatically configured `yandexcloud_default` connection used by default by all the Airflow Yandex Provider operators. To use it, create a DAG file without specifying the `yandex_conn_id` parameter. The operator will be authenticated using the IAM token of the service account attached to the cluster.

For an integration example, see [{#T}](../tutorials/airflow-auto-tasks.md).
