```yaml
# You can split the configuration into several files.
# Below is an example with four documents (including secrets) in a single file.
# This is done for clarity; in a real-life deployment, we recommend putting the documents into separate files.

# Cluster configuration
apiVersion: v1alpha1
kind: StacklandClusterConfig
metadata:
  name: main
spec:
  platform:
    type: "baremetal"                            # Platform on which the deployment takes place: `baremetal` for physical servers or `vmware` for VMware virtualization
    loadBalancer:
      type: "cilium-l2"                          # Load balancer type. Currently only `cilium-l2` (Cilium L2 announcements) is available.
      ipPools:
        - cidrs:
          - 192.168.23.128/25                    # Range from which load balancer addresses will be assigned. You can specify it as CIDR notation...
#        - ranges:
#          - start: 192.168.24.10                # ...or in the form of the first and last address (inclusive)
#            end: 192.168.24.12

  cluster:
    baseDomain: "stackland.internal"             # Required. Cluster domain.

    networking:
      hostsNetwork:
        - cidr: 192.168.23.0/25                  # Required. Subnet in which the IP addresses of the cluster hosts are located.
      clusterNetwork:
        - cidr: 172.16.0.0/16                    # Required. Subnet from which the IP addresses of the cluster pods are allocated.
      servicesNetwork:
        - cidr: 10.96.0.0/12                     # Required. Subnet from which the IP addresses of the cluster services are allocated.
      virtualIPs:
        api: 192.168.23.127                      # Optional, but highly recommended. Virtual IP address that is assigned to one of the healthy `control-plane` nodes and is transferred to another node if an issue occurs. Select any unoccupied IP address from the hostsNetwork range.

    storage:
      defaultStorageClass: "stackland-other"     # Required. Default storage class: "stackland-hdd", "stackland-ssd", "stackland-nvme", or "stackland-other". The specified storage class must have disks in it; otherwise, the cluster cannot be deployed.

  genericHostConfig:                           # General settings for all cluster hosts. Can be overridden for individual hosts in StacklandHostsList.

    disksConfig:                               # Disk settings. All the properties listed below are also supported at individual host level in StacklandHostsList.
      - installDisk:
          name: "/dev/sda"                     # Required. Disk the system will be installed on.

    networkConfig:                             # Network settings. All the properties listed below are also supported at individual host level in StacklandHostsList.
      routes:                                  # Optional. Static route settings.
        - to: 0.0.0.0/0                        # Required. IPv4 CIDR.
          via: "192.168.23.1"                  # Optional. If not specified, the route is available directly.
          iface: "eth0"                        # Required. Name of the interface for which the route is specified.
      resolvers:
        - 192.168.23.1                         # Optional. IP address of the DNS resolver to use on the server nodes.
      timeservers:
        - 192.168.23.1                         # IP address of the time server (NTP). Optional if the {{ stackland-name }} cluster has internet access. Otherwise, specify the address of the internal NTP server.

#    genericHostConfigByRole:                    # General settings to apply to hosts of a specific role. Can be overridden for individual hosts in StacklandHostsList. Cannot be used together with genericHostConfig.
#      controlPlane: {...}
#      worker: {...}
#      combined: {...}
---
# Configuration of control plane hosts
apiVersion: v1alpha1
kind: StacklandHostsList
metadata:
  name: control-plane
spec:
  hosts:                                         # Settings for the hosts where the cluster will reside.

    - hostname: "cp1.stackland.internal"         # Required. Host FQDN. If the host has only addresses assigned via DHCP, the name must be resolvable at the time of cluster deployment.
      role: "control-plane"                      # Required. Host role: `control-plane`, `worker`, or `combined`.

      networkConfig:
        interfaces:                              # Network interface settings. You can skip this section for single-interface machines: the interface will be automatically named `eth0`.
          - macaddress: "f4:52:14:0b:10:a1"      # Required. MAC address of the network interface. It is used as the interface ID when running searches.
            name: "eth0"                         # Required. Name (ID) ​​used to refer to the interface from the `addresses` section. It may not match the network interface name assigned by the Linux kernel (`eth0`, `eno1`, etc.)
        addresses:                               # Address settings. You can skip this section for machines with a single network interface: in this case, DHCP at `eth0` is implied.
          - interface: "eth0"                    # Required. Name of one of the interfaces. It must match the one assigned in the interfaces section.
            ip: "192.168.23.2/24"                # Required. CIDR-formatted IPv4 address the host will be available at during and after installation.
#           dhcp: true                           # Assign address to the interface via DHCP. Prioritized higher than ip: above.
---
#  Settings of the payload hosts
apiVersion: v1alpha1
kind: StacklandHostsList
metadata:
  name: workers
spec:
  hosts:
    - hostname: "wrk1.stackland.internal"
      role: "worker"

      # There is no networkConfig section, because the host has a single DHCP-configured network interface, and the routing, DNS resolver, and NTP settings are no different from the typical ones.

    - hostname: "wrk2.stackland.internal"
      role: "worker"

      disksConfig:
        - installDisk:
            name: "/dev/sdc"                     # Overrides the typical value specified in `StacklandClusterConfig`.

      # There is no networkConfig section, because the host has a single DHCP-configured network interface, and the routing, DNS resolver, and NTP settings are no different from the typical ones.

      features:                                  # Overrides the typical value specified in `StacklandClusterConfig`.
        - gpu                                    # GPU support should be enabled on the host.
        - nvlink                                 # You should enable NVLink support on the host NVLink
---
# Secrets (managed via the `sladm secrets` command)
apiVersion: v1alpha1
kind: StacklandSecretsConfig
metadata:
  name: main
spec:
#  ...
```
