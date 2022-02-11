# Scaling a function

Incoming requests are processed by the function one at a time. If the function is called faster than one instance can process the request, {{ sf-name }} scales the function by running additional function instances. You can set the following:

* `zone_instances_limit`: Number of function instances in an [availability zone](../../../overview/concepts/geo-scope.md).
* `zone_requests_limit`: Number of concurrent function calls in an availability zone.

{% note info %}

Function calls are distributed across availability zones randomly. Cloud Functions does not guarantee their even distribution across zones. For example, all calls, regardless of their number, might end up in the same zone.

{% endnote %}

When the number of function instances reaches the `zone_instances_limit`, {{ sf-name }} stops scaling it. If there are more function calls than instances available, the call is queued and treated as a call-in-progress. When the number of calls-in-progress reaches the `zone_requests_limit`, the service stops queuing calls and returns the `429 TooManyRequests` error.

For different function [versions](../../concepts/function.md#version), you can set individual scaling settings using [tags](../../concepts/function.md#tag). Scaling settings will be valid for the function version that the specified tag is assigned to. Function versions are scaled independently of each other.

The scaling settings must be within the [quotas](../../concepts/limits.md#functions-quotas). If the setting value is zero, the function is scaled within the quotas.

## Viewing scaling settings {#list}

{% list tabs %}

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To view a function's scaling settings, run the command:

    ```
    yc serverless function list-scaling-policies --id=d4eokpuol55h********
    ```

    * `--id`: Function ID. To find out the ID, [request](./version-manage.md#function-list) a list of functions.

    Result:

    ```
    +----------------------+---------+----------------------+---------------------+
    |     FUNCTION ID      |   TAG   | ZONE INSTANCES LIMIT | ZONE REQUESTS LIMIT |
    +----------------------+---------+----------------------+---------------------+
    | d4eokpuol55hmj15k7g1 | $latest |                    1 |                   2 |
    +----------------------+---------+----------------------+---------------------+
    ```

- API

    You can view a function's scaling settings using the [listScalingPolicies](../../functions/api-ref/Function/listScalingPolicies.md) API method.

- Yandex.Cloud Toolkit

    You can view a function's scaling settings using the [Yandex.Cloud Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the family of IDEs on the [IntelliJ platform](https://www.jetbrains.com/opensource/idea/) from [JetBrains](https://www.jetbrains.com/).

{% endlist %}

## Adding scaling settings {#add}

{% list tabs %}

- CLI

    To add scaling settings for a function, run the command:

    ```
    yc serverless function set-scaling-policy \
        --id=d4eokpuol55h******** \
        --tag=\$latest \
        --zone-instances-limit=1 \
        --zone-requests-limit=2
    ```

    * `--id`: Function ID. To find out the ID, [request](./version-manage.md#function-list) a list of functions.
    * `--tag`: [Tag](../../concepts/function.md#tag) of the function version.
    * `--zone-instances-limit`: Number of function instances.
    * `--zone-requests-limit`: Number of calls-in-progress.

    Result:

    ```
    function_id: d4eokpuol55h********
    tag: $latest
    zone_instances_limit: "1"
    zone_requests_limit: "2"
    ```

- Terraform

   {% include [terraform-definition](../../../_includes/tutorials/terraform-definition.md) %}

   If you don't have Terraform yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To add scaling settings:

   1. In the configuration file, describe the parameters of resources that you want to create:
        * `yandex_function_scaling_policy`: Description of function scaling settings.
            * `function_id`: Function ID.
            * `policy`: Scaling settings.
            * `policy.0.tag`: [Tag](../../concepts/function.md#tag) of the function version.
            * `policy.0.zone_instances_limit`: Number of function instances.
            * `policy.0.zone_requests_limit`: Number of calls-in-progress.

        Example configuration file structure:

        ```
        provider "yandex" {
            token = "<OAuth or static key of service account>"
            folder_id = "<folder ID>"
            zone      = "ru-central1-a"
        }
        
        resource "yandex_function_scaling_policy" "my_scaling_policy" {
        	function_id = "are1samplefu********"
        	policy {
        		tag = "$latest"
        		zone_instances_limit = 2
        		zone_requests_limit  = 1
          	}
        }
        ```

        For more information about the resources you can create using Terraform, see the [provider documentation](https://www.terraform.io/docs/providers/yandex/index.html).

    1. Make sure that the configuration files are correct.
        1. In the command line, go to the directory where you created the configuration file.
        1. Run the check using the command:

            ```
            terraform plan
            ```

        If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, Terraform points them out.

   1. Deploy the cloud resources.
        1. If the configuration doesn't contain any errors, run the command:

            ```
            terraform apply
            ```
        1. Confirm that you want to create the resources.

        Afterwards, all the necessary resources are created in the specified folder. You can check resource availability and their settings in the [management console]({{ link-console-main }}).

- API

    You can add scaling settings for a function using the [setScalingPolicy](../../functions/api-ref/Function/setScalingPolicy.md) API method.

- Yandex.Cloud Toolkit

    You can add scaling settings for a function using the [Yandex.Cloud Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the family of IDEs on the [IntelliJ platform](https://www.jetbrains.com/opensource/idea/) from [JetBrains](https://www.jetbrains.com/).

{% endlist %}

## Deleting scaling settings {#delete}

{% list tabs %}

- CLI

    To delete a function's scaling settings, run the command:

    ```
    yc serverless function remove-scaling-policy \
    	--id=d4eokpuol55h******** \
    	--tag=\$latest
    ```

    * `--id`: Function ID. To find out the ID, [request](./version-manage.md#function-list) a list of functions.
    * `--tag`: [Tag](../../concepts/function.md#tag) of the function version.

- API

    You can delete scaling settings for a function using the [removeScalingPolicy](../../functions/api-ref/Function/removeScalingPolicy.md) API method.

- Yandex.Cloud Toolkit

    You can delete scaling settings for a function using the [Yandex.Cloud Toolkit plugin](https://github.com/yandex-cloud/ide-plugin-jetbrains/blob/master/README.en.md) for the family of IDEs on the [IntelliJ platform](https://www.jetbrains.com/opensource/idea/) from [JetBrains](https://www.jetbrains.com/).

{% endlist %}

