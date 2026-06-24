# Diagnostics and troubleshooting

{{ stackland-name }} comes with a specialized tool, `sladm diag`, for collecting diagnostic information on cluster state. This is a command line utility designed for Ubuntu 22.04 or a similar Linux distribution. Generally, `sladm diag` runs on the same host that was used to deploy the {{ stackland-name }} cluster.

While running, `sladm diag` creates an archive containing log files for the installer, core {{ stackland-name }} components, and key Kubernetes resources. Sensitive data is either not included in the archive or, if it is required to preserve structural integrity, replaced with the `<redacted>` string (`PHJlZGFjdGVkPg==` in base64). A user can view the archive content at any time to make sure that their company policies and regulations allow sending it to {{ stackland-name }} developers.

## How to collect diagnostic data

To start diagnostics, navigate to the directory from where you installed {{ stackland-name }}. Make sure `sladm` is available and run the following command:

```bash
sladm diag
```

Data collection takes a few minutes. Once it is complete, the `diagnostics-YYYYMMDD-HHMMSS.tar.gz` archive to send to the {{ stackland-name }} team will appear in the current folder.

If you are running `sladm diag` from outside the installation directory, specify the paths to the installer's output artifacts (the `_out` directory) and `sladm` log files as follows:

```bash
sladm diag \
  --artifacts-dir /path/to/_out \
  --install-log /path/to/install.log
```

In certain cases, {{ stackland-name }} developers may request you to collect diagnostic data from additional Kubernetes namespaces. In this case, add the `--addns` key (which may repeat multiple times):

```bash
sladm diag \
  --addns some-namespace \
  --addns some-other-namespace
```

You can modify the name of the output archive with diagnostic data using the `--output` key:

```bash
sladm diag \
  --artifacts-dir /path/to/_out \
  --install-log /path/to/install.log \
  --output my-stackland-cluster.tar.gz
```

You will get the archive with diagnostic data even when data collection completes with an error. In this case, `sladm diag` will show the relevant notification. Contact the {{ stackland-name }} team to find out what to do next.

## Secrets not injected into the pod {#secrets-not-injected}

If the Secrets Injector does not inject secrets into environment variables or configuration files, see the [Secrets Store diagnostics](secrets-store/troubleshooting.md) section. It describes the typical causes: incorrect placement of annotations, missing `command` field, errors configuring the role in the Secrets Store, etc.

## Accessing _talosctl_ for advanced diagnostics {#talosctl-access}

{% note alert %}

`talosctl` is a tool for emergency access to cluster nodes not intended for daily operations. Misuse of `talosctl` may lead to cluster disruption or data loss.

Use `talosctl` only for advanced diagnostics provided you understand the impact of each command you are running.

{% endnote %}

### Locating talosconfig {#talosconfig-location}

Upon successful installation of {{ stackland-name }}, an administrative configuration file, `talosconfig`, is automatically created and stored on the bastion host, in the installer directory:

```
_out/talosconfig
```

This file contains credentials for accessing cluster nodes via `talosctl`.

### Basic operations with talosctl {#talosctl-usage}

