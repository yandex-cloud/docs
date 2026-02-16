
# Terminating TLS connections


[{{ alb-full-name }}](../../application-load-balancer/) offers you [L7 load balancers](../../application-load-balancer/concepts/application-load-balancer.md) that can _terminate_ TLS connections: send certificates to clients, decrypt incoming traffic to send to the [backends](../../application-load-balancer/concepts/backend-group.md), and encrypt backend responses prior to forwarding them to clients. In this tutorial, you will learn how to configure a load balancer to terminate TLS connections using a [certificate](../../certificate-manager/concepts/index.md) from [{{ certificate-manager-full-name }}](../../certificate-manager/) and to redirect HTTP requests to HTTPS.

In this example, we will use the `my-site.com` domain name and map it to the IP address of the L7 load balancer using [DNS records](../../dns/concepts/resource-record.md) in [{{ dns-full-name }}](../../dns/).

You can create an infrastructure for terminating TLS connections using one of these tools: