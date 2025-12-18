# How to create an internal Ingress controller



## Case description {#case-description}

You need to create an internal Ingress controller.

## Solution {#case-resolution}

{% note info %}

The feature of using internal controllers is at the Preview stage: please contact [support]({{ link-console-support }}) to enable it.

{% endnote %}

To ensure that Ingress creates an internal controller, set certain parameters in the `values.yaml` file and use this file when installing the controller via Helm Chart. To do this, follow these steps:

1. Set `internal.enabled` to [`True`](https://github.com/kubernetes/ingress-nginx/blob/3aa53aaf5b210dd937598928e172ef1478e90e69/charts/ingress-nginx/values.yaml#L526).
1. [Add](https://github.com/kubernetes/ingress-nginx/blob/3aa53aaf5b210dd937598928e172ef1478e90e69/charts/ingress-nginx/values.yaml#L528) the following annotations to the service:

    ```
    yandex.cloud/load-balancer-type: internal
    yandex.cloud/subnet-id: <ID of subnet containing internal IP address to assign>
    ```

1. [Disable the external controller](https://github.com/kubernetes/ingress-nginx/blob/3aa53aaf5b210dd937598928e172ef1478e90e69/charts/ingress-nginx/values.yaml#L521) by setting `external.enabled` to `False`.

After creating the load balancer via Helm Chart, health checks will be automatically added.