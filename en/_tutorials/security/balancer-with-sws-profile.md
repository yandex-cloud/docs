# Creating an L7 {{ alb-full-name }} with a {{ sws-full-name }} profile

With {{ sws-full-name }}, you can protect your infrastructure against DDoS attacks and bots at the application layer (L7).

You will create a test web server, deploy an {{ alb-name }} [L7 load balancer](../../application-load-balancer/concepts/application-load-balancer.md) for distributing traffic to the test web server, and protect the created infrastructure using a {{ sws-name }} [security profile](../../smartwebsecurity/concepts/profiles.md).

Use the following tools to create an infrastructure for your {{ alb-name }} L7 load balancer with a security profile:
