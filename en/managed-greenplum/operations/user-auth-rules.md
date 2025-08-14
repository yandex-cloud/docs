# User authentication rules

[User authentication](../concepts/user-authentication.md) rules determine which users and from which addresses are allowed to connect to a cluster, as well as which databases they can access.

You can:

* [Get a list of rules](#list-rules)
* [Add a rule](#add-rules)
* [Edit a rule](#edit-rules)
* [Change rule priority](#replace-rule)
* [Delete a rule](#delete-rule)

{% note warning %}

The rule priority matches the order of rows: rules are read from top to bottom, and the first relevant rule applies. If authentication based on the first suitable rule fails, other rules are not applied.

{% endnote %}

## Getting a list of rules {#list-rules}

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.greenplum.label_user-auth }}** tab.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. View a description of the command to get a list of rules:

        ```bash
        {{ yc-mdb-gp }} hba-rules list --help
        ```

    1. Get a list of rules:

        ```bash
        {{ yc-mdb-gp }} hba-rules list --cluster-id <cluster_ID>
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

        Result:

        ```bash
        +----------+-----------------+-----+-------+-------------------------------------------+-------------+
        | PRIORITY | CONNECTION TYPE | DB  | USER  |                  ADDRESS                  | AUTH METHOD |
        +----------+-----------------+-----+-------+-------------------------------------------+-------------+
        |        1 | HOST            | db1 | user1 | rc1a-no8u9mlr********.mdb.yandexcloud.net | MD5         |
        +----------+-----------------+-----+-------+-------------------------------------------+-------------+
        ```

- REST API {#api}   

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [HBARule.List](../api-ref/HBARule/list.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request GET \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>/hbaRules'
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/HBARule/list.md#yandex.cloud.mdb.greenplum.v1.ListHBARulesResponse) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [HBARuleService.List](../api-ref/grpc/HBARule/list.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/hba_rule_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.HBARuleService.List
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/HBARule/list.md#yandex.cloud.mdb.greenplum.v1.ListHBARulesResponse) to make sure the request was successful.

{% endlist %}          

## Adding a rule {#add-rules}

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.greenplum.label_user-auth }}** tab.
    1. Click **{{ ui-key.yacloud.greenplum.cluster.user-auth.action_edit-rules }}**.
    1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.greenplum.cluster.user-auth.action_add-rule }}** and specify its parameters:

        {% include [auth-user-rule-settings](../../_includes/mdb/mgp/auth-user-rule-settings.md) %}

    1. To add another rule, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.greenplum.cluster.user-auth.action_add-rule }}**.
    1. Click **{{ ui-key.yacloud.common.save }}**.

    {% note info %}

    The default rule is added automatically at the end of the list; it allows authentication for all users in all databases and from all hosts using the `md5` method (password-based authentication).

    {% endnote %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. View the description of the add rule command:

        ```bash
        {{ yc-mdb-gp }} hba-rules create --help
        ```

    1. Add the rule:

        ```bash
        {{ yc-mdb-gp }} hba-rules create <rule_priority> \
            --cluster-id <cluster_ID> \
            --conn-type <interconnect_type> \
            --database <DB_name> \
            --user <username> \
            --address <address> \
            --auth-method <authentication_method>
        ```

        Where:

        * `conn-type`: Interconnect type. The possible values are `host`, `hostssl`, and `hostnossl`.
        * `address`: Host FQDN or IP range in CIDR notation to connect to the database from.
        * `auth-method`: Authentication method. It can be either `md5` or `reject`.

        For more information about the parameters, see [Authentication rule settings](../../managed-greenplum/concepts/user-authentication.md#auth-settings).

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}   

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [HBARule.Create](../api-ref/HBARule/create.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>/hbaRules' \
            --data '{
                        "hbaRule": {
                            "priority": "<rule_priority>",
                            "connectionType": "<interconnect_type>",
                            "database": "<DB_name>",
                            "user": "<username>",
                            "address": "<address>",
                            "authMethod": "<authentication_method>"
                        }
                    }'
        ```

        Where:

        * `connectionType`: Interconnect type. The possible values are `HOST`, `HOSTSSL`, and `HOSTNOSSL`.
        * `address`: Host FQDN or IP range in CIDR notation to connect to the database from.
        * `authMethod`: Authentication method. It can be either `MD5` or `REJECT`.

        For more information about the parameters, see [Authentication rule settings](../../managed-greenplum/concepts/user-authentication.md#auth-settings).

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/HBARule/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [HBARuleService.Create](../api-ref/grpc/HBARule/create.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/hba_rule_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>",
                    "hba_rule": {
                        "priority": "<rule_priority>",
                        "connection_type": "<interconnect_type>",
                        "database": "<DB_name>",
                        "user": "<username>",
                        "address": "<address>",
                        "auth_method": "<authentication_method>"
                    }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.HBARuleService.Create
        ```

        Where:

        * `connection_type`: Interconnect type. The possible values are `HOST`, `HOSTSSL`, and `HOSTNOSSL`.
        * `address`: Host FQDN or IP range in CIDR notation to connect to the database from.
        * `auth_method`: Authentication method. It can be either `MD5` or `REJECT`.

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/HBARule/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Editing a rule {#edit-rules}

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.greenplum.label_user-auth }}** tab.
    1. Click **{{ ui-key.yacloud.greenplum.cluster.user-auth.action_edit-rules }}** and update the rule parameters:

        {% include [auth-user-rule-settings](../../_includes/mdb/mgp/auth-user-rule-settings.md) %}

    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. View the description of the update rule command:

        ```bash
        {{ yc-mdb-gp }} hba-rules update --help
        ```

    1. Update the rule:

        ```bash
        {{ yc-mdb-gp }} hba-rules update <rule_priority> \
            --cluster-id <cluster_ID> \
            --conn-type <interconnect_type> \
            --database <DB_name> \
            --user <username> \
            --address <address> \
            --auth-method <authentication_method>
        ```

        Where:

        * `conn-type`: Interconnect type. The possible values are `host`, `hostssl`, and `hostnossl`.
        * `address`: Host FQDN or IP range in CIDR notation to connect to the database from.
        * `auth-method`: Authentication method. It can be either `md5` or `reject`.

        For more information about the parameters, see [Authentication rule settings](../../managed-greenplum/concepts/user-authentication.md#auth-settings).

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

        You can find out the rule priority by [requesting a list of all rules in the cluster](#list-rules).

- REST API {#api}   

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [HBARule.Update](../api-ref/HBARule/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>/hbaRules' \
            --data '{
                        "hbaRule": {
                            "priority": "<rule_priority>",
                            "connectionType": "<interconnect_type>",
                            "database": "<DB_name>",
                            "user": "<username>",
                            "address": "<address>",
                            "authMethod": "<authentication_method>"
                        }
                    }'
        ```

        Where:

        * `connectionType`: Interconnect type. The possible values are `HOST`, `HOSTSSL`, and `HOSTNOSSL`.
        * `address`: Host FQDN or IP range in CIDR notation to connect to the database from.
        * `authMethod`: Authentication method. It can be either `MD5` or `REJECT`.

        For more information about the parameters, see [Authentication rule settings](../../managed-greenplum/concepts/user-authentication.md#auth-settings).

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

        You can find out the rule priority by [requesting a list of all rules in the cluster](#list-rules).

    1. View the [server response](../api-ref/HBARule/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [HBARuleService.Update](../api-ref/grpc/HBARule/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/hba_rule_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>",
                    "hba_rule": {
                        "priority": "<rule_priority>",
                        "connection_type": "<interconnect_type>",
                        "database": "<DB_name>",
                        "user": "<username>",
                        "address": "<address>",
                        "auth_method": "<authentication_method>"
                    }
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.HBARuleService.Update
        ```

        Where:

        * `connection_type`: Interconnect type. The possible values are `HOST`, `HOSTSSL`, and `HOSTNOSSL`.
        * `address`: Host FQDN or IP range in CIDR notation to connect to the database from.
        * `auth_method`: Authentication method. It can be either `MD5` or `REJECT`.

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

        You can find out the rule priority by [requesting a list of all rules in the cluster](#list-rules).

    1. View the [server response](../api-ref/grpc/HBARule/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.    

{% endlist %}

## Changing rule priority {#replace-rule}

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.greenplum.label_user-auth }}** tab.
    1. Click **{{ ui-key.yacloud.greenplum.cluster.user-auth.action_edit-rules }}**.
    1. Click ![image](../../_assets/console-icons/grip.svg) for the rule and move it up or down.
    1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Deleting a rule {#delete-rule}

{% list tabs group=instructions %}

- Management console {#console}

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Click the name of the cluster you need and select the ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.greenplum.label_user-auth }}** tab.
    1. Click **{{ ui-key.yacloud.greenplum.cluster.user-auth.action_edit-rules }}**.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) for the rule and select **{{ ui-key.yacloud.common.delete }}**.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    1. View the description of the command for deleting a rule:

        ```bash
        {{ yc-mdb-gp }} hba-rules delete --help
        ```

    1. Delete the rule:

       ```bash
        {{ yc-mdb-gp }} hba-rules delete <rule_priority> \
            --cluster-id <cluster_ID>
        ```    

    You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    You can find out the rule priority by [requesting a list of all rules in the cluster](#list-rules).

- REST API {#api}   

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [HBARuleService.Update](../api-ref/grpc/HBARule/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request DELETE \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<cluster_ID>/hbaRule/<rule_priority>'
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

        You can find out the rule priority by [requesting a list of all rules in the cluster](#list-rules).

    1. View the [server response](../api-ref/grpc/HBARule/delete.md#yandex.cloud.operation.Operation) to make sure the request was successful. 

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [HBARuleService.Delete](../api-ref/grpc/HBARule/delete.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/hba_rule_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>",
                    "priority": "<rule_priority>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.HBARuleService.Delete
        ```

        You can get the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

        You can find out the rule priority by [requesting a list of all rules in the cluster](#list-rules).

    1. View the [server response](../api-ref/grpc/HBARule/delete.md#yandex.cloud.operation.Operation) to make sure the request was successful.      

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
