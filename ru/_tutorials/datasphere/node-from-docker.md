# Развертывание сервиса на основе Docker-образа

{{ ml-platform-name }} позволяет разворачивать и эксплуатировать сервисы на основе произвольного Docker-образа. 

В этом практическом руководстве с помощью [ноды из Docker-образа](../../datasphere/concepts/deploy/index.md#docker-node) вы развернете сервис обнаружения объектов на изображении, основанный на  [NVIDIA Triton Inference Server](https://github.com/triton-inference-server). 

1. [Подготовьте инфраструктуру](#infra).
1. [Подготовьте Docker-образ для развертывания сервиса](#docker).
1. [Разверните сервис в {{ ml-platform-name }}](#deploy).
1. [Проверьте работу развернутого сервиса](#check-node).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость развертывания сервиса на основе Docker-образа входят:

* плата за постоянно запущенные инстансы ноды (см. [тарифы {{ ml-platform-name }}](../../datasphere/pricing.md));
* плата за запуск ячеек с кодом для проверки работы развернутого сервиса;
* объем хранилища, занятый данными {{ container-registry-full-name }} (см. [тарифы {{ container-registry-name }}](../../container-registry/pricing.md)).

## Подготовьте инфраструктуру {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

### Создайте каталог {#create-folder}

Создайте каталог, в котором вы развернете всю необходимую инфраструктуру, а ваш сервис будет хранить логи.

{% note info %}

В примере инфраструктура {{ yandex-cloud }} и развернутый сервис работают в одном каталоге {{ yandex-cloud }}, однако это не обязательно.

{% endnote %}

{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите облако и нажмите кнопку ![create](../../_assets/plus-sign.svg)**Создать каталог**.
   1. Введите имя каталога, например `data-folder`.
   1. Нажмите кнопку **Создать**.

{% endlist %}

### Создайте реестр {{ container-registry-name }} {#create-registry}

{{ ml-platform-name }} может создать ноду из Docker-образа, который хранится в {{ container-registry-full-name }}. Чтобы загрузить образ, создайте реестр:

{% list tabs %}

- Консоль управления

  1. Перейдите в каталог `data-folder`.
  1. В списке сервисов выберите **{{ container-registry-name }}**.
  1. Задайте имя реестра, например `datasphere-registry`.
  1. Нажмите кнопку **Создать реестр**.
  
 {% endlist %} 


### Создайте сервисный аккаунт для проекта {{ ml-platform-name }} {#create-sa}

{% list tabs %}

- Консоль управления

   1. Перейдите в каталог `data-folder`.
   1. На вкладке **Сервисные аккаунты** нажмите кнопку **Создать сервисный аккаунт**.
   1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), например `sa-for-datasphere`.
   1. Нажмите **Добавить роль** и назначьте сервисному аккаунту [роли](../../iam/concepts/access-control/roles.md):
      * `container-registry.images.puller` — чтобы разрешить {{ ml-platform-name }} скачивать ваш Docker-образ для создания ноды.
      * `vpc.user` — для работы с сетью {{ ml-platform-name }}.
      * (опционально) `datasphere.user` — чтобы отправлять запросы в ноду.

   1. Нажмите кнопку **Создать**.

{% endlist %}

### Создайте авторизованный ключ для сервисного аккаунта {#create-key}

Чтобы сервисный аккаунт мог [аутентифицироваться в {{ container-registry-full-name }}](../../container-registry/operations/authentication.md), создайте авторизованный ключ. 

{% include [disclaimer](../../_includes/iam/authorized-keys-disclaimer.md) %}

{% list tabs %}

- Консоль управления

  1. В каталоге `data-folder` перейдите на вкладку **Сервисные аккаунты**.
  1. Выберите сервисный аккаунт `sa-for-datasphere` и нажмите на строку с его именем.
  1. Нажмите кнопку **Создать новый ключ** на верхней панели.
  1. Выберите пункт **Создать авторизованный ключ**.
  1. Выберите алгоритм шифрования.
  1. Задайте описание ключа, чтобы потом было проще найти его в консоли управления.
  1. Сохраните открытый и закрытый ключи: закрытый ключ не сохраняется в {{ yandex-cloud }}, открытый ключ нельзя будет посмотреть в консоли управления.

     {% note tip %}
      
     Вы можете сохранить файл с ключом на свой компьютер. Его содержимое понадобится позднее при создании секрета для доступа {{ ml-platform-name }} в {{ container-registry-name }}
      
     {% endnote %}

{% endlist %}

## Подготовьте Docker-образ для развертывания сервиса {#docker}

Если у вас еще нет Docker, [установите](https://docs.docker.com/install/) его.

### Создайте Docker-образ сервиса {#create-docker}

1. Создайте папку, в которой будет храниться конфигурация Docker-образа, например `/home/docker-images`.
1. Создайте и сохраните текстовый файл без расширения с именем `Dockerfile`. 

   {% cut "Triton Dockerfile" %}

   ```text
   # syntax=docker/dockerfile:1
   FROM nvcr.io/nvidia/tritonserver:22.01-py3
   
   RUN mkdir -p /models/resnet50_640x640/1/model.savedmodel/ &&\
     curl -L "https://tfhub.dev/tensorflow/faster_rcnn/resnet50_v1_640x640/1?tf-hub-format=compressed" |\
     tar -zxvC /models/resnet50_640x640/1/model.savedmodel/ &&\
     mkdir -p /models/resnet101_640x640/1/model.savedmodel/ &&\
     curl -L "https://tfhub.dev/tensorflow/faster_rcnn/resnet101_v1_640x640/1?tf-hub-format=compressed" |\
     tar -zxvC /models/resnet101_640x640/1/model.savedmodel/ && \
     mkdir -p /models/resnet152_640x640/1/model.savedmodel/ &&\
     curl -L "https://tfhub.dev/tensorflow/faster_rcnn/resnet152_v1_640x640/1?tf-hub-format=compressed" |\
     tar -zxvC /models/resnet152_640x640/1/model.savedmodel/ &&\
     mkdir -p /models/inception_resnet_v2_640x640/1/model.savedmodel/ &&\
     curl -L "https://tfhub.dev/tensorflow/faster_rcnn/inception_resnet_v2_640x640/1?tf-hub-format=compressed" |\
     tar -zxvC /models/inception_resnet_v2_640x640/1/model.savedmodel/
   
   ENTRYPOINT ["/opt/tritonserver/nvidia_entrypoint.sh",\
               "tritonserver",\
               "--model-repository=/models",\
               "--strict-model-config=false"]
   ```

   {% endcut %}

1. Запустите [Docker Desktop](https://docs.docker.com/desktop/). 
1. В командной оболочке перейдите в папку, где хранится созданный вами Dockerfile.
   
   ```bash
   cd docker-images
   ```
   
1. Соберите Docker-образ:

   ```bash
   docker build -t triton-docker .
   ```

1. 

### Загрузите Docker-образ в {{ container-registry-name }} {#push-docker}

{% include [install cli](../../_includes/cli-install.md) %}

{% list tabs %}

- CLI

   1. [Задайте](../../cli/operations/profile/manage-properties.md) каталог `data-folder` каталогом по умолчанию:
   
      ```bash
      yc config set folder-name data-folder
      ```
   
   1. Получите список реестров каталога `data-folder`:

      ```bash
      yc container registry list 
      ```

   1. [Аутентифицируйтесь в {{ container-registry-name }}](../../container-registry).
   
      1. Получите [IAM-токен](../../iam/concepts/authorization/iam-token.md) для своего пользовательского аккаунта:
      
      ```bash
      yc iam create-token
      ```
      
      В ответе будет IAM-токен. Если вы аутентифицируетесь от имени федеративного аккаунта, CLI перенаправит вас в консоль управления для аутентификации, а после этого пришлет IAM-токен.
   
      {% note info %}
   
      {% include [iam-token-note](../../_includes/iam/iam-token-note.md) %}
      
      {% endnote %}
   
      1. Выполните команду, подставив вместо `<IAM-токен>` значение токена, которое вы получили на предыдущем шаге:
      
      ```bash
      docker login \
        --username iam \
        --password <IAM-токен> \
        {{ registry }}
      ```

   1. Загрузите Docker-образ в {{ container-registry-name }}. Вместо <ID реестра> подставьте идентификатор вашего реестра `datasphere-registry`:

      ```bash
      docker tag triton-docker {{ registry }}/<ID реестра>/triton:v1
      docker push {{ registry }}/<ID реестра>/triton:v1
      ```

{% endlist %}

## Разверните сервис в {{ ml-platform-name }} {#deploy}

1. [На главной странице]({{ link-datasphere-main }}) {{ ml-platform-name }} в разделе **Сообщества** выберите сообщество с привязанным платежным аккаунтом.
1. Создайте проект `Node from Docker`.
1. [В настройках проекта](../../datasphere/operations/projects/update.md) укажите:
   *  **Сервисный аккаунт** — `sa-for-datasphere`.
   *  **Каталог** — `data-folder`.
1. [Создайте секрет](../../datasphere/operations/data/secrets.md) `iam-secret`, содержащий IAM-токен вашего пользовательского аккаунта. 
1. Создайте секрет `key-for-sa`, хранящий все содержимое файла с авторизованным ключом для сервисного аккаунта `sa-for-datasphere`.
1. Создайте ноду. Для этого на странице проекта в правом верхнем углу нажмите кнопку **Создать ресурс**. Во всплывающем окне выберите **Нода**. Задайте основные параметры ноды:
   * **Тип** — выберите **Docker-образ**.
   * **Имя** — `triton`.
   * В блоке **Образ Docker** задайте путь к образу {{ container-registry-name }}. Его можно получить в консоли управления или в CLI, выполнив команду `yc container registry list `. 
   * Нажмите кнопку **Показать дополнительные параметры** и укажите:
      * **Имя пользователя** — `json_key`.
      * **Секрет с паролем** — выберите `key-for-sa`.
   * В блоке **Эндпоинт**:
      * **Тип** — выберите протокол **HTTP**.
      * **Порт** — 8000.
      * **Таймаут** — оставьте значение по умолчанию (15 секунд).
      * **Idle timeout** — оставьте значение по умолчанию (300 секунд).
   * В блоке **Телеметрия**:
      * **Тип** — выберите **Prometheus**. 
      * **HTTP-адрес** — `/metrics`.
      * **Порт** — 8000.
   * В блоке **Проверка**:
      * **Тип** — выберите **HTTP**.
      * **Порт** — 8020.
      * **Путь** — `/v2/health/ready`.
      * **Таймаут** — 1.
      * **Интервал** — 20.
      * **Неудачные проверки** — 3.
      * **Пройденные проверки** — 3.
1. В блоке **Каталог** выберите каталог `data-folder`.
1. В блоке **Обеспечение** выберите [конфигурацию](../../datasphere/concepts/configurations.md) `c1.4`, [зону доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-a`. Идентификатор [подсети](../../vpc/concepts/network.md#subnet) оставьте пустым, {{ ml-platform-name }} будет использовать свою сеть по умолчанию. 
1. В блоке **Список управления доступом (ACL)** оставьте значение каталога по умолчанию.
1. Нажмите кнопку **Создать**.

## Проверьте работу развернутого сервиса {#check-node}

1. [Скачайте ноутбук](https://{{ s3-storage-host }}/doc-files/datasphere-nodefromdocker.ipynb) с кодом проверки и загрузите его в IDE проекта `Node from Docker`.
1. Выполните ячейки блока **Preparing environment**: выберите ячейки и нажмите **Shift** + **Enter**.
1. В блоке **Authentication** заполните информацию для аутентификации в ноде. Замените `<node ID>` и `<folder ID>` на идентификаторы ноды `triton` и каталога `data-folder`. 
1. Выполните ячейки блока **Authentication**.
1. Выполните ячейки блока **Test requests**. Вы будете обращаться к разным моделям, в ответ на каждый запрос сервис вернет распознанные объекты на изображении.

## Удалите созданные ресурсы {#clear-out}

{% include [node warning](../../_includes/datasphere/nodes-pricing-warn.md) %}

1. [Удалите ноду](../../datasphere/operations/deploy/node-delete.md).
1. [Удалите секреты](../../datasphere/operations/data/secrets.md#delete).
1. [Удалите авторизованный ключ](../../iam/operations/authorized-key/delete.md) сервисного аккаунта.
1. Удалите [Docker-образ](../../container-registry/operations/docker-image/docker-image-delete.md) и [реестр](../../container-registry/operations/registry/registry-delete.md) {{ container-registry-name }}.
