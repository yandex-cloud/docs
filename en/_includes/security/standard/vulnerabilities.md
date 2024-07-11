# 6. Vulnerability management


#### Introduction {#intro}

{{ yandex-cloud }} is responsible for managing vulnerabilities and security updates in managed services. The client is responsible for managing vulnerabilities and security updates for all other system components.

For an example of the scope of responsibility for managing vulnerabilities and security updates, see **Requirement 5** in the [PCI DSS responsibility matrix](https://{{ s3-storage-host }}/yc-compliance/certificates/PCI_DSS_responsibility_matrix-new.pdf).

#### 6.1 A vulnerability scanner is used for container images {#vulnerability-scanning}

We recommend using the image [vulnerability scanner](../../../container-registry/concepts/vulnerability-scanner.md) integrated into {{ container-registry-short-name }}.

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

   1. In the management console, select the cloud or folder to check the images in.
   1. In the list of services, select {{ container-registry-short-name }}.
   1. Go to each of the images and check the value of the **Scan status** column.

{% endlist %}

#### 6.2 Vulnerability scanning is performed at the cloud IP level {#ip-level}

We recommend that clients scan their own hosts for vulnerabilities. Cloud resources support the installation of custom virtual images of vulnerability scanners or software agents on hosts. There are many fee-based and free solutions for scanning.

Network scanners scan hosts that are accessible over a network. Generally, authentication can be configured on network scanners.

Examples of free network scanners:
- [Nmap](https://nmap.org/)
- [OpenVAS](https://www.openvas.org/)
- [OWASP ZAP](https://www.zaproxy.org/)

Example of a free scanner that operates as an agent on hosts: [Wazuh](https://documentation.wazuh.com/current/user-manual/capabilities/vulnerability-detection/how_it_works.html). Wazuh can also be used as a host-based intrusion detection system (IDS).

You can also use a [solution](/marketplace/products/scanfactory/scanfactory) from {{ marketplace-name }}.

{% list tabs group=instructions %}

- Manual check {#manual}

   Run a manual check.

{% endlist %}

#### 6.3 External security scans are performed according to the cloud rules {#external-security-scans}

Customers hosting their own software in {{ yandex-cloud }} can perform external security scans for the hosted software, including penetration tests. You can run your own scans or use contractors. For more information, see [Rules for performing external security scans](../../../security/compliance/pentest.md).

{% list tabs group=instructions %}

- Manual check {#manual}

   Run a manual check.

{% endlist %}

#### 6.4 The process of security updates is set up {#security-updates}

A client must perform their own security updates within their scope of responsibility. Various automated tools are available for centralized automated OS and software updates.

{{ yandex-cloud }} publishes security bulletins to notify customers of newly discovered vulnerabilities and security updates.
 
#### 6.5 A Web Application Firewall is used {#firewall}

To mitigate risks associated with web attacks, we recommend using a Web Application Firewall (WAF). A client can install and maintain a WAF independently or use the {{ sws-full-name }} WAF.

##### Installing a WAF on your own {#self-installation}

[WAF](/marketplace?tab=software&search=waf) images are available from the [{{ marketplace-full-name }}](/marketplace). License types and other required information are available in the product descriptions.

[Solution: A fault-tolerant installation of PT Application Firewall built on {{ yandex-cloud }}](https://github.com/yandex-cloud-examples/yc-webinar-pt-application-firewall-ha-operations)

You can also install Wallarm WAF in [{{ managed-k8s-name }}](../../../managed-kubernetes/). See the [guide](https://docs.wallarm.com/admin-en/installation-kubernetes-en/) in the Wallarm documentation. This is a BYOL licensing model (a license purchased from a third-party vendor).

##### {{ sws-full-name }} WAF {#managed-waf}

A client can use the [{{ sws-full-name }} WAF](../../../smartwebsecurity/concepts/waf.md). A web application firewall analyzes HTTP requests to a web app according to pre-configured rules. Based on the analysis results, certain [actions](../../../smartwebsecurity/concepts/rules.md#rule-action) are applied to HTTP requests.

You can manage the web application firewall using a _WAF profile_ that connects to the [security profile](../../../smartwebsecurity/concepts/profiles.md) as a separate [rule](../../../smartwebsecurity/concepts/rules.md).

For more information about connecting to a security profile, see [{#T}](../../../smartwebsecurity/quickstart/quickstart-waf.md).

{% list tabs group=instructions %}

- Performing a check in the management console {#console}

   1. In the management console, select the cloud or folder to check the security profile in.
   1. In the list of services, select {{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}.
   1. Check that the security profile was created with the **Web Application Firewall** rule type.

{% endlist %}
