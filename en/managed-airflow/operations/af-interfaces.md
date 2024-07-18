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

To open a web interface or send an API request, users need the [{{ roles.maf.user }}](../security/index.md#managed-airflow-user) role or higher. The API checks the role via the [IAM token](../../iam/concepts/authorization/iam-token.md) used for authentication.

{{ AF }} interfaces are accessible via the internet, so the role check is required for added security. Even if an attacker has the link to the web interface and `admin` user password for authentication, they will not have the required role to access the interface.

## Working with the web interface {#web-gui}

{% include [web interface](../../_includes/mdb/maf/web-interface.md) %}

## Using the {{ AF }} API {#rest-api}

You can make [{{ AF }} API](https://airflow.apache.org/docs/apache-airflow/stable/stable-rest-api-ref.html) requests from VMs located in your {{ maf-name }} cluster cloud network.

1. In the cloud network hosting the {{ maf-name }} cluster, create a [Linux](../../compute/quickstart/quick-create-linux.md) VM.
1. [Set up a NAT gateway](../../vpc/operations/create-nat-gateway.md) to connect to the VM.
1. Get an IAM token for a subject with the `{{ roles.maf.user }}` role or higher. The process of getting a token depends on the subject type:

   * [Yandex account](../../iam/operations/iam-token/create.md)
   * [Service account](../../iam/operations/iam-token/create-for-sa.md)
   * [Federated account](../../iam/operations/iam-token/create-for-federation.md)

1. Make an API request, for example, using cURL. In the authorization parameters, enter your username and password.

   Query example:

   ```bash
   curl -X GET \
       'https://c-<cluster_ID>.airflow.yandexcloud.net/api/v1/dags' \
       --user 'admin:<admin_user_password>' \
       --header 'Content-Type: application/json' \
       --header 'X-Cloud-Authorization: Bearer <IAM_token>'
   ```

   The request returns a list of DAG files. For an example of the response, refer to the [{{ AF }} API documentation](https://airflow.apache.org/docs/apache-airflow/stable/stable-rest-api-ref.html#operation/get_dags).

{% note warning %}

To use basic authentication with the {{ AF }} API as in the example above, set the value of the `api.auth_backends` **:** `airflow.api.auth.backend.basic_auth` property in the **{{ ui-key.yacloud.airflow.section_airflow-configuration }}** section when [creating](cluster-create.md) or [updating](cluster-update.md) the cluster. For more information about authentication with the API, see the [{{ AF }} documentation](https://airflow.apache.org/docs/apache-airflow/stable/security/api.html).

{% endnote %}
