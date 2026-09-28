{% list tabs group=instructions %}

- L7-балансировщик {#balancer}

  Если балансировщик управляется [Ingress-контроллером](../../application-load-balancer/tools/k8s-ingress-controller/index.md) {{ alb-name }}, используйте [аннотацию ресурса Ingress](../../application-load-balancer/k8s-ref/ingress.md#annot-security-profile-id).

  {% include [Gwin](../../_includes/application-load-balancer/ingress-to-gwin-tip.md) %}

  Чтобы подключить виртуальный хост:

  {% include [host-connect](../../_includes/smartwebsecurity/security-profile-host-connect.md) %}

  {% include [disable-sp-route](../../_includes/smartwebsecurity/disable-sp-route.md) %}

- API-шлюз {#api-gateway}

  Чтобы подключить API-шлюз:

  {% include [api-gateway-connect](../../_includes/smartwebsecurity/security-profile-api-gateway-connect.md) %}

- Домен {#domain}

  Чтобы подключить домен:

  {% include [domain-connect](../../_includes/smartwebsecurity/security-profile-domain-connect.md) %}

{% endlist %}