# {{ api-gw-name }} protection with {{ sws-name }}

{{ api-gw-full-name }} supports integration with [{{ sws-full-name }}](../../smartwebsecurity/concepts/index.md). This allows you to set up DDoS and bot protection for an API gateway at [OSI](https://en.wikipedia.org/wiki/OSI_model) application level (L7).

With {{ sws-name }} security profiles, you can configure protection using various conditions. For example, you can set a [request limit](../../smartwebsecurity/concepts/arl.md) with request grouping based on various parameters or block requests based on user IP address. To do this:

1. [Get your cloud ready](#before-you-begin).
1. [Create an ARL profile and {{ sws-name }} security profile](#create-arl-and-sws-profiles).
1. [Create an API gateway](#create-api-gateway).
1. [Test the new resources](#check-rules).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

## Create an ARL profile and {{ sws-name }} security profile {#create-arl-and-sws-profiles}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Create an ARL profile](../../smartwebsecurity/operations/arl-profile-create.md) named `arl-profile`.

  1. [Add to it a rule](../../smartwebsecurity/operations/arl-rule-add.md) with a request limit and request grouping based on the `token` parameter. Specify the following parameters:

      * **Name**: `query-limit-rule`
      * **{{ ui-key.yacloud.smart-web-security.arl.column_rule-priority }}**: `999900`
      * **Request grouping**: **By property**
      * **Property**: `Query params`
      * **Group by**: `token`
      * **Request limit per group**: `1` per `1 minute`

  1. [Create a security profile](../../smartwebsecurity/operations/profile-create.md) named `sws-profile` using a preset template. When creating it, select the previously created `arl-profile` in the **{{ ui-key.yacloud.smart-web-security.arl.title_profile }}** field.

  1. To set up blocking based on user IP address, [add a rule](../../smartwebsecurity/operations/rule-add.md) with the following parameters to the {{ sws-name }} security profile:

      * **Name**: `ip-block-rule`
      * **{{ ui-key.yacloud.smart-web-security.arl.column_rule-priority }}**: `999700`
      * **Rule type**: **Basic**
      * **{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}**: **Allow**
      * **{{ ui-key.yacloud.smart-web-security.arl.column_rule-conditions }}**:

          * **Traffic**: **On condition**.
          * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}**: `IP`.
          * **Conditions for IP**: `Matches or falls within the range`.
          * **IP matches or falls within the range**: Specify your IP address.

- {{ TF }} {#tf}

  1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
  1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
  1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
  1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

  1. Download the [api-gw-sws-integration.tf](https://github.com/yandex-cloud-examples/yc-serverless-gateway-protection-with-sws/blob/main/api-gw-sws-integration.tf) configuration file to the same working directory.

      This file describes:

      * ARL profile that sets a request limit and request grouping by the `token` parameter.
      * {{ sws-name }} security profile that uses the ARL profile and, in addition, sets blocking based on IP address.
      * API gateway configured to work with the {{ sws-name }} security profile.

  1. Specify the following parameters in the local variables section of the `api-gw-sws-integration.tf` file:

      * `arl_name`: ARL profile name.
      * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) the ARL profile will be created in.
      * `sws_name`: {{ sws-name }} profile name.
      * `allowed_ips`: List of IP addresses allowed to access the API gateway.
      * `api-gw-name`: API gateway name.

  1. Check that the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

  1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Create an API gateway {#create-api-gateway}

{% list tabs group=instructions %}

- Management console {#console}

  [Create an API gateway](../../api-gateway/operations/api-gw-create.md) named `my-gateway`. When creating it, add the following specification to the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** field:

  ```yaml
  openapi: "3.0.0"

  x-yc-apigateway:
    smartWebSecurity:
      securityProfileId: <SWS_security_profile_ID>

  info:
    version: 1.0.0
    title: Protected application
    license:
      name: MIT
  paths:
    /:
      get:
        x-yc-apigateway-integration:
          type: dummy
          content:
            '*': "This application is protected by SWS!"
          httpCode: 200
  ```

  Leave the other parameters unchanged.

- {{ TF }} {#tf}

  1. In the `api-gw-sws-integration.tf` file:

      1. In the `securityProfileId` parameter of the API gateway specification, specify the ID of the {{ sws-name }} security profile you created earlier.

      1. In the local variable section, specify `create-api-gw = 1`.

  1. Check that the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

  1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Test the new resources {#check-rules}

Test the {{ sws-name }} settings:

* [Request limit](#check-requests-limiter)
* [Request grouping](#check-query-groupping)
* [Request blocking by IP address](#check-ip-block)

### Testing the request limit {#check-requests-limiter}

1. Send a GET request to the API gateway:

    ```bash
    curl <API_gateway_service_domain>
    ```

    The result will be as follows:

    ```bash
    This application is protected by SWS!
    ```

1. Repeat the request straight away. In response, you will get a web page with error code 429. This means the request limit kicked in and blocked your request.

1. Wait for a minute and repeat the request. The response must be the same as the first time:

    ```bash
    This application is protected by SWS!
    ```

### Testing the request grouping {#check-query-groupping}

1. Send a GET request to the API gateway with the `token=token` parameter:

    ```bash
    curl <API_gateway_service_domain>?token=token
    ```

    The result will be as follows:

    ```bash
    This application is protected by SWS!
    ```

1. Repeat the request straight away. In response, you will get a web page with error code 429. This means the request limit kicked in and blocked your request.

1. Repeat the request within the same minute but change the `token` parameter value:

    ```bash
    curl <API_gateway_service_domain>?token=token2
    ```

    The result will be as follows:

    ```bash
    This application is protected by SWS!
    ```

    This means your request got into a new group for which no request limit has been triggered yet. Which is why the request was successfully completed.

### Testing the blocking by IP address {#check-ip-block}

1. Send a GET request to the API gateway from an IP address you specified in the {{ sws-name }} security profile:

    ```bash
    curl <API_gateway_service_domain>
    ```

    The result will be as follows:

    ```bash
    This application is protected by SWS!
    ```

1. Send a request from another IP address, e.g., from a cloud VM:

    ```bash
    curl --verbose <API_gateway_service_domain>
    ```

    In response, you will get a web page with CAPTCHA. This means {{ sws-name }} has blocked the request from an IP address not listed as an allowed one.

# Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need, depending on how they were created:

{% list tabs group=instructions %}

- Management console {#console}

  1. [Delete the API gateway](../../api-gateway/operations/api-gw-delete.md).
  1. [Delete the {{ sws-name }} security profile](../../smartwebsecurity/operations/profile-delete.md).
  1. [Delete the ARL profile](../../smartwebsecurity/operations/arl-profile-delete.md).

- {{ TF }} {#tf}

  {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
