---
title: Migrating from {{ iot-full-name }} to open-source MQTT solutions
description: This tutorial explains how to migrate from {{ iot-full-name }} to open-source MQTT solutions.
---

# Migrating from {{ iot-full-name }} to open-source MQTT solutions

{% include [iot-sunset-warning](../../_includes/iot-core/sunset-warning.md) %}

{% include [migration-note](../../_includes/iot-core/migration-note.md) %}

After {{ iot-full-name }} is phased out, you can deploy an alternative MQTT solution on your own: either on a {{ compute-full-name }} [VM instance](../../compute/concepts/vm.md) or in a {{ managed-k8s-full-name }} [cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).

In place of {{ iot-full-name }}, you can use the following open-source solutions, all of which can run in {{ yandex-cloud }}:

* [Eclipse Mosquitto](https://mosquitto.org/): Recommended for most scenarios where {{ iot-full-name }} was used as an MQTT broker.
* [TBMQ Community Edition](https://thingsboard.io/products/mqtt-broker/): Suitable for high-load MQTT scenarios requiring clustering and long-term message delivery.
* [ThingsBoard Community Edition](https://thingsboard.io/): Suitable for scenarios where, apart from MQTT, you also need device management, dashboards, a rule engine, and a UI.

{% note warning %}

There is no fully compatible open-source alternative for {{ iot-full-name }}. After the migration, you will have to administer your broker or IoT platform yourself by updating the software, configuring TLS, storing credentials, doing backups, monitoring availability, and doing your fault tolerance planning.

{% endnote %}

## How to choose your target solution {#choice}

The section below briefly compares the three options. This guide gives detailed deployment steps for Eclipse Mosquitto. For TBMQ and ThingsBoard, refer to relevant official guides.

Criterion | Eclipse Mosquitto | TBMQ CE | ThingsBoard CE
--- | --- | --- | ---
Type | Lightweight MQTT broker | Clustered MQTT broker | IoT platform with MQTT API
Optimal use case | Direct replacement for the MQTT functionality of {{ iot-full-name }} | High workload, many connections | You need UI, dashboards, rule engine, device management
Clustering | No (active/passive only) | Yes, horizontal scaling | Yes
External dependencies | No | {{ KF }}, {{ RD }}, {{ PG }} | {{ PG }} (other storages optionally)
Device management and UI | No | No | Yes
Operation complexity | Low | High | High

Choose Eclipse Mosquitto if:

* Devices use MQTT and connect to {{ iot-full-name }} over TLS.
* Your main logic centers around publishing and subscribing to topics.
* You are ready to replace your {{ iot-full-name }} integrations with {{ sf-full-name }}, {{ serverless-containers-full-name }}, or {{ yds-full-name }} with a proprietary message handler.
* You are happy with a single broker or active/passive level fault tolerance.

Choose TBMQ Community Edition if:

* Your MQTT broker deals with high workloads.
* You need clustering, horizontal scaling, and more reliable message delivery.
* You are ready to maintain additional infrastructure, e.g., {{ KF }} and a database.

Choose ThingsBoard Community Edition if:

* {{ iot-full-name }} was part of a broader IoT system.
* You need device management, dashboards, a rule engine, a UI, telemetry storage, and event handling.
* You are ready to adapt your devices and backend to ThingsBoard's data model.

{% note tip %}

We recommend you to start with Eclipse Mosquitto as the simplest way to migrate your MQTT traffic. You can add a more sophisticated IoT platform later on if needed.

{% endnote %}

## What will change after the migration {#changes}

Migrating from {{ iot-full-name }} to a custom MQTT solution will affect several key parts of your architecture.

### Endpoint {#endpoint}

In {{ iot-full-name }}, devices were connecting to a managed endpoint provided by the service. After the migration, you will have to create an endpoint of your own, for example:

```text
mqtt.example.com:8883
```

The endpoint may point to:

* Public IP address of a VM running Eclipse Mosquitto.
* Network load balancer upstream of the broker.
* `LoadBalancer`-type `Service` in {{ managed-k8s-full-name }}.

For MQTT, use TCP port `8883` with TLS. An L7 load balancer is not suitable for standard MQTT because MQTT uses TCP, not HTTP.

If some of the clients connect via MQTT over WebSocket (e.g., web or browser clients), configure a separate Mosquitto listener with `protocol websockets` and TLS (typically on port `443`) and open this port in your security group.

### Authentication {#authentication}

In {{ iot-full-name }}, devices could use the following:

* X.509 certificates.
* username and password.

Mosquitto supports the same mechanisms:

* `password_file`: For authentication by username and password.
* `require_certificate` and `use_identity_as_username`: For client certificate-based authentication.
* `acl_file`: For topic-level access control.

{% note warning %}

Device and registry passwords are not exported from {{ iot-full-name }} in plaintext and cannot be retrieved from {{ yandex-cloud }}. If you had not saved the passwords earlier, follow these steps after the migration:

1. Generate a new password for each device in your target MQTT broker (e.g., via `mosquitto_passwd`).
1. Update the firmware or configuration of each device using the new credentials.
1. Provide a phased rollout plan and a maintenance window: if you change all passwords at once, devices that do not get an update will no longer be able to connect.
1. For large fleets, prepare a mechanism for bulk delivery of credentials (OTA updates, configuration service, MDM) in advance.

{{ iot-full-name }} does not exports registry passwords. If your backend used them for broker connections, issue new credentials for it.

{% endnote %}

### Topics {#topics}

In {{ iot-full-name }}, devices and registries use the following topics:

```text
$devices/<device_id>/events
$devices/<device_id>/state
$devices/<device_id>/commands
$devices/<device_id>/config
$registries/<registry_id>/events
$registries/<registry_id>/state
$registries/<registry_id>/commands
$registries/<registry_id>/config
```

The `state` and `config` topics are persistent: the broker stores the last message in them. In standard MQTT, a similar thing is implemented via retained messages (see [below](#permanent-topics)).

For the migration, keep this structure unchanged (`$devices/...`, `$registries/...`) in Mosquitto to avoid tweaking the firmware of devices. All examples below use exactly this structure. Switching to non-`$` topics is a separate optional step. If you do it, you need to update device firmware, ACLs, and subscribers at the same time.

{% note info %}

If devices were connecting to {{ iot-full-name }} via topic aliases (e.g., by publishing to `events` instead of `$devices/<device_id>/events`), upgrade them to full topic names after the migration because Mosquitto does not expand {{ iot-full-name }} aliases.

The `$me` system alias will not work in Eclipse Mosquitto either: a standard MQTT broker does not substitute `$me` with device ID. If devices were publishing or reading topics via `$me/...`, rename them to explicit `$devices/<device_id>/...` paths (or a new topic scheme of your choice) and update device firmware, ACLs, and backend subscriptions at the same time.

{% endnote %}

{% note info %}

In MQTT, topics starting with `$` have special significance. A subscription to `#` gets no messages from such topics. If you choose to temporarily preserve the `$devices/...` structure, subscribe to it explicitly (e.g., `$devices/#`).

{% endnote %}

{% note warning %}

Unlike {{ iot-full-name }}, which was routing `events`, `$devices/<id>/events`, and `devices/<id>/events` into the same logical message, in a standard MQTT broker, `$devices/<id>/events` and `devices/<id>/events` are different topics. A message published into one of them will not reach the subscriber of the other one.

This is critical during phased migration when some devices are already reissued to use the new prefix, while others are not:

* In ACLs, duplicate rules for both prefixes (done in the examples below).
* Backend subscribers must subscribe both to `$devices/+/events/#` and `devices/+/events/#`; otherwise, they will be receiving messages only from one of the device groups.
* Commands and configs, on the contrary, must be published to the prefix expected by the particular device.

{% endnote %}

### Persistent state and config topics {#permanent-topics}

In {{ iot-full-name }}, `state` and `config` are persistent topics used by the service to store the last message.

Standard MQTT replicates this behavior using the `retain` flag. After the migration:

* When publishing device state to `state`, set `retain = true` in the message.
* When publishing device configuration to `config`, also use `retain = true`.
* Make sure your target broker stores retained messages on a persistent disk.

Example of publishing a retained message via `mosquitto_pub`:

```bash
mosquitto_pub \
  -h mqtt.example.com \
  -p 8883 \
  --cafile rootCA.crt \
  -u <device_id> \
  -P '<password>' \
  -t 'devices/<device_id>/state' \
  -m '{"online":true}' \
  -q 1 \
  -r
```

### Triggers and message export {#export}

If you were using triggers to invoke {{ sf-name }} functions or {{ serverless-containers-name }} containers, replace them with a custom MQTT subscriber after the migration.

Such a subscriber must:

* Subscribe to relevant MQTT topics.
* Convert messages to the right format.
* Invoke functions, containers, HTTP APIs, or send data to {{ yds-full-name }} streams.
* Log errors and retry the procedure on failure.

For an example, see [{#T}](#replace-triggers).

## Mosquitto migration architecture {#architecture}

We recommend this minimal architecture:

1. Devices connect to Mosquitto over MQTTS, port `8883`.
1. Mosquitto checks the device's username/password or client certificate.
1. Mosquitto applies ACLs thus allowing the device to publish and read it own topics only.
1. The backend subscriber receives messages from the `events` and `state` topics.
1. The backend subscriber forwards messages to your handlers, databases, {{ sf-name }} functions, {{ serverless-containers-name }} containers, or {{ yds-full-name }} streams.
1. The backend application publishes the commands and configuration to the `commands` and `config` topics.

```text
┌─────────────┐        MQTT/TLS          ┌──────────────┐
│ Devices  │  ─────────────────────▶  │  Mosquitto   │
└─────────────┘                          └──────┬───────┘
                                                │ MQTT subscribe
                                                ▼
                                      ┌────────────────────┐
                                      │ Backend subscriber │
                                      └─────────┬──────────┘
                                                │
                 ┌──────────────────────────────┼──────────────────────────────┐
                 ▼                              ▼                              ▼
        {{ sf-name }}              {{ serverless-containers-name }}      {{ yds-full-name }}
```

## Export data from {{ iot-full-name }} {#uploading-data}

Before migrating, export the lists of registries, devices, certificates, and topic aliases.

Install and configure the {{ yandex-cloud }} CLI if you have not done that already:

```bash
yc init
```

Verify your active CLI configuration:

```bash
yc config get cloud-id
yc config get folder-id
yc config get compute-default-zone
```

{% note warning %}

Do not publish or paste into tickets or chats any raw `yc config list` output because it may contain sensitive data. For diagnostics, use the `yc config get ...` commands or mask sensitive fields beforehand.

If you run your migration commands from CI, sandbox, or another restricted environment, make sure `yc` can write its internal logs to an accessible folder, or run your commands outside the sandbox. Otherwise, the CLI may function but flood the output with warnings about being unable to log.

For automation, use the folder specified in `yc config get folder-id` or provide `--folder-id <folder_id>` explicitly. Avoid having your migration scenario depend on broad commands like `yc resource-manager cloud list` or `yc resource-manager folder list`: in large organizations, these may prove slow or require excessive permissions.

{% endnote %}

Create an export folder:

```bash
FOLDER_ID="$(yc config get folder-id)"
mkdir -p iot-export
```

Export the list of registries and brokers. Provide `--folder-id` explicitly for your export not to depend on the folder specified in your local CLI configuration:

```bash
yc iot registry list --folder-id "$FOLDER_ID" --format json > iot-export/registries.json
yc iot broker list --folder-id "$FOLDER_ID" --format json > iot-export/brokers.json
```

Export your devices, registry certificates, and topic aliases:

```bash
for registry_id in $(jq -r '.[].id' iot-export/registries.json); do
  yc iot device list \
    --folder-id "$FOLDER_ID" \
    --registry-id "$registry_id" \
    --format json > "iot-export/devices-$registry_id.json"

  yc iot registry certificate list \
    --folder-id "$FOLDER_ID" \
    --registry-id "$registry_id" \
    --format json > "iot-export/registry-certs-$registry_id.json"

  yc iot registry list-device-topic-aliases \
    --folder-id "$FOLDER_ID" \
    "$registry_id" \
    --format json > "iot-export/aliases-$registry_id.json"
done
```

Export your device certificates:

```bash
for file in iot-export/devices-*.json; do
  registry_id="${file#iot-export/devices-}"
  registry_id="${registry_id%.json}"

  mkdir -p "iot-export/device-certs-$registry_id"

  jq -r '.[].id' "$file" | while read -r device_id; do
    yc iot device certificate list \
      --folder-id "$FOLDER_ID" \
      --device-id "$device_id" \
      --format json > "iot-export/device-certs-$registry_id/$device_id.json"
  done
done
```

{% note warning "Important note" %}

The export files may contain device IDs, certificates, topic aliases, and other sensitive data. Never save them to public repositories. Store them in a private {{ objstorage-full-name }} [bucket](../../storage/concepts/bucket.md) with restricted access and encryption on.

{% endnote %}

## Deploy Mosquitto on a VM {#vm-deployment}

The example below shows how to deploy Mosquitto on a VM in Docker. For a production scenario, configure disk backup, monitoring, and a recovery procedure.

### Create a VM {#create-vm}

Create a {{ compute-full-name }} VM with a Linux image and a public IP address or access via a network load balancer.

Recommendations:

* Use a dedicated service account for infrastructure management.
* Open only port `8883/TCP` in the security group's inbound rules.
* Restrict SSH access.
* Store TLS keys and passwords in {{ lockbox-full-name }} or another secure secret vault.
* Connect {{ monitoring-full-name }} and {{ cloud-logging-full-name }}.

Before you create a VM, select an SSH key and an administrative CIDR allowed to be used for SSH access:

```bash
ls -1 ~/.ssh/*.pub

SSH_PUBLIC_KEY="$HOME/.ssh/<key>.pub"
SSH_PRIVATE_KEY="${SSH_PUBLIC_KEY%.pub}"

ssh-keygen -y -f "$SSH_PRIVATE_KEY" > /tmp/mqtt-broker-key.pub
diff -u /tmp/mqtt-broker-key.pub "$SSH_PUBLIC_KEY"
chmod 600 "$SSH_PRIVATE_KEY"

ADMIN_CIDR="<your-admin-ip-or-vpn-cidr>/32"
```

If your private key is protected by a `passphrase`, load it into `ssh-agent` before you run automation or use a separate key for migration. For CI and sandbox, do not rely solely on external HTTP services for auto-detection of your public IP: the source SSH address may be different from what such services see. In this case, specify `ADMIN_CIDR` explicitly (e.g., your VPN or bastion host CIDR).

Create a security group and configure the minimal inbound rules:

```bash
yc vpc security-group create \
  --name mqtt-broker-sg \
  --network-name default

yc vpc security-group update-rules mqtt-broker-sg \
  --add-rule "direction=ingress,protocol=tcp,port=8883,v4-cidrs=0.0.0.0/0" \
  --add-rule "direction=ingress,protocol=tcp,port=22,v4-cidrs=${ADMIN_CIDR}"
```

Some {{ yandex-cloud }} CLI versions do not support the `yc vpc security-group rule add` command. Use `yc vpc security-group update-rules --add-rule ...` or look up the syntax via `yc vpc security-group update-rules --help`.

Example of creating a VM using the CLI:

```bash
yc compute instance create \
  --name mqtt-broker \
  --zone ru-central1-a \
  --network-interface subnet-name=default-{{ region-id }}-a,nat-ip-version=ipv4,security-group-names=mqtt-broker-sg \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2204-lts,size=15,type=network-hdd \
  --memory 2 \
  --cores 2 \
  --core-fraction 20 \
  --metadata-from-file user-data=cloud-init.yaml \
  --metadata ssh-keys="ubuntu:$(cat "$SSH_PUBLIC_KEY")"
```

Install Docker and Docker Compose on the VM.

{% note warning "Important note" %}

When creating a VM, keep in mind these {{ yandex-cloud }}-specific features:

* The SSH should be provided via `--metadata ssh-keys=...`, not `--ssh-key`. The `--ssh-key` flag is incompatible with `--metadata-from-file user-data`: the {{ yandex-cloud }} CLI puts the SSH key into `user-data` and overwrites your cloud-init. To provide both cloud-init and the SSH key, use `--metadata ssh-keys=...` and `--metadata-from-file user-data=...` (these are two different metadata keys).
* Do not use the `users:` section in cloud-init. {{ yandex-cloud }} uses an EC2-compatible datasource, and if there is a `users:` section present, cloud-init will not add your SSH key to `~/.ssh/authorized_keys` because the key is added by the metadata service, not the `users` module. The default user (`ubuntu` or an image-specific equivalent) is already created in public {{ yandex-cloud }} images; its SSH key is injected via the `ssh-keys` metadata field.
* In `write_files`, do not use heredoc inside `content: |`. The YAML parser will fail with the `while scanning a simple key` error because the heredoc content usually starts with zero indentation and wrecks this section: `|`. Safer approaches:
    * Make each static file (`mosquitto.conf`, `acl`) into a separate `write_files` element with literal `content: |`.
    * In `runcmd`, copy files via `cp` or compile using `printf '%s\n' ...`, not `bash -c 'cat <<EOF ... EOF'`.
* Check your SSH key pair before you create a VM: `ssh-keygen -y -f "$SSH_PRIVATE_KEY"` should output the same public key you are providing to the metadata. If the private key requires an interactive `passphrase`, the automatic SSH will not be able to connect without `ssh-agent`.
* Before the first SSH connection, set permissions to `600` for the private key: `chmod 600 "$SSH_PRIVATE_KEY"`. With the `644` permissions, the SSH client will reject the key as too open.

{% endnote %}

### Prepare the Mosquitto catalog {#prepare-catalog}

Run the following commands:

```bash
mkdir -p mosquitto/config/certs mosquitto/data mosquitto/log
cd mosquitto
```

{% note warning %}

The `eclipse-mosquitto` container runs under the `mosquitto` user (UID `1883`). To allow the broker to store its persistence database and retained messages (including analogs of persistent `state` and `config` topics), this user must be able to write to the `data` catalog:

```bash
sudo chown -R 1883:1883 data log
```

If the `data` catalog is not writable, Mosquitto will not save retained messages, and the last device states will be lost after the container restarts.

{% endnote %}

Create a file named `docker-compose.yaml`:

```yaml
services:
  mosquitto:
    image: eclipse-mosquitto:2
    container_name: mosquitto
    restart: unless-stopped
    ports:
      - "8883:8883"
    volumes:
      - ./config:/mosquitto/config:ro
      - ./data:/mosquitto/data
      - ./log:/mosquitto/log
```

### Prepare the server TLS certificate {#prepare-tls-certificate}

For a production environment, use a certificate for the domain devices will be using to connect to the broker, for example:

```text
mqtt.example.com
```

If devices can validate public root certificates, a public TLS certificate may be used.

If devices use a custom root certificate, put the server certificate and the key in this catalog:

```text
mosquitto/config/certs/server.crt
mosquitto/config/certs/server.key
```

If devices are authenticated using client certificates, also include the root certificate used to sign the client certificates:

```text
mosquitto/config/certs/device-ca.crt
```

### Option 1. Configure username and password {#login-password}

Create a file named `config/mosquitto.conf`:

```text
persistence true
persistence_location /mosquitto/data/
autosave_interval 60

log_dest stdout

listener 8883 0.0.0.0
protocol mqtt

certfile /mosquitto/config/certs/server.crt
keyfile /mosquitto/config/certs/server.key

allow_anonymous false
password_file /mosquitto/config/passwords
acl_file /mosquitto/config/acl
```

Create a password file. For the first user, use the `-c` flag and do not pre-create the file: `mosquitto_passwd -c` must create the new `password_file` itself.

```bash
docker run --rm -it \
  -v "$PWD/config:/mosquitto/config" \
  eclipse-mosquitto:2 \
  mosquitto_passwd -c /mosquitto/config/passwords <device_id>
```

For non-interactive setup, use `-b` but do not save plaintext passwords in shell history:

```bash
docker run --rm \
  -v "$PWD/config:/mosquitto/config" \
  eclipse-mosquitto:2 \
  mosquitto_passwd -b -c /mosquitto/config/passwords <device_id> '<device_password>'
```

{% note warning %}

The hash format in `password_file` depends on the `mosquitto_passwd` version. Generate the password file of the same Mosquitto version used by the target broker or verify compatibility beforehand.

For example, a local `mosquitto_passwd` from a newer installation may generate a hash that cannot be read by the Mosquitto 2.0.18 Ubuntu package, thus causing the broker to reject all users due to the `Unable to decode password salt` error. For the Docker option, use `mosquitto_passwd` from the same `eclipse-mosquitto` image that runs the broker. For the apt version of Ubuntu, prepare `password_file` via `mosquitto_passwd` from the same Mosquito package as on the target VM.

{% endnote %}

For subsequent users, run the command without `-c` to avoid overwriting the file:

```bash
docker run --rm -it \
  -v "$PWD/config:/mosquitto/config" \
  eclipse-mosquitto:2 \
  mosquitto_passwd /mosquitto/config/passwords <another_device_id>
```

Add a dedicated user for backend applications:

```bash
docker run --rm -it \
  -v "$PWD/config:/mosquitto/config" \
  eclipse-mosquitto:2 \
  mosquitto_passwd /mosquitto/config/passwords Backend
```

### Option 2. Configure client certificates {#user-certificate}

If devices already use X.509 certificates and you want keep it that way, configure mTLS.

Create a file named `config/mosquitto.conf`:

```text
persistence true
persistence_location /mosquitto/data/
autosave_interval 60

log_dest stdout

listener 8883 0.0.0.0
protocol mqtt

certfile /mosquitto/config/certs/server.crt
keyfile /mosquitto/config/certs/server.key
cafile /mosquitto/config/certs/device-ca.crt

require_certificate true
use_identity_as_username true

allow_anonymous false
acl_file /mosquitto/config/acl
```

With this configuration, Mosquitto will use the common name from the client certificate as username. Ensure the common name matches the device ID or another stable ID used in your ACL.

{% note warning %}

With `require_certificate true`, all clients, including the backend subscriber, must present a client certificate. Please note the following:

* For a backend subscriber, you should issue a client certificate signed by the same root certificate (`device-ca.crt`) and use it for connection.
* With `use_identity_as_username true`, the common name of the backend user's certificate will become the user name. The `user Backend` rules in the ACL below imply that the backend certificate's common name equals `Backend`.
* There is no username/password option in this configuration as there is no `password_file` section. Examples with `-u ... -P ...` in the sections below belong to Option 1. For mTLS, replace `-u/-P` with `--cert client.crt --key client.key`.

{% endnote %}

{% note warning %}

Certificates registered in {{ iot-full-name }} cannot be migrated to Mosquitto as registry objects. In a custom broker, you set up the trusted root certificate and certificate validation rules yourself. If devices use self-signed certificates without a common root certificate, you may have to reissue the certificates or try another authentication scheme.

{% endnote %}

### Configure an ACL {#acl}

Create a file named `config/acl`.

ACL example when the username matches the device ID:

```text
pattern write $devices/%u/events/#
pattern write $devices/%u/state/#
pattern read $devices/%u/commands/#
pattern read $devices/%u/config/#

pattern write devices/%u/events/#
pattern write devices/%u/state/#
pattern read devices/%u/commands/#
pattern read devices/%u/config/#

user Backend
topic read $devices/+/events/#
topic read $devices/+/state/#
topic write $devices/+/commands/#
topic write $devices/+/config/#

topic read devices/+/events/#
topic read devices/+/state/#
topic write devices/+/commands/#
topic write devices/+/config/#
```

In this example:

* Device can publish only its own events and state.
* Device can read only its own commands and configuration.
* Backend user can read telemetry and publish commands.

If you have used registry topics, add rules for `registries/...` or generate individual access rules for each device.

{% note tip %}

Do not grant devices access to `#` or topics of other devices. This reduces the risk of telemetry leaks and unauthorized command injection.

{% endnote %}

### Run Mosquitto {#launch}

Run the following commands:

```bash
docker compose up -d
docker compose logs -f mosquitto
```

Make sure the broker listens on port `8883`:

```bash
docker compose ps
```

### Alternatively, install Mosquitto via an apt package {#apt}

If your infrastructure does not use Docker, you can install Mosquitto as an Ubuntu system package. While being simpler for cloud-init, this approach requires careful configuration.

```bash
sudo apt-get update
sudo apt-get install -y mosquitto mosquitto-clients
```

Put additional settings in `/etc/mosquitto/conf.d/<name>.conf`, not the main `/etc/mosquitto/mosquitto.conf`.

{% note warning %}

Ubuntu's default `/etc/mosquitto/mosquitto.conf` already contains these lines:

```text
persistence true
persistence_location /var/lib/mosquitto/
```

Starting with Mosquitto 2.x, repeating the same setting in `conf.d` files is a configuration error, and the broker fails to start with a message like this:

```text
Error: Duplicate persistence_location value in configuration.
```

In files inside `conf.d/`, specify only settings not present in the default `mosquitto.conf`. If you need to change `persistence_location`, edit the main file instead of duplicating the setting. For easier verification, use:

```bash
sudo grep -RhE '^(persistence|persistence_location|password_file|acl_file|listener)' \
  /etc/mosquitto/mosquitto.conf /etc/mosquitto/conf.d/
```

Each setting must appear exactly once.

{% endnote %}

If deploying Mosquitto via cloud-init, pay attention to the module execution order: `write_files` runs before `packages`, so the `mosquitto` group may not exist yet. Write files as `root:root`, then change the owner in `runcmd` after installing the package.

It is safer to provide ACLs containing the `$devices/...` and `$registries/...` topics to cloud-init in Base64 encoding: this way `$` will not be interpreted by the shell wrapper during metadata preparation.

The `/etc/mosquitto/passwd` file you provide to cloud-init must be generated by a compatible `mosquitto_passwd` version. If the target VM uses the Mosquitto 2.0.18 Ubuntu package, do not inject a file created by a newer local `mosquitto_passwd` version because your broker may reject users due to unreadable hash.

Example cloud-init snippet for apt package:

```yaml
#cloud-config
packages:
  - mosquitto
  - mosquitto-clients

write_files:
  - path: /etc/mosquitto/conf.d/iot-migration.conf
    owner: root:root
    permissions: "0644"
    content: |
      listener 8883 0.0.0.0
      protocol mqtt
      certfile /etc/mosquitto/certs/server.crt
      keyfile /etc/mosquitto/certs/server.key
      allow_anonymous false
      password_file /etc/mosquitto/passwd
      acl_file /etc/mosquitto/acl
  - path: /etc/mosquitto/acl
    owner: root:root
    permissions: "0640"
    encoding: b64
    content: <base64-encoded-acl>
  - path: /etc/mosquitto/passwd
    owner: root:root
    permissions: "0640"
    encoding: b64
    content: <base64-encoded-password-file>

runcmd:
  - mkdir -p /etc/mosquitto/certs
  - chown mosquitto:mosquitto /etc/mosquitto/acl /etc/mosquitto/passwd
  - chmod 0640 /etc/mosquitto/acl /etc/mosquitto/passwd
  - systemctl reset-failed mosquitto
  - systemctl restart mosquitto
  - systemctl is-active mosquitto
```

The Mosquitto package may attempt to start the service immediately after the installation, even before the execution of `runcmd` (i.e., before certificates and access file permissions are ready). Several failed starts may cause systemd to set the service to the `Start request repeated too quickly` state. Run `systemctl reset-failed mosquitto` before the final `restart` to clear this start-limit.

Do not add `persistence` or `persistence_location` to this `conf.d` file because these are already present in Ubuntu's default `/etc/mosquitto/mosquitto.conf`.

After you edit the configuration, run these commands:

```bash
sudo systemctl restart mosquitto
sudo systemctl status mosquitto
sudo ss -tlnp | grep 8883
```

For the Mosquitto 2.0.18 Ubuntu package, do not use `mosquitto -t` for configuration validation, as this version treats `-t` as an unknown modifier. If the service fails to start, check the diagnostics:

```bash
sudo journalctl -u mosquitto -n 100 --no-pager
sudo grep -RhE '^(persistence|persistence_location|password_file|acl_file|listener)' \
  /etc/mosquitto/mosquitto.conf /etc/mosquitto/conf.d/
```

If using apt, remember to grant permissions for data and log directories to the `mosquitto` user (`chown -R mosquitto:mosquitto /var/lib/mosquitto /var/log/mosquitto`) and to open only `8883/TCP` in the security group.

## Test the connection {#check-connection}

Install the Mosquitto client utilities on your production or test VM.

{% note info %}

The commands below use username/password authentication (Option 1). If you have set up client certificates (Option 2), replace `-u <user> -P <password>` with `--cert client.crt --key client.key`; the username will be taken from the common name of the certificate.

{% endnote %}

{% note info %}

If your smoke test uses a self-signed certificate not issued for an `-h` DNS name, hostname verification will fail. For production environment, issue a certificate for the actual MQTT DNS name. For a brief smoke test over a public IP, you may temporarily add `--insecure` to your commands, but do not use this as standard device configuration.

{% endnote %}

Subscribe to a topic as a backend user:

```bash
mosquitto_sub \
  -h mqtt.example.com \
  -p 8883 \
  --cafile rootCA.crt \
  -u Backend \
  -P '<Backend_password>' \
  -t '$devices/+/events/#' \
  -q 1
```

Publish a test message as a device:

```bash
mosquitto_pub \
  -h mqtt.example.com \
  -p 8883 \
  --cafile rootCA.crt \
  -u <device_id> \
  -P '<device_password>' \
  -t '$devices/<device_id>/events' \
  -m '{"temperature":25}' \
  -q 1
```

Check the retained message for the `state` persistent topic analog:

```bash
mosquitto_pub \
  -h mqtt.example.com \
  -p 8883 \
  --cafile rootCA.crt \
  -u <device_id> \
  -P '<device_password>' \
  -t '$devices/<device_id>/state' \
  -m '{"online":true}' \
  -q 1 \
  -r
```

Subscribe to this topic as a new client. It should immediately receive the last retained message:

```bash
mosquitto_sub \
  -h mqtt.example.com \
  -p 8883 \
  --cafile rootCA.crt \
  -u Backend \
  -P '<Backend_password>' \
  -t '$devices/<device_id>/state' \
  -q 1
```

### Check device isolation via ACL {#device-isolation}

ACL is the most common point where errors reveal themselves only after migration. Always make certain that one device cannot read from or write to another device's topics.

Scenario 1. Foreign commands are not received. First, as `<device_a>`, subscribe to a topic of another device (`<device_b>`):

```bash
mosquitto_sub \
  -h mqtt.example.com \
  -p 8883 \
  --cafile rootCA.crt \
  -u <device_a> \
  -P '<device_a_password>' \
  -t '$devices/<device_b>/commands' \
  -q 1 \
  -W 5
```

The `-W 5` parameter limits execution time to 5 seconds. While the subscriber is working, publish a backend-initiated message to `$devices/<device_b>/commands` and make sure the subscriber receives nothing. The broker logs for `<device_a>` should now contain an ACL denial entry.

Scenario 2. Foreign events cannot be published. As `<device_a>`, try publishing to another device's topic:

```bash
mosquitto_pub \
  -h mqtt.example.com \
  -p 8883 \
  --cafile rootCA.crt \
  -u <device_a> \
  -P '<device_a_password>' \
  -t '$devices/<device_b>/events' \
  -m '{"spoofed":true}' \
  -q 1
```

The command may appear to succeed on the client side, but the message should not reach the backend subscription on `$devices/<device_b>/events/#`. Check specifically for the absence of the message at the backend subscriber and an ACL denial in broker logs, not just the `mosquitto_pub` response code.

Scenario 3. Anonymous connection is denied. Connect without credentials:

```bash
mosquitto_sub \
  -h mqtt.example.com \
  -p 8883 \
  --cafile rootCA.crt \
  -t '$devices/<device_a>/events' \
  -W 5
```

The client should receive the `Connection Refused: not authorised` error.

{% note tip %}

It makes sense to automate these three checks (e.g., in a shell script) and run them as a smoke test after every ACL or password change. If at least one scenario is disrupted, the broker may suffer a telemetry leak or have commands spoofed by devices.

{% endnote %}

## Replace triggers {#replace-triggers}

In {{ iot-full-name }}, you could configure a trigger to invoke a {{ sf-name }} function or a {{ serverless-containers-name }} container upon receiving an MQTT message. In a custom MQTT broker this integration should be implemented via a dedicated subscriber service.

Below is an example of a simple Python subscriber which receives an MQTT message and forwards it to an HTTP handler.

Create a file named `subscriber.py`:

```python
import base64
import json
import os
import queue
import threading
import time
from urllib import request

import paho.mqtt.client as mqtt


MQTT_HOST = os.environ["MQTT_HOST"]
MQTT_PORT = int(os.getenv("MQTT_PORT", "8883"))
MQTT_USERNAME = os.environ["MQTT_USERNAME"]
MQTT_PASSWORD = os.environ["MQTT_PASSWORD"]
MQTT_TOPIC = os.getenv("MQTT_TOPIC", "$devices/+/events/#")
MQTT_CLIENT_ID = os.getenv("MQTT_CLIENT_ID", "iot-core-migration-subscriber")
MQTT_CA_FILE = os.getenv("MQTT_CA_FILE", "rootCA.crt")
WORKER_COUNT = int(os.getenv("WORKER_COUNT", "4"))

HANDLER_URL = os.environ["HANDLER_URL"]

# The queue and worker pool separate receiving MQTT messages and their handling.
# If the HTTP request is handled directly in on_message, a slow handler
# will block the MQTT network loop, causing the client to disconnect due to keepalive timeout.
message_queue: queue.Queue = queue.Queue(maxsize=10000)


def build_event(msg: mqtt.MQTTMessage) -> dict:
    payload_base64 = base64.b64encode(msg.payload).decode("ascii")
    topic_parts = msg.topic.split("/")

    event = {
        "mqtt_topic": msg.topic,
        "payload": payload_base64,
        "is_base64": True,
        "qos": msg.qos,
        "retain": msg.retain,
    }

    if len(topic_parts) >= 2 and topic_parts[0] in ("$devices", "devices"):
        event["device_id"] = topic_parts[1]

    if len(topic_parts) >= 2 and topic_parts[0] in ("$registries", "registries"):
        event["registry_id"] = topic_parts[1]

    return event


def send_to_handler(event: dict) -> None:
    body = json.dumps(event).encode("utf-8")
    http_request = request.Request(
        HANDLER_URL,
        data=body,
        headers={"Content-Type": "application/json"},
        method="POST",
    )

    with request.urlopen(http_request, timeout=10) as response:
        response.read()


def on_connect(client, userdata, flags, rc):
    if rc != 0:
        print(f"MQTT connection failed with rc={rc}")
        return

    print(f"Connected to MQTT broker. Subscribing to {MQTT_TOPIC}")
    client.subscribe(MQTT_TOPIC, qos=1)


def worker() -> None:
    while True:
        event = message_queue.get()
        try:
            for attempt in range(3):
                try:
                    send_to_handler(event)
                    break
                except Exception as error:
                    print(f"Handler call failed, attempt={attempt + 1}, error={error}")
                    time.sleep(2 ** attempt)
            else:
                print(f"Message was not processed: topic={event.get('mqtt_topic')}")
        finally:
            message_queue.task_done()


def on_message(client, userdata, msg):
    # Put the event into the queue and immediately return control to the network loop:
    # put() pauses reception only when all workers are busy.
    message_queue.put(build_event(msg))


for _ in range(WORKER_COUNT):
    threading.Thread(target=worker, daemon=True).start()

client = mqtt.Client(client_id=MQTT_CLIENT_ID)
client.username_pw_set(MQTT_USERNAME, MQTT_PASSWORD)
client.tls_set(ca_certs=MQTT_CA_FILE)

client.on_connect = on_connect
client.on_message = on_message

client.connect(MQTT_HOST, MQTT_PORT, keepalive=60)
client.loop_forever()
```

Create a file named `requirements.txt`:

```text
paho-mqtt==1.6.1
```

Run the subscriber:

```bash
export MQTT_HOST=mqtt.example.com
export MQTT_PORT=8883
export MQTT_USERNAME=Backend
export MQTT_PASSWORD='<Backend_password>'
export MQTT_TOPIC='$devices/+/events/#'
export MQTT_CA_FILE=./rootCA.crt
export HANDLER_URL='https://<your-handler-url>'

python3 -m pip install -r requirements.txt
python3 subscriber.py
```

Such a subscriber can be deployed:

* On a {{ compute-name }} VM instance.
* In a {{ managed-k8s-name }} cluster.
* In a {{ serverless-containers-name }} container if the application maintains a persistent MQTT connection.
* Alongside other backend services used to process telemetry.

{% note tip %}

For a production scenario, add idempotent processing, metrics, alerts, DLQ, or a separate storage for unprocessed messages. MQTT QoS 1 guarantees delivery to the subscriber but not successful processing by your HTTP handler. The queue in the example resides in the process memory, i.e., unprocessed messages will be lost on crash.

To increase throughput, increase the number of workers (`WORKER_COUNT`) or run multiple subscriber instances with MQTT shared subscriptions: the broker will distribute messages among them.

By default, the subscriber reads only the `events` topic. To receive persistent `state` messages, also subscribe to `$devices/+/state/#`.

{% endnote %}

## Replace export to {{ yds-full-name }} {#replace-yds}

If you were using message export from {{ iot-full-name }} to {{ yds-full-name }} data streams, use one of the following options:

* MQTT subscriber reads messages from Mosquitto and sends them to a {{ yds-full-name }} stream.
* Backend application publishes data to MQTT and to a {{ yds-full-name }} stream at the same time.
* Stream processing is performed by a separate service subscribed to MQTT topics.

General principle:

```text
Mosquitto → MQTT subscriber → {{ yds-full-name }}
```

In your implementation, consider the following:

* Message size.
* Message order.
* Resending on errors.
* Idempotency of writes.
* Write latency and error monitoring.

## Migrate devices {#replace-device}

After you have prepared the broker and backend integrations, begin migrating devices.

We recommend the following order:

1. Create a new DNS name for the MQTT broker, e.g., `mqtt.example.com`.
1. Configure a TLS certificate for this address.
1. Create a test device or test device group.
1. Check that `events` and `state` can be published.
1. Check that `commands` and `config` can be received.
1. Check that the backend receives and correctly processes messages.
1. Migrate a small pilot group of devices.
1. Compare telemetry between the old and new environments.
1. Migrate remaining devices in batches.
1. After the migration is complete, disable publishing to {{ iot-full-name }}.

If device firmware supports simultaneous publishing to two MQTT brokers, use a dual-send period. This will help you compare data and reduce the risk of telemetry loss.

{% note warning %}

Do not delay migration until the {{ iot-full-name }} shutdown date. Once the service enters read-only mode, you will not be able to modify some of the resources; after the full shutdown, devices will stop exchanging messages through the service.

{% endnote %}

### Delete test resources {#delete}

If you had created a test VM or security group for smoke testing, delete them only after you make certain that production traffic has already been routed to the permanent endpoint:

```bash
yc compute instance delete mqtt-broker
yc vpc security-group delete mqtt-broker-sg
```

Do not add the `--quiet` flag to these commands without checking your installed {{ yandex-cloud }} CLI version because some versions do not support it for `yc compute instance delete`. For non-interactive cleanup, first check the current syntax:

```bash
yc compute instance delete --help
```

## Deploying Mosquitto in {{ managed-k8s-full-name }} {#k8s}

Mosquitto can be deployed in a {{ managed-k8s-name }} cluster. For a production environment, use:

* `StatefulSet`
* `PersistentVolumeClaim` for `/mosquitto/data`
* `Secret` for TLS keys and passwords
* `ConfigMap` for `mosquitto.conf` and ACLs
* `Service` of the `LoadBalancer` type for TCP port `8883`
* `PodDisruptionBudget`
* Regular persistent volume backups

Example of `Service`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: mosquitto
spec:
  type: LoadBalancer
  selector:
    app: mosquitto
  ports:
    - name: mqtts
      port: 8883
      targetPort: 8883
      protocol: TCP
```

{% note warning %}

Standard Mosquitto is not a clustered MQTT broker. Do not run multiple independent Mosquitto pods behind a single load balancer as an active/active cluster if you need shared retained messages, unified sessions, and predictable delivery. For such use cases, consider TBMQ Community Edition or another clustered architecture.

{% endnote %}

## When to choose TBMQ Community Edition {#tbmq}

TBMQ Community Edition is an open-source MQTT broker designed for high workloads and clustered architecture.

Consider TBMQ if:

* A single Mosquitto broker is becoming a bottleneck.
* You need horizontal scalability.
* Long-term message delivery is critical.
* You need broker cluster-level fault tolerance.
* You are ready to maintain {{ KF }}, a database, and other components.

Typical architecture:

```text
Devices → TBMQ → Kafka → backend / handlers / storages
```

TBMQ is more difficult to operate than Mosquitto but better suited for scenarios where the MQTT broker is a critical, high-load component.

You can keep your TBMQ or ThingsBoard database in {{ mpg-full-name }} to avoid administering a DBMS by yourself or deploy it in the cluster alongside your other components.

## When to choose ThingsBoard Community Edition {#thingsBoard}

ThingsBoard Community Edition is an open-source IoT platform featuring an MQTT API, device management, telemetry storage, dashboards, and a rule engine.

Consider ThingsBoard CE if:

* You need more than just MQTT message exchange but an IoT platform as well.
* Your users need a UI for devices and telemetry.
* You need dashboards and a rule engine.
* You want to manage device account data within the platform.
* You are ready to adapt your topics, payload, and backend integrations to ThingsBoard.

ThingsBoard CE is not a drop-in replacement for {{ iot-full-name }}. Devices and backend applications typically need to be adapted to ThingsBoard's API and data model.

Typical architecture:

```text
Devices → ThingsBoard CE → Rule Engine → dashboard / backend / storages
```

You can also build an architecture where Mosquitto remains the MQTT broker and ThingsBoard receives data via an integration or an API gateway:

```text
Devices → Mosquitto → ThingsBoard CE → dashboard / Rule Engine
```

## What is not migrated automatically {#limitations}

When you migrate to an open-source solution, the following components are not migrated automatically:

* Registries and devices as managed {{ yandex-cloud }} resources.
* Topic aliases.
* Device and registry passwords.
* {{ iam-short-name }} integrations.
* Message publication via the {{ iot-full-name }} gRPC interface.
* Triggers.
* Export to {{ yds-full-name }}.
* {{ iot-full-name }} monitoring topics.
* Behavior of persistent topics without retained-messages configured.
* {{ yandex-cloud }}-level roles and access permissions.

For each item, you need to implement a replacement:

* Registries and devices: a custom database, broker configuration, or IoT platform.
* Passwords: a new `password_file`, Dynamic Security plugin for Mosquitto, or account data managed by an IoT platform.
* Certificates: a custom root certificate and mTLS.
* Aliases: explicit MQTT topics or a compatibility layer in the backend.
* Publication via gRPC: no direct compatible replacement exists because {{ iot-full-name }} was using {{ iam-short-name }}-based authentication. If this scenario is what you need, build a dedicated backend adapter with a suitable authorization scheme to accept gRPC/API requests from your systems and publish messages to Mosquitto.
* Triggers: an MQTT subscriber.
* Export: an MQTT subscriber able to write to {{ yds-full-name }} streams or another storage system.
* Monitoring: broker metrics, logs, health checks, and custom heartbeat topics.

## Operational recommendations {#recommendations}

### Security {#security}

* Use MQTTS on port `8883`.
* Disable anonymous access.
* Restrict devices with the help of ACLs.
* Do not use a single shared password for all devices.
* Store your passwords, private keys, and the root certificate in a secure vault.
* Rotate your credentials regularly.
* Limit inbound traffic to security groups.
* Do not make the administrative interfaces open to the internet.

### Reliability {#reliability}

* Store broker persistence data on a persistent disk.
* Configure backups for the disk or data catalog.
* Document your recovery procedure.
* Test recovery in a test environment.
* Use QoS 1 for critical messages.
* Make sure retained messages are getting saved.
* For critical scenarios, consider an active/passive setup or a clustered broker.

### Observability {#observability}

* Collect your Mosquitto logs in {{ cloud-logging-full-name }}.
* Set up port `8883` unavailability alerts.
* Monitor CPU, RAM, disk, and network traffic of your VMs or pods.
* Track the number of connected clients.
* Track authentication errors.
* Add backend subscriber metrics: message count, handling errors, delivery latency.

### Performance {#efficiency}

* Perform load testing before migrating all devices.
* Check your CPU, RAM, and network bandwidth limits.
* Separate topics for backend subscribers not to receive irrelevant messages.
* Do not use wildcard subscriptions that are to broad unless you have to.
* For big installations, consider sharding or migration to a clustered broker.

## Migration plan {#migration-plan}

Use this checklist for migration control:

* Target solution selected: Eclipse Mosquitto, TBMQ CE, or ThingsBoard CE.
* List of registries, devices, certificates, and topic aliases exported.
* New device passwords generated; a plan for their delivery to firmware is in place.
* New MQTT endpoint created.
* TLS configured.
* Device authentication configured.
* ACLs configured for both prefixes, `$devices/...` and `devices/...` (if migrating part of devices in a phased way).
* `events` publication checked.
* `state` publication with retained messages checked.
* `commands` delivery checked.
* `config` delivery checked.
* ACL isolation smoke test done (device cannot read/write foreign topics; anonymous connection is rejected).
* Mosquitto configuration checked for duplicate settings (`persistence`, `persistence_location`, `listener`, etc., appear exactly once across all configuration files).
* Trigger replacement mechanism implemented.
* Export to {{ yds-full-name }} replacement mechanism implemented (if used).
* Logs, metrics, and alerts configured.
* Backups configured.
* Pilot migration of small device group completed.
* Data comparison between old and new environments completed.
* All devices migrated.
* Production system dependency on {{ iot-full-name }} removed.

## Useful links {#see-also}

* [Eclipse Mosquitto guides](https://mosquitto.org/documentation/)
* [TBMQ guides](https://thingsboard.io/docs/mqtt-broker/)
* [ThingsBoard guides](https://thingsboard.io/docs/)
* [{{ compute-full-name }} guides](../../compute/)
* [{{ managed-k8s-full-name }} guides](../../managed-kubernetes/)
* [{{ objstorage-full-name }} guides](../../storage/)
* [{{ lockbox-full-name }} guides](../../lockbox/)
* [{{ monitoring-full-name }} guides](../../monitoring/)
* [{{ cloud-logging-full-name }} guides](../../logging/)
