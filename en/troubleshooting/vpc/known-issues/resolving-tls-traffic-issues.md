# Resolving errors when setting up TLS connections on VMs



## Issue description {#issue-description}

* Errors occur when loading packages from remote repositories.
* The process of establishing a TLS connection takes a long time or terminates with an error.
* The `curl` utility does not return the HTTP response code and takes a long time to establish connections.

## Troubleshooting and reproducing issues {#diagnosis-and-reproduction}

* Check whether the VM instance uses an [external IP address protected from DDoS attacks](../../../vpc/operations/enable-ddos-protection.md).
* If a web server is running on the VM, send a request to it from another host using the `curl` utility with `-vI` options:

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

Check whether the VM instance uses an [IP address protected from DDoS attacks](../../../vpc/operations/enable-ddos-protection.md).
For proper interaction with external resources via a protected address, you will need to [decrease the MTU or MSS](../../../vpc/concepts/mtu-mss.md) on the network interface of the VM instance.

If a containerization service (for example, Docker) is running on the VM, you will need to specify the MTU for all network interfaces created by this service (a guide for Docker is provided in a separate tab below).

{% list tabs %}

- Linux

   In the current Linux shell session, you can reduce the MTU with the `sudo ip link set dev <interface_name> mtu 1450` command.
   These changes will remain in effect until the first reboot.

   As one of the options for permanently applying these changes, you can use the `rc.local` service to execute the specified commands at VM startup. To create a file with commands for `rc.local`, follow these steps:

   1. Create a file for the sequence of commands by running `sudo nano /etc/rc.local`.
      Add the following content to the file:

      ```bash
      #!/bin/sh
      sudo ifconfig <interface_name> mtu 1450 up
      ```

   {% note info %}

   After `ipconfig`, specify the network interface name for the VM with a DDOS-protected IP and the desired MTU value.

   {% endnote %}

   2. Make the file executable by running the `sudo chmod +x /etc/rc.local` command.

   3. Activate and start the `rc.local` service using this command: `sudo systemctl enable rc-local.service --now`.

   4. Check the service status with the command: `sudo systemctl status rc-local.service`.
      The result of the command execution should look like this:

      ```bash
      ● rc-local.service - /etc/rc.local Compatibility
      Loaded: loaded (/lib/systemd/system/rc-local.service; enabled-runtime; vendor preset: enabled)
      Drop-In: /usr/lib/systemd/system/rc-local.service.d
      └─debian.conf
      Active: active (exited) since Wed 2022-03-23 10:46:05 UTC; 4min 16s ago
      Docs: man:systemd-rc-local-generator(8)
      Process: 491 ExecStart=/etc/rc.local start (code=exited, status=0/SUCCESS)
      ```

   Note: The return code should be indicated as `0/SUCCESS`

- Docker

   To change the MTU value for all network interfaces created for Docker containers on the VM, modify the Docker service configuration. To do this, follow these steps:

   1. Run this command: `sudo nano /etc/docker/daemon.json` and add the following section to the file:

      ```json
      {
      "mtu": 1450
      }
      ```
   2. Save the file and restart the Docker service: `sudo systemctl restart docker`.

   - Managed Service for Kubernetes

   To change MTU for the network interfaces of all VMs in the Managed Service for Kubrenetes node group, you need to create an object of type `DaemonSet` and apply it to the cluster.  To do this, follow these steps:

   1. Create a file with the object manifest file by running: `nano ds-set-mtu.yaml`.
      Add the following content to the file:

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

   2. Save the manifest file and apply it to the cluster: `kubectl apply -f ds-set-mtu.yaml`.

   {% note info %}

   If you are using the Calico network policy controller, you cannot explicitly set the MTU value for the Managed Service for Kubernetes cluster.
   In this case, set the MTU value on the upstream network infrastructure (router, NAT instance, or IPsec instance).

   {% endnote %}

- Windows

   To change MTU on the VM interface, run the `cmd` command interpreter as an administrator, then complete these steps:

   1. Run the `netsh interface ipv4 show subinterfaces` command to display a list of all available network interfaces on the VM.
      In the `Interface` field, select and save the name of the network interface on which you need to change the MTU value.

   2. Run the `netsh interface ipv4 set subinterface "<interface_name>" mtu=1450 store=persistent` command, specifying the name of the desired network interface, to set the desired MTU value for it. The specified value is saved after system reboot.

   3. Reboot the VM instance.

   4. Make sure that the MTU value was saved for the network device by running the `netsh interface ipv4 show subinterfaces` command.

{% endlist %}

## If the issue persists {#if-issue-still-persists}

If the above actions didn't help, [create a request for support](https://console.cloud.yandex.ru/support?section=contact).
In the request, specify the following information:

1. ID of the problematic VM.
2. External IP address with DDoS protection, where the issue occurs.
3. Description of the issue:
   * Console output of the package manager (`apt`, `yum`, `dnf`, `apk`, `npm`, etc.) at the attempt to download software from remote repositories.
   * Output of the `curl -vk https://$DESTINATION_URL` utility, where `$DESTINATION_URL` is the IP address or domain of the site you cannot connect to.