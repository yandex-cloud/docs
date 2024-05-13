# Создать ноду

Вы можете развернуть отдельную ячейку ноутбука или сторонний [Docker-образ](../../../container-registry/concepts/docker-image.md) в виде самостоятельного сервиса, используя [ноды](../../concepts/resource-model.md#resources).

{% note warning %}

{% include [pricing nodes](../../../_includes/datasphere/nodes-pricing-warn.md) %}

{% endnote %}

Если вы используете в проекте пакеты и библиотеки, не входящие в [список предустановленного ПО](../../concepts/preinstalled-packages.md), предварительно [настройте окружение](node-customization.md) ноды с помощью Docker-образа.

## Нода из модели {#from-model}


1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В правом верхнем углу нажмите кнопку **{{ ui-key.yc-ui-datasphere.project-page.project-card.create-resource }}**. Во всплывающем окне выберите **{{ ui-key.yc-ui-datasphere.resources.node }}**.
1. В поле **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.name }}** введите имя ноды.
1. В блоке **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.type }}** укажите тип ресурса — **{{ ui-key.yc-ui-datasphere.common.model }}**.
1. В поле **{{ ui-key.yc-ui-datasphere.common.models }}** выберите сохраненную [модель](../../concepts/models/index.md) и укажите входные данные, если требуется.

   {% note info %}

   При развертывании [моделей PyTorch](../../concepts/models/index.md#supported-types) {{ ml-platform-name }} не может автоматические определить входные и выходные параметры.

   Если вы задаете входные данные, обязательно указывайте и выходные данные. При ручном задании входных данных для любого типа моделей {{ ml-platform-name }} не сможет автоматические определить выходные данные.

   {% endnote %}

   Для моделей XGBoost и LightGBM имена входных и выходных параметров и их типы остаются неизменными: 
   * входные параметры: `input__0` типа `TYPE_FP32`, вектор длиной [N]. Например, при N=32 в поле **{{ ui-key.yc-ui-datasphere.common.dimension }}** укажите `[32]`. 
   * выходные параметры: `output__0` типа `TYPE_FP32`, скалярная величина. В поле **{{ ui-key.yc-ui-datasphere.common.dimension }}** укажите `[1]`.
   
   {% note tip %}
   
   Чтобы создать ноду из моделей XGBoost и LightGBM, сохраненных в {{ ml-platform-name }} до 8 апреля 2024 года, повторно сохраните их в ресурс [модель](../../concepts/models/index.md).

   {% endnote %}

1. В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.folder }}** выберите каталог, в котором будут создаваться новые ресурсы.
1. В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.provisioning }}** выберите [конфигурацию](../../concepts/configurations.md) вычислительных ресурсов [инстанса](../../concepts/deploy/index.md), [зону доступности](../../../overview/concepts/geo-scope.md) и идентификатор [подсети](../../../vpc/concepts/network.md#subnet) в которых будет размещен инстанс.
1. В поле **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.maintenance-limit }}** укажите, сколько инстансов ноды можно будет выключить одновременно для обслуживания.
1. В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.acl }}** нажмите кнопку ![Add](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-datasphere.new-node.add-acl }}** и укажите [идентификаторы каталогов](../../../resource-manager/operations/folder/get-id.md), из которых можно будет подключаться к ноде. По умолчанию указывается идентификатор каталога пользователя, создающего ноду.
1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.create }}**.

Чтобы посмотреть все созданные ноды:
1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** выберите **{{ ui-key.yc-ui-datasphere.resources.node }}**.

