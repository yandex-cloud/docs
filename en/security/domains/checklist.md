---
title: "{{ yandex-cloud }} security checklist"
description: "In this tutorial, you will learn about {{ yandex-cloud }} security checklist components."
---

# Security checklist

{% include [kz-services](../../_includes/kz-services.md) %}

## Network security {#network-security}

* **Segmentation**: Split resources into groups and put them in different folders or, if strict isolation is required, in different {{ vpc-short-name }}. Traffic within a {{ vpc-short-name }} is allowed by default but not allowed between {{ vpc-short-name }}s (only via a VM with two network interfaces in different networks, either VPN or {{ interconnect-full-name }}). Watch our webinar to learn [how a network works in {{ yandex-cloud }}](https://www.youtube.com/watch?v=g3cZ0o50qH0).
* **Network access restriction, security groups**: Restrict network access across resources using [security groups](../../vpc/operations/security-group-create.md).
  ![](../../_assets/overview/solution-library-icon.svg)[Solution: Setting up security groups (dev/stage/prod) using {{ TF }}](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/segmentation)
* **NGFW from {{ marketplace-short-name }}**: If more robust network protection is required, use [NGFW]({{ link-cloud-marketplace }}?tab=software&categories=security&publishers=f2evobrhpbdrcue7s9l5%2Cf2e8r8u73qr5310ogjcn%2Cf2eddqeb0p9d7brb89l7) from {{ marketplace-full-name }} or deploy infrastructure on your own by following the [setup guide](../../tutorials/routing/high-accessible-dmz.md) for a high-availability, fault-tolerant network infrastructure with a dedicated DMZ segment and comprehensive protection based on the Next-Generation Firewall.
  ![](../../_assets/overview/solution-library-icon.svg)[Solution: Installing an NGFW on a {{ yandex-cloud }} VM: Check Point](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/network-sec/checkpoint-1VM)
* **Secure access from outside the cloud infrastructure (VPN)**: If you need remote access to cloud resources, configure a site-to-site VPN (see the [setup instructions using the strongSwan daemon](../../tutorials/routing/ipsec/index.md)) or use [{{ interconnect-name }}](../../interconnect/index.yaml) (the GOST VPN service is also available).

![](../../_assets/overview/solution-library-icon.svg)[Solution: Creating a site-to-site VPN connection to {{ yandex-cloud }} using {{ TF }}](https://github.com/yandex-cloud-examples/yc-site-to-site-vpn-with-ipsec-strongswan)


* **Secure remote administrator access (VPN)**: Set up a VPN connection between remote devices and {{ yandex-cloud }} using a solution from {{ marketplace-name }}. See the [setup guide](../../tutorials/routing/openvpn.md) for [OpenVPN](/marketplace/products/yc/openvpn-access-server) or deploy infrastructure on your own by following the [setup guide](../../tutorials/routing/remote-wireguard-vpn.md) for WireGuard VPN.
* **Bastion host**: Create a bastion VM to access the infrastructure using control protocols (for example, SSH or RDP).
* **Outbound access (NAT)**: Use a [NAT gateway](../../vpc/concepts/gateways.md#nat-gateway) to ensure secure outbound internet access. The gateway translates your IP addresses to a shared address pool. If internet access should be from your controlled IP address pool, use a [NAT instance](../../tutorials/routing/nat-instance/console.md#create-nat-instance) (a dedicated VM).
* **DDoS protection**: When assigning public IP addresses to your cloud resources, use the [{{ ddos-protection-full-name }}](../../vpc/ddos-protection/index.md) service by clicking the button (L4 DDoS protection). If you need L7 DDoS protection, contact your account manager.

## Authentication and access control {#authentication}

* **Centralized management and identity federations**: Create an organization in [{{ org-full-name }}](/services/organization) and set up Single Sign-On in {{ yandex-cloud }} via your IdP server. See the setup instructions for [AD FS](../../organization/tutorials/federations/integration-adfs.md), [Keycloak](https://www.youtube.com/watch?v=m-oe7V9PvC4), and [Google Workspace](../../organization/tutorials/federations/integration-gworkspace.md).
* **Federated accounts**: Use federated accounts instead of Yandex accounts whenever possible.
* **Principle of least privilege**: Assign service roles (for example, `compute.images.user`) instead of primitive roles (`viewer`, `editor`, or `admin`). See the [list of all roles](../../iam/roles-reference.md) and [examples of assigning roles](../../iam/operations/roles/grant.md). Watch our webinar to learn how to [manage cloud access permissions](https://www.youtube.com/watch?v=7VwSfPZ6eRM&t=3s).
* **{{ TF }} {{ yandex-cloud }} {{ iam-full-name }} module**: Organize access groups for cloud users.
* **Working with service accounts**: [Assign a service account to a VM instance](../../compute/operations/vm-connect/auth-inside-vm.md) and get a token using the metadata service. Set up a local firewall on the VM instance so that only the necessary processes and system users have access to the metadata service (IP address: 169.254.169.254).<!-- tbd: добавить ссылку на решение -->
* **2FA**: For an identity federation, set up 2FA on the side of your IdP. For a Yandex account, set up 2FA using [this guide](https://yandex.com/support/id/authorization/twofa.html).
* **billing.accounts.owner protection**: After performing the initial operations, do not use an account with this role. To manage a billing account, assign the `admin`, `editor`, or `viewer` role for the billing account to a specific employee with a federated account.
* **Organization-manager.organizations.owner protection**:

    {% list tabs %}

    - In an identity federation

      Grant the `organization-manager.organizations.owner` role to a federated account and then delete a passport account with this role from your organization. To mitigate the risks of possible federation failures, follow the steps described in [Deleting a passport account from an organization](../operations/account-deletion.md).

    - Without an identity federation

      Set a complex password for the Yandex account used to create the organization. Grant the less privileged `organization-manager.admin` role to organization administrators; use the account with the `organization-manager.organizations.owner` role only if you absolutely have to.

    {% endlist %}

* **Resource model**: Place all critical resources governed by standards in a separate cloud. Split resource groups into folders. Place shared resources (e.g., network and security groups) in a separate shared resource folder.

## Data encryption and key/secret management {#data-encryption}

* **Encryption in {{ objstorage-full-name }}**: Enable bucket encryption (server-side encryption). See the [instructions](../../storage/operations/buckets/encrypt.md). This encryption protects bucket data from being published on the internet.
* **VM disk encryption (if required)**.
  ![](../../_assets/overview/solution-library-icon.svg)[Solution: VM disk encryption using {{ kms-full-name }}](https://github.com/yandex-cloud-examples/yc-encrypt-vm-disk-with-kms)
* **Client-side encryption (if required)**: Use data encryption with {{ kms-name }} keys. See an [overview of encryption methods](../../kms/tutorials/encrypt/index.md).
* **{{ kms-name }} key protection**: Grant only granular access to individual {{ kms-name }} keys (the `kms.keys.encrypter`, `kms.keys.decrypter`, or `kms.keys.encrypterDecrypter` roles). Use [key rotation](../../kms/concepts/version.md).
* **Secret management**: Use secret management services, such as [{{ lockbox-name }}](../../lockbox/) or [HashiCorp Vault with {{ kms-name }} support](/marketplace/products/yc/vault-yckms) from {{ marketplace-name }}.<!-- или контейнер {{ registry }}/yc/vault -->

## Secure configuration {#secure-configuration}

* **Default passwords**: Keep track of default passwords in VM software organizationally and technically using various vulnerability scanners.
* **Standards and baseline**: Configure the OS and software in accordance with the baseline and standards (such as CIS and PCI DSS). To automate compliance, use, for example, [OpenSCAP](https://www.open-scap.org/getting-started/).
* **Disabling the serial console**: Do not use the serial console; if you still have to, [evaluate your risks](../../compute/operations/serial-console/index.md) and disable it once you are done.
* **Safe use of {{ TF }}**: Use `terraform remote state` based on {{ objstorage-name }} with a lock function in {{ ydb-full-name }}. You can see a setup example [here](https://github.com/yandex-cloud/examples/tree/master/terraform-ydb-state). Set [sensitive = true](https://www.terraform.io/docs/language/values/outputs.html#sensitive-suppressing-values-in-cli-output) if required. Do not transfer private data to the configuration. If you still have to, use [secret management](https://blog.gruntwork.io/a-comprehensive-guide-to-managing-secrets-in-your-terraform-code-1d586955ace1#:~:text=this%20blog%20post%3A-,Do%20not%20store%20secrets%20in%20plain%20text.,secrets%20into%20your%20Terraform%20code) services or environment variables. You can read more [here](../standard/encryption.md#secrets).
  ![](../../_assets/overview/solution-library-icon.svg)[Example: Scanning .tf files with Checkov](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/terraform-sec/checkov-yc)
* **Integrity control on guest OS**: Use free host-based solutions, such as [Wazuh](/marketplace/products/opennix/wazuh) or Osquery, or paid solutions from {{ marketplace-name }}.
* **Secure configuration of {{ objstorage-name }}**: Use encryption, [bucket policies](../../storage/concepts/policy.md), and ACLs, or [versioning for deletion protection](../../storage/concepts/versioning.md), enable [built-in access auditing](../../storage/operations/buckets/enable-logging.md) and configure CORS, if required.
  ![](../../_assets/overview/solution-library-icon.svg)[Solution: Secure configuration of {{ objstorage-name }} in {{ TF }}](https://github.com/yandex-cloud-examples/yc-s3-secure-bucket)
* **Secure configuration of {{ sf-full-name }}**: Provide a service account token via the [native authentication mechanism](../../functions/operations/function-sa.md) using the assigned service account and metadata. If possible, use [private functions](../../functions/operations/function/function-private.md).
* **Secure configuration of {{ container-registry-full-name }}**: We do not recommend using privileged containers to run loads. Use the built-in image [vulnerability scanner](../../container-registry/concepts/vulnerability-scanner.md).
* **{{ certificate-manager-full-name }}**: Use [{{ certificate-manager-name }}](../../certificate-manager/) to store, receive, and update TLS certificates from Let's Encrypt® and to upload your own certificates. The service is integrated with {{ api-gw-full-name }}, {{ alb-full-name }}, and {{ objstorage-name }}.

## Protection against malicious code {#malicious-code-protection}

* **OS-level protection**: Install antivirus solutions from [{{ marketplace-name }}](/marketplace?categories=security) on VMs.
* **Network-level protection**: Use NGFW/IDS/IPS available in [{{ marketplace-name }}](/marketplace?categories=security) (some of them have built-in sandboxes).
* **Container image-level protection**: Use the image vulnerability scanner integrated with {{ container-registry-name }}.<!-- tbd: вставить ссылку на инструкцию, когда она появится -->

## Managing vulnerabilities {#vulnerability-management}

* **Automated vulnerability scanning**: Use free network scanners, such as Nmap, OpenVAS, and OWASP ZAP, or host-based solutions, such as [Wazuh](/marketplace/products/opennix/wazuh) and Tripwire.
* **External security scans**: Perform scans according to the [rules](../compliance/pentest.md).
* **Software and OS updates**: Install updates manually and use automated update tools.
* **Web Application Firewall**: Install a WAF from [{{ marketplace-name }}](/marketplace?categories=security) or use Managed WAF — contact your account manager to get access.
  ![](../../_assets/overview/solution-library-icon.svg)[Solution: PT Application Firewall powered by {{ yandex-cloud }}](https://github.com/yandex-cloud-examples/yc-webinar-pt-application-firewall-ha-operations)

## Collecting, monitoring, and analyzing audit logs {#logs-analysis}

* **{{ at-full-name }}**: Enable [{{ at-name }}](../../audit-trails/quickstart.md) for all clouds and folders.
* **Collecting events on the guest OS and applications side**: Collect events, for example, free solutions, such as Osquery and [Wazuh](/marketplace/products/opennix/wazuh).
* **Collecting Flow logs (if required)**: For example, using NGFW from {{ marketplace-name }} or free software (options are available in service plans).
* **Exporting {{ at-name }} events to SIEM**.
  ![](../../_assets/overview/solution-library-icon.svg)[Solution: Exporting to ArcSight](https://github.com/yandex-cloud-examples/yc-export-auditlogs-to-arcsight)
  ![](../../_assets/overview/solution-library-icon.svg)[Solution: Exporting to Splunk](https://github.com/yandex-cloud-examples/yc-export-auditlogs-to-splunk)
  You can export event data to any SIEM using s3fs, see this [guide](../../storage/tools/s3fs.md).
* **Use cases**.
  ![](../../_assets/overview/solution-library-icon.svg)[Use cases and important security events in audit logs](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/_use_cases_and_searches)
* **Responding to {{ at-name }} with {{ sf-name }}**:
  ![](../../_assets/overview/solution-library-icon.svg)[Solution: Notifications and responses to {{ at-name }} information security events using {{ cloud-logging-full-name }} / {{ sf-name }} + Telegram](https://github.com/yandex-cloud-examples/yc-audit-trails-automatic-response)
* **Regular status audit**: Use the [{{ yandex-cloud }} CLI](../../cli/) for queries to the current state of the cloud infrastructure or the Cloud Advisor partner solution.

## Physical security {#physical-security}

* **Physical security measures**: For more information, see the [description of {{ yandex-cloud }} physical security measures](../standarts.md#physic-sec).

## Backups {#backup}

* **Regular backups**: Configure scheduled creation of disk snapshots using {{ sf-name }}).

## Managing budgets {#budget-management}

* **Notifications for cost control**: Set up notifications for budget thresholds in {{ billing-name }}. See [this guide](../../billing/operations/budgets.md) for details.

## Incident response {#incident-response}

* **Response procedure**: Develop an incident response process. To get additional logs, follow the [data request procedure](../../support/request.md).
