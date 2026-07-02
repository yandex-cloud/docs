[Документация Yandex Cloud](../../../index.md) > [Yandex Object Storage](../../index.md) > [Пошаговые инструкции](../index.md) > Бакеты > Получение информации и статистики о бакете

# Получение информации о бакете и статистики бакета

## Получить информацию о бакете {#get-information}

Для просмотра полной информации о [бакете](../../concepts/bucket.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. Перейдите в сервис **Object Storage**.
  1. Выберите нужный бакет из списка.
  1. На панели слева выберите нужный раздел с информацией о бакете:
     * ![image](../../../_assets/console-icons/folder-tree.svg) **Объекты** — список объектов, хранящихся в бакете.
     * ![image](../../../_assets/console-icons/wrench.svg) **Настройки** — основные параметры бакета, информация о хостинге сайта в бакете, версионировании, логировании, жизненном цикле объектов в бакете.
     * ![image](../../../_assets/console-icons/persons-lock.svg) **Безопасность** — описание прав и политики доступа в бакете, сведения о конфигурации HTTPS и CORS, блокировке и шифровании объектов в бакете.

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения информации о бакете:

     ```bash
     yc storage bucket get --help
     ```

  1. Получите список бакетов в каталоге по умолчанию:
     
     ```bash
     yc storage bucket list
     ```
     
     Результат:
     
     ```text
     +------------------+----------------------+-------------+-----------------------+---------------------+
     |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
     +------------------+----------------------+-------------+-----------------------+---------------------+
     | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
     +------------------+----------------------+-------------+-----------------------+---------------------+
     ```
  1. Сохраните имя бакета (столбец `NAME`), информацию о котором вы хотите получить.

  1. Получите информацию о бакете:

     ```bash
     yc storage bucket get <имя_бакета> --full
     ```

     Результат:

     ```text
     name: first-bucket
     folder_id: b1gmit33ngp6********
     anonymous_access_flags:
       read: false
       list: false
       config_read: false
     default_storage_class: ICE
     versioning: VERSIONING_ENABLED
     max_size: "5368709120"
     acl:
       grants:
         - permission: PERMISSION_READ
           grant_type: GRANT_TYPE_ACCOUNT
           grantee_id: ajep03tkmqqr********
     created_at: "2023-04-10T19:41:30.266075Z"
     website_settings:
       index: index.html
       error: 404.html
       redirect_all_requests: {}
     ```

{% endlist %}

## Получить статистику бакета {#get-statistics}

Для просмотра статистики по бакету:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. Перейдите в сервис **Object Storage**. 
  1. Выберите нужный бакет из списка.
  1. На панели слева выберите ![image](../../../_assets/console-icons/display-pulse.svg) **Мониторинг**.
  1. На открывшейся странице вы можете посмотреть статистику бакета за определенный период времени:
     
     На странице отображаются дашборды:
     
     * ![image](../../../_assets/console-icons/chart-column.svg) **Read Requests** — количество запросов GET, HEAD, LIST и OPTIONS.
     * ![image](../../../_assets/console-icons/chart-column.svg) **Modify Requests** — количество запросов PUT, POST и DELETE.
     * ![image](../../../_assets/console-icons/chart-column.svg) **Traffic** — объем переданного трафика.
     * ![image](../../../_assets/console-icons/chart-column.svg) **Objects counts** — количество объектов в бакете.
     * ![image](../../../_assets/console-icons/chart-column.svg) **Space by object type** — использованный объем хранилища по типу объекта: без разбиения на части, загруженные по частям (multipart) и части объектов.
     * ![image](../../../_assets/console-icons/chart-column.svg) **Space by storage type** — использованный объем хранилища по классу хранилища.


- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения статистики бакета:

     ```bash
     yc storage bucket stats --help
     ```

  1. Получите список бакетов в каталоге по умолчанию:
     
     ```bash
     yc storage bucket list
     ```
     
     Результат:
     
     ```text
     +------------------+----------------------+-------------+-----------------------+---------------------+
     |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
     +------------------+----------------------+-------------+-----------------------+---------------------+
     | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
     +------------------+----------------------+-------------+-----------------------+---------------------+
     ```
  1. Сохраните имя бакета (столбец `NAME`), статистику которого вы хотите получить.

  1. Получите статистику бакета:

     ```bash
     yc storage bucket stats <имя_бакета>
     ```

     Результат:

     ```text
     name: first-bucket
     max_size: "5368709120"
     used_size: "621552"
     storage_class_used_sizes:
       - storage_class: STANDARD
         class_size: "607467"
       - storage_class: COLD
         class_size: "14085"
     storage_class_counters:
       - storage_class: STANDARD
         counters:
           simple_object_size: "607467"
           simple_object_count: "41"
       - storage_class: COLD
         counters:
           simple_object_size: "14085"
           simple_object_count: "16"
     default_storage_class: ICE
     anonymous_access_flags:
       read: false
       list: false
       config_read: false
     created_at: "2023-04-10T19:41:30.266075Z"
     updated_at: "2023-08-02T04:05:44.564924Z"
     ```

{% endlist %}