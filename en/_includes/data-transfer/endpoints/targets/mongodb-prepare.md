{% list tabs %}

- {{ mmg-name }}
    
    1. [Create a database](../../../../managed-mongodb/operations/databases.md#add-db).
    1. [Create a user](../../../../managed-mongodb/operations/cluster-users.md#adduser) with the [`readWrite`](../../../../managed-mongodb/concepts/users-and-roles.md#readWrite) role for the new database.
    1. To shard the migrated collections in the {{ mmg-full-name }} target cluster:
        1. Use [this guide](../../../../managed-mongodb/tutorials/sharding.md) to create and configure empty sharded collections in the target database.
        
           {{ data-transfer-name }} does not automatically shard the migrated collections. Sharding large collections may take a long time and slow down the transfer.
        
        1. If sharding uses any key other than `_id` (default), [assign](../../../../managed-mongodb/operations/cluster-users.md#updateuser) the `mdbShardingManager` role to the user.
        
        1. When [creating a target endpoint](../../../../data-transfer/operations/endpoint/target/mongodb.md), select `DISABLED` or `TRUNCATE` as your cleanup policy.
        
           {% include [MongoDB endpoint DROP clean policy warning](../../note-mongodb-clean-policy.md) %}

       Learn more about sharding in the [{{ MG }} documentation](https://docs.mongodb.com/manual/sharding/).


- {{ MG }}
    
    1. {% include notitle [White IP list](../../configure-white-ip.md) %}
    
    1. Make sure the {{ MG }} version on the target is not lower than that on the source.
    
    1. {% include [mondodb cluster requirement](../../mongodb-cluster-requirement.md) %}
    
    1. [Configure the target cluster](https://docs.mongodb.com/manual/core/security-mongodb-configuration/) to allow connections from the internet:
        
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
    
    1. If the target cluster does not use replication, enable it:
        
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
    
    1. Connect to the cluster and create a target database:
    
        ```javascript
        use <database_name>
        ```
    
    1. Create a user with the `readWrite` role for the target database:
    
        ```javascript
        use admin;
        db.createUser({
            user: "<username>",
            pwd: "<password>",
            mechanisms: ["SCRAM-SHA-1"],
            roles: [
                {
                    db: "<target_database_name>",
                    role: "readWrite"
                }
            ]
        });
        ```
    
       Once started, the transfer will connect to the target on behalf of this user.
    
    1. To shard the migrated collections in the target cluster:
        
        1. Set up a database and populate it with empty collections with the same names as those in the source.
        
           {{ data-transfer-name }} does not automatically shard the migrated collections. Sharding large collections may take a long time and slow down the transfer.
        
        1. Enable target database sharding:
        
            ```javascript
            sh.enableSharding("<target_database_name>")
            ```
        
        1. Shard every collection based on its namespace:
        
            ```javascript
            sh.shardCollection("<target_database_name>.<collection_name>", { <field_name>: <1|"hashed">, ... });
            ```
        
           For the `shardCollection()` function description, see the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/method/sh.shardCollection/#mongodb-method-sh.shardCollection).
        
        1. To make sure that sharding is set up and enabled, get a list of available shards:
        
            ```javascript
            sh.status()
            ```
        
        1. If sharding uses any key other than `_id` (default), assign the `clusterManager` system role to the user {{ data-transfer-name }} will use for connection to the target cluster:
        
            ```javascript
            use admin;
            db.grantRolesToUser("<username>", ["clusterManager"]);
            ```
        
        1. When [creating a target endpoint](../../../../data-transfer/operations/endpoint/target/mongodb.md), select `DISABLED` or `TRUNCATE` as your cleanup policy.
        
           {% include [MongoDB endpoint DROP clean policy warning](../../note-mongodb-clean-policy.md) %}

       Learn more about sharding in the [{{ MG }} documentation](https://docs.mongodb.com/basics/sharding/).

{% endlist %}
