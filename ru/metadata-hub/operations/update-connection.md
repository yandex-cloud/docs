---
title: Как изменить подключение {{ metadata-hub-name }}. Пошаговые инструкции
description: Пошаговые инструкции по работе с {{ connection-manager-name }} в {{ yandex-cloud }}. Из статьи вы узнаете, как изменять подключения.
---

# Изменение подключения


Для изменения настроек подключения:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Выберите сервис **{{ metadata-hub-full-name }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
  1. В списке подключений нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) справа в строке подключения, которое вы хотите изменить.
  1. Выберите пункт **{{ ui-key.yacloud.common.edit }}**.
  1. Измените требуемые параметры подключения, такие как описание, метки, настройки сервера базы данных или данные аутентификации пользователя.
  1. Нажмите **{{ ui-key.yacloud.common.apply }}** для сохранения изменений.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Вы можете изменить настройки подключения к кластеру с управляемой базой данных и к пользовательской инсталляции базы данных.

  1. Чтобы изменить настройки подключения к кластеру с управляемой базой данных:

      1. Посмотрите описание команды CLI для изменения подключения:

          ```bash
          yc metadata-hub connection-manager connection update <тип_базы_данных> --help
          ```

          Возможные типы баз данных: `postgresql`, `mysql`, `clickhouse`, `mongodb`, `opensearch`, `valkey`, `greenplum`, `kafka`.

      1. Измените подключение, выполнив команду:
      
          ```bash
          yc metadata-hub connection-manager connection update <тип_базы_данных> <идентификатор_подключения> \
            --name <имя_подключения> \
            --user <имя_пользователя> \
            --password <пароль> \
            --managed-cluster-id <идентификатор_кластера>
          ```

          Где:

          * `--name` — имя подключения.

          * `--user` — имя пользователя для подключения к кластеру.

          * `--password` — пароль пользователя.
      
          * `--managed-cluster-id` — идентификатор кластера. Идентификатор кластера можно получить со списком кластеров в каталоге.

          Идентификатор подключения можно получить со [списком подключений](view-connection.md#connection-list) в каталоге.

      1. Вы можете изменить список баз данных для всех подключений, кроме подключений к {{ mos-name }} и {{ mkf-name }}, выполнив команду:

          ```bash
          yc metadata-hub connection-manager connection update <тип_базы_данных> <идентификатор_подключения> \
            --databases <список_БД>
          ```

          Где `--databases` — список баз данных, разделенный запятыми.
          
          Убедитесь, что у пользователя есть необходимые права на доступ к ним.
  
  1. Чтобы изменить настройки подключения к пользовательской инсталляции базы данных:
      
      1. Посмотрите описание команды CLI для изменения подключения:

          ```bash
          yc metadata-hub connection-manager connection update <тип_базы_данных> --help
          ```

          Возможные типы баз данных: `postgresql`, `mysql`, `clickhouse`, `mongodb`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`, `kafka`.

      1. Измените подключение, выполнив команду:
      
          ```bash
          yc metadata-hub connection-manager connection update <тип_базы_данных> <идентификатор_подключения> \
            --name <имя_подключения> \
            --user <имя_пользователя> \
            --password <пароль> \
            --ca-certificate <путь_к_сертификату>
          ```

          Где:

          * `--name` — имя подключения.
          
          * `--description` — описание подключения.
          
          * `--labels` — список меток в формате `"<ключ>":"<значение>"`, через запятую.
          
          * `--user` — имя пользователя для подключения к кластеру.
          
          * `--password` — пароль пользователя.
          
          * `--ca-certificate` — путь к файлу CA-сертификата для TLS.
          
            По умолчанию [TLS](../../glossary/tls.md) включен. Чтобы отключить его, используйте флаг `--tls-disabled`.

      1. Дополнительно вы можете изменить:

          * Список хостов для всех подключений, кроме подключения к {{ TR }}, выполнив команду:

            ```bash
            yc metadata-hub connection-manager connection update <тип_базы_данных> <идентификатор_подключения> \
              --hosts <список_хостов>
            ```

            Где `--hosts` — список хостов, разделенных запятой.

            {% note warning %}

            Формат записи хостов зависит от типа базы данных. Подробнее см. в [справочнике CLI](../../cli/cli-ref/metadata-hub/cli-ref/connection-manager/connection/update/index.md).

            {% endnote %}

          * Параметры координатора для подключения к {{ TR }}, выполнив команду:

            ```bash
            yc metadata-hub connection-manager connection update trino <идентификатор_подключения> \
              --coordinator <параметры_координатора>
            ```

            Где `--coordinator` — параметры координатора в формате `<хост>:<порт>`.

          * Список баз данных для всех подключений, кроме подключений к {{ TR }}, {{ OS }} и {{ KF }}, выполнив команду:

            ```bash
            yc metadata-hub connection-manager connection update <тип_базы_данных> <идентификатор_подключения> \
              --databases <список_БД>
            ```

            Где `--databases` — список баз данных, разделенный запятыми.
          
            Убедитесь, что у пользователя есть необходимые права на доступ к ним.


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}
  
  {% include [terraform-install](../../_includes/terraform-install.md) %}

  {% note alert %}

  Не изменяйте имя подключения с помощью {{ TF }}. Это приведет к удалению существующего подключения и созданию нового.

  {% endnote %}

  Вы можете изменить настройки подключения к кластеру с управляемой базой данных и к пользовательской инсталляции базы данных.

  1. Чтобы изменить настройки подключения к кластеру с управляемой базой данных:

     1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      1. Чтобы изменить описание подключения и набор меток, измените значения соответствующих полей в описании ресурса:

          ```hcl
          resource "yandex_connectionmanager_connection" "<локальное_имя_подключения>" {
            ...
            description = "<описание_подключения>"
        
            labels = {
              "<ключ_1>" = "<значение_1>"
              "<ключ_2>" = "<значение_2>"
              ...
              "<ключ_N>" = "<значение_N>"
            }
            ...
          }
          ```

          Где:

          * `description` — описание подключения.

          * `labels` — набор меток в формате `"<ключ>" = "<значение>"`.

      1. Чтобы изменить идентификатор кластера, измените значение поля `managed_cluster_id` в блоке `params.<тип_базы_данных>`:

          ```hcl
          resource "yandex_connectionmanager_connection" "<локальное_имя_подключения>" {
            ...
            params = {
              <тип_базы_данных> = {
                managed_cluster_id = "<идентификатор_кластера>"
                ...
              }
            }
          }
          ```

      1. Чтобы изменить список баз данных для всех подключений, кроме подключений к {{ mos-name }} и {{ mkf-name }}, измените значение поля `databases` в блоке `params.<тип_базы_данных>`:
     
          ```hcl
          resource "yandex_connectionmanager_connection" "<локальное_имя_подключения>" {
            ...
            params = {
              <тип_базы_данных> = {
                ...
                databases = [
                  "<база_данных_1>",
                  "<база_данных_2>",
                  ...
                  "<база_данных_N>"
                ]
                ...
              }
            }
          }
          ```

          Где `databases` — список баз данных. Убедитесь, что у пользователя есть необходимые права на доступ к ним.

      1. Чтобы изменить параметры аутентификации для всех подключений, кроме подключений к {{ mkf-name }}, измените значения полей `user` и `password.raw` в блоке `params.<тип_базы_данных>.auth.user_password`:

          ```hcl
          resource "yandex_connectionmanager_connection" "<локальное_имя_подключения>" {
            ...
            params = {
              <тип_базы_данных> = {
                ...
                auth = {
                  user_password = {
                    user     = "<имя_пользователя>"
                    password = {
                      raw = "<пароль>"
                    }
                  }
                }
              }
            }
          }
          ```
      
      1. Чтобы изменить параметры аутентификации для подключений к {{ mkf-name }}, измените значения полей в блоке `params.kafka.auth.sasl`:

          ```hcl
          resource "yandex_connectionmanager_connection" "<локальное_имя_подключения>" {
            ...
            params = {
              kafka = {
                ...
                auth = {
                  sasl = {
                    user     = "<имя_пользователя>"
                    password = { 
                      raw = "<пароль>"
                    }
                    supported_mechanisms = [
                      <список_механизмов_аутентификации>
                    ]
                  }
                }
              }
            }
          }
          ```

          Где `params.kafka.auth` — параметры аутентификации. Укажите один из блоков:

          * `sasl` — параметры SASL-аутентификации:
            
            * `user` — имя пользователя для подключения к кластеру.
            * `password.raw` — пароль пользователя.
            * `supported_mechanisms` — список механизмов аутентификации. Возможные значения:
              
              * `PLAIN` — аутентификация с передачей логина и пароля в открытом виде.
              * `SCRAM_SHA256` — аутентификация с хэшированием SHA-256.
              * `SCRAM_SHA512` — аутентификация с хэшированием SHA-512.

              [Подробнее о механизмах и протоколах SASL](../../glossary/sasl.md#mechanisms-and-protocols).
          
          * `disabled` — отключает аутентификацию.
  
      1. Проверьте корректность настроек.
  
          {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
      1. Подтвердите изменение ресурсов.
  
          {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
  1. Чтобы изменить настройки подключения к пользовательской инсталляции базы данных:

      1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      1. Чтобы изменить описание подключения и набор меток, измените значения соответствующих полей в описании ресурса:

          ```hcl
          resource "yandex_connectionmanager_connection" "<локальное_имя_подключения>" {
            ...
            description = "<описание_подключения>"
        
            labels = {
              "<ключ_1>" = "<значение_1>"
              "<ключ_2>" = "<значение_2>"
              ...
              "<ключ_N>" = "<значение_N>"
            }
            ...
          }
          ```

          Где:

          * `description` — описание подключения.

          * `labels` — набор меток в формате `"<ключ>" = "<значение>"`.

      1. Чтобы изменить список хостов для всех подключений, кроме подключений к {{ TR }}, измените значение поля `hosts` в блоке `params.<тип_базы_данных>.cluster`:

          ```hcl
          resource "yandex_connectionmanager_connection" "<локальное_имя_подключения>" {
            ...
            params = {
              <тип_базы_данных> = {
                cluster = {
                  hosts = [
                    {
                      <параметры_хоста_1>
                    },
                    {
                      <параметры_хоста_2>
                    },
                    ...
                    {
                      <параметры_хоста_N>
                    }
                  ]
                  ...
                }
                ...
              }
            }
          }
          ```

          {% note warning %}

          Параметры хостов зависят от типа базы данных. Подробнее см. в [документации провайдера {{ TF }}](https://terraform-provider.yandexcloud.net/resources/connectionmanager_connection).

          {% endnote %}

      1. Чтобы изменить параметры координатора для подключений к {{ TR }}, измените значения полей `host` и `port` в блоке `params.trino.cluster.coordinator`:

          ```hcl
          resource "yandex_connectionmanager_connection" "<локальное_имя_подключения>" {
            ...
            params = {
              <тип_базы_данных> = {
                cluster = {
                  coordinator = {
                    host = "<хост>"
                    port = <порт>
                  }
                  ...
                }
                ...
              }
            }
          }
          ```

      1. Чтобы изменить параметры [TLS](../../glossary/tls.md), измените значения полей в блоке `params.<тип_базы_данных>.cluster.tls_params`:

          ```hcl
          resource "yandex_connectionmanager_connection" "<локальное_имя_подключения>" {
            ...
            params = {
              <тип_базы_данных> = {
                cluster = {
                  ...
                  tls_params = {
                    tls {
                      ca_certificate = "<путь_к_сертификату>"
                    }
                  }
                }
                ...
              }
            }
          }
          ```

          Где `params.<тип_базы_данных>.cluster.tls_params` — параметры [TLS](../../glossary/tls.md). Укажите один из блоков:
        
          * `tls.ca_certificate` — путь к файлу CA-сертификата для TLS.
          * `disabled` — отключает TLS. По умолчанию TLS включен.

      1. Чтобы изменить список баз данных для всех подключений, кроме подключений к {{ TR }}, {{ OS }} и {{ KF }}, измените значение поля `databases` в блоке `params.<тип_базы_данных>`:
     
          ```hcl
          resource "yandex_connectionmanager_connection" "<локальное_имя_подключения>" {
            ...
            params = {
              <тип_базы_данных> = {
                ...
                databases = [
                  "<база_данных_1>",
                  "<база_данных_2>",
                  ...
                  "<база_данных_N>"
                ]
                ...
              }
            }
          }
          ```

          Где `databases` — список баз данных. Убедитесь, что у пользователя есть необходимые права на доступ к ним.
  
      1. Чтобы изменить параметры аутентификации для всех подключений, кроме подключений к {{ KF }}, измените значения полей `user` и `password.raw` в блоке `params.<тип_базы_данных>.auth.user_password`:

          ```hcl
          resource "yandex_connectionmanager_connection" "<локальное_имя_подключения>" {
            ...
            params = {
              <тип_базы_данных> = {
                ...
                auth = {
                  user_password = {
                    user     = "<имя_пользователя>"
                    password = {
                      raw = "<пароль>"
                    }
                  }
                }
              }
            }
          }
          ```
      
      1. Чтобы изменить параметры аутентификации для подключений к {{ KF }}, измените значения полей в блоке `params.kafka.auth.sasl`:

          ```hcl
          resource "yandex_connectionmanager_connection" "<локальное_имя_подключения>" {
            ...
            params = {
              kafka = {
                ...
                auth = {
                  sasl = {
                    user     = "<имя_пользователя>"
                    password = { 
                      raw = "<пароль>"
                    }
                    supported_mechanisms = [
                      <список_механизмов_аутентификации>
                    ]
                  }
                }
              }
            }
          }
          ```

          Где `params.kafka.auth` — параметры аутентификации. Укажите один из блоков:

          * `sasl` — параметры SASL-аутентификации:
            
            * `user` — имя пользователя для подключения к кластеру.
            * `password.raw` — пароль пользователя.
            * `supported_mechanisms` — список механизмов аутентификации. Возможные значения:
              
              * `PLAIN` — аутентификация с передачей логина и пароля в открытом виде.
              * `SCRAM_SHA256` — аутентификация с хэшированием SHA-256.
              * `SCRAM_SHA512` — аутентификация с хэшированием SHA-512.

              [Подробнее о механизмах и протоколах SASL](../../glossary/sasl.md#mechanisms-and-protocols).
          
          * `disabled` — отключает аутентификацию.

      1. Проверьте корректность настроек.
  
          {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
      1. Подтвердите изменение ресурсов.
  
          {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
      
- API {#api}

  Воспользуйтесь методом REST API [Connection.Update](../connection-manager/api-ref/Connection/update.md) или методом gRPC API [ConnectionService.Update](../connection-manager/api-ref/grpc/Connection/update.md) и передайте в запросе идентификатор подключения.

  Идентификатор подключения можно получить со [списком подключений](view-connection.md#connection-list) в каталоге.

{% endlist %}


