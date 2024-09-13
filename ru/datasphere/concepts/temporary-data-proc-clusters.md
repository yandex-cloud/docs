# Особенности работы с временными кластерами {{ dataproc-name }}

Если у вас нет существующих кластеров {{ dataproc-full-name }} или кластер нужен на непродолжительное время, вы можете использовать временные кластеры {{ dataproc-name }}. Их можно создать с помощью:

* [коннектора Spark](#spark-with-temporary-cluster) (предпочтительный способ);
* [шаблона {{ dataproc-name }}](#template).

Для работы с кластерами {{ dataproc-name }} требуется [предварительная настройка проекта](data-proc.md#settings).

Все кластеры {{ dataproc-name }} вне зависимости от варианта развертывания тарифицируются по [правилам сервиса {{ dataproc-full-name }}](../../data-proc/pricing.md). Все кластеры, доступные в проекте, можно посмотреть в разделе **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** ⟶ ![image](../../_assets/data-proc/data-proc.svg) **{{ ui-key.yc-ui-datasphere.resources.dataProc }}** на странице проекта.

## Коннектор Spark {#spark-with-temporary-cluster}

При создании коннектора Spark вы можете создать временный кластер {{ dataproc-name }} и задать его параметры. {{ ml-platform-name }} создаст такой кластер при первом запуске вычислений в ноутбуке и будет самостоятельно следить за ним. Кластер удаляется одновременно с остановкой ВМ ноутбука.

ВМ ноутбука будет остановлена, если на ней не будет вычислений в течение времени, указанного в параметре **{{ ui-key.yc-ui-datasphere.edit-project-page.dedicated-vm-inactivity-timeout }}**. Вы также можете принудительно остановить ВМ ноутбука.

Подробнее о работе с коннекторами Spark см. в [инструкции](../operations/data/spark-connectors.md).

## Шаблоны {{ dataproc-name }} {#template}

В шаблоне {{ dataproc-name }} вы выбираете одну из предопределенных конфигураций кластера. На основе шаблона {{ dataproc-name }}, активированного в проекте, {{ ml-platform-name }} развернет временный кластер, используя необходимые параметры проекта.

{{ ml-platform-name }} самостоятельно следит за работой проекта и временных кластеров в нем. Если ВМ в проекте не работают в течение двух часов, такой проект закрывается, а временный кластер удаляется. Вы можете [задать время отключения ВМ](../operations/projects/update.md) в настройке **{{ ui-key.yc-ui-datasphere.edit-project-page.dedicated-vm-inactivity-timeout }}** или принудительно отключить ВМ ноутбука.

Вы также можете делиться шаблонами {{ dataproc-name }} с другими пользователями.

Подробнее о работе с шаблонами {{ dataproc-name }} см. в [инструкции](../operations/data-proc-template.md).

#### См. также {#see-also}

* [{#T}](data-proc-template.md).
* [{#T}](../tutorials/data-proc-integration.md).
* [{#T}](spark-connector.md).
