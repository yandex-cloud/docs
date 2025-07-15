# Using {{ api-gw-full-name }} to set up speech synthesis in {{ speechkit-full-name }}


With serverless technology, you can create your own integration with {{ yandex-cloud }} services.

In this tutorial, you will create a custom setup with an [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification)-based [API gateway](../../api-gateway/concepts/index.md) with [HTTP integration](../../api-gateway/concepts/extensions/http.md). 

The users' speech synthesis requests run through the API gateway that uses HTTP integration to call the [{{ speechkit-name }} API](../../speechkit/concepts/api.md) and retrieve the synthesized speech from {{ speechkit-name }}.

To set up {{ speechkit-name }} speech synthesis using {{ api-gw-full-name }}:

1. [Get your cloud ready](#before-you-begin).
1. [Create a service account](#create-service-account).
1. [Create an API gateway](#create-gateway).
1. [Check the result](#check-out).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The new infrastructure support cost includes:

* Fee for the number of requests to the API gateway and outbound traffic (see [{{ api-gw-full-name }} pricing](../../api-gateway/pricing.md)).
* Fee for using {{ speechkit-name }} (see [{{ speechkit-name }} pricing](../../speechkit/pricing.md)).


## Create a service account {#create-service-account}

[Create](../../iam/operations/sa/create.md) a service account named `speechkit-sa` with the `ai.speechkit-tts.user` [role](../../speechkit/security/index.md#ai-speechkit-tts-user) for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you are creating your infrastructure:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a service account.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Enter the service account name: `speechkit-sa`.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select `ai.speechkit-tts.user`.
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

      Save the ID of the `speechkit-sa` service account (`id`) and the ID of the folder where you created it (`folder_id`).

      For more information about the `yc iam service-account create` command, see the [CLI reference](../../cli/cli-ref/iam/cli-ref/service-account/create.md).

  1. Assign the `ai.speechkit-tts.user` role for the folder to the service account by specifying the folder and service account IDs you previously saved:

      ```bash
      yc resource-manager folder add-access-binding <folder_ID> \
        --role ai.speechkit-tts.user \
        --subject serviceAccount:<service_account_ID>
      ```

      For more information about the `yc resource-manager folder add-access-binding` command, see the [CLI reference](../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).

- API {#api}

  To create a service account, use the [create](../../iam/api-ref/ServiceAccount/create.md) method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call.

  To assign the `ai.speechkit-tts.user` role for a folder to a service account, use the [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md) gRPC API call.

{% endlist %}


## Create an API gateway {#create-gateway}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create an API gateway.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, enter `speechkit-api-gw`.
  1. Under **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}**, add the following specification and provide the `speechkit-sa` service account [ID](../../iam/operations/sa/get-id.md) in the `service_account_id` parameter:

      {% include [api-gw-yaml-spec](../_tutorials_includes/speechkit-integrarion-via-agi-gw/api-gw-yaml-spec.md) %}

  1. Click **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.
  1. Wait until the status of the API gateway you just created switches to `running`, and then click the row with the gateway name.
  1. In the window that opens, copy the **{{ ui-key.yacloud.serverless-functions.gateways.overview.label_domain }}** field value. You will need it later to test the API gateway.

- CLI {#cli}

  1. Save the following specification to `speechkit-gw.yaml` and provide the `speechkit-sa` service account [ID](../../iam/operations/sa/get-id.md) in the `service_account_id` parameter:

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
     domain: {{ api-host-apigw }}
     connectivity: {}
     log_options:
       folder_id: b1gt6g8ht345********
     execution_timeout: 300s
     ```

  Save the service domain (the `domain` field value) of the API gateway you created. You will need it later to test the API gateway.

  For more information about the `yc serverless api-gateway create` command, see the [CLI reference](../../cli/cli-ref/serverless/cli-ref/api-gateway/create.md).

- API {#api}

  To create an API gateway, use the [create](../../api-gateway/apigateway/api-ref/ApiGateway/create.md) REST API method for the [ApiGateway](../../api-gateway/apigateway/api-ref/ApiGateway/index.md) resource or the [ApiGatewayService/Create](../../api-gateway/apigateway/api-ref/grpc/ApiGateway/create.md) gRPC API call.

{% endlist %}


## Check the result {#check-out}

{% note info %}

You will need [cURL](https://curl.haxx.se) and [jq](https://github.com/jqlang/jq) to test your API gateway.

{% endnote %}

Send a request to your API gateway, providing the service domain value you previously saved:

```bash
curl --verbose \
  https://<service_domain>/synthesis \
  --data '{"text": "Hi! S+erverless Api G+ateway now has a new feature: converting HTTP request or response body!"}' \
  | jq -r  '.data' | while read chunk; do base64 -d <<< "$chunk" >> audio.mp3; done
```

After you run the above command, the system will save the synthesized speech to the `audio.mp3` file in the current directory. You can listen to the output file in your browser, e.g., [Yandex Browser](https://browser.yandex.ru) or [Mozilla Firefox](http://www.mozilla.org).

To learn more about the format of the text provided in the `-d` parameter, see [this {{ speechkit-full-name }} article](../../speechkit/tts/request.md).


## How to delete the resources you created {#clear-out}

If you no longer need the resources you created:

* [Delete the API gateway](../../api-gateway/operations/api-gw-delete.md).
* [Delete the service account](../../iam/operations/sa/delete.md).