---
title: '{{ yandex-cloud }} IaaS security checklist'
description: This article presents a security checklist for a {{ yandex-cloud }} based network, VM, and {{ objstorage-name }}.
---

# IaaS security checklist

## VM security {#vm-security}

&#x2713; **Disable the serial console**: Do not use the serial console; if you still have to, evaluate your risks and [disable](../../compute/operations/serial-console/disable.md) it as soon as you are done.

&#x2713; **Disable password authentication**: Password authentication in {{ yandex-cloud }} is disabled by default. Do not enable password-based access unless you have to.

&#x2713; **Connect via OS Login**: Use [OS Login](../../organization/concepts/os-login.md) to link your VM user account with the organization user account. To [connect](../../compute/operations/vm-connect/os-login.md) to a VM via OS Login, set up OS Login on a [new](../../compute/operations/vm-connect/os-login-create-vm.md) or [existing VM](../../compute/operations/vm-connect/enable-os-login.md) instead of the standard SSH connection.

&#x2713; **Use a benchmark image to deploy a VM**: Prepare a VM image configured according to your organization's security policies and use this image to [create](../../compute/operations/vm-create/create-from-user-image.md) VMs.


&#x2713; **Set up VM network interfaces**: For stable and reliable networks, set up [network interfaces](../../vpc/concepts/network.md) on all your new or existing VMs that are stopped, i.e., a subnet, internal and public IP addresses, and security groups. Learn more about security groups and other VM networking concepts in [{#T}](#network-security).

For more information on how to [set up a secure virtual environment](../standard/virtualenv-safe-config.md#serial-console) and [secure access management](../standard/authentication.md), see the respective sections of the {{ yandex-cloud }} security standard.

### Managing vulnerabilities {#vulnerability-management}

&#x2713; **Software and OS updates**: Install updates manually and use automated update tools.

&#x2713; **Automated vulnerability scanning**: Use free network scanners, such as nmap, OpenVAS, OWASP ZAP, or host-based agents, such as [Wazuh](/marketplace/products/opennix/wazuh).

&#x2713; **Regular backups**: Configure scheduled [disk snapshots](../../compute/operations/snapshot-control/create-schedule.md) using {{ compute-full-name }} or [automatic VM backups](../../backup/quickstart.md) using {{ backup-full-name }}.

## Network security {#network-security}

&#x2713; **Controlled use of public IP addresses**: Follow our [recommendations](../../vpc/best-practices/public-ip-recommendations.md) to minimize the use of public IP addresses and build a more stable infrastructure.

&#x2713; **Security groups**: Group resources and restrict network access using [security groups](../../vpc/operations/security-group-create.md). Security groups allow you to:

  * Set up access to your cloud infrastructure from trusted IP addresses only.
  * Restrict traffic by protocols and other parameters defined in the [rules](../../vpc/concepts/security-groups.md#security-groups-rules).

&#x2713; **Web Application Firewall (WAF)**: WAF analyzes a web app's incoming HTTP requests according to pre-configured rules. Based on the analysis results, certain actions are applied to HTTP requests. [Configure a WAF profile](../../smartwebsecurity/quickstart/quickstart-waf.md) and connect it to your security profile in {{ sws-full-name }}.

&#x2713; **Secure remote access**: [Create](../../tutorials/routing/bastion.md) a bastion VM to access the infrastructure over control protocols, e.g., SSH or RDP.

&#x2713; **Outbound access (NAT)**: Use a [NAT gateway](../../vpc/concepts/gateways.md#nat-gateway) to ensure secure outbound internet access. The gateway translates your IP addresses to a shared address pool. If internet access should be from your controlled IP address pool, use a [NAT instance](../../tutorials/routing/nat-instance/console.md#create-nat-instance) (a dedicated VM).

&#x2713; **DDoS protection**: When assigning public IP addresses to cloud resources, use [{{ ddos-protection-full-name }}](../../vpc/ddos-protection/index.md) (L4 DDoS protection). For L7 DDoS protection, use [{{ sws-name }}](../../smartwebsecurity/index.yaml).

  See the example of implementing the [architecture and protection of a basic internet service](../../vpc/tutorials/web-service.md).

Learn more about secure network configuration and use in the [respective section](../standard/network-security.md) of the {{ yandex-cloud }} security standard.

## {{ objstorage-name }} security {#storage-security}

&#x2713; **Encryption**: Enable [bucket encryption](../../storage/operations/buckets/encrypt.md) (server-side encryption) for protection against accidental or intentional publication of bucket contents.

&#x2713; **Limiting access to your bucket**:

   * If possible, [disable](../../storage/operations/buckets/bucket-availability.md#close-public-access) public access. To grant access to a specific object, [generate](../../storage/operations/objects/link-for-download.md) a public link with a limited lifetime.
   * For flexible configuration of access to a bucket, use IAM, Bucket Policy, or other mechanisms described in [{#T}](../../storage/security/overview.md). Use ACLs to configure access only as the last resort: if you grant public access to an object via an ACL, all other security checks will be ignored.


&#x2713; **Deletion protection**: [Configure](../../storage/operations/buckets/configure-object-lock.md) an object lock to protect your data against deletion.

&#x2713; **Logging actions with a bucket**: [Set up](../../storage/operations/buckets/enable-logging.md) logging of actions with a bucket and [enable](../../audit-trails/concepts/events-data-plane.md#objstorage) collection of the service's events in {{ at-full-name }}.

&#x2713; **Secure use of AWS-compatible tools**: Configure access to a storage for [AWS-compatible tools](../../storage/tools/index.md) using [static keys](../../iam/operations/sa/create-access-key.md) and store the keys in a [{{ lockbox-name }} secret](../../iam/tutorials/static-key-in-lockbox.md).

&#x2713; **Cross-Origin Resource Sharing (CORS)**: [Configure](../../storage/operations/buckets/cors.md) CORS in accordance with your company's security policies. If you are using the bucket to host a static website, [enable](../../storage/operations/hosting/certificate.md#cert-manager) HTTPS access using a {{ certificate-manager-name }} certificate.

&#x2713; **Secure {{ objstorage-name }} configuration**:
  ![](../../_assets/overview/solution-library-icon.svg) See the example of implementing a [secure {{ objstorage-name }} configuration in {{ TF }}](https://github.com/yandex-cloud-examples/yc-s3-secure-bucket).

Learn more about secure {{ objstorage-name }} configuration and use in the [respective section](../standard/virtualenv-safe-config.md#objstorage) of the {{ yandex-cloud }} security standard.
