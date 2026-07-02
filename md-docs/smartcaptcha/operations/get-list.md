[Документация Yandex Cloud](../../index.md) > [Yandex SmartCaptcha](../index.md) > [Пошаговые инструкции](index.md) > Получение информации о капче > Получить список капч

# Получить список капч

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите посмотреть список [капч](../concepts/validation.md).
  1. Перейдите в сервис **Yandex SmartCaptcha**.
  1. На странице **Список капч** отобразится список доступных капч.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../../cli/index.md) для просмотра списка [капч](../concepts/validation.md):

      ```bash
      yc smartcaptcha captcha list --help
      ```

  1. Получите список капч:
     
     ```bash
     yc smartcaptcha captcha list
     ```
     
     Результат:
     
     ```text
     +----------------------+---------+---------------------+------------+----------------+----------------+-------------+
     |          ID          |  NAME   |       CREATED       | COMPLEXITY | PRE-CHECK TYPE | CHALLENGE TYPE | RULES COUNT |
     +----------------------+---------+---------------------+------------+----------------+----------------+-------------+
     | bpne29ifsca8******** | test    | 2025-02-24 17:16:13 | MEDIUM     | CHECKBOX       | IMAGE_TEXT     |           0 |
     | bpnm7lhokq2t******** | prod    | 2025-02-26 09:12:02 | MEDIUM     | CHECKBOX       | IMAGE_TEXT     |           0 |
     | bpn43btuo4g9******** | website | 2025-02-26 09:12:42 | MEDIUM     | CHECKBOX       | IMAGE_TEXT     |           0 |
     +----------------------+---------+---------------------+------------+----------------+----------------+-------------+
     ```

- API {#api}

  Чтобы посмотреть список [капч](../concepts/validation.md), воспользуйтесь методом REST API [list](../api-ref/Captcha/list.md) для ресурса [Captcha](../api-ref/Captcha/index.md) или вызовом gRPC API [CaptchaService/List](../api-ref/grpc/Captcha/list.md).

{% endlist %}