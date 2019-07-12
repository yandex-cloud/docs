---
editable: false
---

# Pricing policy for Virtual Private Cloud

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using VPC {#rules}

In VPC, you pay per hour of using public IP addresses.

## Pricing {#prices}

### Public IP addresses {#prices-public-ip}

The price of an inactive public static address is calculated by adding the price of a public IP address to the price for reserving an inactive public static IP address:

> 0.1524 + 0.1980 = ₽0.3504 per hour, with VAT

{% list tabs %}

- Prices in USD
  
  | Service | Rate for 1 hour, without VAT |
  | ----- | ----- |
  | Public IP address | $0.001953 |
  | Reserving an inactive public static IP address | $0.002538 |
  
- Prices in roubles
  
  | Service | Rate for 1 hour, with VAT |
  | ----- | ----- |
  | Public IP address | ₽0.1524 |
  | Reserving an inactive public static IP address | ₽0.1980 |
  
{% endlist %}

### Protection against DDoS attacks {#prices-ddos-protection}

{% list tabs %}

- Prices in USD
  
  | Service | Rate for 1 GB of traffic after filtering, without VAT | 
  | ----- | ----- |
  | Filtering incoming traffic to a public IP address with DDoS protection | $0.031153 |
  
- Prices in roubles
  
  | Service | Rate for 1 GB of traffic after filtering, with VAT | 
  | ----- | ----- |
  | Filtering incoming traffic to a public IP address with DDoS protection | ₽2.4300 |
  
{% endlist %}
