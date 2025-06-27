1. Under ![domain-protection-icon](../../_assets/smartwebsecurity/domain-protection-icon.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection }}**, select the new proxy server.
1. In the left-hand menu, go to the ![globe](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection-domains }}** tab and select the new domain.
1. Under **{{ ui-key.yacloud.smart-web-security.Domain.Overview.targetResources_cNZPL }}**, check that your resource's status is **{{ ui-key.yacloud.smart-web-security.DomainTargetStateStatus.statusHealthy_5F2ks }}**.

    If it is not, the proxy server cannot connect to your resource. Check your web server address and network settings. Make sure access to the web server is allowed from [{{ yandex-cloud }} IP addresses](../../overview/concepts/public-ips.md).
1. In the left-hand panel, check that your domain's status is **{{ ui-key.yacloud.smart-web-security.DomainTargetStateStatus.statusHealthy_5F2ks }}**. 
    
    If it is not, verify the domain address and the A record, and check the certificate for validity.