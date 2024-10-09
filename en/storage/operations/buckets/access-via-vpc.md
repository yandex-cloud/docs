# Accessing a bucket using a service connection from {{ vpc-full-name }}

{% include [vpc-pe-preview](../../../_includes/vpc/pe-preview.md) %}

{% include [intro-access-via-vpc](../../../_includes/storage/intro-access-via-vpc.md) %}

To enable access to a bucket using a service connection from {{ vpc-short-name }}:

1. [Create](../../../vpc/operations/private-endpoint-create.md) a service connection (Private Endpoint).

    {% include [private-endpoint-create-roles](../../../_includes/vpc/private-endpoint-create-roles.md) %}

    {% list tabs group=instructions %}

    - CLI {#cli}

      {% include [private-endpoint-create-cli](../../../_includes/vpc/private-endpoint-create-cli.md) %}

    {% endlist %}

    {{ objstorage-name }} buckets are now accessible via {{ vpc-short-name }} internal IP addresses with no Internet access needed.

1. Save the connection ID from the `ID` column.

1. To restrict access to a bucket to _{{ vpc-short-name }} internal IP addresses only_, [assign](../../../vpc/operations/private-endpoint-storage-policy.md) a bucket policy for a service connection.

    {% include [private-endpoint-policy-tabs](../../../_includes/storage/private-endpoint-policy-tabs.md) %}

#### See also {#see-also}

* [{{ vpc-short-name }} service connections](../../../vpc/operations/index.md#private-endpoint)
* [Managing {{ vpc-short-name }} service connections](../../../vpc/concepts/private-endpoint.md)
* [Bucket policy](../../../storage/concepts/policy.md)
* [Connecting to {{ objstorage-name }} from {{ vpc-name }}](../../../storage/tutorials/storage-vpc-access.md)
