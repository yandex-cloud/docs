{% list tabs %}

- {{ mkf-name }}
    
    
    [Create a user](../../../../managed-kafka/operations/cluster-accounts.md#create-account) with the `ACCESS_ROLE_CONSUMER` role for the source topic.


- {{ KF }}
    
    1. {% include notitle [White IP list](../../configure-white-ip.md) %}
    
    1. [Configure access to the source cluster from {{ yandex-cloud }}](../../../../data-transfer/concepts/network.md#source-external).
    
    1. [Configure user access rights](https://kafka.apache.org/documentation/#multitenancy-security) to the topic you need.
    
    1. Grant the `READ` permissions to the consumer group whose ID matches the transfer ID.
    
        ```text
        bin/kafka-acls --bootstrap-server localhost:9092 \
          --command-config adminclient-configs.conf \
          --add \
          --allow-principal User:username \
          --operation Read \
          --group <transfer_ID>
        ```
    
    1. Optionally, to log in with a username and password, [configure SASL authentication](https://kafka.apache.org/documentation/#security_sasl).

{% endlist %}