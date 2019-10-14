---
editable: false
---
# Pricing for {{ vpc-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ vpc-short-name }} {#rules}

In {{ vpc-short-name }}, you pay for the hourly use of public IP addresses.

## Pricing {#prices}

### Public IP addresses {#prices-public-ip}

A public IP address can be in one of the following two states:

1. **Active**: When a _dynamic_ or _static_ public IP address is linked to a running cloud resource.

1. **Inactive**: When a _static_ public IP address isn't linked to a cloud resource or is linked to a stopped resource. The price of an inactive public static address is calculated by adding the price of a public IP address to the price for reserving an inactive public static IP address:

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

### DDoS protection {#prices-ddos-protection}

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

Filtered traffic is incoming traffic that the DDoS Protection filtering system passes to the user's cloud resources. Only filtered traffic is charged.

For example, a user's VM was subject to a typical 10 Gbit/s DDoS attack generating 75 GB of incoming traffic. During the attack, the user downloaded 2 GB of filtered files from the internet to the VM. When the attack ended, the user downloaded another 2 GB of filtered files.

In this case, only 4 GB of filtered traffic are billed: 2 GB that DDoS Protection passed to cloud resources during the attack, and 2 GB downloaded after the attack. Malicious traffic is filtered out and not billed.

### Cloud Interconnect {#prices-interconnect}

The service is provided when technically possible. Yandex Cloud Interconnect prices are provided upon request and are subject to the technical characteristics of the connection to Yandex.Cloud.

