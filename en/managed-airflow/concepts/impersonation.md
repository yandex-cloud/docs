# Impersonation in {{ maf-full-name }}

_Impersonation_ in {{ maf-short-name }} occurs when an {{ AF }} cluster performs certain actions with user resources on behalf of a user's service account.

By default, an {{ AF }} cluster does not have permissions to access user resources. To provide access to such resources, [create a service account](../../iam/operations/sa/create.md#create-sa) with the required roles and attach it to the {{ AF }} cluster when [creating](../operations/cluster-create.md#create-cluster) or [updating](../operations/cluster-update.md) the cluster. After that, you will be able to authenticate on behalf of the service account from the code of DAG files.

Impersonation enables an {{ AF }} cluster to support integration with other {{ yandex-cloud }} services via the [{{ yandex-cloud }} Python SDK](https://github.com/yandex-cloud/python-sdk) and [Airflow Yandex Provider](https://airflow.apache.org/docs/apache-airflow-providers-yandex/stable/index.html).

{{ maf-short-name }} also supports integration with [{{ lockbox-full-name }}](../../lockbox/concepts/index.md) as an {{ AF }} secret storage.

## Integration with {{ yandex-cloud }} via the Python SDK {#yc-python-sdk-integration}

The [{{ yandex-cloud }} Python SDK](https://github.com/yandex-cloud/python-sdk) allows you to manage {{ yandex-cloud }} resources from DAG files of the {{ AF }} cluster on behalf of a [service account](../../functions/operations/function-sa.md). To do this, create the `yandexcloud.SDK()` object in a DAG file without specifying authentication parameters. The DAG file will be authenticated using the [IAM token](../../iam/concepts/authorization/iam-token.md) of the service account attached to the cluster.

For an integration example, see [{#T}](../tutorials/using-python-sdk.md).

## Integration with {{ yandex-cloud }} via the Airflow Provider {#yc-airflow-provider-integration}

{{ maf-short-name }} clusters with enabled impersonation have an automatically configured `yandexcloud_default` connection that all operators in the Airflow Yandex Provider use by default. To use it, create a DAG file without specifying the `yandex_conn_id` parameter. The operator will be authenticated using the IAM token of the service account attached to the cluster.

For an integration example, see [{#T}](../tutorials/yandex-query-automation.md).

## Integration with {{ lockbox-name }} {#lockbox-integration}

{{ lockbox-name }} is a service for centralized storage of secrets. In {{ lockbox-name }}, you can store data to use in DAG files, such as configuration data, variables and {{ AF }} [connection parameters](../tutorials/data-proc-automation.md#connections).

By default, {{ AF }} stores sensitive data in a metadata storage. In this case, you have to manage secrets for every {{ AF }} cluster manually via the UI or API. To automate management of secrets, store them in {{ lockbox-name }}. For more information, see the [{{ AF }} documentation](https://airflow.apache.org/docs/apache-airflow/stable/security/secrets/secrets-backend/index.html).

To use {{ lockbox-name }} features in an {{ AF }} cluster, [create a secret](../../lockbox/operations/secret-create.md) with the required data and [provide the permission to access it](../../lockbox/operations/secret-access.md) to the service account attached to the cluster. After that, you will be able to use data from the secret in the cluster's DAG files.

For an integration example, see [{#T}](../tutorials/lockbox-secrets-in-maf-cluster.md).
