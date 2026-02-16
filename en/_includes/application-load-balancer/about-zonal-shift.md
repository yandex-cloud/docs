If an [availability zone](../../overview/concepts/geo-scope.md) is under maintenance or fails, {{ yandex-cloud }} technicians may temporarily [disable that zone](../../application-load-balancer/operations/manage-zone/allow-and-deny-shift.md).

You can also manually disable one or more availability zones to address the following scenarios:

* Reducing load during localized issues, e.g., after a faulty app release on your backend or an incident caused by high traffic or misconfiguration. Temporarily disabling the affected zone helps prevent service disruption or quickly restore app functionality for your users.

* Testing the resilience of your load balancer and traffic failover mechanisms. This way, you can proactively identify potential weaknesses, apply fixes, and optimize your load balancer settings in advance.