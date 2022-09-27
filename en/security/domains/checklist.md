# Security checklist

## Network security {#network-security}

* **Segmentation**: Split resources into groups and put them in different folders or, if strict isolation is required, different {{ vpc-short-name }}s. Traffic inside a {{ vpc-short-name }} is allowed by default and is not allowed between {{ vpc-short-name }}s (only via VMs with two network interfaces in different networks, VPN or {{ interconnect-full-name }}). Watch our webinar [How a network works in {{ yandex-cloud }}](https://www.youtube.com/watch?v=g3cZ0o50qH0).
* **Network access restriction, security groups**: Restrict network access across resources using [security groups](../../vpc/operations/security-group-create.md).



  ![](../../_assets/overview/solution-library-icon.svg)[Solution: Setting up security groups (dev/stage/prod) using {{ TF }}](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/segmentation)
* **NGFW from {{ marketplace-short-name }}**: If more robust network protection is required, use [NGFW](/marketplace?tab=software&search=NGFW) from {{ marketplace-full-name }}.
  ![](../../_assets/overview/solution-library-icon.svg)[Solution: Installing an NGFW on a {{ yandex-cloud }} VM: Check Point](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/checkpoint-1VM)


* **Secure access from outside the cloud infrastructure (VPN)**: If you need remote access to cloud resources, configure a site-to-site VPN (see the [setup instructions using the strongSwan daemon](../../tutorials/routing/ipsec-vpn.md))) or use the [{{ interconnect-name }}](../../interconnect/index.yaml) service (the GOST VPN service is also available).



  ![](../../_assets/overview/solution-library-icon.svg)[Solution: Creating a site-to-site VPN connection using {{ TF }}](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/vpn)


