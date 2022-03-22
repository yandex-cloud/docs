---
editable: false
---
# Pricing for {{  api-gw-full-name }}

## What goes into the cost of using {{ api-gw-name }} {#rules}

In {{ api-gw-name }}, you're charged for the number of requests to created API gateways and outgoing traffic.

{% note warning %}

{{ api-gw-name }} only handles HTTPS requests. The service automatically redirects all requests to API gateways over the HTTP protocol to their HTTPS versions. 

{% endnote %}


## Pricing {#prices}


### API gateway requests {#request}




{% include notitle [usd.md](../_pricing/api-gateway/usd.md) %}

### Outgoing traffic {#prices-traffic}




{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

