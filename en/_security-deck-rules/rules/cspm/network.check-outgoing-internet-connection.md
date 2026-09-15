### Outbound internet access control is performed {#check-outgoing-internet-connection}
#|
|| **kind** | **severity** | **ID** ||
|| automatic | information | network.check-outgoing-internet-connection ||
|#

#### Description

**How the rule works**: The rule ensures inventory of resources with external network access through an external IP address in the VM settings or with a NAT gateway in place.

Egress traffic control is one of the fundamental cybersecurity measures. It helps prevent data leaks, protects against anyone using your infrastructure to attack other services or systems, and decreases the risks associated with a public IP address. Without egress traffic control, you cannot see which data goes outside of your infrastructure and where. This makes it impossible to detect anomalies or investigate security issues.

**Risks when not complying with the rule**:
* **Using the infrastructure for attacks**: A compromised VM may become a source of DDoS, port scanning, or brute force attacks against outside resources.
* **Data exfiltration**: With no egress traffic limitations in effect, malicious software or an insider can freely export your data elsewhere.
* **C2 communications**: Malicious software can set up a control channel through unregulated egress traffic.
* **Violation of threat modeling in isolated environments**: Unauthorized creation of a public IP address or NAT gateway completely nullifies the isolation of a protected environment.
* **Public IP address (egress NAT) risk**: A shared address pool may lead to an address ending up in blacklists due to other lessees' actions.
* **No audit**: There is no way to investigate incidents and no compliance with regulatory requirements.

#### Instructions and solutions

* If a VM has public IPs, make sure they are absolutely necessary. Otherwise, [delete the external IP address](https://yandex.cloud/en/docs/compute/operations/vm-control/vm-detach-public-ip) in the VM settings.
* If there is a NAT gateway, make sure it is absolutely necessary. Otherwise, [delete it](https://yandex.cloud/en/docs/vpc/operations/delete-nat-gateway).
To delete a VM's public IP address:
1. [Go](https://console.yandex.cloud/link/compute) to **Compute Cloud**.
1. Select your VM.
1. Under **Network**, click **...** in the top-right corner of your network interface's section and select **Disassociate public IP address**.
1. In the window that opens, click **Delete**.

To delete a NAT gateway:

1. Before deleting your NAT gateway, [disassociate it](https://yandex.cloud/en/docs/vpc/operations/delete-nat-gateway#unlink-nat-gateway) from all route tables that use it.
1. [Go](https://console.yandex.cloud/link/vpc) to **Virtual Private Cloud**.
1. On the left-hand panel, select **Gateways**.
1. Click **...** in the row with your NAT gateway's name and select **Delete**.
1. In the window that opens, click **Delete**.