---
editable: false
---
# Pricing for {{  api-gw-full-name }}

## What goes into the cost of using {{ api-gw-name }} {#rules}

In {{ api-gw-name }}, you're charged for the number of requests to created API gateways and outgoing traffic.

{% note warning %}

{{ api-gw-name }} only handles HTTPS requests. The service automatically redirects all requests to API gateways over the HTTP protocol to their HTTPS versions. {% if audience != "external" %} If the HTTP client automatically handles redirects, then instead of one request, two requests will be made: one over HTTP and one over HTTPS. {% endif %}

{% endnote %}

### Example of calculating the cost of an API gateway {#price-example}

{% if audience != "external" %}

Let's say you create an API gateway that:

* Processed 10,000,000 requests over HTTPS (not including redirects).
* Redirected 100,000 HTTP requests to their HTTPS versions.
* Processed 80,000 redirected requests.

The cost of this API gateway is:

> ₽75 × (10,000,000 / 1,000,000) + ₽75 × (100,000 / 1,000,000) + ₽75 × (80,000 / 1,000,000) = ₽763.5 ₽

Where:

- ₽75: Price per 1 million API gateway calls.
- 10,000,000 / 1,000,000: Number of millions of requests over HTTPS.
- 100,000 / 1,000,000: Number of millions of redirects from HTTP to HTTPS.
- 80,000 / 1,000,000: Number of millions of redirected requests processed.

{% else %}

For example, let's say you create an API gateway that processed 10,000,000 requests over HTTPS.

The cost of this API gateway is:

>  ₽75 × (10,000,000 / 1,000,000) = 750 ₽

Where:

- ₽75: Price per 1 million API gateway calls.
- 10,000,000 / 1,000,000: Number of millions of requests over HTTPS.

{% endif %}

## Pricing {#prices}

### API gateway requests {#request}


{% list tabs %}

- Prices in USD

   | Service | Price per 1 million requests, <br>without VAT |
   | ----- | ----- |
   | Requests to API gateways, up to 100,000 requests per month | Free |
   | Requests to the API gateway, more than 100,000 requests per month | $0.961538
 
   You pay for the actual number of invocations. For example, the cost of ten thousand invocations is `$0.00961538`.

- Prices in roubles

   | Service | Price per 1 million requests, <br>with VAT |
   | ----- | ----- |
   | Requests to API gateways, up to 100,000 requests per month | Free |
   | Requests to the API gateway, more than 100,000 requests per month | ₽75 |
 
   You pay for the actual number of invocations. For example, the cost of ten thousand invocations is `₽0.75`.

{% endlist %}

### Outgoing traffic {#prices-traffic}

{% include notitle [pricing-egress-traffic](../_includes/pricing/pricing-egress-traffic.md) %}

