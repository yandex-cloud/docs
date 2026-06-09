# Системные требования к серверам на базе CPU

Для установки {{ sk-hybrid-name }} вам необходим сервер с ОС Linux, который поддерживает Docker Engine. Список поддерживаемых ОС см. в [официальной документации Docker](https://docs.docker.com/engine/install/#server).

{% note warning %}

Процессор должен поддерживать набор инструкций [AVX2](https://ru.wikipedia.org/wiki/AVX) (Advanced Vector Support).

{% endnote %}

В Linux вы можете проверить, поддерживает ли ваш хост AVX2, командой:

```bash
grep -q avx2 /proc/cpuinfo && echo AVX2 || echo No AVX2
```

## Аппаратные требования {#hardware}

Рекомендуемые аппаратные конфигурации для запуска контейнеров {{ sk-hybrid-name }}:

{% list tabs %}

- Контейнеры с CPU

   | Контейнер | CPU | RAM | HDD |
   |---|---|---|---|
   | Распознавание речи (40 каналов) | 2 процессора Intel® Xeon® Gold 6230R | 128 ГБ | 300 ГБ |
   | Синтез речи (10–16 SPS^1^) | 1 процессор Intel® Xeon® Gold 6230R | 64 ГБ | 300 ГБ |

   ^1^ Seconds per second (SPS) — количество секунд синтезированного текста, которое генерируется за секунду работы.

{% endlist %}

## Программные требования {#software}

Для установки и настройки сервисов {{ sk-hybrid-name }} понадобятся интерфейс командной строки {{ yandex-cloud }} и реестр в {{ container-registry-full-name }}.

1. Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../cli/quickstart.md#install).
1. [Создайте реестр]({{ link-docs }}/container-registry/operations/registry/registry-create) в {{ container-registry-full-name }}.

   По умолчанию используется каталог, указанный при [создании](../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

   ```bash
   yc container registry create --name speechkit-hybrid
   ```

   Результат:

   ```text
   id: <идентификатор_реестра>
   folder_id: <идентификатор_каталога>
   name: speechkit-hybrid
   status: ACTIVE
   created_at: "<дата_и_время_создания>"
   ```

1. [Создайте сервисный аккаунт]({{ link-docs }}/iam/operations/sa/create) с ролью `{{ roles-editor }}` на выбранный каталог.
1. [Создайте API-ключ]({{ link-docs }}/iam/operations/authentication/manage-api-keys#create-api-key) для сервисного аккаунта.
1. Сообщите идентификатор созданного реестра команде {{ speechkit-name }}. В вашем реестре появятся все необходимые контейнеры, и вам предоставят файл `docker-compose.yaml` с настройками развертывания.