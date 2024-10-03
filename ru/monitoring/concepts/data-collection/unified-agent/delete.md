---
title: "Как удалить {{ unified-agent-full-name }}"
description: "Из статьи вы узнаете, как удалить {{ unified-agent-full-name }}."
---

# Удаление {{ unified-agent-full-name }}

Способ удаления {{ unified-agent-short-name }} зависит от способа установки.

{% list tabs group=unified_agent %}

- Docker-образ {#docker}

  1. Посмотрите идентификатор контейнера {{ unified-agent-short-name }}:
   
      ```bash
      sudo docker ps
      ```

   1. Остановите контейнер:
   
      ```bash
      sudo docker stop <идентификатор_контейнера>
      ```

   1. Удалите контейнер:
   
      ```bash
      sudo docker rm <идентификатор_контейнера>
      ```
  
- deb-пакет {#deb}

  1. Остановите {{ unified-agent-short-name }}:
   
      ```bash
      sudo service unified-agent stop
      ```

  1. Посмотрите название deb-пакета:

      ```bash
      sudo dpkg -S /etc/yandex/unified_agent
      ```
  
  1. Удалите deb-пакет:

      ```bash
      sudo apt remove yandex-unified-agent
      ```

- Бинарный файл {#binary}

  1. Посмотрите номер процесса {{ unified-agent-short-name }} и расположение файла `unified_agent` и файла конфигурации `*.yml`:
   
      ```bash
      ps aux | grep unified_agent
      ```

      Результат:

      ```bash
      root 1068 0.0 2.1 2314804 43540 ? Ssl 08:33 0:03 /bin/unified_agent --config /etc/yc/unified_agent/config.yml
      yc-sa-a+ 4124 0.0 0.1 6612 2272 pts/2 S+ 12:34 0:00 grep --color=auto unified_agent
      ```
      В этом примере номер процесса — `1068`.

  1. Остановите процесс {{ unified-agent-short-name }}:

     ```bash
      sudo kill <номер_процесса>
      ```
   
  1. Удалите бинарный файл:
    
      ```bash
      sudo rm -f /usr/bin/unified_agent
      ```

  1. Удалите файл конфигурации:

      ```bash
      sudo rm -f /etc/yc/unified_agent/config.yml
      ```

- При создании ВМ {#vm}

  При этом способе установки на ВМ копируется бинарный файл `unified_agent` и файл конфигурации по умолчанию `config.yml`. Поэтому {{ unified-agent-short-name }} удаляется так же, как и бинарный файл. 
 
  Информация об установленном {{ unified-agent-short-name }} сохраняется в метаданных ВМ. При удалении {{ unified-agent-short-name }} метаданные не обновляются автоматически, но вы можете сделать это вручную.

  {% note info %}

  Информация в метаданных не влияет на работу {{ unified-agent-short-name }}, обновлять ее необязательно.

  {% endnote %}

  Чтобы удалить информацию о {{ unified-agent-short-name }} из метаданных:

  1. [Получите IAM-токен для сервисного аккаунта вашей ВМ](../../../../iam/operations/iam-token/create-for-sa.md#via-cli).
   
  1. Убедитесь, что у вас установлена утилита [cURL](https://curl.haxx.se).
   
  1. Отправьте запрос через API для обновления метаданных:

      ```bash
      curl \
        --request PATCH \
        --header "Authorization: Bearer <IAM-токен>" \
        --data '{"updateMask": "metadata", "metadata": {"install-unified-agent": "0" },}' \
        https://compute.api.cloud.yandex.net/compute/v1/instances/<идентификатор_ВМ>
      ```

  1. Посмотрите метаданные:
   
     1. В [консоли управления]({{ link-console-main }}) перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.

     1. На панели слева выберите ![image](../../../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
   
     1. Выберите ВМ и перейдите на вкладку **{{ ui-key.yacloud.common.overview }}**.
  
     1. Убедитесь, что в блоке **{{ ui-key.yacloud.compute.instance.overview.section_monitoring }}** напротив параметра **{{ ui-key.yacloud.compute.instance.overview.field_ua-enabled }}** теперь установлено `нет`.
   

{% endlist %}
