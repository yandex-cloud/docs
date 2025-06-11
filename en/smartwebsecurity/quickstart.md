# How to get started with {{ sws-full-name }}

{% include [about-sws](../_includes/smartwebsecurity/about-sws.md) %}

## Setup {#steps}

* [Get your cloud ready](#before-you-begin).
* [Create and configure a protected resource](#resource-create).
* [Create and check a security profile](#security-profile).
* [Connect a security profile to the protected resource](#profile-connect).
* [Test the security profile](#monitoring).
* (Optional) [Create and connect a WAF profile](#waf).
* (Optional) [Create and connect an ARL profile](#arl).


## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}


## Create and configure a protected resource {#resource-create}

{% list tabs group=resources %}

- L7 load balancer {#balancer}

  {{ alb-name }} evenly distributes incoming traffic between nodes, thus preventing overload and improving fault tolerance. If you have no L7 load balancer set up yet, you can deploy a [test infrastructure](tutorials/balancer-with-sws-profile/index.md).

- API gateway {#api-gateway}

  API gateway is the single entry point for APIs of various services, enabling requests management, routing, authentication, and so forth. If you have no API gateway configured, you can deploy one with a [test specification](../api-gateway/tutorials/api-gw-sws-integration.md).

- Domain {#domain}

  Domain is a server, website, or application that processes external requests to a web address. To protect a domain, {{ sws-name }} provides a proxy server with load balancing, request analysis and routing. And basic [DDoS protection](../vpc/ddos-protection/) as well.
  
  The proxy server has an MTU limit of 1,450 bytes for all packets.

  {% include [preview-domain](../_includes/smartwebsecurity/preview-domain.md)%}

  ### Prepare data about the resource {#domain-info}
  
    * Address of the domain the web application is running on. You need access to the domain management interface to update the A record.
    * Server IP address, port and protocol used by the web application.
    * Valid private key and TLS certificate for this domain in [PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail)-encoded format. Certificates with RSA-2048 and RSA-4096 keys are supported.

  ### Create a proxy server {#create-proxy}

  {% list tabs group=instructions %}

  - Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
    1. In the left-hand panel, select **Domain protection**.
    1. Click **Create proxy server**.
    1. Enter a name for the proxy server, e.g., `test-proxy`.
    1. Click **Create**.
    
        {% include [after-proxy-create](../_includes/smartwebsecurity/after-proxy-create.md) %}

  {% endlist %}

  ### Add a domain {#add-domain}

  {% list tabs group=instructions %}

  - Management console {#console}

    1. Under **Domains**, click **Add domain**.
    1. Enter the address of the domain your web application is in, e.g., `example.com`.
    1. Click **Continue**.
    1. Select the connection type used by your application. We recommend the secure **HTTPS** protocol.
    1. If you use [{{ certificate-manager-name }}](../../certificate-manager/) and have added your domain certificate to it, select it from the list. 
    1. If not using {{ certificate-manager-name }}, click **Create** → **Custom certificate**.
       1. Enter a name for the certificate.
       1. Copy or upload the private key, certificate, and intermediate certificate chain as a file in PEM format.
       1. Click **Create certificate**.
    1. Click **Continue**.

    1. Specify the **Target resources** settings:
       1. IP address and port your web application runs on.
       1. Protocol your web application runs on.
    1. Click **Save**.

    After you create a domain, the domain parameters overview page will open. Under **Enable protection**, copy the proxy server IP address and {{ yandex-cloud }} trusted addresses. You will need this data at the next step.
  
  {% endlist %}

  ### Set up your infrastructure {#infrastructure-settings}
  
  * Go to the DNS management panel on your hosting provider's or domain registrar's website.
  * Add an A record with the following parameters:
     * `Host name`: `Your domain address (example.com)`. 
     * `Value`: `Proxy server IP address`.
  
     This record redirects requests coming to your domain to the proxy server IP address.

  * In your server settings, block all connections except those for {{ yandex-cloud }} IP addresses.
  
  ### Check your resource status {#check-status}

  {% list tabs group=instructions %}

  - Management console {#console}

    1. In the **Proxy server** section, select the new proxy server.
    1. Go to the **Domains** section and select the domain you created.
    1. In the **Target resources** section, check that your resource is in **Healthy** status.
  
       If it is not, the proxy server cannot connect to your resource. Check your web server address and network settings. Make sure access to the web server is allowed from {{ yandex-cloud }} IP addresses.
    
    1. In the left-hand panel, check that your domain is in **Healthy** status. 
       
       If it is not, verify the domain address and the A record, and check the certificate for validity.

  {% endlist %}

{% endlist %}

## Create and check a security profile {#security-profile}

### Create a security profile {#profile-create}

{% include [user-data-to-ml](../_includes/smartwebsecurity/user-data-to-ml.md)%}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the protected resources are in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Click **{{ ui-key.yacloud.smart-web-security.action_empty }}** and select **{{ ui-key.yacloud.smart-web-security.title_default-template }}**.

      A preset profile includes:

      * [Basic default rule](concepts/rules.md#base-rules) enabled for all traffic with the `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}` [action type](concepts/rules.md#rule-action).
      * [Smart Protection rule](concepts/rules.md#smart-protection-rules) enabled for all traffic with the `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}` action type.

      {% include [smart-protection-tip](../_includes/smartwebsecurity/smart-protection-tip.md) %}

  1. Enter a name for the profile, e.g., `test-sp1`.
  1. In the **{{ ui-key.yacloud.smart-web-security.form.label_default-action }}** field, select `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}`.
  1. Optionally, enable or disable the use of HTTP request information to improve machine learning models under **{{ ui-key.yacloud.component.disallow-data-processing.title_ml-model-training }}**.
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


## Connect a security profile to the resource {#profile-connect}

{% list tabs group=instructions %}

- Management console {#console}

  The connection method depends on the resource type.

  * To connect a domain: 
    1. Under **Domain protection** → **Domains**, select the domain you need. 
    1. Click **Connect a security profile** and select a profile.
  
  * To connect a virtual host in {{ alb-name }}:

    1. If the load balancer is managed by an {{ alb-name }} [Ingress Controller](../application-load-balancer/tools/k8s-ingress-controller/index.md), use the [Ingress resource annotation](../application-load-balancer/k8s-ref/ingress.md#annot-security-profile-id).
    1. If the load balancer is managed by you, select the created profile under **Security profiles**.
    1. At the top right, click ![plug](../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.smart-web-security.overview.action_attach-to-host }}**.
    1. In the window that opens, select:

       * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_balancer }}**](../application-load-balancer/concepts/application-load-balancer.md).
       * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_http-router }}**](../application-load-balancer/concepts/http-router.md).
       * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_virtual-host }}**](../application-load-balancer/concepts/http-router.md#virtual-host). You can connect the security profile to several virtual hosts at the same time.

        To connect the profile to another L7 load balancer, click **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_add-balancer }}**.

    1. Click **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_connect }}**.

      You will see the associated virtual host under **{{ ui-key.yacloud.smart-web-security.overview.title_connected-to-the-hosts }}**.

  * To connect an API gateway:
    1. In the **Security Profiles** section, copy the ID of the profile of your choice.
    1. When creating an API gateway or in the existing API gateway specification, set this extension: [x-yc-apigateway:smartWebSecurity](../api-gateway/concepts/extensions/sws.md).
    1. Specify the copied ID in the extension.


{% endlist %}


## Monitor the security profile operation {#monitoring}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}** service page, select the **Monitoring** section on the left-hand panel.
  1. View the [charts](operations/monitoring.md) of allowed and blocked requests.

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
  1. By default, the WAF profile uses the [OWASP Core Rule Set](https://coreruleset.org/). To view the rules it includes, click the line with its description.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}


### Configure a basic rule set {#waf-configure-rules}

{% list tabs group=instructions %}

- Management console {#console}

  1. On the WAF profile's review page that opens, click **{{ ui-key.yacloud.smart-web-security.waf.action_setup-base-rules }}**.
  1. Set the **{{ ui-key.yacloud.smart-web-security.waf.label_anomaly-threshold }}**, which is the sum of [anomaly](concepts/waf.md#anomaly) values of the triggered rules that will block the request, e.g., `{{ ui-key.yacloud.smart-web-security.waf.label_anomaly-medium }}`.

      We recommend to start with the anomaly threshold of `25` and gradually reduce it to `5`. To reduce the anomaly threshold, address WAF false positives triggered by legitimate requests. To do so, select rules from the basic set and configure [exclusion rules](#create-exclusion). You can use the **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry-run)** mode in the security profile to test various anomaly thresholds.

  1. Set the required **{{ ui-key.yacloud.smart-web-security.waf.label_paranoia-level }}**, e.g., `{{ ui-key.yacloud.smart-web-security.waf.label_paranoia-option-2 }}`.

      [Paranoia level](concepts/waf.md#paranoia) classifies rules based on how aggressive they are. The higher the paranoia level, the better the protection, but also the higher the probability of WAF false positives.

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

  1. Navigate to the ![image](../_assets/console-icons/shield-check.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}** tab.
  1. From the list, select the security profile you want to connect your WAF profile to, e.g., `test-sp1`.
  1. Click ![plus-sign](../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
  1. Enter a name for the rule, e.g., `waf-rule-1`.
  1. In the **{{ ui-key.yacloud.smartcaptcha.field_security-rule_priority }}** field, set a value higher than that of the Smart Protection rules already existing in the security profile, e.g., `888800`.
  1. (Optional) To test your WAF profile and simulate false positives triggered by legitimate requests, use the **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry-run)** mode in the security profile.
  1. In the **Type** field, select `{{ ui-key.yacloud.smart-web-security.overview.label_waf-rule }}`.
  1. In the **{{ ui-key.yacloud.smart-web-security.overview.title_waf-profile }}** field, select the previously created profile named `test-waf-profile-1`.
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
  1. In the **{{ ui-key.yacloud.smartcaptcha.field_security-rule_priority }}** field, set the rule's priority within the ARL profile, e.g., `1000`.
  1. (Optional) To test the ARL rule, enable the **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry run)** mode. Requests will not be blocked in this mode.
  1. Under **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rule-condition-section }}**, select `All traffic` or `On condition`.
  1. To set [traffic conditions](concepts/conditions.md), select one or more items from the **Conditions** list:

      * `{{ ui-key.yacloud.component.condition-column.condition_name-ip-range }}`: IP address, IP address range, IP address region, or [address list](concepts/lists.md).
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

  1. Navigate to the ![image](../_assets/console-icons/shield-check.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}** tab.
  1. From the list, select the security profile you want to connect your ARL profile to, e.g., `test-sp1`.
  1. Click ![image](../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.smart-web-security.overview.action_edit-profile }}**.
  1. In the **{{ ui-key.yacloud.smart-web-security.form.label_arl-profile }}** list, select the previously created `test-arl-profile-1`.
  1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}


#### See also {#see-also}

* [{#T}](operations/profile-create.md)
