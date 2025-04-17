---
title: Updating an endpoint in {{ cns-full-name }}
description: Follow this guide to update an endpoint.
---

# Updating an endpoint

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder containing your endpoint.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Select a push notification channel.
  1. Navigate to the ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.cns.label_endpoints }}** tab.
  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the endpoint and select **{{ ui-key.yacloud.common.edit }}**.
  1. Enter **{{ ui-key.yacloud.cns.field_token }}**, a unique token residing on the user device, created by the notification service for the app.
  1. Optionally, enter **{{ ui-key.yacloud.cns.field_endpoint-user-data }}**, a [UTF-8](https://en.wikipedia.org/wiki/UTF-8) encoded text up to 2,048 characters long.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- AWS CLI {#aws-cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../../storage/tools/aws-cli.md).
  1. Run this command:

      ```bash
      aws sns set-endpoint-attributes \
        --endpoint-arn <endpoint_ARN> \
        --attributes <parameter1>=<new_value1>, ... <parameterN>=<new_valueN>
      ```

      Where:

      * `--endpoint-arn` is the endpoint ID (ARN).
      * `--attributes` are comma-separated endpoint parameters you want to edit, in `<parameter>=<new_value>` format.

      For more information about the `aws sns set-endpoint-attributes` command, see the [AWS documentation](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/set-endpoint-attributes.html).

- AWS SDK for Python {#python}

  1. If you do not have the AWS SDK for Python (boto3) yet, [install and configure it](../../tools/sdk-python.md#aws-sdk).
  1. To update an endpoint, use the following code:

      ```python
      response = client.set_endpoint_attributes(
          EndpointArn="<endpoint_ARN>",
          Attributes={
              "<parameter1>": "<new_value1>",
              ...
              "<parameterN>": "<new_valueN>"
          }
      )
      print("Endpoint attributes updated successfully.")
      ```

      Where:

      * `EndpointArn` is the endpoint ID (ARN).
      * `Attributes` are comma-separated parameters you want to edit, in `"<parameter>": "<new_value>"` format.

- AWS SDK for PHP {#php}

  1. If you do not have the AWS SDK for PHP yet, [install and configure it](../../tools/sdk-php.md#aws-sdk).
  1. To update an endpoint, use the following code:

      ```php
      $response = $client->setEndpointAttributes([
          'EndpointArn' => '<endpoint_ARN>',
          'Attributes' => [
              '<parameter1>' => '<new_value1>',
              ...
              '<parameterN>' => '<new_valueN>'
          ],
      ]);

      echo "Endpoint attributes updated successfully.\n";
      ```

      * `EndpointArn`: Endpoint ID (ARN).
      * `Attributes` are comma-separated parameters you want to edit, in `'<parameter>' => '<new_value>'` format.


- API {#api}

  Use the [setAttributes](../../api-ref/set-endpoint-attributes.md) HTTP API method for the Endpoint resource in {{ cns-full-name }}.

{% endlist %}

Updating an endpoint may take some time.