## Нода из Docker-образа {#from-docker}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В правом верхнем углу нажмите кнопку **{{ ui-key.yc-ui-datasphere.project-page.project-card.create-resource }}**. Во всплывающем окне выберите **{{ ui-key.yc-ui-datasphere.resources.node }}**.
1. В поле **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.name }}** введите имя ноды.
1. (Опционально) В поле **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.Description }}** укажите описание ноды.
1. В блоке **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.type }}** выберите ресурс, на основе которого создается нода — **{{ ui-key.yc-ui-datasphere.common.docker }}**.
1. В блоке **{{ ui-key.yc-ui-datasphere.new-node.source }}** выберите реестр контейнеров. Вы можете выбрать {{ container-registry-name }} или любой произвольный реестр. Для {{ container-registry-name }} укажите:
   * **{{ ui-key.yc-ui-datasphere.new-node.title.docker-image }}** вида `cr.yandex/<идентификатор_реестра>/<идентификатор_образа>:<тег>`.
   * **{{ ui-key.yc-ui-datasphere.new-node.kdi-form-label.user-name }}** автоматически получит значение `json_key`.
   * **{{ ui-key.yc-ui-datasphere.new-node.kdi-form-label.password-secret }}** — выберите из списка [секрет](../../concepts/secrets.md) с содержимым файла с [авторизованным ключом](../../../iam/concepts/authorization/key.md) для сервисного аккаунта из настроек проекта.
     
   Чтобы использовать образ из другого хранилища Docker-образов, выберите тип **{{ ui-key.yc-ui-datasphere.common.other }}** и заполните остальные поля значениями, необходимыми для подключения к вашему реестру.

1. В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.endpoint }}**:
   * **{{ ui-key.yc-ui-datasphere.new-node.endpoint-form-label.type }}** — выберите протокол подключения к ноде: **HTTP** (**HTTP/2**) или **gRPC**.
   * **{{ ui-key.yc-ui-datasphere.new-node.endpoint-form-label.port }}** — укажите порт для подключения к ноде.
   * **{{ ui-key.yc-ui-datasphere.common.timeout }}** — укажите продолжительность сессии в секундах.
   * **{{ ui-key.yc-ui-datasphere.new-node.endpoint-form-label.idle-timeout }}** — укажите время простоя соединения до разъединения в секундах.
1. (Опционально) В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.telemetry }}**:
   * **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.type }}** — выберите сервис для телеметрии: **{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.prometheus }}** или **{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.yandex-monitoring }}**. 
   * **{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.http-path }}** — укажите адрес, на который будут отправляться данные телеметрии.
   * **{{ ui-key.yc-ui-datasphere.new-node.telemetry-form-label.port }}** — укажите порт, на который будут отправляться данные телеметрии.
1. (Опционально) В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.healthcheck }}**:
   * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.type }}** — протокол, по которому проверяется состояние ноды: **HTTP** или **gRPC**.
   * **{{ ui-key.yc-ui-datasphere.common.port }}** — порт, с которого проверяется состояние ноды.
   * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.path }}** — путь к проверяемому ресурсу.
   * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.timeout }}** — продолжительность проверки в секундах.
   * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.interval }}** — интервал между проверками в секундах.
   * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.fails-threshold }}** — допустимое количество неудачных проверок.
   * **{{ ui-key.yc-ui-datasphere.new-node.healthcheck-form-label.passes-threshold }}** — необходимое количество пройденных проверок.
1. (Опционально) В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.runtime-options }}** задайте размер общей памяти, доступной в Docker-образе.
1. В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.folder }}** выберите каталог, в котором будут создаваться новые ресурсы.
1. В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.provisioning }}** выберите [конфигурацию](../../concepts/configurations.md) вычислительных ресурсов [инстанса](../../concepts/deploy/index.md), [зону доступности](../../../overview/concepts/geo-scope.md) и идентификатор [подсети](../../../vpc/concepts/network.md#subnet) в которых будет размещен инстанс. 
1. В поле **{{ ui-key.yc-ui-datasphere.new-node.node-form-label.maintenance-limit }}** укажите, сколько инстансов ноды можно будет выключить одновременно для обслуживания.
1. В блоке **{{ ui-key.yc-ui-datasphere.new-node.title.acl }}** нажмите кнопку ![Add](../../../_assets/console-icons/plus.svg) **{{ ui-key.yc-ui-datasphere.new-node.add-acl }}** и укажите [идентификаторы каталогов](../../../resource-manager/operations/folder/get-id.md), из которых можно будет подключаться к ноде. По умолчанию указывается идентификатор каталога пользователя, создающего ноду.
1. Нажмите кнопку **{{ ui-key.yc-ui-datasphere.common.create }}**.

Чтобы посмотреть все созданные ноды:
1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** выберите **{{ ui-key.yc-ui-datasphere.resources.node }}**.

#### См. также {#see-also}

* [{#T}](node-customization.md)
* [{#T}](node-update.md)
* [{#T}](node-delete.md)
* [{#T}](alias-create.md)
* [{#T}](../../tutorials/node-from-docker.md)
* [{#T}](../../tutorials/node-from-model.md)