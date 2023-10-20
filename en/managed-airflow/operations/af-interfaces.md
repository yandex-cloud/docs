---
title: "Working with {{ AF }} interfaces"
description: "To work with {{ AF }}, you can use the web interface or the {{ AF }} REST API"
keywords:
  - Working with {{ AF }} interfaces
  - {{ AF }}
  - Airflow
---

# Working with {{ AF }} interfaces

To work with {{ maf-name }}, you can use the [web interface](#web-gui) or the [{{ AF }} API](#rest-api).

## Working with the web interface {#web-gui}

{% include [web interface](../../_includes/mdb/maf/web-interface.md) %}

## Using the {{ AF }} API {#rest-api}

You can make [API {{ AF }}](https://airflow.apache.org/docs/apache-airflow/stable/stable-rest-api-ref.html) requests from VMs located in your {{ maf-name }} cluster's cloud network.

1. In the cloud network hosting the {{ maf-name }} cluster, create a [Linux](../../compute/quickstart/quick-create-linux.md) VM.
1. [Set up a NAT gateway](../../vpc/operations/create-nat-gateway.md) to connect to the VM.
1. Make an API request, for example, using cURL. In the authorization parameters, enter your username and password.

Sample request:

```bash
curl -X GET \
    'https://c-<cluster ID>.airflow.yandexcloud.net/api/v1/dags' \
    --user 'admin:<admin user password>' \
    --header 'Content-Type: application/json' \
    --header 'X-Cloud-Authorization: Bearer <IAM token of a subject with the managed-airflow.user role for an Airflow cluster>'
```

The request returns a list of DAG files. For a sample response, refer to the [{{ AF }} API documentation](https://airflow.apache.org/docs/apache-airflow/stable/stable-rest-api-ref.html#operation/get_dags).
