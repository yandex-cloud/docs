# Creating a load balancer with DDoS protection


Distributed denial of service, or [DDoS](https://en.wikipedia.org/wiki/Denial-of-service_attack), is a type of cyberattack that involves sending massive numbers of requests to a server or network to overwhelm it or make it inoperable.

In this tutorial, you will deploy a DDoS protection infrastructure for app backends in {{ yandex-cloud }}. To do this, you will create a cloud network, set up {{ vpc-full-name }} security groups, create a {{ compute-full-name }} instance group as backends and link it to the infrastructure of a [{{ alb-full-name }}](../../application-load-balancer/) L7 load balancer with a DDoS-protected public IP address.

You can create a DDoS protection infrastructure using the following tools:
