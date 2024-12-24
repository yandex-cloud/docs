{% list tabs %}

- {{ mkf-name }}
    

    [Создайте пользователя](../../../../managed-kafka/operations/cluster-accounts.md#create-account) с ролью `ACCESS_ROLE_CONSUMER` на топике-источнике.


- {{ KF }}
    
    1. {% include notitle [White IP list](../../configure-white-ip.md) %}
    
    1. [Настройте доступ к кластеру-источнику из {{ yandex-cloud }}](../../../../data-transfer/concepts/network.md#source-external).
    
    1. [Настройте права доступа](https://kafka.apache.org/documentation/#multitenancy-security) пользователя к нужному топику.
    
    1. Выдайте права `READ` консьюмер-группе, идентификатор которой совпадает с идентификатором трансфера.
    
        ```text
        bin/kafka-acls --bootstrap-server localhost:9092 \
          --command-config adminclient-configs.conf \
          --add \
          --allow-principal User:username \
          --operation Read \
          --group <идентификатор_трансфера>
        ```
    
    1. (Опционально) Чтобы использовать авторизацию по логину и паролю, [настройте SASL-аутентификацию](https://kafka.apache.org/documentation/#security_sasl).

{% endlist %}