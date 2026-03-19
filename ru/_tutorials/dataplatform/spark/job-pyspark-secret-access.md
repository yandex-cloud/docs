# Использование секрета {{ lockbox-name }} в PySpark-задании для подключения к {{ mpg-full-name }}

Вы можете использовать секрет [{{ lockbox-name }}](../../../lockbox/concepts/secret.md) для подключения к кластеру [{{ mpg-full-name }}](../../../managed-postgresql/index.yaml) из PySpark-задания в [{{ msp-full-name }}](../../../managed-spark/index.yaml). Для этого [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md) кластера {{ msp-full-name }} необходимо предоставить доступ к секрету. Секрет создается сервисом {{ connection-manager-full-name }} автоматически при создании пользователя {{ mpg-name }}.

Для PySpark-задания используется Python-скрипт, который хранится в бакете {{ objstorage-full-name }}. Скрипт получает пароль пользователя из секрета и использует его для подключения к кластеру {{ mpg-name }}.

Чтобы получить информацию из секрета и подключиться к кластеру {{ mpg-name }}, выполните следующие действия:

1. [Подготовьте инфраструктуру](#infra).
1. [Настройте права доступа к секрету пользователя](#set-up-roles).
1. [Подготовьте PySpark-задание](#prepare-a-job).
1. [Запустите задание и проверьте результат](#check-out).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

* Кластер {{ msp-full-name }}: вычислительные ресурсы компонентов кластера (см. [тарифы {{ msp-full-name }}](../../../managed-spark/pricing.md)).
* Кластер {{ mpg-name }}: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий (см. [тарифы {{ mpg-name }}](../../../managed-postgresql/pricing.md)).
* Бакет {{ objstorage-name }}: использование хранилища и выполнение операций с данными (см. [тарифы {{ objstorage-name }}](../../../storage/pricing.md)).
* NAT-шлюз: почасовое использование шлюза и исходящий через него трафик (см. [тарифы {{ vpc-name }}](../../../vpc/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ (см. [тарифы {{ vpc-name }}](../../../vpc/pricing.md)).

Использование секретов {{ lockbox-name }}, созданных с помощью {{ connection-manager-name }}, не тарифицируется.

## Подготовьте инфраструктуру {#infra}

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md#create-sa) `spark-agent` и назначьте ему роли:
  
    * [managed-spark.integrationProvider](../../../managed-spark/security.md#managed-spark-integrationProvider) — для взаимодействия {{ msp-full-name }} с другими сервисами;
    * [storage.editor](../../../storage/security/index.md#storage-editor) — для доступа к файлу с PySpark-заданием в бакете {{ objstorage-name }}.
  
1. [Создайте бакет](../../../storage/operations/buckets/create.md). 
1. [Предоставьте разрешение](../../../storage/operations/buckets/edit-acl.md) `READ` для сервисного аккаунта `spark-agent` на созданный бакет.

1. [Создайте облачную сеть](../../../vpc/operations/network-create.md) с именем `spark-network`.

    Вместе с ней автоматически будут созданы три подсети в разных зонах доступности.

1. В сети `spark-network` [создайте группу безопасности](../../../vpc/operations/security-group-create.md) `spark-sg` для кластера {{ msp-full-name }}, разрешающую исходящие TCP-подключения:
    
    * на порт `{{ port-mpg }}` для подключения к {{ PG }};
    * на порт `443` для скачивания Maven-пакетов.

1. В сети `spark-network` создайте группу безопасности `pg-sg` для кластера {{ mpg-name }}, разрешающую входящие TCP-подключения на порт `{{ port-mpg }}`.

1. [Создайте кластер {{ msp-full-name }}](../../../managed-spark/operations/cluster-create.md) со следующими настройками:

    * **Сервисный аккаунт** — `spark-agent`.
    * **Сеть** — `spark-network`.
    * **Группа безопасности** — `spark-sg`.

1. [Настройте NAT-шлюз](../../../vpc/operations/create-nat-gateway.md) для подсети, в которой создан кластер {{ msp-full-name }}. NAT-шлюз нужен для скачивания JDBC-драйвера {{ PG }} из Maven-репозитория.

1. [Создайте кластер {{ mpg-name }}](../../../managed-postgresql/operations/cluster-create.md) со следующими настройками:

    * **Сеть** — `spark-network`.
    * **Группа безопасности** — `pg-sg`.

## Настройте права доступа к секрету пользователя {{ mpg-name }} {#set-up-roles}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором создана необходимая инфраструктура.
  1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_users }}**.
  1. Нажмите на идентификатор подключения в строке нужного пользователя.
    
      Откроется страница подключения {{ connection-manager-name }} для выбранного пользователя.
  
  1. На открывшейся странице нажмите на идентификатор секрета.

      Откроется страница секрета {{ lockbox-name }}, который хранит пароль пользователя {{ PG }}.

  1. На панели слева выберите раздел ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** и нажмите кнопку **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
  1. Выберите сервисный аккаунт `spark-agent`, которому будет предоставлен доступ к секрету.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите `lockbox.payloadViewer`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Чтобы настроить права доступа к секрету пользователя {{ mpg-name }}:
  
  1. Получите идентификатор секрета из подключения {{ connection-manager-name }}:

      ```bash
      yc metadata-hub connection-manager connection list \
        --mdb-cluster-id <идентификатор_кластера_{{ PG }}>
      ```

      Идентификатор кластера можно получить со [списком кластеров в каталоге](../../../managed-postgresql/operations/cluster-list.md).
  
  1. Настройте права доступа к секрету пользователя:

      ```bash
      yc lockbox secret add-access-binding <идентификатор_секрета> \
        --role lockbox.payloadViewer \
        --service-account-name spark-agent 
      ```

      Сервисному аккаунту `spark-agent` будет предоставлен доступ к секрету пользователя {{ mpg-name }}.

{% endlist %}

## Подготовьте PySpark-задание {#prepare-a-job}

1. Создайте локально файл с именем `job-mpg-connection-with-secret.py` и скопируйте в него скрипт:

    {% cut "job-mpg-connection-with-secret.py" %}

    {% include [py](../../_tutorials_includes/spark/job-mpg-connection-with-secret.md) %}

    {% endcut %}

1. Укажите в файле скрипта следующие параметры:
    
    * идентификатор секрета;
    * [FQDN хоста](../../../managed-postgresql/operations/connect/fqdn.md) для подключения к кластеру {{ mpg-name }};
    * имя базы данных;
    * имя таблицы.

## Запустите задание и проверьте результат {#check-out}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Загрузите в бакет](../../../storage/operations/objects/upload.md#simple) файл `job-mpg-connection-with-secret.py`.
  1. В кластере {{ msp-full-name }} [создайте задание](../../../managed-spark/operations/jobs-pyspark.md) со следующими параметрами:
      
      * **Тип задания** — **PySpark**.
      * **Main python файл** – `s3a://<имя_бакета>/job-mpg-connection-with-secret.py`.
      * **Пакеты** — `org.postgresql:postgresql:42.7.3`.

  1. Дождитесь, когда созданное PySpark-задание перейдет в статус **Done**.
  1. [Получите логи выполнения задания](../../../managed-spark/operations/jobs-pyspark.md#get-logs).

      В логах задания будет показан вывод строк таблицы, указанной в скрипте.

- CLI {#cli}
  
  1. Загрузите в бакет файл `job-mpg-connection-with-secret.py`:

      ```bash
      yc storage s3api put-object \
        --body <путь_к_локальному_файлу> \
        --bucket <имя_бакета> \
        --key "job-mpg-connection-with-secret.py"
      ```
  
  1. Запустите задание:

      ```bash
      yc managed-spark job create-pyspark \
        --cluster-id <идентификатор_кластера> \
        --name "<имя_задания>" \
        --main-python-file-uri s3a://<имя_бакета>/job-mpg-connection-with-secret.py \
        --packages org.postgresql:postgresql:42.7.3
      ```

      Идентификатор кластера можно получить со [списком кластеров в каталоге](../../../managed-spark/operations/cluster-list.md#list-clusters).

      Команда вернет идентификатор задания. Сохраните его, он понадобится для получения логов выполнения задания.

  1. Получите логи выполнения задания:

      ```bash
      yc managed-spark job log <идентификатор_задания> \
        --cluster-id <идентификатор_кластера>
      ```

      В логах задания будет показан вывод строк таблицы, указанной в скрипте.

{% endlist %}
 
## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Кластер {{ msp-full-name }}](../../../managed-spark/operations/cluster-delete.md).
1. [Кластер {{ mpg-name }}](../../../managed-postgresql/operations/cluster-delete.md).
1. [Бакет {{ objstorage-name }}](../../../storage/operations/buckets/delete.md). Перед удалением бакета [удалите из него все объекты](../../../storage/operations/objects/delete.md).
1. [NAT-шлюз](../../../vpc/operations/delete-nat-gateway.md).