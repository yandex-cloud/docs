# Как начать работать с Yandex Managed Service for Apache Spark™

Чтобы начать работу с сервисом:

* [Подготовьте облако к работе](#prepare-cloud).
* [Подготовьте инфраструктуру](#prepare-infrastructure).
* [Создайте кластер](#cluster-create).
* [Подготовьте задание PySpark](#prepare-task).
* [Запустите задание в кластере](#run-task).
* [Проверьте выполнение задания](#check-task).

## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит плата за использование бакета Yandex Object Storage (см. [тарифы Object Storage](../storage/pricing.md)).

## Подготовьте облако к работе {#prepare-cloud}

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

1. [Назначьте](../iam/operations/roles/grant.md) вашему аккаунту в Yandex Cloud роли:

    * [managed-spark.admin](security.md#managed-spark-admin) — чтобы создать кластер;
    * [vpc.user](../vpc/security/index.md#vpc-user) — чтобы работать с [сетью](../vpc/concepts/network.md#network) кластера;
    * [iam.serviceAccounts.user](../iam/security/index.md#iam-serviceAccounts-user) — чтобы привязать сервисный аккаунт к кластеру.

    {% note info %}
    
    Если вы не можете управлять ролями, обратитесь к администратору вашего облака или организации.
    
    {% endnote %}

## Подготовьте инфраструктуру {#prepare-infrastructure}

1. [Создайте сервисный аккаунт](../iam/operations/sa/create.md#create-sa) и назначьте ему роли:

   * `managed-spark.integrationProvider` — для взаимодействия Yandex Managed Service for Apache Spark™ с другими сервисами (например для отправки логов и метрик).
   * [storage.editor](../storage/security/index.md#storage-editor) — для доступа к файлам с PySpark-заданиями в бакете Object Storage.

1. [Создайте бакет Object Storage](../storage/operations/buckets/create.md).

1. Предоставьте сервисному аккаунту доступ к бакету Object Storage, в котором будут храниться код и данные для заданий на кластере:

   1. В [консоли управления](https://console.yandex.cloud) выберите нужный каталог.
   1. [Перейдите](../console/operations/select-service.md#select-service) в сервис **Object Storage**.
      1. Откройте [созданный ранее](#create-s3-bucket) бакет.
      1. Перейдите в раздел **Объекты**.
      1. Нажмите на кнопку ![image](../_assets/console-icons/ellipsis.svg) и выберите **Настроить ACL**.
      1. В открывшемся окне **Редактирование ACL**:

         1. Начните вводить имя [созданного ранее](#before-you-begin) сервисного аккаунта и выберите его из выпадающего списка.
         1. Выберите права доступа READ и WRITE .
         1. Нажмите кнопку **Добавить**.
         1. Нажмите кнопку **Сохранить**.

## Создайте кластер {#cluster-create}

{% list tabs group=instructions %}

- Консоль управления

  1. В консоли управления выберите каталог, в котором нужно создать кластер.
  1. [Перейдите](../console/operations/select-service.md#select-service) в сервис **Managed Service for Apache Spark**.
  1. Нажмите кнопку **Создать кластер**.
  1. Задайте имя кластера.
  1. В поле **Сервисный аккаунт** выберите [созданный ранее](#before-you-begin) сервисный аккаунт.
  1. В блоке **Сетевые настройки** выберите сеть, подсеть и группу безопасности для кластера.
  1. Задайте вычислительные ресурсы для хостов, на которых будут запускаться драйверы и исполнители.
  1. В блоке **Дополнительные настройки** настройте логирование:

     1. Включите настройку **Запись логов**.
     1. В поле **Назначение** выберите место записи логов — **Каталог**.
     1. В поле **Каталог** выберите ваш каталог из списка.
     1. Выберите **Минимальный уровень логирования** — **INFO**.

  1. Нажмите кнопку **Создать**.
  1. Дождитесь, когда кластер будет готов к работе: его статус на панели Yandex Managed Service for Apache Spark™ сменится на **Running**, а состояние — на **Alive**. Это может занять некоторое время.

{% endlist %}

## Подготовьте задание PySpark {#prepare-task}

1. Сохраните на локальный компьютер файл с кодом задания [pi.py](https://github.com/apache/spark/blob/master/examples/src/main/python/pi.py) из репозитория Apache Spark™. Этот код вычисляет приблизительное значение числа Пи методом Монте-Карло.

1. Загрузите файл в [созданный ранее](#before-you-begin) бакет Object Storage.

## Запустите задание PySpark {#run-task}

1. В [консоли управления](https://console.yandex.cloud) откройте созданный ранее кластер.
1. Перейдите в раздел **Задания**.
1. Нажмите кнопку **Создать задание**.
1. Выберите **Тип задания** — **PySpark**.
1. В поле **Main python файл** введите путь к файлу `pi.py` в формате `s3a://<имя_бакета_Object_Storage>/<имя_файла>`.
1. Нажмите кнопку **Создать задание**.

## Проверьте выполнение задания {#check_task}

1. Дождитесь, пока запущенное задание перейдет в статус **Running**.
1. Перейдите на вкладку **Логи**.
1. В логах найдите строку с результатом выполнения задания, например:

   ```
   Pi is roughly 3.144720
   ```