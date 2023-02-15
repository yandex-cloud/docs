# 6. Vulnerability management

#### Introduction {#intro}

{{ yandex-cloud }} is responsible for managing vulnerabilities and security updates in managed services. The client is responsible for managing vulnerabilities and security updates for all other system components.

For an example of a scope of responsibility for managing vulnerabilities and security updates, see **Requirement 5** in the [PCI DSS responsibility matrix](https://storage.yandexcloud.net/yc-compliance/certificates/PCI_DSS_responsibility_matrix-new.pdf).

#### 6.1 A vulnerability scanner is used for container images {#vulnerability-scanning}

We recommend using the image [vulnerability scanner](../../../container-registry/concepts/vulnerability-scanner.md) integrated into {{ container-registry-short-name }}.

{% list tabs %}

- Performing a check in the management console

   1. In the management console, select the cloud or folder to check the images in.
   1. From the list of services, select {{ container-registry-short-name }}.
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

You can also use a [solution](https://cloud.yandex.ru/marketplace/products/scanfactory/scanfactory) from {{ marketplace-name }}.

{% list tabs %}

- Manual check

   Run a manual check.

{% endlist %}

#### 6.3 External security scans are performed according to the cloud rules {#external-security-scans}

Customers hosting their own software in {{ yandex-cloud }} can perform external security scans for the hosted software, including penetration tests. You can run your own scans or use contractors. For more information, see [Rules for performing external security scans](../../../security/compliance/pentest.md).

{% list tabs %}

- Manual check

   Run a manual check.

{% endlist %}

#### 6.4 The process of security updates is set up {#security-updates}

A client must perform their own security updates within their scope of responsibility. Various automated tools are available for centralized automated OS and software updates.

{{ yandex-cloud }} publishes security bulletins to notify customers of newly discovered vulnerabilities and security updates.
 
#### 6.5 A Web Application Firewall is used {#firewall}

To mitigate risks associated with web attacks, we recommend using a Web Application Firewall (WAF). A client can install and maintain a WAF independently or use the Managed WAF service.

##### Installing a WAF on your own {#self-installation}

[WAF](/marketplace?tab=software&search=waf) images are available from the [{{ marketplace-full-name }}](/marketplace). License types and other required information are available in the product descriptions.

[Solution: A fault-tolerant installation of PT Application Firewall built on {{ yandex-cloud }}](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/vuln-mgmt/unmng-waf-ptaf-cluster)

You can also install Wallarm WAF in [{{ managed-k8s-name }}](../../../managed-kubernetes/). See the [instructions](https://docs.wallarm.com/admin-en/installation-kubernetes-en/) in the Wallarm documentation. This is a BYOL licensing model (a license purchased from a third-party vendor).

##### Managed WAF {#managed-waf}

A customer receives a cloud WAF as a service from {{ yandex-cloud }}. They are provided access to a personal account and the ability to view statistics and perform management. To activate the service and get detailed information, contact your account manager, the [sales department](https://cloud.yandex.ru/#contact-form), or [support]({{link-console-support}}?section=contact). The service is provided in partnership with Qrator.

[Solution: Installing a damn vulnerable web application (DVWA) in {{ yandex-cloud }} using {{ TF }} to test Managed WAF](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/vuln-mgmt/vulnerable-web-app-waf-test)

{% list tabs %}

- Performing a check in the management console

   1. In the management console, select the cloud or folder to check the images in.
   1. From the list of services, select {{ compute-short-name }}.
   1. Make sure there is at least one VM with a WAF image.

- Manual check

   Contact your account manager from the Yandex Cloud team or your company's information security service to find out if Managed WAF is used for your organization.

{% endlist %}
