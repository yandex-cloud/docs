
# Terminating TLS connections


[{{ alb-full-name }}](../../application-load-balancer/)-enabled [L7 balancers](../../application-load-balancer/concepts/application-load-balancer.md) can _terminate_ TLS connections: send certificates to clients, decrypt inbound traffic to send to the backends, and encrypt [backend](../../application-load-balancer/concepts/backend-group.md) responses prior to forwarding them to clients. In this tutorial, you will learn how to configure a load balancer to terminate TLS connections using a [certificate](../../certificate-manager/concepts/index.md) from [{{ certificate-manager-full-name }}](../../certificate-manager/) and redirect HTTP requests to HTTPS.

The tutorial features the `my-site.com` domain as an example. It will be mapped to the IP address of the L7 load balancer using [DNS records](../../dns/concepts/resource-record.md) in [{{ dns-full-name }}](../../dns/).

You can create an infrastructure for terminating TLS connections using one of these tools: