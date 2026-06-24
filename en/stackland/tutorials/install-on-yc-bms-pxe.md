---
title: Installing {{ stackland-name }} on {{ baremetal-full-name }} via PXE
---

# Installing {{ stackland-name }} on {{ baremetal-full-name }} via PXE

This tutorial describes how to install {{ stackland-full-name }} on {{ baremetal-full-name }} servers using PXE network boot. This method sees servers download the installation environment over the network, so you do not need to manually attach an ISO image to each server via a KVM console.

For general requirements as to cluster resources, DNS, disks, and network ranges, see the [Installation guide](../quickstart.md). For a basic use case on preparing {{ baremetal-name }} servers, see [Installing {{ stackland-name }} on {{ baremetal-full-name }}](install-on-yc-bms.md). This guide outlines the differences specific to PXE-based installation.

## Introduction {#introduction}

For PXE installation, you will need:

* One bastion server running Ubuntu 22.04 or later, which will host `sladm`, a DHCP server, and a TFTP server for network boot.
* At least three servers for the future {{ stackland-name }} cluster, connected to the same private network as the bastion.
* PXE file archive: `stackland-pxe-amd64-<version>.zip`.
* `sladm` utility version supporting the `--dhcp-interface` and `--pxe-folder` installation parameters.
* `key.json` provided with your {{ stackland-name }} distribution for accessing components and generating secrets.
* Cluster configuration specifying the static IP addresses and MAC addresses of all node network interfaces.

{% note warning %}

Do not run other DHCP servers in the private subnet used for PXE boot. When creating the {{ baremetal-name }} private subnet, make sure DHCP is disabled.

{% endnote %}

The examples below employ `192.168.22.0/24` as the subnet. The bastion is assigned address `192.168.22.1`, and the cluster nodes receive addresses `192.168.22.2`, `192.168.22.3`, and `192.168.22.4`. Replace these with addresses from your infrastructure.

## Get your private subnet ready {#create-private-subnet}

Create a private subnet for the bastion and cluster servers as described in the [base guide](install-on-yc-bms.md#create-private-subnet), but disable automatic IP assignment via DHCP.

When creating the subnet, specify:

* Private subnet CIDR (e.g., `192.168.22.0/24`).
* IP assignment via DHCP disabled.

Assign static IP addresses to cluster nodes in the {{ stackland-name }} configuration. During installation, `sladm` will assign these IPs to the nodes using its built-in DHCP server.

## Rent servers {#lease-servers}

Rent desired {{ baremetal-name }} servers as in the [base use case](install-on-yc-bms.md#lease-servers):

1. Rent a bastion server.

   When creating your server:

   * Select Ubuntu 24.04.
   * Connect the server to the private subnet you created in the previous step.
   * Assign your server a public IP address for SSH access.
   * Set a password for the `root` user and add an SSH key.

1. Rent at least three servers for your new {{ stackland-name }} cluster.

   When creating each server:

   * Select **No operating system**.
   * Connect the server to the same private subnet.
   * Select **No address** for the public address.

After renting the servers, record the MAC address of the network interface for each cluster server. You can find it on the server's page under **Private network** → **MAC address**. You will need these values in the `StacklandHostsList` configuration.

## Configure the bastion {#configure-bastion}

On the bastion, set up VPN, routing, DNS, and NTP as described in [Configuring network access](install-on-yc-bms.md#net-settings) and [Installing additional services](install-on-yc-bms.md#additional-services).

If the bastion's private interface does not have an IP address from the subnet hosting your cluster servers, configure that IP manually and persist the setting in the OS network configuration.

For Ubuntu with `netplan`, add the private address to the configuration of the corresponding interface. In the example below, the private interface is named `eth1`:

```yaml
network:
  version: 2
  ethernets:
    eth1:
      addresses:
        - 192.168.22.1/24
      dhcp4: false
```

Apply the configuration and verify the address:

```bash
sudo netplan apply
ip -brief addr show eth1
```

Replace `eth1` and `192.168.22.1/24` with your interface name and subnet address.

To prepare PXE files and set permissions for `sladm`, install additional utilities on the bastion:

```bash
sudo apt install wget unzip libcap2-bin -y
```

On the bastion, allow incoming DHCP and TFTP traffic from the private subnet. If using `ufw`, run this command:

```bash
sudo ufw allow from 192.168.22.0/24 to any port 67 proto udp
sudo ufw allow from 192.168.22.0/24 to any port 69 proto udp
sudo ufw allow from 192.168.22.0/24 to any port 53 proto udp
sudo ufw allow from 192.168.22.0/24 to any port 123 proto udp
```

Replace `192.168.22.0/24` with your private subnet's CIDR. Ports 53 and 123 are only required if DNS and NTP for cluster nodes also run on the bastion.

Verify that IPv4 forwarding is enabled on the bastion and that NAT is configured for the private subnet, as described in the [base guide](install-on-yc-bms.md#net-settings).

```bash
sysctl net.ipv4.ip_forward
sudo iptables -t nat -S POSTROUTING
```

## Download and unpack PXE files {#prepare-pxe-files}

Download the `stackland-pxe-amd64-<version>.zip` archive from the link provided with your {{ stackland-name }} distribution and unpack it on the bastion:

```bash
unzip stackland-pxe-amd64-<version>.zip
ls -lh pxe/
```

If a checksum is provided alongside the archive, verify it before extraction:

```bash
sha256sum -c stackland-pxe-amd64-<version>.zip.sha256
```

In the `pxe/` directory, you should see these files:

* `ipxe.pxe`: iPXE bootloader for BIOS
* `ipxe.efi`: iPXE bootloader for UEFI
* `vmlinuz`: Linux kernel
* `initramfs.xz`: Initial ramdisk

Download and install `sladm` as described in [Downloading required files](../quickstart.md#download-files).

Verify that your `sladm` version supports PXE installation:

```bash
sladm install --help | grep -E 'dhcp-interface|pxe-folder'
```

After preparing the files on the bastion, keep all installation artifacts in a single working directory:

```text
yc-bms-pxe/
├── sladm
├── key.json
├── stackland-pxe-amd64-<version>.zip
├── pxe/
│   ├── initramfs.xz
│   ├── ipxe.efi
│   ├── ipxe.pxe
│   └── vmlinuz
└── config/
    ├── cluster.yaml
    ├── hosts.yaml
    └── secrets.yaml
```

The `secrets.yaml` file will be generated after running `sladm secrets add`, as described below.

## Configure DNS {#dns}

Configure the cluster DNS zone and the node hostname zone as described in [here](install-on-yc-bms.md#dns).

In this example, the node hostnames correspond to the following addresses:

* `node1.baremetal.internal`: `192.168.22.2`
* `node2.baremetal.internal`: `192.168.22.3`
* `node3.baremetal.internal`: `192.168.22.4`

## Prepare the cluster configuration {#configuration}

Create a `config/` directory and prepare configuration files. The general format is described in [Initial configuration](../quickstart.md#configuration).

For PXE installation, each node's configuration must specify:

* MAC address of the network interface used for the node's PXE boot.
* Static IP address for that interface in CIDR format.

Before creating your `StacklandHostsList`, prepare a mapping table of servers, interfaces, and addresses:

| Server | FQDN | MAC address of the private PXE interface | Static IP | Role | Installation disk |
| --- | --- | --- | --- | --- | --- |
| `node1` | `node1.baremetal.internal` | `06:2a:b7:15:de:f1` | `192.168.22.2/24` | `combined` | `/dev/sda` |
| `node2` | `node2.baremetal.internal` | `0e:9d:6b:fc:42:88` | `192.168.22.3/24` | `combined` | `/dev/sda` |
| `node3` | `node3.baremetal.internal` | `02:5e:c3:a8:07:d9` | `192.168.22.4/24` | `combined` | `/dev/sda` |

The MAC address must belong to the private interface used for the server's PXE boot. If multiple network boot options appear in your KVM console, select the one matching this MAC address.

{% note warning %}

Do not use `dhcp: true` for interfaces performing PXE boot. The built-in `sladm` DHCP server only assigns static addresses defined in the configuration.

{% endnote %}

Example configuration for a three-node cluster with each node having the `combined` role:

```yaml
apiVersion: v1alpha1
kind: StacklandClusterConfig
metadata:
  name: main
spec:
  platform:
    type: "baremetal"
    loadBalancer:
      type: "cilium-l2"
      ipPools:
        - cidrs:
          - 192.168.22.128/25

  cluster:
    baseDomain: "stackland.internal"

    networking:
      hostsNetwork:
        - cidr: 192.168.22.0/25
      clusterNetwork:
        - cidr: 172.16.0.0/16
      servicesNetwork:
        - cidr: 10.96.0.0/12
      virtualIPs:
        api: 192.168.22.127

    storage:
      defaultStorageClass: "stackland-ssd"

  genericHostConfig:
    disksConfig:
      - installDisk:
          name: "/dev/sda"
    networkConfig:
      routes:
        - to: "0.0.0.0/0"
          via: "192.168.22.1"
          iface: "eth0"
      resolvers:
        - "192.168.22.1"
      timeservers:
        - "192.168.22.1"

---
apiVersion: v1alpha1
kind: StacklandHostsList
metadata:
  name: main
spec:
  hosts:
    - hostname: "node1.baremetal.internal"
      role: "combined"
      networkConfig:
        interfaces:
          - macaddress: "06:2a:b7:15:de:f1"
            name: "eth0"
        addresses:
          - interface: "eth0"
            ip: "192.168.22.2/24"

    - hostname: "node2.baremetal.internal"
      role: "combined"
      networkConfig:
        interfaces:
          - macaddress: "0e:9d:6b:fc:42:88"
            name: "eth0"
        addresses:
          - interface: "eth0"
            ip: "192.168.22.3/24"

    - hostname: "node3.baremetal.internal"
      role: "combined"
      networkConfig:
        interfaces:
          - macaddress: "02:5e:c3:a8:07:d9"
            name: "eth0"
        addresses:
          - interface: "eth0"
            ip: "192.168.22.4/24"
```

Save the configuration in the `config/` folder and create the secrets file:

```bash
sladm secrets add --out config/secrets.yaml --license-key key.json
chmod 600 key.json config/secrets.yaml
```

Learn more about preparing secrets [here](../quickstart.md#prepare-secrets).

## Start PXE installation {#start-installation}

Start installation on the bastion:

```bash
sladm install \
  --config config/ \
  --dhcp-interface <interface_name> \
  --pxe-folder ./pxe \
  --installation-timeout 3h
```

Command parameters:

* `--config`: Path to the directory with configuration files.
* `--dhcp-interface`: The bastion's network interface connected to the private subnet hosting the cluster servers.
* `--pxe-folder`: Path to the directory with PXE files.
* `--installation-timeout`: Installation timeout. For PXE installations on {{ baremetal-name }} servers, consider increasing this value, as selecting a boot device via the KVM may take extra time.

For example, if the bastion's private interface is named `eth1`, the command would be:

```bash
sladm install \
  --config config/ \
  --dhcp-interface eth1 \
  --pxe-folder ./pxe \
  --installation-timeout 3h
```

Once started, `sladm` waits for nodes to boot over the network and connect to the installation process.

If pre-checks fail because nodes have not yet booted into the installation environment, either resolve the reported issues or restart installation with the `--ignore-checks` flag, as described in [Installing a cluster](../quickstart.md#installation-online).

## Boot servers over the network {#boot-servers}

For each cluster server, perform the following steps:

1. Connect to the [KVM console](https://yandex.cloud/ru/docs/baremetal/operations/servers/server-kvm).
1. Open the boot device selection menu.
1. Select network boot: **Network Boot**, **PXE Boot**, or **UEFI PXE IPv4** for the private interface whose MAC address is listed in `StacklandHostsList`.
1. Wait for the {{ stackland-name }} installation environment to load.

If the server opens UEFI Shell, select `exit`, return to the boot menu, and select network boot. Do not set UEFI Shell as the primary boot device. If both IPv4 and IPv6 are available, go for IPv4.

After network boot, the server receives an IP address from the built-in `sladm` DHCP server and loads the installation environment via TFTP. The rest of the installation proceeds automatically.

In `sladm` logs, you should see received DHCP requests and TFTP file transfers. For example:

```text
INFO  DHCP: Received request  {"mac": "06:2a:b7:15:de:f1", "message_type": "DISCOVER"}
INFO  DHCP: Processing request from known MAC  {"mac": "06:2a:b7:15:de:f1", "hostname": "node1", "ip": "192.168.22.2"}
INFO  TFTP read request  {"client": "192.168.22.2:49152", "filename": "ipxe.efi"}
INFO  TFTP transfer completed  {"client": "192.168.22.2:49152", "filename": "ipxe.efi"}
```

After installation, the node will boot from its local disk.

Expected stages in `sladm` logs:

1. DHCP request from a known MAC address.
1. TFTP download of `boot.ipxe`, `vmlinuz`, and `initramfs.xz`.
1. The Talos API becomes available at the node's IP on port 50000.
1. The Kubernetes API becomes available at the virtual IP on port 6443.
1. The {{ stackland-name }} components become ready.

Installation is complete when `sladm` reports successful completion of the reconcile cycle and saves the administrator kubeconfig. If installation was interrupted after node boot or during platform component setup, re-run `sladm install` with the same configuration file. The installer will resume from the last completed stage.

If nodes are already installed, booted from local disks, and accessible via the Talos API, PXE boot is no longer needed for the restart. In this case, you may omit `--pxe-folder` and disable the `sladm` DHCP server.

```bash
sladm install \
  --config config/ \
  --dhcp-interface none \
  --installation-timeout 3h
```

If your `sladm` version does not support `none` for `--dhcp-interface`, re-run the original command with both `--dhcp-interface` and `--pxe-folder`. Before restarting, ensure UDP ports 67 and 69 are either free or exclusively used by the current `sladm` process.

## Check the installation {#verification}

Cluster verification is identical to the base use case. Perform the actions described in these sections:

* [Testing the cluster](../quickstart.md#verification)
* [Checking the cluster validity and next steps](install-on-yc-bms.md#final-check)

Additionally, verify that all nodes and platform components are ready:

```bash
kubectl get nodes
kubectl get componentinstallations.stackland.yandex.cloud
kubectl get pods -A --field-selector=status.phase!=Running,status.phase!=Succeeded
```

In a successful installation:

* All nodes are `Ready`.
* All `ComponentInstallation` resources are `Ready`.
* The pod search command returns no unexpected resources.

Check for warnings in Kubernetes events:

```bash
kubectl get events -A --field-selector type=Warning --sort-by=.lastTimestamp
```

Old Kubernetes events may persist after an issue has been resolved. Do not delete them until diagnostics are complete. If `sladm install` succeeded, all components are ready, and the warning no longer recurs, you can safely remove the stale event:

```bash
kubectl delete event -n <namespace> <event_name>
```
