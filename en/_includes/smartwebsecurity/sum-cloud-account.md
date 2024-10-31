Billing is based on the number of requests across all [clouds](../../resource-manager/concepts/resources-hierarchy.md#cloud) linked to a single [billing account](../../billing/concepts/billing-account.md).

You pay for the actual number of legitimate requests. For each request, you are charged for:

* Processing with security profile rules, both [basic](../../smartwebsecurity/concepts/rules.md#base-rules) and [Smart Protection](../../smartwebsecurity/concepts/rules.md#smart-protection-rules) ones.
  
* Processing with [WAF rules](../../smartwebsecurity/concepts/rules.md#waf-rules). If a request is processed with security profile rules and then with WAF rules, you are charged for both.
  
* Processing with rules in the dry run mode. Even though a rule blocks a request, those are not blocked in the dry run mode, which means they reach their destination. If you only enabled dry run for one rule type, e.g., for security profile rules, while the request was blocked with WAF or ARL without dry run, you are not charged for such a request.

You are not charged for processing requests with ARL profile rules. You are not charged for blocked requests, regardless of when and which rule blocked them.
