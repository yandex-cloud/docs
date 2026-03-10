# Настройка прав доступа к секрету, созданному {{ connection-manager-full-name }}, для пользователя {{ mpg-full-name }}

Вы можете получить пароль пользователя [{{ mpg-name }}](../../managed-postgresql/index.yaml) из [секрета {{ lockbox-name }}](../../lockbox/concepts/secret.md). Это можно сделать через [{{ yandex-cloud }} CLI](../../cli/index.yaml). Для этого [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), под которым вы авторизованы в {{ yandex-cloud }} CLI, нужно настроить права доступа к секрету пользователя. Информацию о секрете, необходимую для настройки прав, можно получить из подключения [{{ connection-manager-name }}](../../metadata-hub/concepts/connection-manager.md).

Чтобы настроить права доступа к секрету пользователя:

1. [Создайте необходимую инфраструктуру и настройте права доступа к секрету пользователя](#set-up-roles).
1. [Получите пароль пользователя из секрета](#get-password).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

* Кластер {{ mpg-name }}: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий (см. [тарифы {{ mpg-name }}](../../managed-postgresql/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md)).

Использование {{ connection-manager-name }}, а также секретов {{ lockbox-name }}, созданных с его помощью, не тарифицируется.

## Настройте права доступа к секрету пользователя {{ mpg-name }} {#set-up-roles}

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}

        {% note warning %}
        
        Требуется провайдер Yandex версии не ниже `0.160.0`. Если в конфигурации версия провайдера не указана явно, {{ TF }} автоматически загрузит последнюю совместимую версию.

        {% endnote %}

    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации [conn-man-secret-access.tf](https://github.com/yandex-cloud-examples/yc-connection-manager-secret-access/blob/main/conn-man-secret-access.tf).

        В этом файле описаны:

        * кластер {{ mpg-name }};
        * настройка прав сервисного аккаунта для доступа к секрету пользователя {{ mpg-name }};
        * получение идентификатора подключения и идентификатора секрета.     

    1. Укажите в конфигурационном файле следующие параметры:
        
        * `network_id` — идентификатор [сети](../../vpc/concepts/network.md#network) для кластера;
        * `subnet_id` — идентификатор [подсети](../../vpc/concepts/network.md#subnet) в [зоне доступности](../../overview/concepts/geo-scope.md) `ru-central1-a` для кластера;
        * `pg_cluster_version` — версия {{ PG }};
        * `pg_cluster_name` — имя кластера;
        * `pg_cluster_db` — имя базы данных в кластере;
        * `pg_cluster_username` — имя пользователя в кластере;
        * `pg_cluster_password` — пароль пользователя;
        * `lockbox_sa_id` — идентификатор сервисного аккаунта, для которого будет настроен доступ к секрету.

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}
    
    1. После применения конфигурации {{ TF }} выведет идентификаторы подключения и секрета.

        Пример вывода:
        
        > ```bash
        > Outputs:
        >
        > connection_id = "a59v09bb8907********"
        > connection_info = "e6q2rjghh9bc********"
        > ```

        Сохраните идентификатор секрета `connection_info`, он понадобится для [получения пароля пользователя](#get-password).

{% endlist %}

## Получите пароль пользователя из секрета {{ lockbox-name }} {#get-password}

1. [Аутентифицируйтесь в {{ yandex-cloud }} CLI от имени сервисного аккаунта с помощью авторизованного ключа](../../cli/operations/authentication/service-account.md#auth-as-sa).

1. Получите пароль пользователя из секрета и сохраните его в переменную `PASSWORD`: 

    {% list tabs group=instructions %}

    - CLI {#cli}

      ```bash
      PASSWORD=$(yc lockbox payload get <идентификатор_секрета> \
        --format json \
        | jq -r '.entries[] | select(.key=="postgresql_password") | .text_value')
      ```

    {% endlist %}

1. Чтобы посмотреть сохраненный пароль, выполните команду:

    ```bash
    echo "$PASSWORD"
    ```

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}