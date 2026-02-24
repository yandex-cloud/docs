### Web application firewall is implemented {#use-waf}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | appsec.use-waf ||
|#

#### Description

{% note tip "**Automatic verification**" %}

This control automatically checks for Web Application Firewall configuration.

{% endnote %}

{% note warning "**Manual Check**" %}

This rule checks only the built-in information security features in Yandex Cloud. If an applied protection is used, please manually mark the rule as completed.

{% endnote %}

To mitigate risks associated with web attacks, we recommend using the Yandex Smart Web Security web application firewall (WAF). A web application firewall analyzes HTTP requests to a web app according to pre-configured rules. Based on the analysis results, certain [actions](https://yandex.cloud/en/docs/smartwebsecurity/concepts/rules#rule-action) are applied to HTTP requests.

You can manage the web application firewall using a [WAF profile](https://yandex.cloud/en/docs/smartwebsecurity/concepts/waf) that connects to a [security profile](https://yandex.cloud/en/docs/smartwebsecurity/concepts/profiles) in Smart Web Security as a separate [rule](https://yandex.cloud/en/docs/smartwebsecurity/concepts/rules).

#### Guides and solutions

Guides and solutions to use:

* [Creating a WAF profile and connecting it to a security profile in Smart Web Security](https://yandex.cloud/en/docs/smartwebsecurity/quickstart#waf)