* **Secure remote administrator access (VPN)**: Set up a VPN connection between remote devices and {{ yandex-cloud }} using solutions from {{ marketplace-name }}. See the [setup instructions](../../tutorials/routing/openvpn.md) for [OpenVPN](/marketplace/products/yc/openvpn-access-server).
* **Bastion host**: Create a bastion VM to access the infrastructure using control protocols (for example, SSH or RDP).
* **Outgoing access (NAT)**: Use the [built-in NAT service](../../vpc/operations/enable-nat.md) for secure outgoing internet access (egress NAT). This service translates your addresses into a shared address pool. If internet access should be from your controlled address pool, use a [NAT instance](../../tutorials/routing/nat-instance.md#create-nat-instance) (a dedicated VM).



* **DDoS protection**: When assigning public IP addresses to your cloud resources, use the built-in [{{ ddos-protection-full-name }}](../../vpc/ddos-protection/index.md) component by clicking the button (L4 DDoS protection). If you need L7 DDoS protection, contact your manager.


## Authentication and access control {#authentication}

* **Centralized management and identity federations**: Create an organization in [{{ org-full-name }}](https://cloud.yandex.com/services/organization) and set up Single Sign-On in {{ yandex-cloud }} via your IdP server. See the setup instructions for [AD FS](../../organization/operations/federations/integration-adfs.md), [Keycloak](https://www.youtube.com/watch?v=m-oe7V9PvC4), and [Google Workspace](../../organization/operations/federations/integration-gworkspace.md).
* **Federated accounts**: Use federated accounts instead of Yandex accounts whenever possible.
* **Principle of least privilege**: Assign service roles (for example, `compute.images.user`) instead of primitive roles (`viewer`, `editor`, or `admin`). See a [list of all roles](../../iam/concepts/access-control/roles.md) and [examples of assigning roles](../../iam/operations/roles/grant.md). Watch our webinar [Managing cloud access permissions](https://www.youtube.com/watch?v=7VwSfPZ6eRM&t=3s).
* **{{ TF }} {{ yandex-cloud }} {{ iam-full-name }} module**: Organize access groups for cloud users.



  ![](../../_assets/overview/solution-library-icon.svg)[Solution: {{ iam-name }} in {{ TF }} for {{ yandex-cloud }}](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auth_and_access/iam#identity-and-access-management-iam-terraform-module-for-yandexcloud)


* **Working with service accounts**: [Assign a service account to a VM instance](../../compute/operations/vm-connect/auth-inside-vm.md) and get a token using the metadata service. Set up a local firewall on the VM instance so that only the necessary processes and system users have access to the metadata service (IP address: 169.254.169.254).
* **2FA** For an identity federation, set up 2FA on the side of your IdP. For a Yandex account, set up 2FA using the [instructions](https://yandex.com/support/id/authorization/twofa.html).
* **billing.accounts.owner protection**: After performing the initial operations, don't use an account with this role. To manage a billing account, assign the `admin`, `editor`, or `viewer` role for the billing account to a specific employee with a federated account.
* **resource-manager.clouds.owner protection**: Assign the `resource-manager.clouds.owner `role to employees with federated accounts. Set a strong password for the Yandex account that was used to create the cloud, and use it only when absolutely necessary. Grant administrators less privileged access and use `resource-manager.clouds.owner` only when absolutely necessary.
* **Resource model**: Place all critical resources that must be compliant with standards in a separate cloud. Divide resource groups by folders. Host shared resources (such as network and security groups) in a separate shared resource folder.

## Data encryption and key/secret management {#data-encryption}



* **Encryption in {{ objstorage-full-name }}**: Enable bucket encryption (server-side encryption). See the [instructions](../../storage/operations/buckets/encrypt.md). This encryption protects bucket data from being published on the internet.
* **VM disk encryption (if required)**.
  ![](../../_assets/overview/solution-library-icon.svg)[Solution: VM disk encryption using {{ kms-full-name }}](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/encrypt_and_keys/encrypt_disk_VM)


* **Client-side encryption (if required)**: Use data encryption with {{ kms-name }} keys. See an [overview of encryption methods](../../kms/tutorials/encrypt/index.md).
* **{{ kms-name }} key protection**: Grant only granular access to individual {{ kms-name }} keys — the `kms.keys.encrypterDecrypter` role. Use [key rotation](../../kms/concepts/version.md).
* **Secret management**: Use secret management services, such as [{{ lockbox-name }}](../../lockbox/index.yaml) or [HashiCorp Vault with {{ kms-name }} support](/marketplace/products/f2eokige6vtlf94uvgs2) from {{ marketplace-name }}.

## Secure configuration {#secure-configuration}

* **Default passwords**: Keep track of default passwords in VM software organizationally and technically using various vulnerability scanners.
* **Standards and baseline**: Configure the OS and software in accordance with the baseline and standards (such as CIS and PCI DSS). To automate compliance, use, for example, [OpenSCAP](https://www.open-scap.org/getting-started/).
* **Disabling the serial console**: Don't use the serial console, but if you must, [evaluate your risks](../../compute/operations/serial-console/index.md) and disable it when you finish.
* **Safe use of {{ TF }}**: Use `terraform remote state` based on {{ objstorage-name }} with a lock function in {{ ydb-full-name }}. See a [setup example](https://github.com/yandex-cloud/examples/tree/master/terraform-ydb-state). Set [sensitive = true](https://www.terraform.io/docs/language/values/outputs.html#sensitive-suppressing-values-in-cli-output) if required. Don't transfer private data to the configuration, but if you must, use secret management services or environment variables. [Read more](https://blog.gruntwork.io/a-comprehensive-guide-to-managing-secrets-in-your-terraform-code-1d586955ace1#:~:text=this%20blog%20post%3A-,Do%20not%20store%20secrets%20in%20plain%20text.,secrets%20into%20your%20Terraform%20code).
* **Integrity control on guest OS**: Use free host-based solutions, such as Wazuh or Osquery, or paid solutions from {{ marketplace-name }}, such as [Kaspersky Security](/marketplace?search=Kaspersky+Security).



* **Secure configuration of {{ ydb-name }}**: Use encryption, [bucket policies](../../storage/concepts/policy.md), and ACLs, or [versioning for deletion protection](../../storage/concepts/versioning.md), enable [built-in access auditing](../../storage/operations/buckets/enable-logging.md) and configure CORS (if necessary).
  ![](../../_assets/overview/solution-library-icon.svg)[Solution: Secure configuration of {{ objstorage-name }} in {{ TF }}](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/configuration/hardering_bucket)

* **Secure configuration of {{ sf-full-name }}**: Provide a service account token via the [native authentication mechanism](../../functions/operations/function-sa.md) using the assigned service account and metadata. If possible, use [private functions](../../functions/operations/function-public.md).


* **Secure configuration of {{ container-registry-full-name }}**: We do not recommend using privileged containers to run loads. Use the built-in image [vulnerability scanner](../../container-registry/tutorials/image-auto-scan.md).
* **{{ certificate-manager-full-name }}**: Use [{{ certificate-manager-name }](../../certificate-manager/index.yaml) to store, receive, and update TLS certificates from Let's Encrypt® and to upload your own certificates. The service is integrated with {{ objstorage-name }}, {{ api-gw-full-name }}, and {{ alb-full-name }}.

## Protection against malicious code {#malicious-code-protection}

* **OS-level protection**: Install antivirus solutions from [{{ marketplace-name }}](/marketplace?categories=security) on VMs.



  ![](../../_assets/overview/solution-library-icon.svg)[Solution: Deploying Kaspersky Antivirus in {{ yandex-cloud }} ({{ compute-full-name }}, {{ coi }})](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/malware-defense/kaspersy-install-in-yc)


* **Network-level protection**: Use NGFW/IDS/IPS available in [{{ marketplace-name }}](/marketplace?categories=security) (some of them have built-in sandboxes).
* **Container image-level protection**: Use the image vulnerability scanner integrated with {{ container-registry-name }}.

## Managing vulnerabilities {#vulnerability-management}

* **Automated vulnerability scanning**: Use free network scanners, such as nmap, OpenVAS, and OWASP ZAP, or host-based solutions, such as Wazuh and Tripwire.
* **External security scans**: Perform scans according to the[ rules](../compliance/pentest.md).
* **Software and OS updates**: Install updates manually and use automated update tools.

* **Web Application Firewall**: Install a WAF from [{{ marketplace-name }}](/marketplace?categories=security) or use Managed WAF — contact your account manager to get access.



  ![](../../_assets/overview/solution-library-icon.svg)[Solution: PT Application Firewall built on {{ yandex-cloud }}](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/vuln-mgmt/unmng-waf-ptaf-cluster)
  ![](../../_assets/overview/solution-library-icon.svg)[Example: Installing a Damn Vulnerable Web Application (DVWA) in {{ yandex-cloud }} using {{ TF }} to test Managed WAF](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/vuln-mgmt/vulnerable-web-app-waf-test)


## Collecting, monitoring, and analyzing audit logs {#logs-analysis}

* **{{ at-full-name }}**: Enable [{{ at-name }}](../../audit-trails/quickstart.md) for all clouds and folders.
* **Collecting events on the guest OS and applications side**: Collect events, for example, using [{{ mes-full-name }}](../../managed-elasticsearch/index.yaml) or free solutions, such as Osquery and Wazuh.
* **Collecting Flow logs (if required)**: For example, using NGFW from {{ marketplace-name }} or free software (options are available in service plans).
* **Exporting {{ at-name }} events to SIEM**.



  ![](../../_assets/overview/solution-library-icon.svg)[Solution: Exporting to {{ mes-name }} (ELK)](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_main)
  ![](../../_assets/overview/solution-library-icon.svg)[Solution: Exporting to ArcSight](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ArcSight)
  ![](../../_assets/overview/solution-library-icon.svg)[Solution: Exporting to Splunk](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-Splunk)

  You can export event data to any SIEM using s3fs, see the [instructions](../../storage/tools/s3fs.md).
* **Use cases**.
  ![](../../_assets/overview/solution-library-icon.svg)[Use cases and important security events in audit logs](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/_use_cases_and_searches)
* **Responding to {{ at-name }} with {{ sf-name }}**:
  ![](../../_assets/overview/solution-library-icon.svg)[Solution: Notifications and responses to {{ at-name }} security events using {{ cloud-logging-full-name }} / {{ sf-name }} + Telegram](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/trails-function-detector)


* **Regular status audit**: Use the [CLI](../../cli/index.yaml) for queries to the current state of the cloud infrastructure or the [Cloud Advisor](https://cloud.yandex.ru/blog/posts/2021/03/cloud-advisor-review) partner solution.

## Physical security {#physical-security}

* **Physical security measures**: For more information, see the [description of {{ yandex-cloud }} physical security measures](../standarts.md#physic-sec).

## Backups {#backup}



* **Regular backups**: Configure scheduled creation of disk snapshots using {{ sf-name }}, see the [tutorial](https://cloud.yandex.ru/blog/posts/2020/01/snapshot-triggers).






## Managing budgets {#budget-management}

* **Notifications for cost control**: Set up notifications for budget thresholds in Billing. See the [instructions](../../billing/operations/budgets.md).


## Incident response {#incident-response}

* **Response procedure**: Develop an incident response process. To get additional logs, follow the [data request procedure](../../support/request.md).

## Security of {{ managed-k8s-full-name }} {#kubernetes-security}

### Data encryption and key/secret management {#kubernetes-data-encryption}

* **Server-side encryption**: Enable secret encryption in etcd. See the [instructions](../../kms/tutorials/k8s.md). Do this at all times, regardless of whether you use secret management services or not.
* **Secret management**: Use [{{ lockbox-name }}](../../lockbox/index.yaml) or [HashiCorp Vault with {{ kms-name }} support](/marketplace/products/f2eokige6vtlf94uvgs2) from {{ marketplace-name }}.



  ![](../../_assets/overview/solution-library-icon.svg)[Solution: Secret management using SecretManager ({{ lockbox-name }}, Vault)](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/kubernetes-security/encrypt_and_keys/secret-management)


### Network security {#kubernetes-network-security}

* **Security groups**: Configure security groups for {{ k8s }}. See the [instructions](../../managed-kubernetes/operations/connect/security-groups.md). We don't recommend granting public access and public addresses to {{ k8s }} components.
* **Ingress controller**: To access {{ k8s }} services from outside, use a LoadBalancer (internal or external) Ingress controller (HTTPS): [Application Load Balancer Ingress Controller](../../managed-kubernetes/tutorials/alb-ingress-controller.md) (recommended) or other solutions, such as [NGINX Ingress Controller](../../managed-kubernetes/tutorials/ingress-cert-manager.md).



* **DDoS protection**: Create an IP address with DDoS protection and assign it to the service or Ingress controller.


* **Network policy**: Restrict access at the {{ k8s }} level using [Calico network policies](../../managed-kubernetes/operations/calico.md) or advanced [Cilium network policies](../../managed-kubernetes/operations/cilium.md).
* **Access only from a limited pool of addresses (if required)**: Assign security groups for the {{ alb-name }} Ingress controller and use network policies for other Ingress controllers.

### Authentication and access control {#kubernetes-authentication}

* **Access control**: Configure roles to access {{ k8s }}. See the [instructions](../../managed-kubernetes/security/index.md#sa-annotation). Control access rights of the node group's service account (the `container-registry.images.puller` role is usually enough).



  ![](../../_assets/overview/solution-library-icon.svg)[Solution: Setting up role-based models and policies in {{ managed-k8s-name }}](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/kubernetes-security/auth_and_access/role-model-example)


### Secure configuration {#kubernetes-secure-configuration}

* **Node group configuration according to baseline and standards**: Configure node groups according to standards and baseline: NIST, CIS, and other. You can use automated tools, such as kube-bench and kubescape.
* **Runtime security and policy engine**: Use runtime security solutions, such as Falco, as well as policy engine solutions, such as OPA Gatekeeper and Kyverno.



  ![](../../_assets/overview/solution-library-icon.svg)[Solution: Installing Falco and policy engine with alerts delivered to {{ mes-name }}](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_k8s)


* **Security updates**: Select a relevant [update channel](../../managed-kubernetes/concepts/release-channels-and-updates.md) and enable automatic or manual installation of updates immediately after publication in the selected channel. Also perform timely updates of your own software on node groups.
* **Distribution of pods into different node groups**: Configure node taints and tolerations + node affinity (by load and degree of privacy).

### Collecting, monitoring, and analyzing audit logs {#kubernetes-logs-analysis}



* **Collecting and analyzing {{ k8s }} audit logs and security tools**.
  ![](../../_assets/overview/solution-library-icon.svg)[Solution: Analyzing {{ k8s }} security logs in {{ mes-name }}: audit logs, policy engine, and Falco](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_k8s)

* **Collecting and analyzing audit logs of workloads and node groups**: For example, using open-source tools, such as Fluent Bit and Beats.

* **Monitoring abnormal loads**: Use [{{ monitoring-full-name }}](../../monitoring/index.yaml).


### Backups {#kubernetes-backup}

* **Backups**: Configure {{ k8s }} cluster backups in {{ objstorage-name }}. See the [instructions](../../managed-kubernetes/tutorials/backup.md). Follow the recommendations in [Secure configuration of {{ objstorage-name }}](secure-config.md#object-storage).