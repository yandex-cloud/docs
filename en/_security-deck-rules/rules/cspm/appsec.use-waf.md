### Web Application Firewall is implemented {#use-waf}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | appsec.use-waf ||
|#

#### Description

{% note warning "**Manual Check**" %}

This rule checks only the built-in information security features in Yandex Cloud. If an applied protection is used, please manually mark the rule as completed.

{% endnote %}

To mitigate risks associated with web attacks, we recommend using the Yandex Smart Web Security web application firewall (WAF). A web application firewall analyzes HTTP requests to a web app according to pre-configured rules. Based on the analysis results, certain [actions](https://yandex.cloud/en/docs/smartwebsecurity/concepts/rules#rule-action) are applied to HTTP requests.

You can manage the web application firewall using a [WAF profile](https://yandex.cloud/en/docs/smartwebsecurity/concepts/waf) that connects to a [security profile](https://yandex.cloud/en/docs/smartwebsecurity/concepts/profiles) in Smart Web Security as a separate [rule](https://yandex.cloud/en/docs/smartwebsecurity/concepts/rules).

#### Instructions and solutions

Create a WAF profile and connect it to a security profile in Smart Web Security. It is recommended to configure and test your security profile Basic and Smart Protection rules beforehand.

**Guides and solutions to use:**

1. [Create](https://yandex.cloud/en/docs/smartwebsecurity/operations/waf-profile-create) a WAF profile. 2. [Configure](https://yandex.cloud/en/docs/smartwebsecurity/operations/configure-set-rules) a WAF rule set. 3. [Add](https://yandex.cloud/en/docs/smartwebsecurity/operations/exclusion-rule-add) an exclusion rule to the WAF profile. 4. [Attach](https://yandex.cloud/en/docs/smartwebsecurity/operations/rule-add) the WAF profile to your security profile.
