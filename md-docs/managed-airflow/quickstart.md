# Как начать работать с {{ maf-name }}

Чтобы начать работу с сервисом {{ maf-name }}:

1. [Создайте кластер](#cluster-create).
1. [Откройте веб-интерфейс {{ AF }}](#web-gui).

## Перед началом работы {#before-you-begin}

1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь, если вы еще не зарегистрированы.

1. Если у вас еще нет каталога, создайте его:

   1. В [консоли управления]({{ link-console-main }}) на панели сверху нажмите ![image](../_assets/console-icons/layout-side-content-left.svg) или ![image](../_assets/console-icons/chevron-down.svg) и выберите нужное [облако](../resource-manager/concepts/resources-hierarchy.md#cloud).
   1. Справа от названия облака нажмите ![image](../_assets/console-icons/ellipsis.svg).
   1. Выберите ![image](../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   
      ![create-folder1](../_assets/resource-manager/create-folder-1.png)
   
   1. Введите имя [каталога](../resource-manager/concepts/resources-hierarchy.md#folder). Требования к имени:
   
       * длина — от 3 до 63 символов;
       * может содержать строчные буквы латинского алфавита, цифры и дефисы;
       * первый символ — буква, последний — не дефис.
   
   1. (Опционально) Введите описание каталога.
   1. Выберите опцию **{{ ui-key.yacloud.iam.cloud.folders-create.field_default-net }}**. Будет создана [сеть](../vpc/concepts/network.md#network) с подсетями в каждой зоне доступности. Также в этой сети будет создана [группа безопасности по умолчанию](../vpc/concepts/security-groups.md#default-security-group), внутри которой весь сетевой трафик разрешен.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.
   
      ![create-folder2](../_assets/resource-manager/create-folder-2.png)

   Настройки группы безопасности не влияют на доступ к [веб-интерфейсу {{ AF }}](operations/af-interfaces.md#web-gui).

1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в {{ yandex-cloud }} роли:

    * [{{ roles.maf.editor }}](security/index.md#managed-airflow-editor) — чтобы создать кластер;
    * [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) — чтобы работать с [сетью](../vpc/concepts/network.md#network) кластера;
    * [iam.serviceAccounts.user](../iam/security/index.md#iam-serviceAccounts-user) — чтобы привязать сервисный аккаунт к кластеру.

    {% note info %}
    
    Если вы не можете управлять ролями, обратитесь к администратору вашего облака или организации.
    
    {% endnote %}

1. [Создайте бакет {{ objstorage-full-name }}](../storage/operations/buckets/create.md) для хранения [DAG-файлов](concepts/index.md#about-the-service) {{ maf-name }}.
1. [Создайте сервисный аккаунт](../iam/operations/sa/create.md).
1. [Назначьте сервисному аккаунту роль](../iam/operations/sa/assign-role-for-sa.md) `{{ roles.maf.integrationProvider }}` на каталог или бакет.
1. [Предоставьте разрешение](../storage/operations/buckets/edit-acl.md) `READ` сервисному аккаунту на бакет.

## Создайте кластер {#cluster-create}

1. В консоли управления выберите каталог, в котором нужно создать [кластер](../glossary/cluster.md) {{ maf-name }}.
1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-airflow }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.airflow.button_create-cluster }}**.
1. Задайте параметры кластера и нажмите кнопку **{{ ui-key.yacloud.common.create }}**. Процесс подробно рассмотрен в разделе [Создание кластера](operations/cluster-create.md).
1. Дождитесь, когда кластер будет готов к работе: его статус сменится на **Running**, а состояние — на **Alive**. Это может занять некоторое время. Чтобы проверить состояние, наведите курсор на статус кластера в столбце **{{ ui-key.yacloud.common.availability }}**.

## Откройте веб-интерфейс {{ AF }} {#web-gui}

Для управления {{ AF }} можно использовать веб-интерфейс. Работать с ним могут только пользователи с ролью не ниже [{{ roles.maf.user }}](security/index.md#managed-airflow-user). Чтобы начать работу в веб-интерфейсе {{ AF }}:

1. В [консоли управления]({{ link-console-main }}) откройте страницу кластера.
1. В поле **{{ ui-key.yacloud.airflow.cluster.overview.title_resource-webserver }}** нажмите **{{ ui-key.yacloud.mdb.cluster.overview.label_web-server-url }}** ![start](../_assets/console-icons/arrow-up-right-from-square.svg).
1. В открывшемся веб-интерфейсе [веб-сервера {{ maf-name }}](concepts/index.md#components) введите данные для аутентификации:

   * Логин — `admin`.
   * Пароль — пароль пользователя `admin`, который вы указали при создании кластера.

Подробнее о работе в веб-интерфейсе см. [документацию {{ AF }}](https://airflow.apache.org/docs/apache-airflow/stable/ui.html).

Помимо веб-интерфейса можно также использовать [API {{ AF }}](https://airflow.apache.org/docs/apache-airflow/stable/stable-rest-api-ref.html). Подробнее о нем читайте в разделе [{#T}](operations/af-interfaces.md).

## Что дальше {#whats-next}

* Изучите [концепции сервиса {{ maf-name }}](concepts/index.md).
* Узнайте подробнее о [создании кластера](operations/cluster-create.md) {{ maf-name }} и [работе с интерфейсами](operations/af-interfaces.md) {{ AF }}.
* Создайте DAG-файлы и [загрузите их](operations/upload-dags.md) в кластер {{ maf-name }}. Пример DAG-файла в [документации {{ AF }}](https://airflow.apache.org/docs/apache-airflow/stable/tutorial/fundamentals.html).