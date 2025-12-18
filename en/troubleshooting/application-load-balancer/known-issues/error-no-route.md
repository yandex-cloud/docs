# Resolving the `no_route` error when accessing an address


## Issue description {#issue-description}

Your {{ alb-name }} load balancer is configured with multiple SNI-based listeners. When you open the first address in your browser and then, in a new tab, open the second address, you receive this error: `"error_details""no_route"`. After 30 seconds, the error disappears and the resource becomes accessible again. 

## Solution {#issue-resolution}

This occurs because your browser re-uses the existing TLS connection. Both domains resolve to the same IP address, and the TLS certificate includes a *wildcard* covering the entire domain. As a result, the load balancer does not re-evaluate which listener should handle the request; instead, it continues routing traffic through the initially established connection to the wrong HTTP router, causing the `no_route` error.

We recommend the following solutions:

1. Use separate TLS certificates for your primary and additional listeners.
1. Use a single HTTP router and configure multiple virtual hosts within it to route traffic correctly among the different domain names covered by the same certificate.

For more details on listener behavior, see [this article](../../../application-load-balancer/concepts/application-load-balancer.md#listener).
