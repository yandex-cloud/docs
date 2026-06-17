# Способы работы с кластерами Apache Spark™ в DataSphere

Сервис [Yandex Data Processing](../../data-proc/index.md) позволяет разворачивать кластеры Apache Spark™. Вы можете использовать кластеры Yandex Data Processing, чтобы запускать распределенные обучения на кластерах.

## Варианты развертывания кластеров {#types}

Чтобы работать в DataSphere с кластерами Yandex Data Processing, вы можете использовать:

* [коннектор Spark](data-processing-operations.md#spark-with-existing-cluster);
* [Livy-сессию](data-processing-operations.md#livy-sessions).

Если у вас нет существующих кластеров Yandex Data Processing или кластер нужен на непродолжительное время, вы можете использовать временные кластеры Yandex Data Processing. Их можно создать с помощью:

* [коннектора Spark](temporary-data-processing-clusters.md#spark-with-temporary-cluster) (предпочтительный способ);
* [шаблона Yandex Data Processing](temporary-data-processing-clusters.md#template).

Все кластеры Yandex Data Processing вне зависимости от варианта развертывания тарифицируются по [правилам сервиса Yandex Data Processing](../../data-proc/pricing.md).

## Настройки проекта DataSphere для работы с кластерами Yandex Data Processing {#settings}

Для работы с кластерами Yandex Data Processing:

1. [Укажите в настройках проекта](../operations/projects/update.md) следующие параметры:

   * [Каталог по умолчанию](../../resource-manager/concepts/resources-hierarchy.md#folder) для интеграции с другими сервисами Yandex Cloud. В нем будет развернут кластер Yandex Data Processing в рамках текущих [квот](../../data-proc/concepts/limits.md) облака, а стоимость использования кластера будет списана с платежного аккаунта облака.
   * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с [ролью](../../iam/concepts/access-control/roles.md) `vpc.user`, от имени которого DataSphere будет работать с сетью кластера Yandex Data Processing.
   * [Подсеть](../../vpc/concepts/network.md#subnet) для связи DataSphere с кластером Yandex Data Processing. Указанная подсеть должна находиться в [зоне доступности](../../overview/concepts/geo-scope.md), в которой создано сообщество. Кластеру Yandex Data Processing необходим доступ в интернет, поэтому в подсети должен быть [настроен NAT-шлюз](../../vpc/operations/create-nat-gateway.md). После указания подсети время выделения вычислительных ресурсов может быть увеличено.

1. Создайте [сервисного агента](../../iam/concepts/service-control.md#service-agent):

   1. Чтобы разрешить сервисному агенту работать в DataSphere, попросите администратора или владельца вашего облака выполнить команду в Yandex Cloud CLI:
   
      ```bash
      yc iam service-control enable datasphere --cloud-id <идентификатор_облака>
      ```
   
      Где `--cloud-id` — [идентификатор облака](../../resource-manager/operations/cloud/get-id.md), с которым вы будете работать в сообществе DataSphere.

   1. Создайте сервисный аккаунт с ролями:

      * `dataproc.agent` — для использования кластеров Yandex Data Processing.
      * `dataproc.admin`— для создания кластеров из шаблонов Yandex Data Processing.
      * `vpc.user` — для работы с сетью кластера Yandex Data Processing.
      * `iam.serviceAccounts.user` — для создания ресурсов в каталоге от имени сервисного аккаунта.

   1. В настройках сообщества в блоке **Кластеры Spark** нажмите **Добавить сервисный аккаунт** и выберите созданный сервисный аккаунт.
   
{% note warning %}

Постоянный кластер Yandex Data Processing должен иметь настройку `livy:livy.spark.deploy-mode : client`.

{% endnote %}

#### Полезные ссылки {#see-also}

* [Шаблоны Yandex Data Processing](data-processing-template.md)
* [Интеграция с сервисом Yandex Data Processing](../tutorials/data-processing-integration.md)
* [Коннектор Spark](spark-connector.md)