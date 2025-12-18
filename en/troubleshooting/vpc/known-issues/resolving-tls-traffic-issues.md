# Fixing TLS connection errors on VMs



## Issue description {#issue-description}

* Errors occur when loading packages from remote repositories.
* The process of establishing a TLS connection takes a long time or terminates with an error.
* `curl` returns no HTTP status code and takes a long time to establish connections.

## Diagnostics and issue reproduction {#issue-diagnostics-and-reproduction}

Check whether your VM uses an [external IP address with DDoS protection](../../../vpc/operations/enable-ddos-protection.md). If the VM runs a web server, send a request to it from another host using `curl` with the `-vI` options:

{% cut "Example of a curl request to a web server with an external IP address protected from DDoS attacks without a changed MTU" %}

```bash
curl -vI https://site-name.site/
*   Trying ip...
* TCP_NODELAY set
* ALPN, offering h2
* ALPN, offering http/1.1
* successfully set certificate verify locations:
*   CAfile: /etc/ssl/cert.pem
  CApath: none
* TLSv1.2 (OUT), TLS handshake, Client hello (1):
* TLSv1.2 (IN), TLS handshake, Server hello (2):
* TLSv1.2 (IN), TLS handshake, Certificate (11):
* TLSv1.2 (IN), TLS handshake, Server key exchange (12):
* TLSv1.2 (IN), TLS handshake, Server finished (14):
* TLSv1.2 (OUT), TLS handshake, Client key exchange (16):
* TLSv1.2 (OUT), TLS change cipher, Change cipher spec (1):
* TLSv1.2 (OUT), TLS handshake, Finished (20):
* TLSv1.2 (IN), TLS change cipher, Change cipher spec (1):
* TLSv1.2 (IN), TLS handshake, Finished (20):
```

{% endcut %}

The process of establishing a TLS connection will take a long time, noticeably longer than usual.

## Solution {#issue-resolution}

Check whether your VM uses an [IP address with DDoS protection](../../../vpc/operations/enable-ddos-protection.md). For proper access to external resources via a protected address, [reduce the MTU or MSS value](../../../vpc/concepts/mtu-mss.md) on the network interface of the VM.

If your VM runs a containerization service such as Docker, specify the MTU value for all network interfaces created by this service. For Docker-specific steps, see a separate tab below.

{% list tabs group=operating_system %}

- Linux {#linux}

   To reduce the MTU in the current Linux shell session, run the `sudo ip link set dev <interface_name> mtu 1450` command.
   These changes will remain in effect until the first reboot.

   As an option for applying these changes permanently, use the `rc.local` service to run the specified commands at VM startup. To create a command file for `rc.local`, follow these steps:

   1. Create a file with the sequence of commands by running `sudo nano /etc/rc.local`. 
      Add the following content to the file:

      ```bash
      #!/bin/sh
      sudo ifconfig <interface_name> mtu 1450 up
      ```

   {% note info %}

   After `ipconfig`, specify the network interface name of the VM with a DDoS-protected IP and the MTU value you want to set.

   {% endnote %}

   1. Make the file executable by running `sudo chmod +x /etc/rc.local`.

   1. Enable and start the `rc.local` service by running `sudo systemctl enable rc-local.service --now`.

   1. Check the service status using the `sudo systemctl status rc-local.service` command. The command output should look like this:

      ```bash
      ● rc-local.service - /etc/rc.local Compatibility
      Loaded: loaded (/lib/systemd/system/rc-local.service; enabled-runtime; vendor preset: enabled)
      Drop-In: /usr/lib/systemd/system/rc-local.service.d
      └─debian.conf
      Active: active (exited) since Wed 2022-03-23 10:46:05 UTC; 4min 16s ago
      Docs: man:systemd-rc-local-generator(8)
      Process: 491 ExecStart=/etc/rc.local start (code=exited, status=0/SUCCESS)
      ```

   Make sure the return code displays `0/SUCCESS`.

- Docker {#docker}

   To change the MTU value for all network interfaces created for Docker containers on the VM, modify the Docker service configuration. To do this, follow these steps:

   1. Run the `sudo nano /etc/docker/daemon.json` command and add the following section to the file:

      ```json
      {
      "mtu": 1450
      }
      ```
   1. Save the file and run `sudo systemctl restart docker` to restart Docker.

- {{ managed-k8s-name }} {#mk8s}

   To change the MTU value for the network interfaces of all VMs in the {{ managed-k8s-name }} node group, you need to create a `DaemonSet` object and apply it to the cluster. To do this, follow these steps:

   1. Create a file with the object manifest by running `nano ds-set-mtu.yaml`. Add the following content to the file:

      ```yaml
      apiVersion: apps/v1
      kind: DaemonSet
      metadata:
      name: set-mtu
      spec:
      selector:
         matchLabels:
            app: set-mtu
      template:
         metadata:
            labels:
            app: set-mtu
         spec:
            containers:
            - name: set-mtu
            image: amouat/network-utils
            command: ["sh", "-c", "ip link set dev <interface_name> mtu 1450"]
            securityContext:
               privileged: true
            resources:
               requests:
                  cpu: "100m"
                  memory: "50Mi"
               limits:
                  cpu: "200m"
                  memory: "100Mi"
            hostNetwork: true
            nodeSelector:
            kubernetes.io/os: linux
      ```

   1. Save the manifest file and run `kubectl apply -f ds-set-mtu.yaml` to apply it to the cluster.

   {% note info %}

   If you are using the Calico network policy controller, you cannot explicitly set the MTU value for the {{ managed-k8s-name }} cluster. In this case, we recommend setting the MTU value on the upstream network components, such as router, NAT instance, or IPsec instance.

   {% endnote %}

- Microsoft Windows® {#windows}

   To change the MTU value on the VM interface, run `cmd` as administrator and follow these steps:

   1. Run the `netsh interface ipv4 show subinterfaces` command to display a list of all available network interfaces on the VM. In the `Interface` field, select and save the name of the network interface where you want to change the MTU value.

   1. Run the `netsh interface ipv4 set subinterface "<interface_name>" mtu=1450 store=persistent` command, specifying the name of the network interface where you want to set the new MTU value. This value will persist after the system reboot.

   1. Restart the VM.

   1. Make sure the new MTU value persists on the network device by running `netsh interface ipv4 show subinterfaces`.

{% endlist %}

## If the issue persists {#if-issue-still-persists}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. ID of the VM in question.
1. DDoS-protected external IP address experiencing the issue.
1. Issue description: 
   * Console output of the package manager (`apt`, `yum`, `dnf`, `apk`, `npm`, etc.) when attempting to download software from remote repositories.
   * `curl -vk https://$DESTINATION_URL` output, where `$DESTINATION_URL` is the IP address or website domain you cannot connect to.