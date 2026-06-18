# Настроить парольную политику


Чтобы настроить [парольную политику](../../concepts/password-policy.md):

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../../_assets/organization/userpool.svg) **Пулы пользователей** и выберите нужный пул пользователей.
  1. На вкладке **Обзор** нажмите **Парольная политика** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и выберите ![gear](../../../_assets/console-icons/gear.svg) **Настроить политику**.
  1. В блоке **Сложность пароля** укажите настройки классов символов в пароле:

     * **Произвольные** — настройте минимальную длину в зависимости от количества классов символов, которые используются в пароле:
 
       * 1 класс (`abc`);
       * 2 класса (`aBc`);
       * 3 класса (`aBc1`);
       * 4 класса (`aB#c1`).
       
       Это предпочтительный вариант, поскольку он не требует наличия определенных символов и позволяет пользователям делать более простые для запоминания, но надежные пароли.
 
     * **Обязательные** — выберите типы символов, которые должны использоваться в пароле, активируя следующие опции:

       * **Строчные буквы латинского алфавита**;
       * **Заглавные буквы латинского алфавита**;
       * **Цифры**;
       * **Специальные символы, например `!@#$%^&*`**.

       В поле **Минимальная длина** задайте минимальное число символов в пароле, но не менее 7.
       
  1. В блоке **Уникальность пароля** в поле **Проверка пароля** при необходимости включите опцию **Нельзя использовать пароль из базы распространенных паролей**. Это защитит пользователей от установки паролей, которые легко подбираются по словарю.
  1. В блоке **Срок жизни пароля** задайте минимальный и максимальный срок жизни пароля (до 730 дней) или выберите **Без ограничений**.
  1. В блоке **Защита пароля от подбора** задайте:
     * **Количество неудачных попыток ввода пароля до блокировки** — от 1 до 100.
     * **Интервал для подсчёта неудачных попыток** в минутах или секундах.
     * **Продолжительность блокировки** в минутах или секундах.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../../../cli/index.md) для обновления пула пользователей:

     ```bash
     yc organization-manager idp userpool update --help
     ```

  1. Получите список пулов пользователей в организации:

     ```bash
     yc organization-manager idp userpool list \
       --organization-id <идентификатор_организации>
     ```

  1. Настройте парольную политику для пула пользователей:

     ```bash
     yc organization-manager idp userpool update <идентификатор_пула> \
       --password-smart-one-class <минимальная_длина_для_1_класса> \
       --password-smart-two-classes <минимальная_длина_для_2_классов> \
       --password-smart-three-classes <минимальная_длина_для_3_классов> \
       --password-smart-four-classes <минимальная_длина_для_4_классов> \
       --password-allow-similar \
       --password-match-length <длина_подстроки_для_проверки> \
       --password-max-length <максимальная_длина_пароля> \
       --password-blacklist-check-common \
       --password-min-days <минимальный_срок_жизни_в_днях> \
       --password-max-days <максимальный_срок_жизни_в_днях> \
       --bruteforce-attempts <количество_попыток> \
       --bruteforce-window <интервал_подсчета> \
       --bruteforce-block <продолжительность_блокировки>
     ```

     Где:

     * Для настройки произвольных типов символов (smart policy):
       * `--password-smart-one-class` — минимальная длина пароля с одним классом символов (например, только строчные буквы).
       * `--password-smart-two-classes` — минимальная длина пароля с двумя классами символов (например, строчные и заглавные буквы).
       * `--password-smart-three-classes` — минимальная длина пароля с тремя классами символов (например, буквы и цифры).
       * `--password-smart-four-classes` — минимальная длина пароля с четырьмя классами символов (буквы, цифры и специальные символы).

     * Для настройки обязательных типов символов (fixed policy):
       * `--password-fixed-min-length` — минимальная длина пароля (не менее 7 символов).
       * `--password-fixed-lowers-required` — требовать строчные буквы.
       * `--password-fixed-uppers-required` — требовать заглавные буквы.
       * `--password-fixed-digits-required` — требовать цифры.
       * `--password-fixed-specials-required` — требовать специальные символы.

     * `--password-allow-similar` — разрешить использование паролей, похожих на предыдущие. Если флаг не указан, похожие пароли запрещены.
     * `--password-match-length` — минимальная длина подстроки для проверки на сходство с уязвимыми последовательностями.
     * `--password-max-length` — максимальная длина пароля. Значение `0` означает отсутствие ограничения.
     * `--password-blacklist-check-common` — проверка пароля по базе распространенных паролей. Если флаг не указан, проверка отключена.
     * `--password-min-days` — минимальное количество дней до смены пароля.
     * `--password-max-days` — максимальное количество дней, в течение которых пароль остается действительным (до 730 дней). Значение `0` означает, что пароли не истекают.
     * `--bruteforce-attempts` — количество неудачных попыток ввода пароля до блокировки (от 1 до 100).
     * `--bruteforce-window` — интервал для подсчета неудачных попыток (например, `10m` для 10 минут или `600s` для 600 секунд).
     * `--bruteforce-block` — продолжительность блокировки после превышения лимита попыток (например, `10m` или `600s`).

     Пример команды для настройки парольной политики:

     {% list tabs group=examples %}

     - С произвольным типом символов {#smart}

       ```bash
       yc organization-manager idp userpool update fpd9mu9gqq12******** \
         --password-smart-one-class 24 \
         --password-smart-two-classes 14 \
         --password-smart-three-classes 11 \
         --password-smart-four-classes 10 \
         --password-max-length 128 \
         --password-max-days 365 \
         --bruteforce-attempts 15 \
         --bruteforce-window 10m \
         --bruteforce-block 10m \
         --password-blacklist-check-common true
       ```

     - С обязательными типами символов {#fixed}

       ```bash
       yc organization-manager idp userpool update fpd9mu9gqq12******** \
         --password-fixed-min-length 8 \
         --password-fixed-lowers-required \
         --password-fixed-uppers-required \
         --password-fixed-digits-required \
         --password-max-length 128 \
         --password-max-days 365 \
         --bruteforce-attempts 15 \
         --bruteforce-window 10m \
         --bruteforce-block 10m \
         --password-blacklist-check-common true
       ```
     {% endlist %}

  Подробнее о команде `yc organization-manager idp userpool update` см. в [справочнике CLI](../../cli-ref/idp/userpool/update.md).

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Подробнее о Terraform см. в [документации](../../../tutorials/infrastructure-management/terraform-quickstart.md).

  1. Создайте конфигурационный файл с параметрами пула пользователей и парольной политикой:

     ```hcl
     resource "yandex_organizationmanager_idp_userpool" "my_userpool" {
       name              = "<имя_пула>"
       organization_id   = "<идентификатор_организации>"
       default_subdomain = "<поддомен>"
       description       = "<описание_пула>"

       password_quality_policy = {
         allow_similar   = true
         max_length      = 128
         match_length    = 4

         # Используйте либо `smart`, либо `fixed`
         # Настройка произвольных типов символов
         smart = {
           one_class     = 24
           two_classes   = 14
           three_classes = 11
           four_classes  = 10
         }

         # Настройка обязательных типов символов
         fixed = {
           min_length        = 8
           lowers_required   = true
           uppers_required   = true
           digits_required   = true
           specials_required = false
         }
       }

       password_blacklist_policy = {
         check_common = true
       }

       password_lifetime_policy = {
         min_days_count = 0
         max_days_count = 365
       }

       bruteforce_protection_policy = {
         attempts = 15
         window   = "10m"
         block    = "10m"
       }
     }
     ```

     Где:

     * `name` — имя пула пользователей.
     * `organization_id` — идентификатор организации.
     * `default_subdomain` — поддомен по умолчанию для пула.
     * `description` — описание пула пользователей.
     * `password_quality_policy` — настройки сложности пароля:

       * `allow_similar` — разрешить использование паролей, похожих на предыдущие.
       * `max_length` — максимальная длина пароля. Значение `0` означает отсутствие ограничения.
       * `match_length` — минимальная длина подстроки для проверки на сходство с уязвимыми последовательностями.

       Используйте либо `smart`, либо `fixed`.
       * `smart` — настройка произвольных типов символов (минимальная длина в зависимости от количества классов).
         * `one_class` — минимальная длина пароля с одним классом символов (например, только строчные буквы).
         * `two_classes` — минимальная длина пароля с двумя классами символов (например, строчные и заглавные буквы).
         * `three_classes` — минимальная длина пароля с тремя классами символов (например, буквы и цифры).
         * `four_classes` — минимальная длина пароля с четырьмя классами символов (буквы, цифры и специальные символы).

       * `fixed` — настройка обязательных типов символов (используйте вместо `smart`).
         * `min_length` — минимальная длина пароля (не менее 7 символов).
         * `lowers_required` — требовать строчные буквы.
         * `uppers_required` — требовать заглавные буквы.
         * `digits_required` — требовать цифры.
         * `specials_required` — требовать специальные символы.

     * `password_blacklist_policy` — настройка уникальности пароля.
       * `check_common` — запретить использование паролей из базы распространенных паролей. Значение по умолчанию: `false`.

     * `password_lifetime_policy` — настройки срока жизни пароля.
       * `min_days_count` — минимальное количество дней до смены пароля.
       * `max_days_count` — максимальное количество дней, в течение которых пароль остается действительным (до 730 дней). Значение `0` означает, что пароли не истекают.

     * `bruteforce_protection_policy` — настройки защиты от подбора пароля.
       * `attempts` — количество неудачных попыток ввода пароля до блокировки (от 1 до 100).
       * `window` — интервал для подсчета неудачных попыток (например, `10m` для 10 минут или `600s` для 600 секунд).
       * `block` — продолжительность блокировки после превышения лимита попыток (например, `10m` или `600s`).

     Более подробную информацию о параметрах ресурса `yandex_organizationmanager_idp_userpool` см. в [документации провайдера](../../../terraform/resources/organizationmanager_idp_userpool.md).

  1. Создайте ресурсы:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

  После этого в указанной организации будет создан пул пользователей с заданной парольной политикой. Проверить появление пула и его настройки можно в [интерфейсе Cloud Center](https://center.yandex.cloud/organization) или с помощью команды CLI:

  ```bash
  yc organization-manager idp userpool get <идентификатор_пула>
  ```

- API {#api}

  Воспользуйтесь методом REST API [update](../../idp/api-ref/Userpool/update.md) для ресурса [Userpool](../../idp/api-ref/Userpool/index.md) или вызовом gRPC API [UserpoolService/Update](../../idp/api-ref/grpc/Userpool/update.md).

{% endlist %}

{% note info %}

Парольная политика применяется только к тем паролям, которые задают пользователи. На автоматически сгенерированные пароли парольная политика не распространяется.

{% endnote %}