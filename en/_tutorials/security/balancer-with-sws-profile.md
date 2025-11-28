# Creating an L7 load balancer in {{ alb-full-name }} with a {{ sws-full-name }} profile

With {{ sws-full-name }}, you can protect your infrastructure against DDoS attacks and bots at the application layer (L7).

You will create a test web server, deploy an [L7 {{ alb-name }}](../../application-load-balancer/concepts/application-load-balancer.md) to distribute traffic to the test web server, and protect this new infrastructure with a {{ sws-name }} [security profile](../../smartwebsecurity/concepts/profiles.md).

Use the following tools to create an infrastructure for your L7 {{ alb-name }} with a security profile:
