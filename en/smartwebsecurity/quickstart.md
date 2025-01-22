# Getting started with {{ sws-full-name }}

{{ sws-name }} protects your infrastructure from cybersecurity threats at application layer L7 of the OSI model. These may include DDoS attacks, bots, and SQL injections. In addition, you can enable DDoS protection at levels L3 and L4 using [{{ ddos-protection-full-name }}](../vpc/ddos-protection/index.md).

{{ sws-name }} is an assortment of tools you can use either separately or in a combination for optimized protection for your resources. The main {{ sws-name }} component is a _security profile_ to which you can connect:

* Basic rules. For simple traffic filtering based on certain conditions.
* Smart Protection rules. To analyze traffic with machine learning and behavioral analysis algorithms.
* WAF profile rules. Allow using rule sets to counter common security threats, such as OWASP Core Rule Set (CRS). Rule sets protect web apps from many known threats, e.g., SQL injections, command injections, cross-site scripting, unauthorized access to server resources, and more.
* CAPTCHA. After you have checked traffic with rules, you can additionally route it to [{{ captcha-full-name }}](../smartcaptcha) for protection against bots and spam.
* ARL profile. To limit the number of requests to the protected resource based on various conditions.

To protect resources, you need to connect a security profile to a [virtual host](../application-load-balancer/concepts/http-router.md#virtual-host) or an [Ingress controller](../application-load-balancer/tools/k8s-ingress-controller/index.md#smart-web-security) in {{ alb-full-name }}.

To get started with the service:

* [Prepare your cloud](#before-you-begin)
* [Create and check a security profile](#security-profile)
* [Connect the security profile to a virtual host](#profile-connect)
* (Optional) [Create and connect a WAF profile](#waf)
* (Optional) [Create and connect an ARL profile](#arl)
* [Configure the L7 network load balancer for additional protection](#configure-balancer)


## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}


## Create and check a security profile {#security-profile}

Create your first [security profile](concepts/profiles.md) and connect it to an existing [virtual host](../application-load-balancer/concepts/http-router.md#virtual-host) of an L7 load balancer in {{ alb-full-name }}.

If you have no L7 load balancer configured, you can deploy a [test infrastructure](tutorials/balancer-with-sws-profile.md).

### Create a security profile {#profile-create}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to create a profile in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Click **{{ ui-key.yacloud.smart-web-security.action_empty }}** and select **{{ ui-key.yacloud.smart-web-security.title_default-template }}**.

      A preset profile includes:

      * [Basic default rule](concepts/rules.md#base-rules) enabled for all traffic with the `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}` [action type](concepts/rules.md#rule-action).
      * [Smart Protection rule](concepts/rules.md#smart-protection-rules) enabled for all traffic with the `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}` action type.

      {% include [smart-protection-tip](../_includes/smartwebsecurity/smart-protection-tip.md) %}

  1. Enter a name for the profile, e.g., `test-sp1`.
  1. In the **{{ ui-key.yacloud.smart-web-security.form.label_default-action }}** field, select `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}`.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}


### Check your security profile settings {#profile-check}

{% list tabs group=instructions %}

- Management console {#console}

  1. Select the `test-sp1` profile you created earlier.
  1. Make sure the **{{ ui-key.yacloud.smart-web-security.overview.title_security-rules }}** tab contains a rule with the following parameters:

      * **{{ ui-key.yacloud.smart-web-security.overview.column_type }}**: `{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}`.
      * **{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}**: `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}`.
      * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}**: `{{ ui-key.yacloud.component.condition-column.condition_full-trafic }}`.

      This rule sends all incoming traffic of the protected resource for automatic analysis using ML and behavioral analysis algorithms. As a result of automatic analysis:

      * Legitimate requests are routed to the protected resource.
      * Illegitimate requests and attacks are blocked.
      * Suspicious requests are sent to {{ captcha-name }} for additional verification.

{% endlist %}


## Connect the security profile to the virtual host {#profile-connect}

{% list tabs group=instructions %}

- Management console {#console}

  1. At the top right, click ![plug](../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.smart-web-security.overview.action_attach-to-host }}**.
  1. In the window that opens, select:

      * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_balancer }}**](../application-load-balancer/concepts/application-load-balancer.md).
      * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_http-router }}**](../application-load-balancer/concepts/http-router.md).
      * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_virtual-host }}**](../application-load-balancer/concepts/http-router.md#virtual-host). You can connect the security profile to multiple virtual hosts at once.

        To connect the profile to another L7 load balancer, click **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_add-balancer }}**.

  1. Click **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_connect }}**.

      You will see the connected virtual host under **{{ ui-key.yacloud.smart-web-security.overview.title_connected-to-the-hosts }}**.

{% endlist %}


## Create and connect a WAF profile {#waf}

WAF allows using rule sets to protect web applications from various information attacks.

### Create a WAF profile {#waf-create}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to create a WAF profile in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Go to the ![image](../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}** tab and click **{{ ui-key.yacloud.smart-web-security.waf.label_create-profile }}**.
  1. Enter a name for the profile, e.g., `test-waf-profile-1`.
  1. By default, the WAF profile includes a basic rule set called [OWASP Core Rule Set](https://coreruleset.org/). To view the rules it includes, click the line with its description.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}


### Configure a basic rule set {#waf-configure-rules}

{% list tabs group=instructions %}

- Management console {#console}

  1. On the WAF profile's review page that opens, click **{{ ui-key.yacloud.smart-web-security.waf.action_setup-base-rules }}**.
  1. Set the **{{ ui-key.yacloud.smart-web-security.waf.label_anomaly-threshold }}**, which is the sum of [anomaly](concepts/waf.md#anomaly) values of the triggered rules that will block the request, e.g., `{{ ui-key.yacloud.smart-web-security.waf.label_anomaly-medium }}`.

      We recommend to start with the anomaly threshold of `25` and gradually reduce it to `5`. To reduce the anomaly threshold, address WAF false positives triggered by legitimate requests. To do so, select rules from the basic set and configure [exclusion rules](#create-exclusion). You can use the **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry-run)** mode in the security profile to test various anomaly thresholds.

  1. Set the required **{{ ui-key.yacloud.smart-web-security.waf.label_paranoia-level }}**, e.g., `{{ ui-key.yacloud.smart-web-security.waf.label_paranoia-option-2 }}`.

      [Paranoia level](concepts/waf.md#paranoia) classifies rules according to their aggression. The higher the paranoia level, the better your protection, but also the higher the probability of WAF false positives.

  1. Check the rules you included in the set. Add or delete them as needed. When using rules, pay attention to their anomaly values and paranoia levels.

  You can turn any rule from the set into a blocking rule. A request that satisfies such a rule will be blocked regardless of the anomaly threshold you specified. To turn a rule into a blocking rule, click ![image](../_assets/console-icons/ban.svg) to the right of it. If the **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}(dry-run)** mode is enabled in the security profile, requests will not be blocked even when if they satisfy the blocking rules.

{% endlist %}


### Create an exclusion rule {#create-exclusion}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the ![image](../_assets/console-icons/file-xmark.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_exclusion-rules }}** tab and click **{{ ui-key.yacloud.smart-web-security.waf.label_create-exclusion-rule }}**.
  1. Enter a name for the [exclusion rule](concepts/waf.md#exclusion-rules), e.g., `exception-rule-1`.
  1. Under **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rule-rules-section }}**, specify rules from the basic set for which the exclusion will be valid. You can either select `{{ ui-key.yacloud.smart-web-security.waf.value_exclude-all-yes }}` or specify particular rules.
  1. Under **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rule-condition-section }}**, select the triggering [conditions](concepts/conditions.md) for the exclusion rule.

      If you leave the **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** field empty, the exclusion rule will apply to all traffic.

  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}


### Connect the WAF profile to a security profile {#waf-connect}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the ![image](../_assets/console-icons/shield-check.svg) **{{ ui-key.yacloud.smart-web-security.label_profiles-list }}** tab.
  1. From the list, select the security profile you want to connect your WAF profile to, e.g., `test-sp1`.
  1. Click ![plus-sign](../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
  1. Enter a name for the rule, e.g., `waf-rule-1`.
  1. In the **{{ ui-key.yacloud.smartcaptcha.field_security-rule_priority }}** field, set a value higher than that of the Smart Protection rules already existing in the security profile, e.g., `888800`.
  1. (Optional) To test your WAF profile and simulate false positives triggered by legitimate requests, use the **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry-run)** mode in the security profile.
  1. In the **Type** field, select `{{ ui-key.yacloud.smart-web-security.overview.label_waf-rule }}`.
  1. In the **{{ ui-key.yacloud.smart-web-security.overview.title_waf-profile }}** field, select the previously created `test-waf-profile-1`.
  1. In the **{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}** field, select `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}`.
  1. If required, set the [conditions](concepts/conditions.md) for traffic mapping.
  1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}


## Create and connect an ARL profile {#arl}

ARL allows limiting the number of requests to the protected resource to avoid an overload.

### Create an ARL profile {#arl-create}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to create your ARL profile in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Go to the ![image](../_assets/smartwebsecurity/arl.svg) **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}** tab and click **{{ ui-key.yacloud.smart-web-security.arl.label_create-profile }}**.
  1. Enter a name for the profile, e.g., `test-arl-profile-1`.
  1. Add profile description and labels if needed.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}


### Configure rules {#arl-configure-rules}

{% list tabs group=instructions %}

- Management console {#console}

  1. On the ARL profile's review page that opens, click **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
  1. Enter a name for the rule, e.g., `arl-rule-1`.
  1. In the Priority field, set the rule's priority within the ARL profile, e.g., `1000`.
  1. (Optional) To test the ARL rule, enable the **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (Dry run)** mode. Requests will not be blocked in this mode.
  1. Under **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rule-condition-section }}**, select `All traffic` or `On condition`.
  1. To set [traffic conditions](concepts/conditions.md), select one or more items from the **Conditions** list:

      * `{{ ui-key.yacloud.component.condition-column.condition_name-ip-range }}`: IP address, IP address range, or IP address region.
      * `{{ ui-key.yacloud.component.condition-column.condition_name-header }}`: HTTP header string.
      * `{{ ui-key.yacloud.component.condition-column.condition_name-host }}`: Domain receiving the request.
      * `{{ ui-key.yacloud.component.condition-column.condition_name-httpMethod }}`: Request method.
      * `{{ ui-key.yacloud.component.condition-column.condition_name-cookie }}`: Cookie header string.

  1. Under **Request counting**, select how to count requests for limit application purposes:

      * `{{ ui-key.yacloud.smart-web-security.arl.label_rule-without-grouping }}`: Count each request separately.
      * `Grouping by property`: Count the number of request groups sharing one or more common properties.

      1. Select a grouping property:

          * `Request path`: Request path.
          * `{{ ui-key.yacloud.component.condition-column.condition_name-httpMethod }}`: Request method.
          * `IP address`: IP address the request originates from.
          * `Region`: IP address region of the requests.
          * `{{ ui-key.yacloud.component.condition-column.condition_name-host }}`: Domain receiving the request.
          * `HTTP cookie`: String in the cookie header.
          * `{{ ui-key.yacloud.component.condition-column.condition_name-header }}`: HTTP header string.
          * `Query params`: String in query parameters.

      1. (Optional) Enable **Case-sensitive** to put properties with the same values in different cases into different groups.

  1. Specify the request limit and select the time interval, e.g., `1000` requests per `1` minute.
  1. Click **{{ ui-key.yacloud.smart-web-security.arl.label_save-rule }}**.

{% endlist %}


### Connect your ARL profile to a security profile {#arl-connect}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the ![image](../_assets/console-icons/shield-check.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}** tab.
  1. From the list, select the security profile you want to connect your ARL profile to, e.g., `test-sp1`.
  1. Click ![image](../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.smart-web-security.overview.action_edit-profile }}**.
  1. In the **{{ ui-key.yacloud.smart-web-security.form.label_arl-profile }}** list, select the previously created `test-arl-profile-1`.
  1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}


## Configure the L7 load balancer for additional protection {#configure-balancer}

{% include [alb-settings-recommendation](../_includes/smartwebsecurity/alb-settings-recommendation.md) %}


#### See also {#see-also}

* [{#T}](operations/profile-create.md)
