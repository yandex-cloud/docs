* Инфраструктура и сеть:
  * [Создайте виртуальную машину Linux](../compute/quickstart/quick-create-linux.md).
  {% if product == "cloud-il" %}
  * [Создайте виртуальную машину Windows](../compute/quickstart/quick-create-windows.md).
  {% endif %}
  * [Создайте группу виртуальных машин](../compute/quickstart/ig.md).
  * [Разместите файлы в {{ objstorage-name }}](../storage/quickstart.md).
  * [Создайте облачную сеть в {{ vpc-name }}](../vpc/quickstart.md).
  * [Настройте сетевой балансировщик в {{ network-load-balancer-name }}](../network-load-balancer/quickstart.md).
  * [Настройте L7-балансировщик в {{ alb-name }}](../application-load-balancer/quickstart.md).
  {% if product == "yandex-cloud" %}* [Настройте раздачу контента через CDN](../cdn/quickstart.md).{% endif %}
  * [Создайте зоны DNS](../dns/quickstart.md).
  * [Загрузите Docker-образ в реестр в {{ container-registry-name }}](../container-registry/quickstart/index.md).
* Безопасность:
  * [Добавьте пользователей и назначьте им роли в {{ iam-short-name }}](../iam/quickstart.md).
  * [Создайте новый каталог в облаке и предоставьте к нему доступ в {{ resmgr-name }}](../resource-manager/quickstart.md).
  * [Управляйте ключами шифрования в {{ kms-name }}](../kms/quickstart/index.md).
  * [Настройте сертификат для доступа по безопасному соединению в {{ certificate-manager-name }}](../certificate-manager/quickstart/index.md).
  * [Безопасно храните конфиденциальные данные в {{ lockbox-name }}](../lockbox/quickstart.md).
* Ресурсы и управление:
  * [Управляйте ресурсами в каталогах и облаках с помощью {{ resmgr-name }}](../resource-manager/quickstart.md).
  * [Настраивайте корпоративные аккаунты в {{ org-name }}](../organization/quick-start.md).
  {% if audience != "internal" %} 
  * [Задавайте метрики и следите за состоянием ресурсов с помощью {{ monitoring-name }}](../monitoring/quickstart.md).
  {% endif %}
  {% if audience != "internal" and product == "yandex-cloud" %}
  * [Визуализируйте данные в {{ datalens-name }}](../datalens/quickstart.md).
  {% endif %}
  {% if product == "yandex-cloud" %}* [Собирайте логи работы ресурсов с помощью {{ cloud-logging-name }}](../logging/quickstart.md).{% endif %}
* Контейнерная разработка:
  * [Создайте кластер {{ k8s }}](../managed-kubernetes/quickstart.md).
  * [Создайте реестр Docker-образов {{ container-registry-name }}](../container-registry/quickstart/index.md).
* Бессерверные вычисления:
  {% if product == "yandex-cloud" %}* [Запускайте ваш код в виде функций в {{ sf-name }}](../functions/quickstart/index.md).{% endif %}
  {% if product == "yandex-cloud" %}* [Используйте {{ api-gw-name }}, чтобы интегрировать сервисы {{ yandex-cloud }} с другими облачными платформами](../api-gateway/quickstart/index.md).{% endif %}
  * [Настраивайте очереди для обмена сообщениями между приложениями с {{ message-queue-name }}](../message-queue/quickstart.md).
  {% if audience != "internal" and product == "yandex-cloud" %}
  * [Управляйте потоками данных в {{ yds-name }}](../data-streams/quickstart/index.md).
  {% endif %}
  {% if product == "yandex-cloud" %}* [Используйте {{ iot-name }} как основу вашей разработки умного дома](../iot-core/quickstart.md).{% endif %}
* Базы данных и кластеры баз данных:
  * [{{ CH }}](../managed-clickhouse/quickstart.md).
  {% if product == "yandex-cloud" %}* [{{ MG }}](../managed-mongodb/quickstart.md).{% endif %}
  * [{{ MY }}](../managed-mysql/quickstart.md).
  {% if product == "yandex-cloud" %}* [{{ RD }}](../managed-redis/quickstart.md).{% endif %}
  * [{{ PG }}](../managed-postgresql/quickstart.md).
  {% if product == "yandex-cloud" %}* [{{ ES }}](../managed-elasticsearch/quickstart.md).{% endif %}
  * [{{ KF }}](../managed-kafka/quickstart.md).
  {% if product == "yandex-cloud" %}* [{{ GP }}](../managed-greenplum/quickstart.md).{% endif %}
  {% if audience != "internal" and product == "yandex-cloud" %}
  * [{{ ydb-name }}](../ydb/quickstart.md#create-db).
  {% endif %}
  * [Копируйте и реплицируйте данные из одной базы в другую с помощью {{ data-transfer-name }}](../data-transfer/quickstart.md).
{% if product == "yandex-cloud" %}
* Машинное обучение:
  * [Преобразуйте текст в речь и наоборот с помощью {{ speechkit-name }}](../speechkit/quickstart.md).
  * [Переведите текст в {{ translate-name }}](../translate/quickstart.md).
  * [Анализируйте изображение с помощью компьютерного зрения в {{ vision-name }}](../vision/quickstart.md).
  * [Обучайте и запускайте модели машинного обучения в {{ ml-platform-name }}](../datasphere/quickstart.md).
{% endif %}
