{% list tabs group=instructions %}

- L7 load balancer {#balancer}

  If the load balancer is managed by an {{ alb-name }} [ingress controller](../../application-load-balancer/tools/k8s-ingress-controller/index.md), use the [ingress resource annotation](../../application-load-balancer/k8s-ref/ingress.md#annot-security-profile-id).

  {% include [Gwin](../../_includes/application-load-balancer/ingress-to-gwin-tip.md) %}

  To connect a virtual host:

  {% include [host-connect](../../_includes/smartwebsecurity/security-profile-host-connect.md) %}

  {% include [disable-sp-route](../../_includes/smartwebsecurity/disable-sp-route.md) %}

- API gateway {#api-gateway}

  To connect an API gateway:

  {% include [api-gateway-connect](../../_includes/smartwebsecurity/security-profile-api-gateway-connect.md) %}

- Domain {#domain}

  To connect a domain:

  {% include [domain-connect](../../_includes/smartwebsecurity/security-profile-domain-connect.md) %}

{% endlist %}