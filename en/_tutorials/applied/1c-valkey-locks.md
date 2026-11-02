# Distributed locks for 1C:Enterprise in a {{ mrd-full-name }} cluster

You can use a {{ mrd-full-name }} cluster as a distributed lock storage for 1C:Enterprise, e.g., to prevent multiple users from editing the same catalog item at the same time.

Integration is implemented via an intermediate HTTP server running on a {{ compute-full-name }} virtual machine. The server provides an HTTP API for managing locks and uses a {{ VLK }} cluster as its backend. A 1C:Enterprise module accesses the API through an external connection.

{% note info %}

The module requires 1C:Enterprise 8.3 or later.

{% endnote %}

To set up locks:

1. [Set up your infrastructure](#deploy-infrastructure).
1. [Deploy your HTTP lock server](#deploy-lock-server).
1. [Configure the 1C:Enterprise module](#configure-1c).
1. [Test the locks](#test).
1. [Delete the resources you created](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

* {{ mrd-name }} cluster: host computing resources and storage size (see [{{ mrd-name }} pricing](../../managed-valkey/pricing.md)).
* VM instance: use of computing resources, storage, public IP address, and OS (see [{{ compute-name }} pricing](../../compute/pricing.md)).


## Set up your infrastructure {#deploy-infrastructure}

{% list tabs group=instructions %}

- Manually {#manual}

  1. [Create a {{ mrd-name }} cluster](https://yandex.cloud/ru/docs/managed-valkey/operations/cluster-create) with the following specifications:

     * **{{ ui-key.yacloud.mdb.forms.base_field_name }}**: `1c-locks`.
     
     * **{{ ui-key.yacloud.mdb.forms.base_field_version }}**: `Valkey 9.1`.

     * Enable **{{ ui-key.yacloud.redis.field_announce-hostnames }}**.

     * Select [{{ ui-key.yacloud.redis.field_persistence-mode }}](../../managed-valkey/concepts/replication.md#persistence) {{ ui-key.yacloud.redis.persistence-mode-on-replicas }} mode.

       {% note warning %}

       Locks have a limited TTL. To prevent data loss, use a [high-availability cluster configuration](../../managed-valkey/concepts/high-availability.md).

       {% endnote %}

     * Enable the **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}** setting.

  1. [Create a VM](../../compute/operations/vm-create/create-linux-vm.md) for the HTTP lock server in the same network as the cluster.

  1. [Configure security groups](../../managed-valkey/operations/connect/index.md#configure-security-groups) to allow:

     * The HTTP server to connect to the cluster.
     * The 1C:Enterprise server to access the HTTP server on the selected port.

- {{ TF }} {#tf}

  1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
  1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
  1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
  1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}
  1. Download the [valkey-1c-http.tf](https://github.com/yandex-cloud-examples/yc-valkey-1c-locks/blob/main/valkey-1c-http.tf) configuration file to your current working directory.

      This file describes:

      * Network.
      * Subnet.
      * Security groups.
      * {{ mrd-name }} cluster.
      * Virtual machine with public internet access and a pre-installed HTTP server with all required dependencies.

      {% note info %}

      The {{ TF }} example creates a simplified {{ mrd-name }} cluster with no replicas, just for demo purposes. For production use, set up a high-availability configuration with replica persistence, as described in the **Management console** tab.

      {% endnote %}

  1. In `valkey-1c-http.tf`, specify the following:

      * Password to access the {{ mrd-name }} cluster.
      * HTTP lock server access port.
      * Lock key prefix in {{ VLK }}.

  1. Validate your {{ TF }} configuration using this command:

      ```bash
      terraform validate
      ```

      {{ TF }} will display any configuration errors detected in your files.

  1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

  After creating the resources, the terminal will display the following HTTP lock server settings:

  * `vm_public_ip`: Server public IP address.
  * `http_url`: Server connection endpoint.

{% endlist %}

## Deploy your HTTP lock server {#deploy-lock-server}

An HTTP lock server is a thin layer between a 1C:Enterprise server and a {{ mrd-name }} cluster. It exposes endpoints with the `/locks` prefix:

#|
|| **Endpoint** | **Method** | **Description** ||
|| `/locks/acquire` | POST | Acquire a lock ||
|| `/locks/release` | POST | Release a lock ||
|| `/locks/renew` | POST | Extend a lock ||
|| `/locks/status` | GET (`file` parameter) or POST | Get the status of a lock ||
|| `/locks` | GET | Get a list of locks ||
|#

{% note warning %}

The example is demo: The HTTP server has no authentication nor HTTPS, and the {{ TF }} example opens a port for `0.0.0.0/0`. For production use, employ HTTPS, request authentication, and IP-based access restrictions.

{% endnote %}

How to work with your cluster:

* To acquire a lock (`/locks/acquire`), use the `SET` command with the `NX` argument and specify the key TTL (`PX`). The `NX` argument ensures the lock is only acquired when no such key exists, while the TTL prevents the lock from lasting indefinitely:

  ```text
  SET <key> <token> NX PX <ttl_in_milliseconds>
  ```

* To release (`/locks/release`) or renew (`/locks/renew`) a lock, use the `EVAL` command to call Lua scripts. These scripts perform the following operations in {{ VLK }} sequentially:

   1. Get lock data by key.
   1. Compare the lock token with the request token.
   1. Delete the key or renew the lock.

   Calling a script ensures transaction atomicity, meaning that either all operations complete successfully or none of them do. Below is an example of a script for releasing a lock:

   ```lua
   -- release: Delete the key only if the token matches.
   local value = server.call('GET', KEYS[1])
   if not value then
     return 0
   end
   local ok, lock = pcall(cjson.decode, value)
   if not ok or lock['token'] ~= ARGV[1] then
     return 0
   end
   return server.call('DEL', KEYS[1])
   ```

* The server returns HTTP status codes and error messages showing whether it successfully acquired, released, or renewed the lock.

To deploy your server:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Connect to your virtual machine over SSH](../../compute/operations/vm-connect/ssh.md).
    1. Install [Go 1.26.2](https://go.dev/dl/) or higher.
    1. Clone the repository:

       ```bash
       git clone https://git.sourcecraft.dev/valkey/webinar-260624-1c-example.git && \
       cd webinar-260624-1c-example/http-lock-valkey
       ```

    1. Create environment variables with the server configuration:

       ```bash
       export HTTP_ADDR=:<server_port_exposed_for_requests>
       export VALKEY_ADDR=<{{ VLK }}_host_FQDN>:6379
       export VALKEY_USER=default
       export VALKEY_PASSWORD=<{{ VLK }}_password>
       export DEFAULT_LOCK_TTL=<lock_renewal_interval_in_seconds>
       export LOCK_KEY_PREFIX=<lock_key_prefix>
       ```

    1. Start the HTTP server with this command:

       ```bash
       go run .
       ```

- {{ TF }} {#tf}

    The {{ TF }} configuration file contains all commands required to deploy the HTTP server. Once the infrastructure is created, the server is ready to use.

    1. Update the server settings in the configuration file as needed:

       * The lock renewal interval in the `DEFAULT_LOCK_TTL` setting of the `cloud_init` local variable.
       * The lock key prefix in the `lock_key_prefix` local variable.
       * The server port for {{ VLK }} cluster requests in the `http_port` local variable.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm resource changes.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    After updating the resources, the terminal will display the updated HTTP lock server settings:

    * `vm_public_ip`: Server public IP address.
    * `http_url`: Server connection endpoint.

{% endlist %}

## Configure the 1C:Enterprise module {#configure-1c}

1C:Enterprise uses the **Catalog lock** module, which accesses the HTTP server through an external connection. The ready-to-use module code is in the container hosting the 1C:Enterprise test database in the [valkey/webinar-260624-1c-example](https://sourcecraft.dev/valkey/webinar-260624-1c-example/browse/1CExample) repository.

The module performs the following functions:

* Sends HTTP requests to the server endpoints (`/locks/acquire`, `/locks/release`, `/locks/status`, `/locks/renew`, `GET /locks`) depending on the action.
* Generates a lock key from the full catalog path (collection metadata) and the item ID. This ensures a unique lock for each catalog item.
* In the module form, you can configure event handlers for catalogs:
   * On opening: Attempt to acquire the lock.
   * On modification and closing: Renew or release the lock.
* To prevent the lock from expiring while the user is working with the form, configure periodic lock renewal.
* For clarity, the form displays lock information: its status (acquired or available), the remaining TTL, and the token used to verify lock ownership.

To configure the module:

1. Connect the database from the `1CExample` repository directory and copy the `CatalogLocks` common module to your 1C:Enterprise configuration.
1. If methods are called from server form code, make sure server calls are enabled for the module.
1. In the `HTTPRequest()` function, specify the HTTP lock server address:

   ```text
   Connection = New HTTPConnection("<new_VM_public_IP_address>", <port_from_HTTP_ADDR_variable>);
   ```

1. Add the lock to the appropriate form. Follow these steps:

   * Add form attributes for the token and status.
   * When opening the form, call `LockCatalog()`.
   * When closing the form, call `UnlockCatalog()`.
   * Enable periodic `renew` sending.

1. Connect the form event handlers to the appropriate catalogs. Here is a minimum functionality example:

   ```text
   OnCreatingOnServer:
       acquire

   OnOpening:
       renew

   OnClosing:
       release
   ```

1. Set up a lock key. By default, the key is generated as follows:

   ```text
   "Catalog." + Reference.Metadata().Name + ":" + Reference.UniqueID()
   ```

   For documents, you can use the same approach:

   ```text
   Document.CustomerOrder:UniqueID()
   ```

   If you need to use one module for different object types, generalize the `LockKey()` function.

{% note warning %}

The module connection settings may vary depending on the 1C:Enterprise implementation.

{% endnote %}

## Test the locks {#test}

1. Open 1C:Enterprise and go to a catalog, such as `Customers`.
1. Open an item, such as `Roman`, for editing. The form will display the lock status as _acquired_, along with the lock TTL and token.
1. Monitor the TTL for a while: it should decrease over time, e.g., from `41` to `31` seconds. When the renewal interval expires (30 seconds by default), 1C:Enterprise automatically renews the lock.

1. Make sure the lock appears in the cluster:

   {% list tabs group=instructions %}

   - Management console {#console}

       1. Open {{ websql-full-name }} [**Connections**]({{ websql-link }}).
       1. [Add a database connection](../../websql/operations/add-connection-to-db-in-cluster.md) for the {{ VLK }} cluster you created earlier. Specify `0` as the database name.
       1. Connect to the `0` database and find the lock key row.

       {% note info %}

       Due to encoding limitations, {{ websql-name }} may display the key name incorrectly. To verify lock ownership, check whether the key exists and look at its value (token), rather than checking whether the key name is readable.

       {% endnote %}

   - SQL {#sql}

       [Connect the {{ mrd-name }} cluster](../../managed-valkey/operations/connect/clients.md#valkey-cli) and run this command:

       ```bash
       KEYS <lock_key_prefix>:*
       ```

       {{ VLK }} will return the lock key as a string.

   {% endlist %}

## Delete the resources you created {#clear-out}

Delete the created resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

- Manually {#manual}

  1. [Delete the {{ mrd-name }} cluster](../../managed-valkey/operations/cluster-delete.md).
  1. [Delete the VM](../../compute/operations/vm-control/vm-delete.md).

- {{ TF }} {#tf}

  {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
