# Reference for {{ alb-name }} Ingress controller for {{ managed-k8s-name }}

A [{{ alb-name }} Ingress controller](../tools/k8s-ingress-controller/index.md) helps deploy L7 load balancers in {{ managed-k8s-full-name }} clusters. The following primary {{ k8s }} resources are used to configure the infrastructure being deployed:

* [Ingress](ingress.md): Backend traffic distribution rules.
* [HttpBackendGroup](http-backend-group.md): Combining backends into groups.
* [Service](service.md): Description of {{ k8s }} services used as backends.