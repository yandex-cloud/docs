# Synchronous and asynchronous command execution modes

The CLI provides two command execution modes: synchronous and asynchronous.

By default, all commands are executed in **synchronous mode**. After you run a command in this mode, the CLI waits for the corresponding operation to be completed in {{ yandex-cloud }}. If the command takes a long time to execute, dots are displayed indicating the execution process.

Commands that run for a long time are more convenient to execute in **asynchronous mode**. After running a command in this mode, the CLI immediately outputs information about the corresponding operation in {{ yandex-cloud }} and lets the user continue working. To use this mode, run a command with the `--async` flag. In response to this call, the CLI returns the operation ID, which is then used for getting information about the operation.

To get information about an operation run asynchronously, use the following commands:

- Find out the current operation status:

   ```
   yc operation get <operation ID>
   ```

   - If the operation is still in progress, the information about the operation is displayed again.
   - If the operation is completed, you'll see the result of the operation.

- To return to synchronous mode of operation execution:

   ```
   yc operation wait <operation ID>
   ```

## Examples {#example}

Compare the execution of the create VM command in different modes.

### Command execution in synchronous mode {#sync}

First, dots are displayed indicating that the operation is in progress and then the result of the operation is output.

```
yc compute instance create --name my-inst3 --metadata user-data="#ps1\nnet user Administrator Passw0rd" --zone {{ region-id }}-a --public-ip --create-boot-disk image-folder-id=standard-images,image-name=windows-2016-gvlk-1537967224
....................................................................................................................................................................done
id: epdplofgadqohn5ppkt3
folder_id: b1g88tflru0ek1omtsu0
created_at: "2019-01-23T14:18:21Z"
name: my-inst3
zone_id: {{ region-id }}-a
platform_id: standard-v3
resources:
  memory: "2147483648"
  cores: "2"
  core_fraction: "100"
status: RUNNING
boot_disk:
  mode: READ_WRITE
  device_name: epdb30lg3sidrc65hbg1
  auto_delete: true
  disk_id: epdb30lg3sidrc65hbg1
network_interfaces:
- index: "0"
  mac_address: d0:0d:19:ae:1f:05
  subnet_id: e2lj2pco4kg851gsv3n2
  primary_v4_address:
    address: 10.0.0.11
    one_to_one_nat:
      address: 84.201.142.79
      ip_version: IPV4
fqdn: epdplofgadqohn5ppkt3.auto.internal
```

### Command execution in asynchronous mode {#async}

Once the command has been run, information about the operation is output, and the execution continues in the background.

```
yc compute instance create --name my-test-inst --metadata user-data="#ps1\nnet user Administrator Passw0rd" --zone {{ region-id }}-a --public-ip --create-boot-disk image-folder-id=standard-images,image-name=windows-2016-gvlk
-1537967224 --async
id: epdjte17at0fguj52ili
description: "Create instance"
created_at: "2019-02-13T08:49:25Z"
created_by: ajed79hm85fu3g6g5uej
modified_at: "2019-02-13T08:49:25Z"
metadata:
  '@type': type.googleapis.com/yandex.cloud.compute.v1.CreateInstanceMetadata
  instance_id: epdil0po4toutfhjrk0g
```
