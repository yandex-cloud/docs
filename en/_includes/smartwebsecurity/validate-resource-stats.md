1. Under ![domain-protection-icon](../../_assets/smartwebsecurity/domain-protection-icon.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection }}**, select the new proxy server.
1. Navigate to the **{{ ui-key.yacloud.smart-web-security.label_domain-protection-domains }}** tab and select the domain you created.
1. Under **{{ ui-key.yacloud.smart-web-security.Domain.Overview.targetResources_cNZPL }}**, check that your resource's status is **{{ ui-key.yacloud.smart-web-security.DomainTargetStateStatus.statusHealthy_5F2ks }}**.

    If it is not, the proxy server cannot connect to your resource. Check the following:

    * Web server address.
    * Network settings. Make sure access to the web server is allowed from [{{ yandex-cloud }} IP addresses](../../overview/concepts/public-ips.md).
    * Domain address.
    * A record.
    * Certificate validity.