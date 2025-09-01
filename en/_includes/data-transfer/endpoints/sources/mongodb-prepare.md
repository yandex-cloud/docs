{% list tabs %}

- {{ mmg-name }}


    1. Estimate the total number of databases for transfer and the total {{ mmg-name }} workload. If the workload on the database exceeds 10,000 writes per second, create multiple endpoints and transfers. For more information, see [{#T}](../../../../data-transfer/operations/endpoint/source/mongodb.md).
    
    1. [Create a user](../../../../storedoc/operations/cluster-users.md#adduser) with the `readWrite` role for each source database to replicate. The `readWrite` role is required to enable the transfer to write data to the `__data_transfer.__dt_cluster_time` service collection.

- {{ MG }}
    
    1. Estimate the total number of databases for transfer and the total {{ MG }} workload. If the workload on the database exceeds 10,000 writes per second, create multiple endpoints and transfers. For more information, see [{#T}](../../../../data-transfer/operations/endpoint/source/mongodb.md).
    
    1. {% include notitle [White IP list](../../configure-white-ip.md) %}
    
    1. Make sure the {{ MG }} version on the target is `4.0` or higher.
    
    1. {% include [mondodb cluster requirement](../../mongodb-cluster-requirement.md) %}
    
    1. [Configure access to the source cluster from {{ yandex-cloud }}](../../../../data-transfer/concepts/network.md#source-external). To configure a [source cluster](https://docs.mongodb.com/manual/core/security-mongodb-configuration/) for connections from the internet:
        
        1. In the configuration file, change `net.bindIp` from `127.0.0.1` to `0.0.0.0`:
        
            ```yaml
            # network interfaces
            net:
              port: 27017
              bindIp: 0.0.0.0
            ```
        
        1. Restart `mongod`:
        
            ```bash
            sudo systemctl restart mongod.service
            ```
    
    1. If the source cluster does not use replication, enable it:
        
        1. Add the replication settings to the `/etc/mongod.conf` configuration file:
        
            ```yaml
            replication:
              replSetName: <replica_set_name>
            ```
        
        1. Restart `mongod`:
        
            ```bash
            sudo systemctl restart mongod.service
            ```
        
        1. Connect to {{ MG }} and initialize the replica set with this command:
        
            ```javascript
            rs.initiate({
                _id: "<replica_set_name>",
                members: [{
                    _id: 0,
                    host: "<IP_address_listened_by_{{ MG }}>:<port>"
                }]
            });
            ```
    
    1. Create a user with the [`readWrite`](https://www.mongodb.com/docs/manual/reference/built-in-roles/#mongodb-authrole-readWrite) role for all the source databases to replicate:
    
        ```javascript
        use admin
        db.createUser({
            user: "<username>",
            pwd: "<password>",
            mechanisms: ["SCRAM-SHA-1"],
            roles: [
                {
                    db: "<source_database_1_name>",
                    role: "readWrite"
                },
                {
                    db: "<source_database_2_name>",
                    role: "readWrite"
                },
                ...
            ]
        });
        ```
    
       Once started, the transfer will connect to the source on behalf of this user. The `readWrite` role is required to enable the transfer to write data to the `__data_transfer.__dt_cluster_time` service collection.
    
       {% note info %}
    
       For {{ MG }} {{ dt-mg-version }} or higher, you only need to assign the created user the [`read`](https://www.mongodb.com/docs/manual/reference/built-in-roles/#mongodb-authrole-read) role for the databases to replicate.
    
       {% endnote %}
    
    1. When using {{ MG }} {{ dt-mg-version }} or higher, to run the transfer, the user must have the read permission for the `local.oplog.rs` collection and the read and write permissions for the `__data_transfer.__dt_cluster_time` collection. To assign a user the [`clusterAdmin`](https://www.mongodb.com/docs/manual/reference/built-in-roles/#mongodb-authrole-clusterAdmin) role granting these permissions, connect to {{ MG }} and run the following commands:
    
        ```js
        use admin;
        db.grantRolesToUser("<username>", ["clusterAdmin"]);
        ```
    
       To grant more granular permissions, you can assign the [`clusterMonitor`](https://www.mongodb.com/docs/manual/reference/built-in-roles/#mongodb-authrole-clusterMonitor) role required for reading the `local.oplog.rs` collection and grant read and write access to the `__data_transfer.__dt_cluster_time` system collection.

{% endlist %}