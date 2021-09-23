# Штатные работы

## Расширение кластера {#expand_cluster}

(добавить инструкцию)

## SelfHeal {#selfheal}

В процессе работы кластеров могут выходить из строя отдельные блочные устройства, на которых работает ydb, либо узлы целиком. Для сохранения работоспособности и отказоустойчивости кластера в условиях, когда оперативная починка вышедших из строя узлов или устройств невозможна, используется механизм SelfHeal.

Механизм SelfHeal состоит из двух частей. Детектирование неисправных дисков и перевоз их в щадящем режиме не допуская потери данных и развала групп хранения.

По умолчанию SelfHeal включен.  
Ниже инструкция по включению в случае если он выключен, аналогично SelfHeal можно выключить.

1. Включение детектирования

    Открыть сртраницу

    ```http://localhost:8765/cms#show=config-items-25```

    Можно включить через viewer -> Cluster Management System -> CmsConfigItems

    Поле Status: Enable

    Или через cli

    * Зайти на любой узел

    * Составить файл с измененными конфигами

        Пример файла config.txt

        ```
        Actions {
            AddConfigItem {
                ConfigItem {
                    Config {
                        CmsConfig {
                            SentinelConfig {
                                Enable: true
                            }
                        }
                    }
                }
            }
        }
        ```

    * Обновить конфиг на кластере

        ```bash
        kikimr admin console configs update config.txt
        ```

2. Включение перевоза

    ```bash
    kikimr -s <ендпоинт> admin bs config invoke --proto 'Command{EnableSelfHeal{Enable: true}}'
    ```

## Увезти один вдиск с блочного устройтства {#moving_vdisk}

Для того чтобы перевезти диск с блочного устройства, надо зайти на ноду по ssh и выполнить следующую команду.

```bash
kikimr admin bs config invoke --proto 'Command { ReassignGroupDisk { GroupId: <ID группы хранения> GroupGeneration: <Поколение группы хранения> FailRealmIdx: <FailRealm> FailDomainIdx: <FailDomain> VDiskIdx: <Номер слота> } }'
```

Нужную информацию для выполнения команды можно посмотреть во вьювере (ссылка).

## Перевезти вдиски со сломанного/отсутствующего устройства {#removal_from_a_broken_device}

В случае если SelfHeal выключен или не перевозит вдиски, данную операцию придется выполнить вручную.

1. Убедиться в мониторинге, что диск действительно в нерабочем состоянии.  

    Записать fqdn узла, ic-port, путь до диска, pdiskId

2. Зайти на любой узел кластера

3. Выполнить перевоз диска

    ```bash
    kikimr admin bs config invoke --proto 'Command { UpdateDriveStatus { HostKey: { Fqdn: "<Xост>" IcPort: <IC Порт>} Path: "<Путь до партлейбла устройства>" PDiskId: <ID ПДиска> Status: BROKEN } }'
    ```

## Вернуть диск после развоза  {#return_a_device_to_work}

1. Убедиться в мониторинге, что диск в рабочем состоянии  

    Записать fqdn узла, ic-port, путь до диска, pdiskId

2. Зайти на любой узел кластера

3. Вернуть диск

    ```bash
    kikimr admin bs config invoke --proto 'Command { UpdateDriveStatus { HostKey: { Fqdn: "<Xост>" IcPort: <IC Порт>} Path: "<Путь до партлейбла устройства>" PDiskId: <ID ПДиска> Status: ACTIVE } }'
    ```

## Остановка/рестарт процесса ydb на узле {#restart_process}

Чтобы убедиться, что процесс можно остановить, надо выполнить следуюшие шаги.

1. Перейти на ноду по ssh.

1. Выполнить команду

    ```bash
    kikimr cms request restart host {node_id} --user {user} --duration 60 --dry --reason 'format disk'
    ```

    При разрешение выведет `ALLOW`.

1. Остановить процесс

    ```bash
    sudo systemctl stop kikimr
    ```

1. Если потребуется, запустить процесс

   ```bash
    sudo systemctl start kikimr
    ```

## Замена оборудования {#replace_hardware}

Перед заменой нужно убедиться, что процесс ydb можно [остановить](#restart_process).  
При длительном отсутствии стоит перед этим перевезти все вдиски с данного узла и дождаться окончания репликации.  
После окончания репликации ноду можно безопасно выключать.
