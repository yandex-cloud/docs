# Terminating TLS connections


[{{ alb-full-name }}](../../application-load-balancer/) [L7 load balancers](../../application-load-balancer/concepts/application-load-balancer.md) can _terminate_ TLS connections: send certificates to clients, decrypt incoming traffic to send to the backends, and encrypt [backend](../../application-load-balancer/concepts/backend-group.md) responses prior to forwarding them to clients. In this tutorial, you will learn how to configure a load balancer to terminate TLS connections using a [certificate](../../certificate-manager/concepts/index.md) from [{{ certificate-manager-full-name }}](../../certificate-manager/) and to redirect HTTP requests to HTTPS.

You can create an infrastructure for terminating TLS connections using one of the tools:
* [Management console](../../tutorials/security/tls-termination/console.md): Use this method to create the infrastructure step-by-step in the {{ yandex-cloud }} management console.
* [{{ TF }}](../../tutorials/security/tls-termination/terraform.md): Use this method to streamline resource creation and management using the _infrastructure as code_ (IaC) approach. Download the {{ TF }} configuration example from the GitHub repository, and then deploy the infrastructure using the [{{ yandex-cloud }} {{ TF }} provider]({{ tf-docs-link }}).