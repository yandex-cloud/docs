# How to set up a static IP address



## Scenario description {#case-description}

You need to set up a static IP address for a function or Serverless.

## Solution {#case-resolution}

Assigning a static IP address to a cloud function is not supported yet. The function can execute on resources with different addresses each time, so you cannot assign a specific address to it.

As an alternative solution, you can use Compute Cloud. Create in it a VM instance with a static IP address, install the runtime environment for your programming language, and start executing the function code in it. We provide more details [here](https://cloud.yandex.ru/docs/compute/operations/vm-create/create-linux-vm) and [there](https://cloud.yandex.ru/docs/vpc/operations/get-static-ip).

{% note info %}

You can also use the API gateway to call the function via a custom domain.

Read more in our documentation:
- [Linking a domain to the gateway](https://cloud.yandex.ru/docs/api-gateway/operations/api-gw-domains)
- [Calling a function via a gateway](https://cloud.yandex.ru/docs/api-gateway/concepts/extensions/cloud-functions)
- [Calling a container via a gateway](https://cloud.yandex.ru/docs/api-gateway/concepts/extensions/containers)

{% endnote %}