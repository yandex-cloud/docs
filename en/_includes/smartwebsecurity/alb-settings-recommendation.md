To enhance DDoS protection of your applications, consider these additional tips:

* Configure [autoscaling](../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling). This will allow you to dynamically adapt to the increased load and optimize traffic redistribution.
* Deploy your resources across multiple [availability zones](../../overview/concepts/geo-scope.md).
* Use HTTPS for secure communication: [configure a listener](../../application-load-balancer/concepts/application-load-balancer.md#listener) to automatically redirect requests from HTTP to HTTPS.
* Ensure protection at the lower OSI model layer: [enable](../../smartwebsecurity/tutorials/alb-with-ddos-protection/console.md) basic DDOS protection at L3 and L4 to prevent some attacks at an earlier stage.

These measures, in addition to setting up {{ sws-name }}, will increase the resilience of your services to potential threats and ensure security of your applications.