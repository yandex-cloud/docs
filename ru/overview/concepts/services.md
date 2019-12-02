# Сервисы Яндекс.Облака

_Сервис_ в составе Яндекс.Облака позволяет управлять определенными категориями облачных ресурсов и доступом к ним.

## Категории сервисов {#service-type}

{% include  [service-type](../../_includes/overview/service-type.md) %}

## Список сервисов Яндекс.Облака

На данный момент в рамках платформы Яндекс.Облако доступны следующие сервисы:
- Infrastructure:
    - [{{ compute-full-name }}](../../compute/) (Сервис Облачных вычислений).
    - [{{ objstorage-full-name }}](../../storage/) (Сервис Объектного хранилища).
    - [{{ vpc-full-name }}](../../vpc/) (Сервис Виртуальное частное облако).
    - [{{ interconnect-full-name }}](../../vpc/interconnect/) (Сервис управления выделенными сетевыми соединениями).
    - [{{ iam-full-name }}](../../iam/) (Сервис по управлению доступом к облачным ресурсам).
    - [{{ resmgr-full-name }}](../../resource-manager/) (Сервис по управлению облачными ресурсами).
    - [{{ kms-full-name }}](../../kms/) (Сервис для управления ключами шифрования).
    - [{{ load-balancer-full-name }}](../../load-balancer/) (Сервис для управления сетевыми балансировщиками нагрузки).
    - [Yandex Instance Groups](../../compute/concepts/instance-groups/) (Сервис для создания и управления группами виртуальных машин).
    - [{{ container-registry-full-name }}](../../container-registry/) (Сервис для управления образами контейнеров).
    - [{{managed-k8s-full-name}}<sup>®</sup>](../../managed-kubernetes/) (Сервис Управления для Kubernetes).
    - [{{ monitoring-full-name }}](../../monitoring/) (Сервис мониторинга).
    - [Yandex DDoS Protection](../../vpc/ddos-protection/) (Сервис защиты от DDoS-атак).
- Data storage & Analytics:
    - [{{ mpg-full-name }}](../../managed-postgresql/) (Сервис Управления для PostgreSQL).
    - [{{ mch-full-name }}](../../managed-clickhouse/) (Сервис Управления для ClickHouse).
    - [{{ mmg-full-name }}](../../managed-mongodb/) (Сервис Управления для MongoDB).
    - [{{ mmy-full-name }}<sup>®</sup>](../../managed-mysql/) (Сервис Управления для MySQL).
    - [{{ mrd-full-name }}™](../../managed-redis/) (Сервис Управления для Redis).
    - [{{ dataproc-full-name }}](../../data-proc/) (Сервис Управления данными Data Proc).
    - [{{ datalens-full-name }}](../../datalens/) (Сервис визуализации и анализа данных).
- Cloud-native:
    - [{{ ydb-full-name }}](../../ydb/) (Сервис управления для {{ ydb-full-name }}). 
    - [{{ message-queue-full-name }}](../../message-queue/) (Сервис очередей).
    - [{{ sf-full-name }}](../../functions/) (Сервис бессерверных вычислений).
    - [{{ iot-full-name }}](../../iot-core/) (Сервис Интернета Вещей).
- Machine Learning & Artificial Intelligence (ML & AI):
    - [{{ speechkit-full-name }}](../../speechkit/) (Сервис речевых технологий).
    - [{{ translate-full-name }}](../../translate/) (Сервис машинного перевода).
    - [{{ vision-full-name }}](../../vision/) (Сервис компьютерного зрения).

### Как подключиться к сервисам

Для подключения к сервисам и управления ресурсами вы можете использовать консоль управления Яндекс.Облака. С ее помощью вы можете запускать виртуальные машины в Яндекс.Облаке и подключаться к ним, обращаться к объектному хранилищу, создавать базы данных и т. п.
