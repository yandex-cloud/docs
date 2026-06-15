#### What are the advantages of {{ mgl-name }} over a custom {{ GL }} Community Edition installation? {#advantages}

The main advantage of {{ mgl-name }} is lower installation and administration costs for {{ GL }}. In addition, {{ mgl-name }} adds features not found in [Community Edition](https://about.gitlab.com/install/ce-or-ee/), such as approval rules. For more information, see [Advantages over a custom {{ GL }} installation](../../managed-gitlab/concepts/managed-gitlab-vs-custom-installation.md).

#### How can I migrate data from {{ GL }} to {{ mgl-name }}? {#migration}

You can migrate data from a custom {{ GL }} installation to {{ mgl-name }}. Learn how to do this in [this guide](../../managed-gitlab/operations/instance/migration.md). Before you begin, see [how to run migration](../../managed-gitlab/concepts/migration.md).

You cannot migrate data from {{ GL }}.com to {{ mgl-name }}: migration is only available for {{ GL }} installed on a server or local computer (self-managed {{ GL }}).

#### Can I integrate {{ GL }} authentication providers? {#auth-provider}

Yes, you can. To do this, [configure OmniAuth](../../managed-gitlab/operations/omniauth.md).

#### Can I use Yandex ID or Yandex 360 for authentication? {#auth-yandex-id}

Yes, you can. To do this, [add a provider](../../managed-gitlab/operations/omniauth.md#add-provider) of the `Yandex ID` type to OmniAuth and configure its [settings](../../managed-gitlab/operations/omniauth.md#yandex-id).

#### Is there {{ GL }} integration with {{ tracker-full-name }}? {#tracker-integration}

Yes, there is. For the integration settings, see [Integration with {{ tracker-full-name }}](https://yandex.ru/support/tracker/ru/user/gitlab).

#### Why cannot I push changes to my {{ mgl-name }} repository? {#push}

Error messages:

```text
You are not allowed to push code to this project.
```

```text
You are not allowed to push code to protected branches on this project.
```

To push changes to a {{ mgl-name }} repository, [assign]({{ gl.docs }}/ee/user/project/members/#add-users-to-a-project) the user the appropriate role in the project. To push changes:

* To protected branches, e.g., `master`, assign the `Maintainer` or `Owner` role.
* To unprotected branches, assign the `Developer`, `Maintainer`, or `Owner` role.

Users with the `Guest` and `Reporter` roles cannot push changes.

For more information about roles, see the [this {{ GL }} article]({{ gl.docs }}/ee/user/permissions.html).

#### I get `500 Internal Server Error` when trying to open my instance. What could be the issue?

The instance may run out of disk space. You can [increase the instance disk space](../../managed-gitlab/operations/instance/instance-update.md) on your own.

For details, see [{#T}](../../managed-gitlab/operations/instance/clean-up-disk-space.md).

#### How can I clear pipeline logs to free up disk space? {#pipeline-cleanup}

Logs cannot be deleted separately. However, you delete them by [deleting irrelevant pipelines](../../managed-gitlab/operations/instance/clean-up-disk-space.md#pipeline-cleanup).

#### Where can I monitor my disk space usage? {#disk-space}

You can monitor your disk space usage:

* In the management console using the [instance state monitoring](../../managed-gitlab/operations/instance/monitoring.md#view-graphs) tools.
* In [{{ monitoring-full-name }}](../../monitoring/concepts/index.md), where you also can [set up alerts](../../managed-gitlab/operations/instance/monitoring.md#monitoring-integration) for specified metrics.

#### How can I configure an alert for when disk usage reaches a certain percentage? {#alert-for-disk-space}

See [Setting up alerts in {{ monitoring-name }} for {{ mgl-name }}](../../managed-gitlab/operations/instance/monitoring.md#monitoring-integration).

#### Why are backups not created? {#backup-failed}

If backup creation fails (the `Failed` status), [set up a dedicated security group](../../managed-gitlab/operations/configure-security-group.md) and assign it to the {{ GL }} instance.

#### Can I change instance type or disk size after the instance has been created? {#change-type-size}

Yes, you can upgrade your instance to a higher-performance type and increase its disk size. However, you cannot reduce instance disk size or downgrade the instance to a lower-performance type. For more information, see [{#T}](../../managed-gitlab/operations/instance/instance-update.md).

#### What should I do if I cannot connect to the system hook on `localhost`? {#system-hooks-localhost}

If you cannot connect to the system hook, use the `127.0.0.1` IP address instead of `localhost`:

1. In the system hook settings (**Admin area** → **System Hooks**), change the **URL** value to `http://127.0.0.1:24080/default`.
1. In the {{ GL }} settings that allow sending messages to the local network (**Admin area** → **Settings** → **Network** → **Expand outbound requests**, the CIDR input field), add `http://127.0.0.1:24080` to the list of IP addresses and domain names.

#### What must I do if I get the EOF fatal error on a worker? {#eof-fatal-error}

Complete error message:

```text
EOF fatal: early EOF fatal: fetch-pack: invalid index-pack output
```

You can fix the error only in a runner deployed manually on the VM. Do it by applying these settings:

```bash
sysctl -w net.core.rmem_max=26214400
sysctl -w net.core.rmem_default=6250000
sysctl -w net.core.wmem_max=26214400
sysctl -w net.core.wmem_default=6250000
sysctl -w net.ipv4.tcp_rmem='4096 6250000 26214400'
sysctl -w net.ipv4.tcp_wmem='4096 6250000 26214400'
```