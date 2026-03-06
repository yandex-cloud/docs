# Integrating an L7 load balancer with {{ cdn-short-name }} and {{ objstorage-short-name }}


In this tutorial, we will use a {{ objstorage-full-name }} [bucket](../../storage/concepts/bucket.md) as an L7 {{ alb-full-name }} [backend](../../application-load-balancer/concepts/backend-group.md#types). To reduce content delivery time, the load [balancer](../../application-load-balancer/concepts/application-load-balancer.md) receives user requests via the {{ cdn-full-name }} [content delivery network](../../cdn/concepts/points-of-presence.md).

To create an infrastructure to integrate an L7 load balancer with {{ cdn-name }} and {{ objstorage-name }}, you can use one of the following tools:
