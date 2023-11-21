# Перенести виртуальную машину в другой каталог

При создании виртуальной машины она размещается в текущем каталоге.

В {{ yandex-cloud }} есть возможность переместить виртуальную машину в другой каталог внутри одного облака. Останавливать виртуальную машину при переносе не обязательно.

[Подробнее об иерархии ресурсов в {{ yandex-cloud }}](../../../resource-manager/concepts/resources-hierarchy.md).

## Ограничения {#limits}

Ограничения при переносе виртуальной машины:

* Метрики в [{{ monitoring-full-name }}](../../../monitoring/) не переносятся. То, что было в предыдущем каталоге, останется в нем, новые метрики будут создаваться уже в новом каталоге.
* Перенос возможен только внутри одного облака.

## Перенести виртуальную машину {#change-folder}

Чтобы изменить каталог виртуальной машины:

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Получите список всех виртуальных машин в каталоге по умолчанию:

      ```bash
      yc compute instance list
      ```

      Результат:

      ```bash
      +----------------------+-----------------+---------------+---------+----------------------+
      |          ID          |       NAME      |    ZONE ID    | STATUS  |     DESCRIPTION      |
      +----------------------+-----------------+---------------+---------+----------------------+
      | fhm0b28lgfp4tkoa3jl6 | first-instance  | {{ region-id }}-a | RUNNING | my first vm via CLI  |
      | fhm9gk85nj7gcoji2f8s | second-instance | {{ region-id }}-a | RUNNING | my second vm via CLI |
      +----------------------+-----------------+---------------+---------+----------------------+
      ```      

  1. Получите список всех каталогов в облаке по умолчанию:

      ```bash
      yc resource-manager folder list
      ```

      Результат:

      ```bash
      +----------------------+--------------------+------------------+--------+
      |          ID          |        NAME        |      LABELS      | STATUS |
      +----------------------+--------------------+------------------+--------+
      | b1gd129pp9ha0vnvf5g7 | my-folder          |                  | ACTIVE |
      | b1g66mft1vopnevbn57j | default            |                  | ACTIVE |
      +----------------------+--------------------+------------------+--------+
      ```

  1. Посмотрите описание команды CLI для переноса виртуальной машины:

      ```bash
      yc compute instance move --help
      ```

  1. Перенесите виртуальную машину в другой каталог со следующими параметрами: 
      
      * в параметре `id` укажите идентификатор виртуальной машины, например `fhm0b28lgfp4tkoa3jl6`;
      * в параметре `destination-folder-id` укажите идентификатор целевого каталога, например `b1gd129pp9ha0vnvf5g7`.

      ```bash
      yc compute instance move \
        --id fhm0b28lgfp4tkoa3jl6 \
        --destination-folder-id b1gd129pp9ha0vnvf5g7
      ```

      Подробнее о команде `yc compute instance move` см. в [справочнике CLI](../../../cli/cli-ref/managed-services/compute/instance/move.md).

- API

  Воспользуйтесь методом REST API [move](../../api-ref/Instance/move.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Move](../../api-ref/grpc/instance_service.md#Move).

  Ниже описан пример Bash-скрипта для REST API, который можно исполнить из Linux-сред. В нём также используется метод [move](../../api-ref/Disk/move.md) для ресурса [Disk](../../api-ref/Disk/index.md) (если не перенести загрузочный диск, он останется в исходном каталоге).
  
  [Аутентификация в API Compute Cloud](../../api-ref/authentication.md) осуществляется посредством [IAM-токена](../../../iam/operations/iam-token/create.md). Его получение - посредством [OAuth-токена](https://yandex.ru/dev/id/doc/ru/access) для аккаунта в Яндекс ID.
  
  В Linux-среде должны быть установлены:
  * curl - для получения OAuth-токена и выполнения HTTP-запросов типа POST.
  * jq - для извлечения OAuth-токена из JSON-вывода первой команды скрипта.
 
  
  Переносить ВМ можно без её остановки.
  
  > [!NOTE]
  > ВМ после переноса остаётся подключена к подсети Virtual Private Cloud исходного каталога. Отключить от неё машину можно в настройках сетевого интерфейса на странице ВМ.
  
  ```#!/bin/bash
  
  # Задаётся переменная IAM_TOKEN. В переменной (скобках) - команда, получающая IAM-токен и извлекающая его из JSON-вывода (jq). Вместо "Oauth_Token" подставить OAuth-токен аккаунта в Яндекс ID.
  IAM_TOKEN=$(curl -d "{\"yandexPassportOauthToken\":\"OAuth_Token\"}" "https://iam.api.cloud.yandex.net/iam/v1/tokens" | jq -r '.iamToken')
  
  instanceId='ID_переносимой_ВМ'
  bootDiskId='ID_загрузочного_диска_этой_ВМ'
  destinationFolderId='ID_каталога_в_который_переносится_ВМ'
  
  # Команда перемещения ВМ:
  curl -X POST "https://compute.api.cloud.yandex.net/compute/v1/instances/{${instanceId}}:move" \
  -H "Authorization: Bearer ${IAM_TOKEN}" \
  -d '{ "destinationFolderId": "'"${destinationFolderId}"'" }'
  
  # Команда перемещения загрузочного диска:
  curl -X POST "https://compute.api.cloud.yandex.net/compute/v1/disks/{${bootDiskId}}:move" \
  -H "Authorization: Bearer ${IAM_TOKEN}" \
  -d '{ "destinationFolderId": "'"${destinationFolderId}"'" }'```

{% endlist %}
