# Метки ресурсов сервисов

Большая часть сервисов поддерживает использование меток для маркировки ресуров.

_Метка_ — это пара ключ-значение.

На метку накладываются следующие ограничения: 
- Максимальное количество меток на один ресурс: 64. 
- Для ключа: 
    - Длина — от 1 до 63 символов.
    - Может содержать строчные буквы латинского алфавита, цифры, дефисы и нижние подчеркивания.
    - Первый символ — буква. 
- Для значения: 
    - Длина — до 63 символов.
    - Может содержать строчные буквы латинского алфавита, цифры, дефисы и нижние подчеркивания.

## Сервисы, в которых поддержаны метки {#services}

Список сервисов, ресурсы которых поддерживают использование меток: 
- [{{ compute-full-name }}](../../compute/)
- [{{ vpc-full-name }}](../../vpc/)
- [{{ resmgr-full-name }}](../../resource-manager/)
- [{{ kms-full-name }}](../../kms/)
- [{{ load-balancer-full-name }}](../../load-balancer/)
- [{{ container-registry-full-name }}](../../container-registry/)
- [{{ managed-k8s-full-name }}](../../managed-kubernetes/)
- [{{ mpg-full-name }}](../../managed-postgresql/)
- [{{ mch-full-name }}](../../managed-clickhouse/)
- [{{ mmg-full-name }}](../../managed-mongodb/)
- [{{ mmy-full-name }}](../../managed-mysql/)
- [{{ mrd-full-name }}](../../managed-redis/)
- [{{ dataproc-full-name }}](../../data-proc/)
- [{{ sf-full-name }}](../../functions/)
- [{{ iot-full-name }}](../../iot-core/)
