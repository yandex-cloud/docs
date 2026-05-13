# Особенности работы с временными кластерами Yandex Data Processing

Если у вас нет существующих кластеров Yandex Data Processing или кластер нужен на непродолжительное время, вы можете использовать временные кластеры Yandex Data Processing. Их можно создать с помощью:

* [коннектора Spark](#spark-with-temporary-cluster) (предпочтительный способ);
* [шаблона Yandex Data Processing](#template).

Для работы с кластерами Yandex Data Processing требуется [предварительная настройка проекта](data-processing.md#settings).

Все кластеры Yandex Data Processing вне зависимости от варианта развертывания тарифицируются по [правилам сервиса Yandex Data Processing](../../data-proc/pricing.md). Все кластеры, доступные в проекте, можно посмотреть в разделе **Ресурсы проекта** ⟶ ![image](../../_assets/data-processing/data-processing.svg) **Yandex Data&nbsp;Processing** на странице проекта.

## Коннектор Spark {#spark-with-temporary-cluster}

При создании коннектора Spark вы можете создать временный кластер Yandex Data Processing и задать его параметры. DataSphere создаст такой кластер при первом запуске вычислений в ноутбуке и будет самостоятельно следить за ним. Кластер запускается и останавливается вместе с остановкой ВМ ноутбука.

ВМ ноутбука будет остановлена, если на ней не будет вычислений в течение времени, указанного в параметре **Остановить простаивающую ВМ через**. Вы также можете принудительно остановить ВМ ноутбука.

Подробнее о работе с коннекторами Spark см. в [инструкции](../operations/data/spark-connectors.md).

## Шаблоны Yandex Data Processing {#template}

В шаблоне Yandex Data Processing вы выбираете одну из предопределенных конфигураций кластера. На основе шаблона Yandex Data Processing, активированного в проекте, DataSphere развернет временный кластер, используя необходимые параметры проекта.

DataSphere самостоятельно следит за работой проекта и временных кластеров в нем. Если ВМ в проекте не работают в течение двух часов, такой проект закрывается, а временный кластер удаляется. Вы можете [задать время отключения ВМ](../operations/projects/update.md) в настройке **Остановить простаивающую ВМ через** или принудительно отключить ВМ ноутбука.

Вы также можете делиться шаблонами Yandex Data Processing с другими пользователями.

Подробнее о работе с шаблонами Yandex Data Processing см. в [инструкции](../operations/data-processing-template.md).

#### См. также {#see-also}

* [Шаблоны Yandex Data Processing](data-processing-template.md).
* [Интеграция с сервисом Yandex Data Processing](../tutorials/data-processing-integration.md).
* [Коннектор Spark](spark-connector.md).