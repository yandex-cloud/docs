# Как начать работать с Managed Service for Apache Airflow™

Чтобы начать работу с сервисом Managed Service for Apache Airflow™:

1. [Создайте кластер](#cluster-create).
1. [Откройте веб-интерфейс Apache Airflow™](#web-gui).

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь, если вы еще не зарегистрированы.

1. Если у вас еще нет каталога, создайте его:

   1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../_assets/console-icons/layout-side-content-left.svg) или ![image](../_assets/console-icons/chevron-down.svg) и выберите нужное [облако](../resource-manager/concepts/resources-hierarchy.md#cloud).
   1. Справа от названия облака нажмите ![image](../_assets/console-icons/ellipsis.svg).
   1. Выберите ![image](../_assets/console-icons/plus.svg) **Создать каталог**.
   
      ![create-folder1](../_assets/resource-manager/create-folder-1.png)
   
   1. Введите имя [каталога](../resource-manager/concepts/resources-hierarchy.md#folder). Требования к имени:
   
       * длина — от 3 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.
   
   1. (Опционально) Введите описание каталога.
   1. Выберите опцию **Создать сеть по умолчанию**. Будет создана [сеть](../vpc/concepts/network.md#network) с подсетями в каждой зоне доступности. Также в этой сети будет создана [группа безопасности по умолчанию](../vpc/concepts/security-groups.md#default-security-group), внутри которой весь сетевой трафик разрешен.
   1. Нажмите кнопку **Создать**.
   
      ![create-folder2](../_assets/resource-manager/create-folder-2.png)

   Настройки группы безопасности не влияют на доступ к [веб-интерфейсу Apache Airflow™](operations/af-interfaces.md#web-gui).

1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в Yandex Cloud роли:

    * [managed-airflow.editor](security/index.md#managed-airflow-editor) — чтобы создать кластер;
    * [vpc.user](../vpc/security/index.md#vpc-user) — чтобы работать с [сетью](../vpc/concepts/network.md#network) кластера;
    * [iam.serviceAccounts.user](../iam/security/index.md#iam-serviceAccounts-user) — чтобы привязать сервисный аккаунт к кластеру.

    {% note info %}
    
    Если вы не можете управлять ролями, обратитесь к администратору вашего облака или организации.
    
    {% endnote %}

1. [Создайте бакет Yandex Object Storage](../storage/operations/buckets/create.md) для хранения [DAG-файлов](concepts/index.md#about-the-service) Managed Service for Apache Airflow™.
1. [Создайте сервисный аккаунт](../iam/operations/sa/create.md).
1. [Назначьте сервисному аккаунту роль](../iam/operations/sa/assign-role-for-sa.md) `managed-airflow.integrationProvider` на каталог или бакет.
1. [Предоставьте разрешение](../storage/operations/buckets/edit-acl.md) `READ` сервисному аккаунту на бакет.

## Создайте кластер {#cluster-create}

1. В консоли управления выберите каталог, в котором нужно создать [кластер](../glossary/cluster.md) Managed Service for Apache Airflow™.
1. Перейдите в сервис **Managed Service for&nbsp;Apache&nbsp;Airflow™**.
1. Нажмите кнопку **Создать кластер**.
1. Задайте параметры кластера и нажмите кнопку **Создать**. Процесс подробно рассмотрен в разделе [Создание кластера](operations/cluster-create.md).
1. Дождитесь, когда кластер будет готов к работе: его статус сменится на **Running**, а состояние — на **Alive**. Это может занять некоторое время. Чтобы проверить состояние, наведите курсор на статус кластера в столбце **Доступность**.

## Откройте веб-интерфейс Apache Airflow™ {#web-gui}

Для управления Apache Airflow™ можно использовать веб-интерфейс. Работать с ним могут только пользователи с ролью не ниже [managed-airflow.user](security/index.md#managed-airflow-user). Чтобы начать работу в веб-интерфейсе Apache Airflow™:

1. В [консоли управления](https://console.yandex.cloud) откройте страницу кластера.
1. В поле **Веб-сервер** нажмите **Перейти** ![start](../_assets/console-icons/arrow-up-right-from-square.svg).
1. В открывшемся веб-интерфейсе [веб-сервера Managed Service for Apache Airflow™](concepts/index.md#components) введите данные для аутентификации:

   * Логин — `admin`.
   * Пароль — пароль пользователя `admin`, который вы указали при создании кластера.

Подробности о работе в веб-интерфейсе читайте в [документации Apache Airflow™](https://airflow.apache.org/docs/apache-airflow/stable/ui.html).

Помимо веб-интерфейса можно также использовать [API Apache Airflow™](https://airflow.apache.org/docs/apache-airflow/stable/stable-rest-api-ref.html). Подробнее о нем читайте в разделе [Работа с интерфейсами Apache Airflow™](operations/af-interfaces.md).

## Что дальше {#whats-next}

* Изучите [концепции сервиса Managed Service for Apache Airflow™](concepts/index.md).
* Узнайте подробнее о [создании кластера](operations/cluster-create.md) Managed Service for Apache Airflow™ и [работе с интерфейсами](operations/af-interfaces.md) Apache Airflow™.
* Создайте DAG-файлы и [загрузите их](operations/upload-dags.md) в кластер Managed Service for Apache Airflow™. Пример DAG-файла в [документации Apache Airflow™](https://airflow.apache.org/docs/apache-airflow/stable/tutorial/fundamentals.html).