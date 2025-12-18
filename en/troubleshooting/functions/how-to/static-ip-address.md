# How to set up a static IP address



## Case description {#case-description}

You need to set up a static IP address for a function or {{ serverless-containers-name }}.

## Solution {#case-resolution}

Assigning a static IP address to a cloud function is not supported yet. The function may run on resources with different addresses each time, so you cannot assign it a specific address.

As an alternative, you can use {{ compute-full-name }}. Create in it a VM instance with a static IP address, install the runtime environment for your programming language, and run the function code in it. For more information, see [here](../../../compute/operations/vm-create/create-linux-vm.md) and [there](../../../vpc/operations/get-static-ip.md).

{% note info %}

You can also use the API gateway to call the function via a custom domain. 

Learn more in our guides: 

* [Associating a domain with the gateway](../../../api-gateway/operations/api-gw-domains.md)
* [Calling a function via a gateway](../../../api-gateway/concepts/extensions/cloud-functions.md)
* [Calling a container via a gateway](../../../api-gateway/concepts/extensions/containers.md)

{% endnote %}