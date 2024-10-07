---
title: Terminating TLS connections using {{ alb-full-name }}
description: In this tutorial, you will configure a {{ alb-full-name }} load balancer to terminate TLS connections using a certificate from {{ certificate-manager-full-name }} and to redirect HTTP requests to HTTPS.
---

# Terminating TLS connections


[{{ alb-full-name }}](../../application-load-balancer/) [L7 load balancers](../../application-load-balancer/concepts/application-load-balancer.md) can _terminate_ TLS connections: send certificates to clients, decrypt incoming traffic to send to the backends, and encrypt [backend](../../application-load-balancer/concepts/backend-group.md) responses prior to forwarding them to clients. In this tutorial, you will learn how to configure a load balancer to terminate TLS connections using a [certificate](../../certificate-manager/concepts/index.md) from [{{ certificate-manager-full-name }}](../../certificate-manager/) and to redirect HTTP requests to HTTPS.

The `my-site.com` domain name is used as an example. It will be mapped to the IP address of the L7 load balancer using [DNS records](../../dns/concepts/resource-record.md) in [{{ dns-full-name }}](../../dns/).

You can create an infrastructure for terminating TLS connections using one of these tools: