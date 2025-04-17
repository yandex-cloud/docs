---
title: Managing an endpoint in {{ cns-full-name }}
description: Follow this guide to update or delete an endpoint.
---

# Managing an endpoint

## Updating endpoint parameters {#endpoint-update}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the endpoint.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Select an in-browser push notification channel.
  1. Navigate to the ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.cns.label_endpoints }}** tab.
  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the endpoint and select **{{ ui-key.yacloud.common.edit }}**.
  1. Update **{{ ui-key.yacloud.cns.field_web-push-endpoint_params }}** and **{{ ui-key.yacloud.cns.field_endpoint-user-data }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- AWS CLI {#aws-cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../../storage/tools/aws-cli.md).
  1. Run this command:

      ```bash
      aws sns set-endpoint-attributes \
        --endpoint-arn <endpoint_ARN> \
        --attributes Token=<pushSubscription_JSON>,CustomUserData=<any_data>
      ```

      Where:

      * `--endpoint-arn`: Endpoint ID (ARN).
      * `--attributes`: Comma-separated endpoint parameters you want to edit.
        * `Token`: [PushSubscription](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription) object, in [JSON](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription/toJSON) format received in the user's browser.
        * `CustomUserData`: Additional information.

      For more information about the `aws sns set-endpoint-attributes` command, see the [AWS documentation](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/set-endpoint-attributes.html).

- AWS SDK for Python {#python}

      ```python
      response = client.set_endpoint_attributes(
          EndpointArn="<endpoint_ARN>",
          Attributes={
              Token: "<pushSubscription_JSON>",
              CustomUserData: "<any_data>"
          }
      )
      print("Endpoint attributes updated successfully.")
      ```

      Where:

      * `EndpointArn`: Endpoint ID (ARN).
      * `Attributes`: Comma-separated parameters you want to edit.
        * `Token`: [PushSubscription](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription) object, in [JSON](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription/toJSON) format received in the user's browser.
        * `CustomUserData`: Additional information.

- AWS SDK for PHP {#php}

      ```php
      $response = $client->setEndpointAttributes([
          'EndpointArn' => '<endpoint_ARN>',
          'Attributes' => [
              Token => '<pushSubscription_JSON>',
              CustomUserData => '<any_data>'
          ],
      ]);

      echo "Endpoint attributes updated successfully.\n";
      ```

      * `EndpointArn`: Endpoint ID (ARN).
      * `Attributes`: Comma-separated parameters you want to edit.
        * `Token`: [PushSubscription](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription) object, in [JSON](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription/toJSON) format received in the user's browser.
        * `CustomUserData`: Additional information.

- API {#api}

  Use the [setAttributes](../../api-ref/set-endpoint-attributes.md) HTTP API method for the Endpoint resource in {{ cns-full-name }}.

{% endlist %}

Updating an endpoint may take some time.

## Deleting an endpoint {#endpoint-delete}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder containing your endpoint.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Select an in-browser push notification channel.
  1. Navigate to the ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.cns.label_endpoints }}** tab.
  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the endpoint and select **{{ ui-key.yacloud.common.delete }}**.
  1. Click **{{ ui-key.yacloud.common.delete }}**.

- AWS CLI {#aws-cli}

      ```bash
      aws sns delete-endpoint \
        --endpoint-arn <endpoint_ARN>
      ```

      Where `--endpoint-arn` is the endpoint ID (ARN).

      For more information about the `aws sns delete-endpoint` command, see the [AWS documentation](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/delete-endpoint.html).

- AWS SDK for Python {#python}

      ```python
      response = client.delete_endpoint(
          EndpointArn="<endpoint_ARN>"
      )
      print("Endpoint deleted successfully.")
      ```

- AWS SDK for PHP {#php}

      ```php
      $response = $client->deleteEndpoint([
          'EndpointArn' => '<endpoint_ARN>',
      ]);

      echo "Endpoint deleted successfully.\n";
      ```

- API {#api}

  Use the [delete](../../api-ref/delete-endpoint.md) HTTP API method for the Endpoint resource in {{ cns-full-name }}.

{% endlist %}