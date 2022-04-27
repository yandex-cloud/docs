# Security checklist

## Network security {#network-security}

- **Segmentation**: Split resources into groups and put them in different folders or, if strict isolation is required, different VPCs. Traffic inside a VPC is allowed by default and is not allowed between VPCs (only via VMs with two network interfaces in different networks, VPN, or Cloud Interconnect). Watch our webinar [How a network works in {{ yandex-cloud }}](https://www.youtube.com/watch?v=g3cZ0o50qH0).
- **Network access restriction, security groups**: Restrict network access across resources using [security groups](../../../vpc/operations/security-group-create.md).
  ![](../../../_assets/overview/solution-library-icon.svg)[Solution: Setting up security groups (dev/stage/prod) using Terraform](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/segmentation)
- **NGFW from Marketplace**: If more robust network protection is required, use NGFW from [Yandex Cloud Marketplace](https://cloud.yandex.com/marketplace?categories=network).
  ![](../../../_assets/overview/solution-library-icon.svg)[Solution: Installing an NGFW on a {{ yandex-cloud }} VM: Check Point](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/checkpoint-1VM)
- **Secure access from outside the cloud infrastructure (VPN)**: If you need remote access to cloud resources, configure a site-to-site VPN. See [the setup instructions using the strongSwan daemon](../../../tutorials/routing/ipsec-vpn.md) or use [Cloud Interconnect](../../../interconnect/index.yaml) (the GOST VPN service is also available). 
  ![](../../../_assets/overview/solution-library-icon.svg)[Solution: Creating a site-to-site VPN connection to {{ yandex-cloud }} using Terraform](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/vpn)
- **Secure remote administrator access (VPN)**: Set up a VPN connection between remote devices and {{ yandex-cloud }} using solutions from [Yandex Cloud Marketplace](https://cloud.yandex.com/marketplace?categories=network). See the [setup instructions for OpenVPN](../../../tutorials/routing/openvpn.md).
- **Bastion host**: Create a bastion VM to access the infrastructure using control protocols (for example, SSH or RDP).
- **Outgoing access (NAT)**: Use the [built-in NAT service](../../../vpc/operations/enable-nat.md) for secure outgoing internet access (egress NAT). This service translates your addresses into a shared address pool. If internet access should be from your controlled address pool, use a [NAT instance](../../../tutorials/routing/nat-instance.md#create-nat-instance) (a dedicated VM).
- **DDoS protection**: When assigning public IP addresses to your cloud resources, use the built-in [DDoS protection](../../../vpc/ddos-protection/index.md) by clicking the button (L4 DDoS protection). If you need L7 DDoS protection, contact your manager.

## Authentication and access control {#authentication}

- **Centralized management and identity federations**: Create an organization in [Yandex Cloud Organization](https://cloud.yandex.com/en/services/organization) and set up Single Sign-On in {{ yandex-cloud }} via your IdP server. See the setup instructions for [AD FS](../../../organization/operations/federations/integration-adfs.md), [Keycloak](https://www.youtube.com/watch?v=m-oe7V9PvC4), and  [Google Workspace](../../../organization/operations/federations/integration-gworkspace.md).
- **Federated accounts**: Use federated accounts instead of Yandex accounts where possible.
- **Principle of least privilege**: Assign service roles (for example, `compute.images.user`) instead of primitive roles (`viewer`, `editor`, or `admin`). See a [list of all roles](../../../iam/concepts/access-control/roles.md) and [examples of assigning roles](../../../iam/operations/roles/grant.md). Watch our webinar [Access management in the cloud](https://www.youtube.com/watch?v=7VwSfPZ6eRM&t=3s).
- **Terraform Yandex Cloud IAM module**: Organize access groups for cloud users.
  ![](../../../_assets/overview/solution-library-icon.svg)[Solution: IAM in Terraform for {{ yandex-cloud }}](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auth_and_access/iam#identity-and-access-management-iam-terraform-module-for-yandexcloud)
- **Working with service accounts**: Apply the mechanism of [assigning a service account to a VM](../../../compute/operations/vm-connect/auth-inside-vm.md) and getting a token via the metadata service. Set up a local firewall on the VM instance so that only the necessary processes and system users have access to the metadata service (IP address: 169.254.169.254).
- **2FA**: For an identity federation, set up 2FA on the side of your IdP. For a Yandex account, follow the [instructions](https://yandex.com/support/id/authorization/twofa.html).
- **billing.accounts.owner protection**: After performing the initial operations, don't use an account with this role. To manage a billing account, assign the `admin`, `editor`, or `viewer` role for the billing account to a specific employee with a federated account.
- **resource-manager.clouds.owner protection**: Assign the `resource-manager.clouds.owner` role to employees with federated accounts. Set a strong password for the Yandex account that was used to create the cloud, and use it only when absolutely necessary. Grant administrators less privileged access and use `resource-manager.clouds.owner` only when absolutely necessary.
- **Resource model**: Place all critical resources that must be compliant with standards in a separate cloud. Divide resource groups by folders. Host shared resources (such as network and security groups) in a separate shared resource folder.

## Data encryption and key/secret management {#data-encryption}

- **Encryption in Object Storage**: Enable bucket encryption (server-side encryption). See the [instructions](../../../storage/operations/buckets/encrypt.md). This encryption protects bucket data from being published on the internet.
- **VM disk encryption (if required)**.
  ![](../../../_assets/overview/solution-library-icon.svg)[Solution: VM disk encryption using KMS](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/encrypt_and_keys/encrypt_disk_VM)
- **Client-side encryption (if required)**: Use data encryption using KMS keys. See an [overview of encryption methods](../../../kms/tutorials/encrypt/index.md).
- **KMS key protection**: Grant only granular access to individual KMS keys — the `kms.keys.encrypterDecrypter` role. Use [key rotation](../../../kms/concepts/version.md).
- **Secret management**: Use secret management services, such as [Yandex Lockbox](../../../lockbox/index.yaml) or [HashiCorp Vault with Yandex KMS support](https://cloud.yandex.com/marketplace/products/f2eokige6vtlf94uvgs2) from Yandex Cloud Marketplace. 

## Secure configuration {#secure-configuration}

- **Default passwords**: Keep track of default passwords in VM software organizationally and technically using various vulnerability scanners.
- **Standards and baseline**: Configure the OS and software in accordance with the baseline and standards (such as CIS and PCI DSS). To automate compliance, use, for example, [OpenSCAP](https://www.open-scap.org/getting-started/).
- **Disabling the serial console**: Don't use a serial console, but if you must, [evaluate your risks](../../../compute/operations/serial-console/index.md) and disable it when you finish.
- **Safe use of Terraform**: Use `terraform remote state` based on Yandex Object Storage with a lock function in {{ ydb-full-name }}. See a [setup example](https://github.com/yandex-cloud/examples/tree/master/terraform-ydb-state). Use the [sensitive = true](https://www.terraform.io/docs/language/values/outputs.html#sensitive-suppressing-values-in-cli-output) parameter, if required. Don't transfer private data to the configuration, but if you must, use secret management services or environment variables. [Learn more](https://blog.gruntwork.io/a-comprehensive-guide-to-managing-secrets-in-your-terraform-code-1d586955ace1#:~:text=this%20blog%20post%3A-,Do%20not%20store%20secrets%20in%20plain%20text.,secrets%20into%20your%20Terraform%20code)
- **Integrity control on guest OS**: Use free host-based solutions, such as Wazuh or Osquery, or paid solutions from Yandex Cloud Marketplace, such as Kaspersky Security.
- **Secure configuration of Object Storage**: Use encryption, [bucket policies](../../../storage/concepts/policy.md), and ACLs or [versioning for deletion protection](../../../storage/concepts/versioning.md), enable [built-in access auditing](../../../storage/operations/buckets/enable-logging.md) and configure CORS (if necessary). 
  ![](../../../_assets/overview/solution-library-icon.svg)[Solution: Secure configuration of Yandex Object Storage in Terraform](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/configuration/hardering_bucket)
- **Secure configuration of Cloud Functions**: Provide a service account token via the [native authentication mechanism](../../../functions/operations/function-sa.md) using the assigned service account and metadata. If possible, use [private functions](../../../functions/operations/function-public.md).
- **Secure configuration of Yandex Container Registry**: We do not recommend using privileged containers to run loads. Use the built-in [vulnerability scanner](../../../container-registry/tutorials/image-auto-scan.md) in images.
- **Yandex Certificate Manager**: Use [Yandex Certificate Manager](../../../certificate-manager/index.yaml) to store, receive, and update TLS certificates from Let's Encrypt® and to upload your own certificates. The service is integrated with Yandex Object Storage, Yandex API Gateway, and Application Load Balancer.

## Protection against malicious code {#malicious-code-protection}

- **OS-level protection**: Install antivirus solutions from [Yandex Cloud Marketplace](https://cloud.yandex.com/marketplace?categories=security) on VMs.
  ![](../../../_assets/overview/solution-library-icon.svg)[Solution: Deploying Kaspersky Antivirus in {{ yandex-cloud }} (Compute Instance, COI)](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/malware-defense/kaspersy-install-in-yc)
- **Network-level protection**: Use NGFW/IDS/IPS available in [Yandex Cloud Marketplace](https://cloud.yandex.com/marketplace?categories=security) (some of them have built-in sandboxes).
- **Container image-level protection**: Use the image vulnerability scanner integrated with Yandex Container Registry.

## Managing vulnerabilities {#vulnerability-management}

- **Automated vulnerability scanning**: Use free network scanners, such as nmap, OpenVAS, and OWASP ZAP, or host-based solutions, such as Wazuh and Tripwire.
- **External security scans**: Perform scans according to the [rules](../../../overview/compliance/pentest.md).
- **Software and OS updates**: Install updates manually and use automated update tools.
- **Web Application Firewall**: Install WAF from [Yandex Cloud Marketplace](https://cloud.yandex.com/marketplace?categories=security) or use Managed WAF — contact your manager to get access. 
  ![](../../../_assets/overview/solution-library-icon.svg)[Solution: PT Application Firewall built on {{ yandex-cloud }}](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/vuln-mgmt/unmng-waf-ptaf-cluster)
  ![](../../../_assets/overview/solution-library-icon.svg)[Example: Installing a Damn Vulnerable Web Application (DVWA) in {{ yandex-cloud }} using Terraform for Managed WAF testing](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/vuln-mgmt/vulnerable-web-app-waf-test)

## Collecting, monitoring and analyzing audit logs {#logs-analysis}

- **Audit trails**: Enable [Yandex Audit Trails](../../../audit-trails/quickstart.md) for all clouds and folders.
- **Collecting events on the guest OS and applications side**: Collect events, for example, using [Yandex Managed Service for Elasticsearch](../../../managed-elasticsearch/index.yaml) or free solutions, such as Osquery and Wazuh.
- **Collecting Flow logs (if required)**: For example, using NGFW from Yandex Cloud Marketplace or free software (options are available in service plans).
- **Exporting Audit Trails events to SIEM**.
  ![](../../../_assets/overview/solution-library-icon.svg)[Solution: Exporting to Yandex Managed Service for Elasticsearch (ELK)](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_main)
  ![](../../../_assets/overview/solution-library-icon.svg)[Solution: Exporting to ArcSight](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ArcSight)
  ![](../../../_assets/overview/solution-library-icon.svg)[Solution: Exporting to Splunk](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-Splunk)
Events can be exported to any SIEM system using s3fs, see the [instructions](../../../storage/tools/s3fs.md)
- **Use cases**. 
  ![](../../../_assets/overview/solution-library-icon.svg)[Use cases and important security events in audit logs](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/_use_cases_and_searches)
- **Responding to Audit Trails with Cloud Functions**:
  ![](../../../_assets/overview/solution-library-icon.svg)[Solution: Notifications and responses to Audit Trails information security events using Cloud Logging/Cloud Functions + Telegram](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/trails-function-detector)
- **Regular status audit**: Use the [CLI](../../../cli/index.yaml) for queries to the current state of the cloud infrastructure or the [Cloud Advisor](https://cloud.yandex.ru/blog/posts/2021/03/cloud-advisor-review) partner solution.

## Physical security {#physical-security}

- **Physical security measures**: For more information, see the [description of {{ yandex-cloud }} physical security measures](../../../overview/security/standarts.md#physic-sec).

## Backups {#backup}

- **Regular backups**: Set up disk snapshot creation on a schedule using Yandex Cloud Functions. See the [tutorial](https://cloud.yandex.ru/blog/posts/2020/01/snapshot-triggers).

## Managing budgets {#budget-management}

- **Notifications for cost control**: Set up notifications for budget thresholds in Billing. See the [instructions](../../../billing/operations/budgets.md).

## Incident response {#incident-response}

- **Response procedure**: Develop an incident response process. To get additional logs, follow the [data request procedure](../../../support/request.md).

## Security of Managed Service for Kubernetes {#kubernetes-security}

### Data encryption and key/secret management {#kubernetes-data-encryption}

- **Server-side encryption**: Enable secret encryption in etcd. See the [instructions](../../../kms/tutorials/kubernetes.md). Do this at all times, regardless of whether you use secret management services or not.
- **Secret management**: Use [Yandex Lockbox](../../../lockbox/index.yaml) or [HashiCorp Vault with Yandex KMS support](https://cloud.yandex.com/marketplace/products/f2eokige6vtlf94uvgs2) from Yandex Cloud Marketplace. 
  ![](../../../_assets/overview/solution-library-icon.svg)[Solution: Secret management using SecretManager ({{ lockbox-name }}, Vault)](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/kubernetes-security/encrypt_and_keys/secret-management)

### Network security {#kubernetes-network-security}

- **Security groups**: Configure security groups for Kubernetes. See the [instructions](../../../managed-kubernetes/operations/security-groups.md). We don't recommend granting public access and public addresses to Kubernetes components.
- **Ingress controller**: To access Kubernetes services from outside, use a LoadBalancer (external or internal) Ingress controller (HTTPS): [Application Load Balancer Ingress Controller](../../../managed-kubernetes/tutorials/alb-ingress-controller.md) (recommended) or other solutions, such as [NGINX Ingress Controller](../../../managed-kubernetes/tutorials/ingress-cert-manager.md).
- **DDoS protection**: Create an IP address with DDoS protection and assign it to the service or Ingress controller.
- **Network policy**: Restrict access at the Kubernetes level using [Calico Network Policies](../../../managed-kubernetes/operations/calico.md) or advanced [Cilium network policies](../../../managed-kubernetes/operations/cilium.md).
- **Access only from a limited pool of addresses (if required)**: Assign security groups for the Application Load Balancer Ingress controller and use network policies for other Ingress controllers.

### Authentication and access control {#kubernetes-authentication}

- **Access control**: Configure roles to access Kubernetes. See the [instructions](../../../managed-kubernetes/security/index.md#sa-annotation). Control access rights of the node group's service account (the `container-registry.images.puller` role is usually enough).
  ![](../../../_assets/overview/solution-library-icon.svg)[Solution: Setting up role models and policies in Managed Service for Kubernetes](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/kubernetes-security/auth_and_access/role-model-example)

### Secure configuration {#kubernetes-secure-configuration}

- **Node group configuration according to baseline and standards**: Configure node groups according to standards and baseline: NIST, CIS, and others. You can use automated tools, such as kube-bench and kubescape.
- **Runtime security and policy engine**: Use runtime security solutions, such as Falco, as well as policy engine solutions, such as OPA Gatekeeper and Kyverno.
  ![](../../../_assets/overview/solution-library-icon.svg)[Solution: Installing Falco and policy engine with alerts delivered to Managed Service for Elasticsearch](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_k8s)
- **Security updates**: Choose the relevant [update channel](../../../managed-kubernetes/concepts/release-channels-and-updates.md) and set up automatic updates or apply them manually as soon as they are published in the selected channel. Also perform timely updates of your own software on node groups.
- **Distribution of pods into different node groups**: Configure node taints and tolerations + node affinity (by load and degree of privacy).

### Collecting, monitoring and analyzing audit logs {#kubernetes-logs-analysis}

- **Collecting and analyzing Kubernetes audit logs and security tools**.
  ![](../../../_assets/overview/solution-library-icon.svg)[Solution: Analyzing Kubernetes security logs in Managed Service for Elasticsearch: audit logs, policy engine, and Falco](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_k8s)
- **Collecting and analyzing audit logs of workloads and node groups**: For example, using open-source tools, such as Fluentbit and Beats.
- **Monitoring abnormal loads**: Use [Yandex Monitoring](../../../monitoring/index.yaml).

### Backups {#kubernetes-backup}

- **Backups**: Configure Kubernetes cluster backups in Yandex Object Storage. See the [instructions](../../../managed-kubernetes/tutorials/backup.md). Follow the recommendations in [Secure configuration of Yandex Object Storage](secure-config.md#object-storage).

