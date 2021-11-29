---
editable: false
---
# Pricing for {{  api-gw-full-name }}

## What goes into the cost of using {{ api-gw-name }} {#rules}

In {{ api-gw-name }}, you're charged for the number of requests to created API gateways and outgoing traffic.

{% note warning %}

{{ api-gw-name }} only handles HTTPS requests. The service automatically redirects all requests to API gateways over the HTTP protocol to their HTTPS versions. {% if audience != "external" %} If the HTTP client automatically handles redirects, then instead of one request, two requests will be made: one over HTTP and one over HTTPS. {% endif %}

{% endnote %}

{% if region == "ru"%}

### Example of calculating the cost of an API gateway {#price-example}

{% if audience != "external" %}

Let's say you create an API gateway that:

* Processed 10,000,000 requests over HTTPS (not including redirects).
* Redirected 100,000 HTTP requests to their HTTPS versions.
* Processed 80,000 redirected requests.

The cost of this API gateway is:

> ₽75 × (10,000,000 / 1,000,000) + ₽75 × (100,000 / 1,000,000) + ₽75 × (80,000 / 1,000,000) = ₽763.5

Where:

- ₽75: Price per 1 million API gateway calls.
- 10,000,000 / 1,000,000: Number of millions of requests over HTTPS.
- 100,000 / 1,000,000: Number of millions of redirects from HTTP to HTTPS.
- 80,000 / 1,000,000: Number of millions of redirected requests processed.

{% else %}

For example, let's say you create an API gateway that processed 10,000,000 requests over HTTPS.

The cost of this API gateway is:

>  ₽75 × (10,000,000 / 1,000,000) = ₽750

Where:

- ₽75: Price per 1 million API gateway calls.
- 10,000,000 / 1,000,000: Number of millions of requests over HTTPS.

{% endif %}

{% endif %}

## Pricing {#prices}

### API gateway requests {#request}

{% if region == "ru" %}

{% include notitle [rub.md](../_pricing/api-gateway/rub.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt.md](../_pricing/api-gateway/kzt.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd.md](../_pricing/api-gateway/usd.md) %}

{% endif %}

### Outgoing traffic {#prices-traffic}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-egress-traffic.md](../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

{% endif %}

