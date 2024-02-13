---
title: "Working with {{ AF }} interfaces"
description: "To work with {{ AF }}, you can use the web interface or the {{ AF }} REST API"
keywords:
  - "Working with {{ AF }} interfaces"
  - "{{ AF }}"
  - Airflow
---

# Working with {{ AF }} interfaces

To work with {{ maf-name }}, you can use the [web interface](#web-gui) or the [{{ AF }} API](#rest-api).

## Working with the web interface {#web-gui}

{% include [web interface](../../_includes/mdb/maf/web-interface.md) %}

## Using the {{ AF }} API {#rest-api}

You can make [{{ AF }} API](https://airflow.apache.org/docs/apache-airflow/stable/stable-rest-api-ref.html) requests from VMs located in your {{ maf-name }} cluster cloud network.

1. In the cloud network hosting the {{ maf-name }} cluster, create a [Linux](../../compute/quickstart/quick-create-linux.md) VM.
1. [Set up a NAT gateway](../../vpc/operations/create-nat-gateway.md) to connect to the VM.
1. Make an API request, for example, using cURL. In the authorization parameters, enter your username and password.

Sample request:

```bash
curl -X GET \
    'https://c-<cluster_ID>.airflow.yandexcloud.net/api/v1/dags' \
    --user 'admin:<admin_user_password>' \
    --header 'Content-Type: application/json' \
    --header 'X-Cloud-Authorization: Bearer <IAM_token>'
```

Where `<IAM_token>` is the IAM token of the subject with the `managed-airflow.user` role for the Airflow cluster.

The request returns a list of DAG files. For a sample response, refer to the [{{ AF }} API documentation](https://airflow.apache.org/docs/apache-airflow/stable/stable-rest-api-ref.html#operation/get_dags).

{% note warning %}

To use basic authentication with the {{ AF }} API as in the example above, set the value of the `api.auth_backends` **:** `airflow.api.auth.auth.backend.basic_auth` property in the **{{ ui-key.yacloud.airflow.section_airflow-configuration }}** section when [creating](cluster-create.md) or [updating](cluster-update.md) the cluster. For more information about authentication with the API, see the [{{ AF }} documentation](https://airflow.apache.org/docs/apache-airflow/stable/security/api.html).

{% endnote %}
