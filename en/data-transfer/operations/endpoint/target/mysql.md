---
title: "How to configure {{ MY }} target endpoint in {{ data-transfer-full-name }}"
description: "Following this guide you will learn how to configure {{ MY }} target endpoint in {{ data-transfer-full-name }}."
---

# Configuring a {{ MY }} target endpoint

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* [{{ mmy-full-name }} cluster](#managed-service) connection or [custom installation](#on-premise) settings, including those based on {{ compute-full-name }} VMs. These are required parameters.
* [Additional parameters](#additional-settings).

## {{ mmy-name }} cluster {#managed-service}

Connecting to the database with the cluster ID specified in {{ yandex-cloud }}. Available only for clusters deployed in [{{ mmy-full-name }}](../../../../managed-mysql/).

{% list tabs %}

- Management console

   {% include [Managed MySQL UI](../../../../_includes/data-transfer/necessary-settings/ui/managed-mysql-target.md) %}

- CLI

   * Endpoint type: `mysql-target`.

   {% include [Managed MySQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/managed-mysql-target.md) %}

- {{ TF }}

   * Endpoint type: `mysql_target`.

   {% include [Managed MySQL Terraform](../../../../_includes/data-transfer/necessary-settings/terraform/managed-mysql-target.md) %}

   Example configuration file structure:

   ```hcl
   resource "yandex_datatransfer_endpoint" "<endpoint name in {{ TF }}>" {
     name = "<endpoint name>"
     settings {
       mysql_target {
         security_groups = [ "list of security group IDs" ]
         connection {
           mdb_cluster_id = "<{{ mmy-name }} cluster ID>"
         }
         database = "<name of database being transferred>"
         user     = "<username for connection>"
         password {
           raw = "<user password>"
         }
         <advanced endpoint settings>
       }
     }
   }
   ```

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API

   {% include [Managed MySQL API](../../../../_includes/data-transfer/necessary-settings/api/managed-mysql-target.md) %}

{% endlist %}

## Custom installation {#on-premise}

For OnPremise, all fields are filled in manually.

{% list tabs %}

- Management console

   {% include [On premise MySQL UI](../../../../_includes/data-transfer/necessary-settings/ui/on-premise-mysql-target.md) %}

- CLI

   * Endpoint type: `mysql-target`.

   {% include [On premise MySQL CLI](../../../../_includes/data-transfer/necessary-settings/cli/on-premise-mysql-target.md) %}

- {{ TF }}

   * Endpoint type: `mysql_target`.

   {% include [On premise MySQL CLI](../../../../_includes/data-transfer/necessary-settings/terraform/on-premise-mysql-target.md) %}

   Example configuration file structure:

   ```hcl
   resource "yandex_datatransfer_endpoint" "<endpoint name in {{ TF }}>" {
     name = "<endpoint name>"
     settings {
       mysql_target {
         security_groups = [ "list of security group IDs" ]
         connection {
           on_premise {
             hosts = ["<host list>"]
             port  = <connection port>
           }
         }
         database = "<name of database being transferred>"
         user     = "<username for connection>"
         password {
           raw = "<user password>"
         }
         <advanced endpoint settings>
       }
     }
   }
   ```

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API

   {% include [On premise MySQL API](../../../../_includes/data-transfer/necessary-settings/api/on-premise-mysql-target.md) %}

{% endlist %}

## Additional settings {#additional-settings}

{% note warning %}

You can configure **Cleanup policy** and **DB schema for service tables** only via the management console.

{% endnote %}

{% list tabs %}

- Management console

   * **sql_mode mode**: Specify the settings that override the [{{ MY }} standard behavior](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html).

   * **Disable constraint checks**: Used to speed up replication: the `FOREIGN_KEY_CHECKS` and `UNIQUE_CHECKS` settings are set to `0` (no checks are performed).

      {% include [Note turn-off-mysql-constraints](../../../../_includes/data-transfer/notes/mysql-turn-off-constraints.md) %}

   * **DB time zone**: Specify the [IANA Time Zone Database](https://www.iana.org/time-zones) identifier. Defaults to UTC+0.

   * {% include [Field Cleanup Policy Disabled/Drop/Truncate](../../../../_includes/data-transfer/fields/common/ui/cleanup-policy-disabled-drop-truncate.md) %}

   * **DB schema for service tables**: Specify the name of the schema where service tables needed for the transfer operation will be created.

- CLI

   * `sql_mode`: Specify the settings that override the [{{ MY }} standard behavior](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html).

   * `--skip-constraint-checks`: Used to speed up replication: the `FOREIGN_KEY_CHECKS` and `UNIQUE_CHECKS` settings are set to `0` (no checks are performed).

      {% include [Note turn-off-mysql-constraints](../../../../_includes/data-transfer/notes/mysql-turn-off-constraints.md) %}

   * `--timezone`: Specify the [IANA Time Zone Database](https://www.iana.org/time-zones) identifier. Defaults to UTC+0.

- {{ TF }}

   * `sql_mode`: Specify settings to override [standard {{ MY }} behavior](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html). The following list is used by default: `NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION`.

   * `skip_constraint_checks`: Used to speed up replication: the `FOREIGN_KEY_CHECKS` and the `UNIQUE_CHECKS` values are set to `0` (no checks are performed).

      {% include [Note turn-off-mysql-constraints](../../../../_includes/data-transfer/notes/mysql-turn-off-constraints.md) %}

   * `timezone`: Specify the [IANA Time Zone Database](https://www.iana.org/time-zones) identifier. Defaults to UTC+0.

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-dt-endpoint }}).

- API

   * `sqlMode`: Specify the settings that override the [{{ MY }} standard behavior](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html).

   * `skipConstraintChecks`: Used to speed up replication: the `FOREIGN_KEY_CHECKS `and `UNIQUE_CHECKS` settings are set to `0` (no checks are performed).

      {% include [Note turn-off-mysql-constraints](../../../../_includes/data-transfer/notes/mysql-turn-off-constraints.md) %}

   * `timezone`: Specify the [IANA Time Zone Database](https://www.iana.org/time-zones) identifier. Defaults to UTC+0.

{% endlist %}