Download `talosctl` from the [project website](https://github.com/siderolabs/talos/releases/tag/v1.11.6).

To use it in your cluster, specify the configuration file path:

```bash
export TALOSCONFIG=_out/talosconfig
_out/bin/talosctl --nodes <node_IP_address> <command>
```

Examples of diagnostic commands:

* Viewing logs of system services:

  ```bash
  _out/bin/talosctl --nodes 192.168.22.2 logs kubelet
  ```

* Health-checking a node:

  ```bash
  _out/bin/talosctl --nodes 192.168.22.2 health
  ```

* View the list of running services:

  ```bash
  _out/bin/talosctl --nodes 192.168.22.2 services
  ```

* Getting information about disks:

  ```bash
  _out/bin/talosctl --nodes 192.168.22.2 disks
  ```

For a complete list of commands and their descriptions, see the [Talos CLI reference](https://www.talos.dev/latest/reference/cli/).

### Limitations and risks {#talosctl-limitations}

When using `talosctl`, consider the following:

* Directly reconfiguring nodes with `talosctl` may desynchronize them with your {{ stackland-name }} cluster state.
* Some operations, e.g., node reboots or network setting updates, can trigger temporary service downtime.
* Use `talosctl` only to collect information or make targeted changes in settings via `talosctl mc patch`. Other write commands will lead to cluster failure and data loss.
* Restrict access to `talosconfig`, as it provides full administrative control over cluster nodes.

For routine cluster operations, use `kubectl` and other standard Kubernetes tools.

## sladm stopped due to temporary unavailability of the node {#rerun-sladm}

If the `Node is not running+ready in configured state` message is logged, and then the installation terminates with an error, check the nodes for their current state:

```bash
kubectl get nodes -o wide
```

If all nodes are `Ready`, repeat the installation command:

```bash
./sladm install --config config/ --installation-timeout 2h 2>&1 | tee install-rerun-$(date +%y%m%d-%H%M).log
```

Re-running is safe: `sladm` will re-check the state of nodes and components and continue the installation.

## `Failed` jobs in storage left over from the previous attempt {#storage-failed-jobs}

If `sladm` ended with the `Your Stackland cluster is ready` message, and `platformconfig` turned `Installed`, yet there are still old pods or jobs in the `Error` or `Failed` state in the `stackland-storage` namespace, check the jobs and operators for their current state:

```bash
kubectl get platformconfig main -o jsonpath='{.status.initialInstall.state}{"\n"}'
kubectl get jobs -A | grep -E 'storage|s3|mds|nscfg|gosper' || true
kubectl get pod -n stackland-storage -o wide
kubectl get pod -n stackland-storage-goose -o wide
kubectl get pod -n stackland-storage-mds2 -o wide
```

If your re-run jobs end up `Complete`, and the _storage_ operators are in the `Running` state, the old `Failed` jobs belong to previous installation attempts. They do not block access to the management console but may remain in the output of diagnostic commands until you clear the job history.

## The monitoring component stuck in the Updating state {#monitoring-updating}

If `monitoring-main` is stuck in the `Updating` state for a long time, check the `stackland-monitoring` namespace pods:

```bash
kubectl get pod -n stackland-monitoring
kubectl describe pod -n stackland-monitoring <pod_name>
kubectl logs -n stackland-monitoring <pod_name> --previous --tail=100
```

If the `kube-state-metrics` pod had been terminated due to `OOMKilled`, wait for the next component check or re-run `sladm install`. If the problem persists, increase the monitoring component's resources.

### Installation interrupted due to the Kubernetes API being unreachable {#kubernetes-api-unreachable}

During installation, nodes need to reboot several times. This is when temporary Kubernetes API access errors, e.g., `Kubernetes cluster unreachable`, may get logged. Wait for the Talos API of all nodes and the Kubernetes API to become available:

```bash
nc -vz 192.168.22.2 50000
nc -vz 192.168.22.3 50000
nc -vz 192.168.22.4 50000
nc -vz 192.168.22.127 6443
```

Replace the addresses with the values from your configuration. After availability is restored, restart `sladm install` with the same command. The installer will resume from the last completed stages.

### Installation interrupted during the configuration of components {#components-not-ready}

If `sladm` terminated with an error during the platform component configuration stage, first check the current state of the cluster. The error in the old log may no longer correspond to the current state of the resources:

```bash
kubectl get componentinstallations.stackland.yandex.cloud
kubectl get pods -A --field-selector=status.phase!=Running,status.phase!=Succeeded
kubectl get events -A --field-selector type=Warning --sort-by=.lastTimestamp
```

If the `ComponentInstallation` output contains the phases `Installing`, `Updating`, or `Error`, check the description of the relevant resource:

```bash
kubectl describe componentinstallation <componentinstallation_name>
```

After you address the cause of the error, re-run `sladm install` with the same `--config`. If the nodes are already installed and accessible via the Talos API, disable PXE/DHCP for the re-run:

```bash
sladm install \
  --config config/ \
  --dhcp-interface none \
  --installation-timeout 3h
```

Wait until `sladm` completes successfully. Then repeat the checks from the [Check the installation](#verification) section.

### Installation timeout expired {#installation-timeout}

By default, the installation has a timeout limit. When installing via PXE, increase it if you need to select the boot device or reboot servers via KVM manually:

```bash
sladm install \
  --config config/ \
  --dhcp-interface eth1 \
  --pxe-folder ./pxe \
  --installation-timeout 3h
```

### sladm ignores the node's DHCP requests {#unknown-mac}

If `sladm` ignores the node's DHCP requests, check the MAC address in the configuration. It must match the MAC address of the network interface used to boot the server via PXE.

Specify the MAC address in lowercase with colons, e.g., `06:2a:b7:15:de:f1`.
