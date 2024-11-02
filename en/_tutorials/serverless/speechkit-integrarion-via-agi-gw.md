# Using {{ api-gw-full-name }} to set up speech synthesis in {{ speechkit-full-name }}

Using serverless technology, you can create your own integration with {{ yandex-cloud }} services.

This guide will show you how to create a custom setup with an [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification)-based [API gateway](../../api-gateway/concepts/index.md) with [HTTP integration](../../api-gateway/concepts/extensions/http.md). 

The users’ speech synthesis requests run through the API gateway that calls [{{ speechkit-name }} API](../../speechkit/concepts/api.md) through HTTP integration and retrieves the synthesized speech from {{ speechkit-name }}.

To set up {{ speechkit-name }} speech synthesis using {{ api-gw-full-name }}:

1. [Prepare your cloud](#before-you-begin).
1. [Create a service account](#create-service-account).
1. [Create an API gateway](#create-gateway).
1. [Check the result](#check-out).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of support for the new infrastructure includes:

* Fee for the number of requests to the API gateway and outgoing traffic (see [{{ api-gw-full-name }} pricing](../../api-gateway/pricing.md)).
* Fee for using {{ speechkit-name }} (see [{{ speechkit-name }} pricing](../../speechkit/pricing.md)).


## Create a service account {#create-service-account}

[Create](../../iam/operations/sa/create.md) a service account with the `speechkit-sa` [role](../../speechkit/security/index.md#ai-speechkit-tts-user) for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you create your infrastructure:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a service account.
  1. Go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Enter a name for the service account: `speechkit-sa`.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `ai.speechkit-tts.user` role.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Create a service account named `speechkit-sa`:

      ```bash
      yc iam service-account create speechkit-sa
      ```

      Result:

      ```
      id: nfersamh4sjq********
      folder_id: b1gc1t4cb638********
      created_at: "2023-09-21T10:36:29.726397755Z"
      name: speechkit-sa
      ```

      Save the `id` of the `speechkit-sa` service account and the folder where it was created (`folder_id`).

      For more information about the `yc iam service-account create` command, see the [CLI reference](../../cli/cli-ref/managed-services/iam/service-account/create.md).

  1. Assign the `ai.speechkit-tts.user` role for the folder to the service account by specifying the folder and service account IDs you previously saved:

      ```bash
      yc resource-manager folder add-access-binding <folder_ID> \
        --role ai.speechkit-tts.user \
        --subject serviceAccount:<service_account_ID>
      ```

      For more information about the `yc resource-manager folder add-access-binding` command, see the [CLI reference](../../cli/cli-ref/managed-services/resource-manager/folder/add-access-binding.md).

- API {#api}

  To create a service account, use the [create](../../iam/api-ref/ServiceAccount/create.md) method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call.

  To assign the `ai.speechkit-tts.user` role for the folder to the service account, use the [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md) gRPC API call.

{% endlist %}


## Create an API gateway {#create-gateway}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create an API gateway.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**.
  1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_name }}** field, enter `speechkit-api-gw`.
  1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** section, add the following specification and provide the `speechkit-sa` service account [ID](../../iam/operations/sa/get-id.md) in the `service_account_id` parameter:

      {% include [api-gw-yaml-spec](../_tutorials_includes/speechkit-integrarion-via-agi-gw/api-gw-yaml-spec.md) %}

  1. Click **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.
  1. Wait until the status of the API gateway you just created switches to `running`, and then click the row with the gateway name.
  1. In the window that opens, copy the **{{ ui-key.yacloud.serverless-functions.gateways.overview.label_domain }}** field value. You will need it later to check how the API gateway works.

- CLI {#cli}

  1. Save the following specification to the `speechkit-gw.yaml` file and provide the `speechkit-sa` service account [ID](../../iam/operations/sa/get-id.md) in the `service_account_id` parameter:

      {% include [api-gw-yaml-spec](../_tutorials_includes/speechkit-integrarion-via-agi-gw/api-gw-yaml-spec.md) %}

  1. Run this command:

     ```bash
     yc serverless api-gateway create \
       --name speechkit-api-gw \
       --spec=speechkit-gw.yaml
     ```

     Where:
     * `--name`: API gateway name.
     * `--spec`: Path to the specification file.

     Result:

     ```text
     done (2s)
     id: d5ddbmungf72********
     folder_id: b1gt6g8ht345********
     created_at: "2024-08-19T18:58:32.101Z"
     name: speechkit-api-gw
     status: ACTIVE
     domain: d5ddbmungf72********.apigw.yandexcloud.net
     connectivity: {}
     log_options:
       folder_id: b1gt6g8ht345********
     execution_timeout: 300s
     ```

  Save the service domain (the `domain` filed value) of the API gateway you created. You will need it later to check how the API gateway works.

  For more information about the `yc serverless api-gateway create` command, see the [CLI reference](../../cli/cli-ref/managed-services/serverless/api-gateway/create.md).

- API {#api}

  To create an API gateway, use the [create](../../api-gateway/apigateway/api-ref/ApiGateway/create.md) REST API method for the [ApiGateway](../../api-gateway/apigateway/api-ref/ApiGateway/index.md) resource or the [ApiGatewayService/Create](../../api-gateway/apigateway/api-ref/grpc/ApiGateway/create.md) gRPC API call.

{% endlist %}


## Check the result {#check-out}

{% note info %}

To check whether your API gateway works properly, you will need [cURL](https://curl.haxx.se) and [jq](https://github.com/jqlang/jq).

{% endnote %}

Send a request to your API gateway by providing the service domain value you previously saved:

```bash
curl --verbose \
  https://<service_domain>/synthesis \
  --data '{"text": “Hello! S+erverless Api G+ateway now has a new feature: converting HTTP request or response body!"}' \
  | jq -r  '.data' | while read chunk; do base64 -d <<< "$chunk" >> audio.mp3; done
```

Once you run the above command, the synthesized speech will be saved to the `audio.mp3` file in the current directory. You can listen to the output file in your browser, e.g., [Yandex Browser](https://browser.yandex.ru) or [Mozilla Firefox](http://www.mozilla.org).

To learn more about the format of the text provided in the `-d` parameter, see the [{{ speechkit-full-name }} documentation](../../speechkit/tts/request.md).


## How to delete the resources you created {#clear-out}

If you no longer need the resources you created:

* [Delete the API gateway](../../api-gateway/operations/api-gw-delete.md).
* [Delete the service account](../../iam/operations/sa/delete.md).