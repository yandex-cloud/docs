---
title: Deleting an endpoint in {{ cns-full-name }}
description: Follow this guide to delete an endpoint.
---

# Deleting an endpoint

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder containing your endpoint.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Select a push notification channel.
  1. Navigate to the ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.cns.label_endpoints }}** tab.
  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the endpoint and select **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- AWS CLI {#aws-cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../../storage/tools/aws-cli.md).
  1. Run this command:

      ```bash
      aws sns delete-endpoint \
        --endpoint-arn <endpoint_ARN>
      ```

      Where `--endpoint-arn` is the endpoint ID (ARN).

      For more information about the `aws sns delete-endpoint` command, see the [AWS documentation](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/delete-endpoint.html).

- AWS SDK for Python {#python}

  1. If you do not have the AWS SDK for Python (boto3) yet, [install and configure it](../../tools/sdk-python.md#aws-sdk).
  1. To update an endpoint, run the following code:

      ```python
      response = client.delete_endpoint(
          EndpointArn="<endpoint_ARN>"
      )
      print("Endpoint deleted successfully.")
      ```

      Where `EndpointArn` is the endpoint ID (ARN).

- AWS SDK for PHP {#php}

  1. If you do not have the AWS SDK for PHP yet, [install and configure it](../../tools/sdk-php.md#aws-sdk).
  1. To delete an endpoint, use the following code:

      ```php
      $response = $client->deleteEndpoint([
          'EndpointArn' => '<endpoint_ARN>',
      ]);

      echo "Endpoint deleted successfully.\n";
      ```

      Where `EndpointArn` is the endpoint ID (ARN).


- API {#api}

  Use the [delete](../../api-ref/delete-endpoint.md) HTTP API method for the Endpoint resource in {{ cns-full-name }}.

{% endlist %}