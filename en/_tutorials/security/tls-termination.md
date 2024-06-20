# Terminating TLS connections


[{{ alb-full-name }}](../../application-load-balancer/) [L7 load balancers](../../application-load-balancer/concepts/application-load-balancer.md) can _terminate_ TLS connections: send certificates to clients, decrypt incoming traffic to send to the backends, and encrypt [backend](../../application-load-balancer/concepts/backend-group.md) responses prior to forwarding them to clients. In this tutorial, you will learn how to configure a load balancer to terminate TLS connections using a [certificate](../../certificate-manager/concepts/index.md) from [{{ certificate-manager-full-name }}](../../certificate-manager/) and to redirect HTTP requests to HTTPS.

The `my-site.com` domain name is used as an example. It will be mapped to the L7 load balancer's IP address using [DNS records](../../dns/concepts/resource-record.md) in [{{ dns-full-name }}](../../dns/).

You can create an infrastructure for terminating TLS connections using one of these tools:
* [Management console](../../tutorials/security/tls-termination/console.md): Create your infrastructure one step at a time from the {{ yandex-cloud }} management console.
* [{{ TF }}](../../tutorials/security/tls-termination/terraform.md): Streamline creating and managing your resources using the _infrastructure as code_ (IaC) approach. Download the {{ TF }} configuration example from the GitHub repository, and then deploy the infrastructure using the [{{ yandex-cloud }} {{ TF }} provider]({{ tf-docs-link }}).