# Шаблоны Yandex Data Processing

Шаблон Yandex Data Processing — это специальный ресурс для быстрого развертывания кластеров Yandex Data Processing в проектах DataSphere. Шаблон определяет конфигурацию кластера, на его основе DataSphere может развернуть кластер несколько раз.

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

## Информация о шаблонах Yandex Data Processing как о ресурсе {#info}

О каждом шаблоне хранится следующая информация:

* имя ресурса;
* создатель ресурса;
* конфигурация кластера;
* дата создания шаблона в формате в [UTC](https://ru.wikipedia.org/wiki/Всемирное_координированное_время), например `18 июля 2022 г., 14:23`.

Все шаблоны Yandex Data Processing, созданные в проекте, можно посмотреть на странице ресурса Yandex Data Processing. Там же отображается список всех доступных в проекте кластеров Yandex Data Processing. В него входят и временные кластеры на основе шаблонов Yandex Data Processing, и подключенные кластеры, развернутые в [сервисе Yandex Data Processing](../../data-proc/index.md). Чтобы посмотреть подробную информацию о шаблоне или кластере, нажмите на него.

## Особенности временного кластера на основе шаблона Yandex Data Processing {#special}

Чтобы создать кластер из шаблона Yandex Data Processing, [активируйте](../operations/data-processing-template.md#activate) шаблон в проекте. При запуске проекта в IDE DataSphere создаст временный кластер в каталоге и подсети Yandex Cloud, указанных в настройках проекта.

DataSphere следит за временем жизни кластера и автоматически удаляет его, если в течение двух часов на нем не было вычислений. Кластер также будет удален, если в проекте принудительно остановить вычисления.

### Конфигурации временных кластеров {#configurations}

Автоматические кластеры Yandex Data Processing разворачиваются на базе [виртуальных машин Yandex Compute Cloud](../../compute/concepts/vm.md) на платформе Intel Cascade Lake (`standard-v2`).

Необходимый суммарный объем дисков для разных конфигураций кластеров можно рассчитать по формуле:

```text
<количество_хостов_Yandex_Data_Processing> × 256 + 128
```

| Тип кластера | Количество хостов | Объем дисков |  Параметры хоста   |
|:------------:|:-----------------:|--------------|------------------- |
|    **XS**    |         1         | 384 ГБ HDD   | 4 vCPU, 16 ГБ RAM  |
|    **S**     |         4         | 1152 ГБ SSD  | 4 vCPU, 16 ГБ RAM  |
|    **M**     |         8         | 2176 ГБ SSD  | 16 vCPU, 64 ГБ RAM |
|    **L**     |        16         | 4224 ГБ SSD  | 16 vCPU, 64 ГБ RAM |
|    **XL**    |        32         | 8320 ГБ SSD  | 16 vCPU, 64 ГБ RAM |

{% note tip %}

Перед запуском проекта с активированным шаблоном Yandex Data Processing убедитесь, что [квоты](https://console.yandex.cloud/cloud?section=quotas) на создание HDD или SSD-дисков позволяют создать диск достаточного размера.

{% endnote %}

Работа временных кластеров, созданных из шаблонов Yandex Data Processing, тарифицируется дополнительно по [правилам тарификации Yandex Data Processing](../../data-proc/pricing.md).

### Статусы временного кластера Yandex Data Processing {#status}

DataSphere создаст временный кластер Yandex Data Processing, когда вы откроете проект в IDE.

После создания кластер появится в списке доступных кластеров на странице ресурсов Yandex Data Processing. Временный кластер может быть в одном из статусов:
* `STARTING` — кластер создается.
* `UP` — кластер создан и готов для выполнения вычислений.
* `DOWN` — возникли проблемы при создании кластера.

#### Полезные ссылки {#see-also}

* [Как создать, активировать, копировать или удалить шаблон](../operations/data-processing-template.md)