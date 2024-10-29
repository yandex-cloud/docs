Regular subscription active status check.

You can get the up-to-date subscription information using the [list](../../marketplace/license-manager/api-ref/Instance/list.md) REST API method for the [Instance](../../marketplace/license-manager/api-ref/Instance/index.md) resource or the [InstanceService/List](../../marketplace/license-manager/api-ref/grpc/Instance/list.md) gRPC API call.

{% note info %}

Please note that the user can unlink a resource from the subscription and link another one to it. Make sure your code can handle cases like this correctly.

{% endnote %}