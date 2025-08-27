
# Setting up basic protection in {{ sws-name }}

[{{ sws-name }}](../../smartwebsecurity/concepts/index.md) (SWS) protects web resources from internet threats by filtering malicious traffic.

For individual customization, you can connect several {{ sws-name }} tools:

* Basic rules for simple filtering.
* Smart Protection rules for DDoS protection.
* [{{ captcha-name }}](../../smartcaptcha/) for protection against bots.
* Web Application Firewall (WAF) as a safeguard from exploitation of vulnerabilities.
* Advanced Rate Limiter (ARL) for traffic limiting.

Setting up each tool includes these steps: adding rules, testing them in real-world conditions, and adjusting. We recommend setting up the tools one by one, starting from the basic and Smart Protection rules. This will allow you to quickly enable protection and easily monitor and adjust your rules.

In this guide, you will set up web resource protection using SWS tools connected to a security profile, an essential SWS element. Security profile setup involves rule adjustment based on real web application traffic. So here we assume that you already have a configured web resource in {{ yandex-cloud }} or another infrastructure. 

## Steps {#steps}

1. Connecting resources to {{ yandex-cloud }}:
   1. [Get your cloud ready](#before-you-begin)
   1. [Create a protected resource](#resource-create)

1. [Set up DDoS and anti-bot protection](#antiddos-antibot-protection):

   1. [Create a security profile](#security-profile-create)
   1. [Set up filtering by IP address lists](#list-filters)
   1. Optionally, [set up filtering by regions](#region-filters)
   1. [Set up an allowing rule for captcha](#captcha-rule)
   1. [Check the sequence in which the rules will apply](#rules-execution-order)
   1. [Connect the security profile to your resources](#profile-connect)
   1. [Test your security profile in logging mode](#test-sp-rules)
   1. [Test your security profile in real mode](#check-sp-rules)

1. [Set up load limitations](#rate-limiter):

   1. [Create an ARL profile](#arl-create)
   1. [Set up ARL rules](#arl-configure-rules)
   1. [Add your ARL profile to the security profile](#arl-add-to-profile)
   1. [Test the ARL rules](#test-arl-rules)

1. Optionally, [set up the web application firewall](#firewall)

   1. [Create a WAF profile](#waf-create)
   1. [Configure basic rules](#waf-configure-rules)
   1. [Create an exclusion rule](#create-exclusion)
   1. [Add your WAF profile to the security profile](#waf-add-to-profile)
   1. [Test the WAF rules](#test-waf-rules)

## Required paid resources {#paid-resources}

* [Fee for the number of requests](../../smartwebsecurity/pricing.md) to {{ sws-name }}.
* Fee for the [{{ alb-name }}](../../application-load-balancer/pricing.md) or [{{ api-gw-name }}](../../api-gateway/pricing.md) infrastructure if using one. You will not be charged for the domain infrastructure.

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Create a protected resource {#resource-create}

{% include [sws-type-resources](../../_includes/smartwebsecurity/sws-type-resources.md) %}

This guide assumes that you already have a configured web resource. If your resource is not in {{ yandex-cloud }} or you are not using {{ alb-name }} and {{ api-gw-name }}, create a domain by following the steps below. You can also see the documentation of other services with {{ sws-name }} support and set up the relevant infrastructure.

{% list tabs group=resources %}

- L7 load balancer {#balancer}

  [{{ alb-name }}](../../smartwebsecurity/tutorials/balancer-with-sws-profile/index.md) evenly distributes incoming traffic between nodes, thus preventing overload and improving fault tolerance.

- API gateway {#api-gateway}

  [API gateway](../../api-gateway/tutorials/api-gw-sws-integration.md) is the single entry point for APIs of various services, enabling requests management, routing, authentication, and so forth.

- Domain {#domain}

  Domain is a server, website, or application that processes external requests to a web address. For domain protection, {{ sws-name }} provides a proxy server with load balancing, request analysis and routing, and basic [DDoS](../../vpc/ddos-protection/) protection.

  The proxy server has an MTU limit of 1,450 bytes for all packets.

  {% include [preview-domain](../../_includes/smartwebsecurity/preview-domain.md)%}

  ### Prepare data about the resource {#domain-info}

  * Address of the domain the web application is running on. You need access to the domain management interface to update the A record.
  * Server IP address, port and protocol used by the web application.
  * Valid private key and TLS certificate for this domain in [PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail)-encoded format. Certificates with RSA-2048 and RSA-4096 keys are supported.

  ### Create a proxy server {#create-proxy}

  {% list tabs group=instructions %}

  - Management console {#console}

    1. In the [management console]({{ link-console-main }}), select your folder.
    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
    1. In the left-hand panel, select ![domain-protection-icon](../../_assets/smartwebsecurity/domain-protection-icon.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection }}**.
    1. Click **{{ ui-key.yacloud.smart-web-security.ProxyServers.createProxyServer_jatYQ }}**.
    1. Enter a name for the proxy server, e.g., `test-proxy`.
    1. Enable the **Log requests** option.
    1. Select an existing log group or [create a new one](../../logging/operations/create-group.md).
    1. Click **{{ ui-key.yacloud.smart-web-security.ProxyServerFormCreate.createServer_sycVk }}**.

        {% include [after-proxy-create](../../_includes/smartwebsecurity/after-proxy-create.md) %}

  {% endlist %}

  ### Add a domain {#add-domain}

  {% list tabs group=instructions %}

  - Management console {#console}

    1. In the left-hand menu, go to the ![globe](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection-domains }}** tab and click **{{ ui-key.yacloud.smart-web-security.ProxyServer.Domains.createDomain_49MGX }}**.
    1. Enter the address of the domain your web application is in, e.g., `example.com`.
    1. Click **{{ ui-key.yacloud.common.continue }}**.
    1. Select the connection type used by your application. We recommend the secure **{{ ui-key.yacloud.smart-web-security.DomainForm.ConnectionSection.https_qWPJb }}** protocol.
    1. If you use [{{ certificate-manager-name }}](../../certificate-manager/) and have added your domain certificate to it, select it from the list. 
    1. If not using {{ certificate-manager-name }}, click **{{ ui-key.yacloud.common.create }}** → **{{ ui-key.yacloud.certificate-manager.CertificateField.userCertificate_bChXn }}**.
       1. Enter a name for the certificate.
       1. Copy or upload the private key, certificate, and intermediate certificate chain as a file in PEM format.
       1. Click **{{ ui-key.yacloud.certificate-manager.CertificateImportDialog.createCertificate_x7Ww3 }}**.
    1. Click **{{ ui-key.yacloud.common.continue }}**.

    1. Under **{{ ui-key.yacloud.smart-web-security.DomainForm.TargetResourcesSection.targetResources_hqBQm }}**, set up the targets:
       1. IP address and port your web application runs on.
       1. Optionally, expand the **{{ ui-key.yacloud.smart-web-security.DomainForm.TargetResourcesSection.connectTargetResources_1mGNK }}** section to select the protocol your web application runs on.
    1. Click **{{ ui-key.yacloud.smart-web-security.CreateDomain.createDomain_b2Ykj }}**.

    After you create a domain, the domain parameters overview page will open. Under **{{ ui-key.yacloud.smart-web-security.Domain.Overview.howToActivateProtection_dK3yy }}**, copy the proxy server IP address, as you will need it in the next step.

  {% endlist %}

  ### Set up your infrastructure {#infrastructure-settings}

  1. {% include [create-proxy-a-record](../../_includes/smartwebsecurity/create-proxy-a-record.md) %}
  1. {% include [limit-traffic-to-yc](../../_includes/smartwebsecurity/limit-traffic-to-yc.md) %}

  ### Check your resource status {#check-status}

  {% list tabs group=instructions %}

  - Management console {#console}

    {% include [validate-resource-stats](../../_includes/smartwebsecurity/validate-resource-stats.md) %}

  {% endlist %}

{% endlist %}

## Set up DDoS and anti-bot protection {#antiddos-antibot-protection}

### Create a security profile {#security-profile-create}

{% include [setting-by-expert](../../_includes/smartwebsecurity/setting-by-expert.md) %}

This guide uses a ready-made security profile template.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the protected resources are in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/profiles.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
  1. Click **{{ ui-key.yacloud.smart-web-security.action_empty }}** and select **{{ ui-key.yacloud.smart-web-security.title_default-template }}**.

      A preset profile includes:

      * [Basic default rule](../../smartwebsecurity/concepts/rules.md#base-rules) enabled for all traffic with the `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}` [action type](../../smartwebsecurity/concepts/rules.md#rule-action).
      * [Smart Protection rule](../../smartwebsecurity/concepts/rules.md#smart-protection-rules), `sp-rule-1`, enabled for all traffic with the `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}` action type.
   
  1. Enter a name for the profile, e.g., `site-protection`.

  1. Enable test mode for the `sp-rule-1` Smart Protection rule:
     1. For **{{ ui-key.yacloud.smart-web-security.form.label_default-action }}**, select `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}`.
     1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to `sp-rule-1` and select **{{ ui-key.yacloud.smart-web-security.overview.action_edit-profile }}**.
     1. Enable **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**.
     1. Click **{{ ui-key.yacloud.common.save-changes }}**.

      {% note info %}

      Rules in a security profile apply based on the first triggered rule in the priority order. Rules in the **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}** mode do not actually apply. Logs only collect the information on possible rule triggering. That is why the first triggered rule will be the basic default rule with the `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}` action type. This will block all traffic to your resource. To prevent this, switch the basic default rule to the `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}` mode.

      You will be charged for the traffic handled by the rules in the **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}** mode. For more information, see [{#T}](../../smartwebsecurity/pricing.md).
      
      {% endnote %}

  1. Optionally, set up security policies for API calls.
   
      If your service additionally handles requests to a public API, set up an additional Smart Protection rule with the `API protection` action. In contrast to full protection, in this mode, requests are not sent to {{ captcha-name }} for an additional check for automated traffic. To do this, enable the **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}** mode for this rule as well.

     1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
     1. Enter a name for the rule, e.g., `api-protection`.
     1. Set a higher priority than that of the full protection rule, e.g., `900000`.
     1. Enable **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**.
     1. Specify the rule settings:
        * **Rule type**: `{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}`.
        * **Action**: `API protection`.
        * **Traffic**: `On condition`.
        * **Conditions**: `Request URI`.
        * **Request path**: Relative path for requests to the API. Let’s assume your primary domain is `example.com`, and requests to the API are received at `example.com/api`. In this case, select `Starts with` as a condition and specify this path: `/api`.
     1. Click **{{ ui-key.yacloud.smart-web-security.action_empty }}**.
  
  1. Under **{{ ui-key.yacloud.component.disallow-data-processing.title_ml-model-training }}**, consent to the use of HTTP request information to tune machine learning models. Otherwise, {{ sws-name }} will not get data for investigating security incidents.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Set up filtering by IP address lists {#list-filters}

[IP address lists](../../smartwebsecurity/concepts/lists.md) allow you to optimize traffic checks by allowing requests from trusted (white) addresses. You can instantly block unsecure or questionable addresses or redirect their requests to {{ captcha-name }}.

{{ sws-name }} has pre-installed lists of untrusted (black) IP addresses. You can manually add lists of white addresses, e.g., addresses of your counterparties or partners. You can also add your own lists of black addresses.

{% list tabs group=instructions %}

- Management console {#console}

  1. Add your own black and white address lists.

     1. In the left-hand panel, select **{{ ui-key.yacloud.smart-web-security.match-lists.label_match-lists }}**.
     1. Click **{{ ui-key.yacloud.smart-web-security.match-lists.label_create-list }}**.
     1. Enter a name for the list, e.g., `my-partners`, and click **{{ ui-key.yacloud.smart-web-security.match-lists.label_create-match-list }}**.
     1. Click **{{ ui-key.yacloud.smart-web-security.match-lists.ip-list_add-addresses }}**.
     1. Enter or upload a list of white addresses that you do not need to filter.
     1. Click **{{ ui-key.yacloud.common.save-changes }}**.
     1. If needed, add a list of black addresses.
  
  1. Configure a rule for blocking by IP address lists.
     1. In the left-hand panel, select **{{ ui-key.yacloud.smart-web-security.title_profiles }}** and select the `site-protection` profile.
     1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
     1. Enter a name for the rule, e.g., `block-by-list`.
     1. Set a higher **{{ ui-key.yacloud.smart-web-security.overview.column_priority }}** than that of the Smart Protection rules, e.g., `9100`.
     1. Enable **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**.
     1. Specify the rule settings:
        * **{{ ui-key.yacloud.smart-web-security.overview.column_type }}**: `{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}`.
        * **{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}**: `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}` or `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-captcha }}`.
        * **Traffic**: `On condition`.
        * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}**: `{{ ui-key.yacloud.component.condition-column.condition_name-ip-range }}`.
        * **Conditions for IP**: `IP belongs to the list`.
        * Select the `is_ddoser` list (IP addresses used in DDoS attacks). Requests from these addresses will be blocked.
        * To add another list, click **+ or** and select a list.
  
          Add pre-installed `is_tor` lists (IP addresses of the Tor network used for traffic anonymization), `is_anonimous` (IP addresses of anonymous networks frequently used to hide one’s identity), and your own black lists.
       1. Click **{{ ui-key.yacloud.common.add }}**.

  1. Set up an allowing rule to allow all requests from white IP addresses.
     1. In the `site-protection` profile, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
     1. Enter a name for the rule, e.g., `allow-by-list`.
     1. Set a higher **{{ ui-key.yacloud.smart-web-security.overview.column_priority }}** than that of the blocking rule for black lists, e.g., `9000`.
     1. Enable **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**.
     1. Specify the rule settings:
        * **{{ ui-key.yacloud.smart-web-security.overview.column_type }}**: `{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}`.
        * **{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}**: `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}`.
        * **Traffic**: `On condition`.
        * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}**: `{{ ui-key.yacloud.component.condition-column.condition_name-ip-range }}`.
        * **Conditions for IP**: `IP belongs to the list`.
        * Select the white address lists you created earlier.
     1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

### Set up filtering by regions {#region-filters}

If your service does not expect traffic from certain countries, you can set up policies to handle such traffic, e.g., block it or redirect it to captcha.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the `site-protection` profile, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
  1. Enter a name for the rule, e.g., `block-by-geo`.
  1. Enable **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**.
  1. Set a higher **{{ ui-key.yacloud.smart-web-security.overview.column_priority }}** than that of the Smart Protection rules, but lower than that of the rules for IP address lists, e.g., `9200`.
  1. Specify the rule settings:
      * **{{ ui-key.yacloud.smart-web-security.overview.column_type }}**: `{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}`.
      * **{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}**: `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}` or `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-captcha }}`.
      * **Traffic**: `On condition`.
      * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}**: `{{ ui-key.yacloud.component.condition-column.condition_name-ip-range }}`.
      * **Conditions for IP**: `IP belongs to the region`.
      * Select a region where your service is not available, e.g., `CN`, `US`, or `IN`.
  
         To add another region, click **+ or**.

      {% note tip %}

      If your service operates only in certain regions, select the `IP does not belong to the region` condition. In the list, specify the target region, e.g., `RU`. Traffic from other regions will be blocked.

      You can check the region of an IP address at [ipinfo.io](https://ipinfo.io/) or with an [ASN provider](https://en.wikipedia.org/wiki/Autonomous_system_(Internet)).

      {% endnote %}

   1. Click **{{ ui-key.yacloud_billing.common.add }}**.

{% endlist %}

### Set up an allowing rule for captcha {#captcha-rule}

An allowing rule for {{ captcha-name }} is requred in case the `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}` action is set for the default basic rule and the requests are sent to {{ captcha-name }} for verification.

1. In the left-hand panel, click ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}** and select `site-protection`.
1. {% include [allow-captcha](../../_includes/smartwebsecurity/allow-captcha.md) %}

{% include [allow-path-captcha](../../_includes/smartwebsecurity/allow-patch-captcha.md) %}

### Check the sequence in which the rules will apply {#rules-execution-order}

Security profile rules apply to all traffic according to the priority: the lower the number, the higher the priority. The sequence in which the rules will apply is provided in the table below.

Priority | Rule name | Action | Rule description
--- | --- | --- | ---
8000 | allow-captcha | Allow | Basic for captcha
9000 | allow-by-list | Allow | Basic for white IP addresses
9100 | block-by-list | Deny | Basic for black IP addresses
9200 | block-by-geo  | Deny | Basic by regions
900000  | api-protection | API protection | Smart Protection for the public API
999900 | sp-rule-1 | Full protection | Smart Protection from a ready-made template
1000000 |  | Allow | Basic default

The `Allow` action is set for the basic default rule, while other rules are in the `Logging only` (dry run) mode. When switching rules to the real mode, set the `Deny` action for the basic default rule.

### Connect the security profile to the resources {#profile-connect}

{% list tabs group=instructions %}

- L7 load balancer {#balancer}

  To connect a virtual host in {{ alb-name }}:
  1. If the load balancer is managed by an {{ alb-name }} [ingress controller](../../application-load-balancer/tools/k8s-ingress-controller/index.md), use the [ingress resource annotation](../../application-load-balancer/k8s-ref/ingress.md#annot-security-profile-id).
  1. If the load balancer is managed by you, select the created profile under ![image](../../_assets/console-icons/shield-check.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
  1. At the top right, click ![plug](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.smart-web-security.overview.action_attach-to-host }}**.
  1. In the window that opens, select the following in the given order:

     * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_balancer }}**](../../application-load-balancer/concepts/application-load-balancer.md).
     * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_http-router }}**](../../application-load-balancer/concepts/http-router.md).
     * [**{{ ui-key.yacloud.smart-web-security.attach-dialog.label_virtual-host }}**](../../application-load-balancer/concepts/http-router.md#virtual-host). You can associate the security profile with multiple virtual hosts at once.

      To associate the profile with another L7 load balancer, click **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_add-balancer }}**.

  1. Click **{{ ui-key.yacloud.smart-web-security.attach-dialog.action_connect }}**.

    You will see the associated virtual host under **{{ ui-key.yacloud.smart-web-security.overview.title_connected-to-the-hosts }}**.

- API gateway {#api-gateway}
  
  To connect an API gateway:
  1. Under ![image](../../_assets/console-icons/shield-check.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**, copy the ID of the profile you need.
  1. Specify the [x-yc-apigateway:smartWebSecurity](../../api-gateway/concepts/extensions/sws.md) extension when creating an API gateway or in the existing API gateway specification.
  1. Specify the copied ID in the extension.

- Domain {#domain}

  To connect a domain:
  1. Under ![domain-protection-icon](../../_assets/smartwebsecurity/domain-protection-icon.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection }}** → ![globe](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection-domains }}**, select the required domain.
  1. In the top menu, click ![plug-connection](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.smart-web-security.DomainsTable.connectSecurityProfile_g5MA4 }}** and select the `site-protection` security profile.

{% endlist %}

### Test your security profile in logging mode {#test-sp-rules}

{% note info %}

Keep the rules in the **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}** mode for a few days. This will help you detect false positives, while your service will continue to operate.

{% endnote %}

To see how the security profile rules work, check the logs.

{% list tabs group=instructions %}

- L7 load balancer {#balancer}

  1. Make sure that [logging](../../smartwebsecurity/operations/configure-logging.md) is configured.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
  1. Select the load balancer with an associated security profile.
  1. {% include [log-requests](../../_includes/smartwebsecurity/log-requests.md) %}

- API gateway {#api-gateway}
  
  1. Make sure that [logging](../../api-gateway/operations/api-gw-logs-write.md) is configured.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Select the API gateway with an associated security profile.
  1. {% include [log-requests](../../_includes/smartwebsecurity/log-requests.md) %}

- Domain {#domain}

  1. Make sure that [logging](../../smartwebsecurity/operations/proxy-create.md) is configured.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![domain-protection-icon](../../_assets/smartwebsecurity/domain-protection-icon.svg) **{{ ui-key.yacloud.smart-web-security.label_domain-protection }}**.
  1. Select the proxy server your security profile is associated with.
  1. {% include [log-requests](../../_includes/smartwebsecurity/log-requests.md) %}

{% endlist %}

For more information about working with logs, see [{#T}](../../smartwebsecurity/operations/configure-logging.md).

After testing the rules, make the required adjustments and test the rules again in the **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}** mode.

### Test your security profile in real mode {#check-sp-rules}

Once you make sure the rules work correctly:
  1. Disable the **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}** mode for all security profile rules.
  1. Set the `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}` action for the basic default rule.

Use logs and monitoring charts to check the performance of your rules:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Select **{{ ui-key.yacloud.common.monitoring }}**.
  1. Examine the data displayed on the charts:
     * **Denied by Security Profile RPS**: Number of incoming requests per second the security profile has checked and blocked.
     * **Redirected to SmartCaptcha RPS**: Number of incoming requests per second routed to {{ captcha-name }} for additional verification.

{% endlist %}

For detailed description of charts, see [{#T}](../../smartwebsecurity/operations/monitoring.md).

## Set up load limitations {##rate-limiter}

After setting up and testing a security profile, set limitations for the number of requests. This will keep your service alive in case of accidental traffic spikes or request flooding during DDoS attacks.

Request limitations are set in an advanced rate limiter (ARL) profile. It runs checks after the security profile and only works with the traffic that passed the initial verification. Unlike security profile rules, ARL rules can be triggered simultaneously. In this case, a higher priority rule applies to the traffic.

To set a request limitation, estimate your standard service load first. If you use an L7 load balancer, you can do this in {{ alb-name }} under **{{ ui-key.yacloud.common.monitoring }}**. The **RPS** chart displays the total number of incoming requests per second the load balancer receives. Set the request limit with a small margin. Instead of setting a limit for the whole traffic, you can set one by certain [conditions](../../smartwebsecurity/concepts/conditions.md), e.g., by region, by IP address range or list, by request address, etc.

### Create an ARL profile {#arl-create}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the security profile.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/arl.svg) **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}** and click **{{ ui-key.yacloud.smart-web-security.arl.label_create-profile }}**.
  1. Enter a name for the profile, e.g., `arl-site-protection`.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Set up ARL rules {#arl-configure-rules}

{% list tabs group=instructions %}

- Management console {#console}

  1. On the ARL profile page, click ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
  1. Enter a name for the rule, e.g., `arl-rule-1`.
  1. In the **{{ ui-key.yacloud.smart-web-security.arl.column_rule-priority }}** field, set the rule triggering priority, e.g., `1000`. 
  
     Since all ARL profile rules apply after the security profile rules, this priority applies only to ARL rules and is independent of the rule priority in the security profile.
  1. Enable the `dry run (logging only)` mode.
  1. Under **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rule-condition-section }}**, select `All traffic` or `On condition`.
  1. Optionally, specify [traffic conditions](../../smartwebsecurity/concepts/conditions.md) to apply the rule by.

  1. Under **Request counting**, select how to count requests for limiting:

      * `{{ ui-key.yacloud.smart-web-security.arl.label_rule-without-grouping }}`: Count each request separately.
      * `Grouping by property`: Count the number of request groups sharing one or more properties.
      1. Optionally, enable **Case-sensitive** to put properties with the same values but in different cases into separate groups.

  1. Specify the request limit and select the time interval, e.g., `1000` per `1` minute.
  1. Click **{{ ui-key.yacloud.smart-web-security.arl.label_save-rule }}**.

{% endlist %}

### Add your ARL profile to the security profile {#arl-add-to-profile}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/profiles.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
  1. Open the `site-protection` security profile.
  1. Click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. From the list of ARL profiles, select `arl-site-protection`.
  1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

### Test the ARL rules {#test-arl-rules}

You usually need to test ARL rules only once, and then you can switch the real mode protection. However, in certain cases, rules might require more testing and adjustment.

You can use [{{ load-testing-name }}](../../load-testing/) to perform a load test. For more information on configuring HTTP load, see [{#T}](../../load-testing/tutorials/loadtesting-https-phantom.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the L7 load balancer, API gateway, or proxy server your security profile is associated with.
  1. Select **{{ ui-key.yacloud.common.logs }}**.
  1. In the **Query** row, specify your query for ARL rule search and click **Run**.

      Request examples:

      * Show requests blocked by the ARL profile rules (in logging mode):
        ```
        json_payload.smartwebsecurity.dry_run_advanced_rate_limiter.verdict = DENY
        ```
      * Similar request without the logging mode:
        ```
        json_payload.smartwebsecurity.advanced_rate_limiter.verdict = DENY
        ```
{% endlist %}

After disabling the **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}** mode, use logs and monitoring charts to check the performance of your profile.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Select **{{ ui-key.yacloud.common.monitoring }}**.
  1. Examine the data displayed on the charts:
     * **Allowed by ARL Profile RPS**: Number of incoming requests per second not exceeding the ARL profile limit.
     * **Denied by ARL Profile RPS**: Number of incoming requests per second exceeding the ARL profile limit and blocked.

{% endlist %}

## Set up the web application firewall {#firewall}

A web application firewall (WAF) protects your web apps from various vulnerability exploits and requires fine tuning depending on the specific features of your service.

When creating a WAF profile, the pre-installed [OWASP Core Ruleset](https://coreruleset.org/) is added to it, and you need to tailor it to your service. You may need to disable certain rules to prevent false positives and create exclusion rules. Since every service is unique, configuring these might take a while.

To optimize {{ sws-name }} performance, you can set up WAF checks only for certain routes instead of all traffic.

A WAF profile is connected to the security profile as a rule along with basic and Smart Protection rules. WAF rules must have a higher priority than that of the Smart Protection rules. In case incoming traffic conditions for a WAF rule and a Smart Protection rule match, you can disable Smart Protection since the {{ sws-name }} architecture is designed to always apply a Smart Protection rule before a WAF rule.

In the WAF rule, you must configure two parameters:

* **Paranoia level**: Determines the number of active rules. The higher the paranoia level, the more checks will be made. The first paranoia level is for the most precise rules that produce the lowest number of false positives. In test mode, start from the first level and gradually move up.

* **Anomaly threshold**: Total threat score of a request. The score grows with each triggered rule, and once it exceeds the threshold, the request gets blocked. Start from the threshold of `25` and gradually reduce it.

  You can set any rule you deem critical for the serivce as a blocking rule. In this case, requests that trigger this rule get blocked regardless of the total score.

To avoid false positives for your service, you can create exclusions for all or specific rules.

### Create a WAF profile {#waf-create}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the security profile.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Go to the ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}** tab and click **{{ ui-key.yacloud.smart-web-security.waf.label_create-profile }}**.
  1. Enter a name for the profile, e.g., `waf-site-protection`.
  1. By default, the WAF profile uses the [OWASP Core Rule Set](https://coreruleset.org/). To view the rules it includes, click the row with its description.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Configure a basic rule set {#waf-configure-rules}

{% list tabs group=instructions %}

- Management console {#console}

  1. On the WAF profile page, click **{{ ui-key.yacloud.smart-web-security.waf.action_setup-base-rules }}**.
  1. Set the **{{ ui-key.yacloud.smart-web-security.waf.label_anomaly-threshold }}**, which is the total [anomaly](../../smartwebsecurity/concepts/waf.md#anomaly) score of triggered rules that results in blocking the request, e.g., `{{ ui-key.yacloud.smart-web-security.waf.label_anomaly-medium }}`.

      We recommend that you start with an anomaly threshold of `25` and gradually reduce it to `5`. To reduce the anomaly threshold, address WAF false positives triggered by legitimate requests. To do so, select rules from the basic set and configure exclusion rules.
  1. Set **{{ ui-key.yacloud.smart-web-security.waf.label_paranoia-level }}** to `{{ ui-key.yacloud.smart-web-security.waf.label_paranoia-option-1 }}`.

      The [paranoia level](../../smartwebsecurity/concepts/waf.md#paranoia) classifies rules based on how aggressive they are. The higher the paranoia level, the better the protection, but also the greater the risk of WAF false positives.
  1. Check the rules you included in the set. Add or delete them as needed. When using rules, pay attention to their anomaly scores and paranoia levels.

  1. If needed, set one or multiple rules as blocking ones by clicking ![image](../../_assets/console-icons/ban.svg) to the right of the rule. Requests matching such a rule get blocked regardless of the anomaly threshold you set.

{% endlist %}

### Create an exclusion rule {#create-exclusion}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the ![image](../../_assets/console-icons/file-xmark.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_exclusion-rules }}** tab and click **{{ ui-key.yacloud.smart-web-security.waf.label_create-exclusion-rule }}**.
  1. Enter a name for the [exclusion rule](../../smartwebsecurity/concepts/waf.md#exclusion-rules), e.g., `exception-rule-1`.
  1. Under **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rule-rules-section }}**, specify rules from the basic set for which the exclusion will apply. You can either select `{{ ui-key.yacloud.smart-web-security.waf.value_exclude-all-yes }}` or specify particular rules.
  1. Under **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rule-condition-section }}**, select the triggering [conditions](../../smartwebsecurity/concepts/conditions.md) for the exclusion rule.

      If you leave the **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** field empty, the exclusion rule will apply to all traffic.

  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Add your WAF profile to the security profile {#waf-add-to-profile}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/profiles.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}**.
  1. Open the `site-protection` security profile.
  1. Click ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
  1. Enter a name for the rule, e.g., `waf-rule-1`.
  1. Set a higher priority for the rule than that of the Smart Protection rules, e.g., `1111`.
  1. Enable **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**.
  1. Select **{{ ui-key.yacloud.smart-web-security.overview.column_type }}**: `{{ ui-key.yacloud.smart-web-security.overview.label_waf-rule }}`.
  1. In the list of WAF profiles, select `waf-site-protection`.

{% endlist %}

### Test the WAF rules {#test-waf-rules}

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the L7 load balancer, API gateway, or proxy server your security profile is associated with.
  1. Select **{{ ui-key.yacloud.common.logs }}**.
  1. In the **Query** row, specify your query for WAF rule search and click **Run**.

      Request examples:

      * Show requests blocked based on the WAF profile, i.e., by the security profile WAF rules (in logging mode):
        ```
        json_payload.smartwebsecurity.dry_run_matched_rule.rule_type = WAF and json_payload.smartwebsecurity.matched_rule.verdict = DENY
        ```
      * Similar request without the logging mode:
        ```
        json_payload.smartwebsecurity.matched_rule.rule_type = WAF and json_payload.smartwebsecurity.matched_rule.verdict = DENY
        ```

{% endlist %}

Since WAF is configured for each web service individually, test WAF in logging mode for no less than a week. During this stage, you will get a lot of false positives, so you should track them in logs and adjust the rule parameters. For example, if the rule with `id920280` gets triggered incorrectly when using HTTP/2, you can disable it immediately. This rule will work correctly with HTTP/1.1.

Once WAF is configured and switched to the real mode, use logs and monitoring charts to regularly check the performance of its rules. This will allow you to track anomalies and adjust the protection specifically for your web app.

## Further configuration of security policies {#further-configuration}

Each time you update or add security profile, WAF, or ARL rules, enable the **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}** mode. Activate a rule only after the logs confirm that it works correctly. This way you will avoid false positives and ensure stable operation of your web app.