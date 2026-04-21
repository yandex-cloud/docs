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

## Accessing talosctl for advanced diagnostics {#talosctl-access}

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
