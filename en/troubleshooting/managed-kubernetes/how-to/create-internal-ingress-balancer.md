# How to create an internal Ingress controller


## Scenario description {#case-description}

You need to create an internal Ingress controller.

## Solution {#case-resolution}

{% note info %}

The feature of using internal controllers is in Preview: please contact [support](https://console.cloud.yandex.ru/support?section=contact) to enable it.

{% endnote %}

To ensure Ingress creates an internal controller, set up a number of parameters in the `values.yaml` file and use it when installing the controller via Helm Chart:

1. Set the `internal.enabled` parameter value to [true](https://github.com/kubernetes/ingress-nginx/blob/3aa53aaf5b210dd937598928e172ef1478e90e69/charts/ingress-nginx/values.yaml#L526);
2. [Add](https://github.com/kubernetes/ingress-nginx/blob/3aa53aaf5b210dd937598928e172ef1478e90e69/charts/ingress-nginx/values.yaml#L528) the following annotations to the service:

```
yandex.cloud/load-balancer-type: internal
yandex.cloud/subnet-id: <ID of subnet from which the internal IP will be issued>
```

3. [Disable external controller](https://github.com/kubernetes/ingress-nginx/blob/3aa53aaf5b210dd937598928e172ef1478e90e69/charts/ingress-nginx/values.yaml#L521) by setting the `external.enabled` parameter to false.

After creating the load balancer via Helm Chart, health checks will be automatically added.