---
title: "{{ yandex-cloud }} IaaS security checklist"
description: "This article provides a checklist of measures for network, VM, and {{ objstorage-name }} security on the {{ yandex-cloud }} platform."
---

# IaaS security checklist

## VM security {#vm-security}

✔ **Disable the serial console**: Do not use the serial console; if you still have to, evaluate your risks and [disable](../../compute/operations/serial-console/disable.md) it as soon as you are done.

✔ **Disable password authentication**: Password authentication in {{ yandex-cloud }} is disabled by default. Do not enable password-based access unless you have to.

✔ **Connect via OS Login**: Link your VM user account with the organization user account using [OS Login](../../organization/concepts/os-login.md). To [connect](../../compute/operations/vm-connect/os-login.md) to a VM via OS Login, set up OS Login on a [new](../../compute/operations/vm-connect/os-login-create-vm.md) or [existing VM](../../compute/operations/vm-connect/enable-os-login.md) instead of the standard SSH connection.

✔ **Use a benchmark image to deploy a VM**: Prepare a VM image configured according to your organization's security policies and use this image to [create](../../compute/operations/vm-create/create-from-user-image.md) VMs.


✔ **Set up VM network interfaces**: For stable and reliable networks, set up [network interfaces](../../vpc/concepts/network.md) on all your new or existing VMs that are stopped, i.e., a subnet, internal and public IP addresses, and security groups. Learn more about security groups and other VM networking concepts in [{#T}](#network-security).

For more information on how to [set up a secure virtual environment](../standard/virtualenv-safe-config.md#serial-console) and [secure access management](../standard/authentication.md), see the respective sections of the {{ yandex-cloud }} security standard.

### Managing vulnerabilities {#vulnerability-management}

✔ **Software and OS updates**: Install updates manually and use automated update tools.

✔ **Automated vulnerability scanning**: Use free network scanners, such as nmap, OpenVAS, OWASP ZAP, or host-based agents, such as [Wazuh](/marketplace/products/opennix/wazuh).

✔ **Regular backups**: Configure scheduled [disk snapshots](../../compute/operations/snapshot-control/create-schedule.md) using {{ compute-full-name }} or automatic VM [backups](../../backup/quickstart.md) using {{ backup-full-name }}.

Learn more about vulnerability management in the [respective section](../standard/vulnerabilities.md) of the {{ yandex-cloud }} security standard.

## Network security {#network-security}

✔ **Controlled use of public IP addresses**: Follow our [recommendations](../../vpc/best-practices/public-ip-recommendations.md) to minimize the use of public IP addresses and build a more stable infrastructure.

✔ **Security groups**: Group resources and restrict network access using [security groups](../../vpc/operations/security-group-create.md). Security groups allow you to:

* Set up access to your cloud infrastructure from trusted IP addresses only.
* Restrict traffic by protocols and other parameters defined in the [rules](../../vpc/concepts/security-groups.md#security-groups-rules).

✔ **Web Application Firewall (WAF)**: WAF analyzes a web app's incoming HTTP requests according to pre-configured rules. Based on the analysis results, certain actions are applied to HTTP requests. [Configure a WAF profile](../../smartwebsecurity/quickstart/quickstart-waf.md) and connect it to your security profile in {{ sws-full-name }}.

✔ **Secure remote access**: [Create](../../tutorials/routing/bastion.md) a bastion VM to access the infrastructure over control protocols, e.g., SSH or RDP.

✔ **Outbound access (NAT)**: Use a [NAT gateway](../../vpc/concepts/gateways.md#nat-gateway) to ensure secure outbound internet access. The gateway translates your IP addresses to a shared address pool. If internet access should be from your controlled IP address pool, use a [NAT instance](../../tutorials/routing/nat-instance/console.md#create-nat-instance) (a dedicated VM).

✔ **DDoS protection**: When assigning public IP addresses to cloud resources, use [{{ ddos-protection-full-name }}](../../vpc/ddos-protection/index.md) (L4 DDoS protection). For L7 DDoS protection, use [{{ sws-name }}](../../smartwebsecurity/index.yaml).

![](../../_assets/overview/solution-library-icon.svg) See the example of implementing the [architecture and protection of a basic internet service](../../vpc/tutorials/web-service.md).

Learn more about secure network configuration and use in the [respective section](../standard/network-security.md) of the {{ yandex-cloud }} security standard.

## Security {{ objstorage-name }} {#storage-security}

✔ **Encryption**: Enable [bucket encryption](../../storage/operations/buckets/encrypt.md) (server-side encryption) for protection against accidental or intentional publication of bucket contents.

✔ **Limiting access to your bucket**:

* If possible, [disable](../../storage/operations/buckets/bucket-availability.md#close-public-access) public access. To grant access to a certain object, [generate](../../storage/operations/objects/link-for-download.md) a public link with a limited lifetime.
* To flexibly configure access to a bucket, use IAM, Bucket Policy, or other mechanisms described in [{#T}](../../storage/security/overview.md). Use ACLs to configure access only as the last resort: if you grant public access to an object via an ACL, all other security checks will be ignored.


✔ **Deletion protection**: [Configure](../../storage/operations/buckets/configure-object-lock.md) an object lock to protect your data against deletion.

✔ **Logging actions with a bucket**: [Set up](../../storage/operations/buckets/enable-logging.md) logging of actions with a bucket and [enable](../../audit-trails/concepts/events-data-plane.md#objstorage) collection of the service's audit logs in {{ at-full-name }}.

✔ **Secure use of AWS-compatible tools**: Configure access to a storage for [AWS-compatible tools](../../storage/tools/index.md) using [static keys](../../iam/operations/sa/create-access-key.md) and store the keys in a [{{ lockbox-name }} secret](../../iam/tutorials/static-key-in-lockbox.md).

✔ **Cross-Origin Resource Sharing (CORS)**: [Configure](../../storage/operations/buckets/cors.md) CORS in accordance with your company's security policies. If you are using the bucket to host a static website, [enable](../../storage/operations/hosting/certificate.md#cert-manager) HTTPS access using a {{ certificate-manager-name }} certificate.

✔ **Secure {{ objstorage-name }} configuration**:
![](../../_assets/overview/solution-library-icon.svg) See the example of implementing a [secure {{ objstorage-name }} configuration in {{ TF }}](https://github.com/yandex-cloud-examples/yc-s3-secure-bucket).

Learn more about secure {{ objstorage-name }} configuration and use in the [respective section](../standard/virtualenv-safe-config.md#objstorage) of the {{ yandex-cloud }} security standard.
