# Creating an L7 {{ alb-full-name }} with a {{ sws-full-name }} profile

With {{ sws-full-name }}, you can protect your infrastructure against DDoS attacks and bots at the application layer (L7).

You will create a test web server, deploy an [L7 {{ alb-name }}](../../../application-load-balancer/concepts/application-load-balancer.md) for distributing traffic to the test web server, and protect this new infrastructure using a [security profile](../../../smartwebsecurity/concepts/profiles.md) in {{ sws-name }}.

Use the following tools to create an infrastructure for your L7 {{ alb-name }} with a security profile: