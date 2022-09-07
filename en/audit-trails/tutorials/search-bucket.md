# Searching for {{ yandex-cloud }} events in {{ objstorage-name }}

## Before you begin {#before-you-begin}
1. Install and set up [s3fs](../../storage/tools/s3fs.md) or [goofys](../../storage/tools/goofys.md) to mount {{ objstorage-name }} buckets using [FUSE]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/FUSE_(модуль_ядра)){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Filesystem_in_Userspace){% endif %}.
1. Mount a bucket with audit logs to your file system using [s3fs](../../storage/tools/s3fs.md#mounting-bucket) or [goofys](../../storage/tools/goofys.md#bucket-mounting).
1. Install the [jq](https://stedolan.github.io/jq) utility to search through data in JSON format.

## Search scenarios {#search}

1. To search through multiple files, use the `find` command. As a command-line argument, enter the path to the mount directory of the audit log bucket or to its subdirectory with logs for a certain month or day.

   Example command to search events by type:

   ```bash
   find <directory path> -type f -exec cat {} \; | jq  '.[] | select( .event_type == "{{ yandex-dot-cloud }}.audit.iam.CreateServiceAccount")'
   ```

1. To find out who deleted a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) from the cloud, search by the `eventType` (_event type_) field across all files for the period, filtering by the folder ID:

   ```bash
   find <directory path> -type f -exec cat {} \; | jq  '.[] | select( .event_type == "{{ yandex-dot-cloud }}.audit.resourcemanager.DeleteFolder" and .details.folder_id == "<folder ID>") | .authentication'
   ```

1. To find out who created/stopped/restarted/deleted a VM instance, search by the `eventType` field in all files for the period, filtering by the VM instance ID:
   {% if product == "yandex-cloud" %}

   ```bash
   find <directory path> -type f -exec cat {} \; | jq  '.[] | select((.event_type | test("yandex\\.cloud\\.audit\\.compute\\..*Instance")) and .details.instance_id == "<VM instance ID>") | .authentication'
   ```

{% endif %}
{% if product == "cloud-il" %}

```bash
find <directory path> -type f -exec cat {} \; | jq  '.[] | select((.event_type | test("cloudil\\.audit\\.compute\\..*Instance")) and .details.instance_id == "<VM instance ID>") | .authentication'
```

{% endif %}
3. To find out what actions a user performed over a period of time, search by the subject ID:

```bash
find <directory path> -type f -exec cat {} \; | jq  '.[] | select(.authentication.subject_id == "<user ID>" and .event_time > "2021-03-01" and .event_time < "2021-04-01")'
```

You can also search by the subject name:

```bash
find <directory path> -type f -exec cat {} \; | jq  '.[] | select(.authentication.subject_name == "<username>" and .event_time > "2021-03-01" and .event_time < "2021-04-01")'
```

4. To find out which events occurred to objects in a certain folder, search by the folder ID:

   ```bash
   find <directory path> -type f -exec cat {} \; | jq  '.[] | select(.resource_metadata != null and .resource_metadata.path != null) | select( .resource_metadata.path[] | .resource_type == "resource-manager.folder" and .resource_id == "<folder ID>")'
   ```

   You can also search by the folder name:

   ```bash
   find <directory path> -type f -exec cat {} \; | jq  '.[] | select(.resource_metadata != null and .resource_metadata.path != null) | select( .resource_metadata.path[] | .resource_type == "resource-manager.folder" and .resource_name == "<folder name>")'
   ```

#### See also {#see-also}

* [Audit log](../concepts/format.md)
* [Jq documentation](https://stedolan.github.io/jq/tutorial)
* [s3fs](../../storage/tools/s3fs.md)
* [goofys](../../storage/tools/goofys.md)