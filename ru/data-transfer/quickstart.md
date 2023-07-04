# Как начать работать с {{ data-transfer-name }}

Копируйте или реплицируйте данные из источника в приемник, создав [эндпоинты](concepts/index.md#endpoint) и настроив между ними [трансферы](concepts/index.md#transfer).


## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль]({{ link-console-main }}) {{ yandex-cloud }} и выберите каталог, в котором будете выполнять операции. Если такого каталога нет, создайте его:

    {% list tabs %}

    - Консоль управления

         {% include [create-folder](../_includes/create-folder.md) %}

    - CLI

         {% include [cli-install](../_includes/cli-install.md) %}

        1. Посмотрите описание команды создания каталога:

            ```bash
            yc resource-manager folder create --help
            ```

        1. Создайте новый каталог:

            * с именем и без описания:

                 ```bash
                 yc resource-manager folder create \
                   --name new-folder
                 ```

                 {% include [name-format](../_includes/name-format.md) %}

            * с именем и описанием:

                ```bash
                yc resource-manager folder create \
                  --name new-folder \
                  --description "my first folder with description"
                ```

    - API

        Воспользуйтесь методом [create](../resource-manager/api-ref/Folder/create.md) для ресурса [Folder](../resource-manager/api-ref/Folder/index.md) сервиса {{ resmgr-full-name }}.

    {% endlist %}


1. [На странице биллинга]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md), и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
1. На странице [Управление доступом]({{ link-console-access-management }}) убедитесь, что у вас есть роль `editor` или выше на нужный каталог или облако, которому принадлежит этот каталог.


## Настройте источник и приемник {#db-settings}

В качестве источника и приемника могут выступать разные системы.

### Совместимость источников и приемников {#connectivity-matrix}

{% include [include](../_includes/data-transfer/connectivity-marix.md) %}

### Подготовка источников и приемников {#prepare-source-and-target}

Подготовьте источник к отправке данных:

* Airbyte®:
    * [AWS CloudTrail](operations/prepare.md#source-aws)
    * [BigQuery](operations/prepare.md#source-bigquery)
    * [S3](operations/prepare.md#source-s3)
* [{{ KF }}](operations/prepare.md#source-kf)
* [{{ CH }}](operations/prepare.md#source-ch)
* [{{ GP }}](operations/prepare.md#source-gp)
* [{{ MG }}](operations/prepare.md#source-mg)
* [{{ MY }}](operations/prepare.md#source-my)
* [{{ PG }}](operations/prepare.md#source-pg)
* [{{ yds-full-name }}](operations/prepare.md#source-yds)

Подготовьте приемник к получению данных:

* [{{ CH }}](operations/prepare.md#target-ch)
* [{{ GP }}](operations/prepare.md#target-gp)
* [{{ MG }}](operations/prepare.md#target-mg)
* [{{ MY }}](operations/prepare.md#target-my)
* [{{ objstorage-name }}](operations/prepare.md#target-storage)
* [{{ PG }}](operations/prepare.md#target-pg)


* [{{ ydb-full-name }}](operations/prepare.md#target-ydb)


## Создайте эндпоинт для источника {#source}

1. Перейдите на страницу каталога и выберите сервис **{{ data-transfer-full-name }}**.
1. Нажмите кнопку **Создать эндпоинт**.
1. Убедитесь, что в поле **Направление** указано `Источник`.
1. Укажите имя эндпоинта.
1. В поле **Тип базы данных** выберите тип СУБД, из которой вы хотите передавать данные.
1. Укажите параметры эндпоинта в соответствующем блоке настроек.
1. Нажмите кнопку **Создать**.

Подробнее см. в разделе [{#T}](operations/endpoint/index.md).

## Создайте эндпоинт для приемника {#target}

1. Перейдите на страницу каталога и выберите сервис **{{ data-transfer-full-name }}**.
1. Нажмите кнопку **Создать эндпоинт**.
1. Убедитесь, что в поле **Направление** указано `Приемник`.
1. Укажите имя эндпоинта.
1. В поле **Тип базы данных** выберите тип СУБД, в которую вы хотите передавать данные.
1. Укажите параметры эндпоинта в соответствующем блоке настроек.
1. Нажмите кнопку **Создать**.

Подробнее см. в разделе [{#T}](./operations/endpoint/index.md).

## Создайте трансфер {#create-transfer}

1. Перейдите на страницу каталога и выберите сервис **{{ data-transfer-full-name }}**.
1. На панели слева выберите ![image](../_assets/data-transfer/transfer.svg) **Трансферы**.
1. Нажмите кнопку **Создать трансфер**.
1. Выберите эндпоинт для источника и эндпоинт для приемника.
1. Укажите имя трансфера.
1. Выберите [тип трансфера](./concepts/index.md#transfer-type.md):
    * {{ dt-type-copy }} — чтобы создать полную копию данных без дальнейшего получения обновлений из источника. Этот тип также можно использовать для [репликации постоянно меняющихся таблиц](concepts/transfer-lifecycle.md#select-transfer-type).
    * {{ dt-type-copy-reg }} — чтобы создавать полную копию данных через определенные интервалы времени.
    * {{ dt-type-repl }} — чтобы непрерывно получать изменения данных от источника и применять их к приемнику (без создания полной копии данных источника).
    * {{ dt-type-copy-repl }} — чтобы создать полную копию данных источника и поддерживать ее в актуальном состоянии.
1. (опционально) Добавьте описание трансфера.
1. Нажмите кнопку **Создать**.

Подробнее см. в разделе [Типы трансферов](./concepts/transfer-lifecycle.md#transfer-types).

## Активируйте трансфер {#activate}

1. Перейдите на страницу каталога и выберите сервис **{{ data-transfer-full-name }}**.
1. На панели слева выберите ![image](../_assets/data-transfer/transfer.svg) **Трансферы**.
1. Нажмите значок ![ellipsis](../_assets/horizontal-ellipsis.svg) рядом с именем нужного трансфера и выберите пункт **Активировать**.

Начнется процесс переноса данных.

Подробнее см. в разделе [{#T}](operations/transfer.md).

## Что дальше {#whats-next}

* Изучите [концепции сервиса](concepts/index.md).
* Узнайте больше о [подготовке баз данных для использования сервиса](operations/prepare.md) и [настройке трансферов](operations/transfer.md).
* Ознакомьтесь с [практическими руководствами по работе с сервисом](tutorials/index.md).

{% include [greenplum-trademark](../_includes/mdb/mgp/trademark.md) %}
