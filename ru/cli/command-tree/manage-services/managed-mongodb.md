# yc managed-mongodb

Управление [!KEYREF MG].

#### Использование команды

Синтаксис: 

`yc managed-mongodb <group>`

Алиасы:
  
- `yc mongodb <group>`;
- `yc mongo <group>`.

#### Группы

- `yc managed-mongodb cluster` — управление кластерами [!KEYREF MG].
    - `get` — [получить информацию об указанном кластере [!KEYREF MG]](../../../managed-mongodb/operations/cluster-list.md#get-cluster).
    - `list` — [получить список кластеров [!KEYREF MG]](../../../managed-mongodb/operations/cluster-list.md#list-clusters).
    - `create` — [создать кластер [!KEYREF MG]](../../../managed-mongodb/operations/cluster-create.md).
    - `restore` — [восстановить кластер [!KEYREF MG]](../../../managed-mongodb/operations/cluster-backups.md#restore).
    - `update` — [изменить указанный кластер [!KEYREF MG]](../../../managed-mongodb/operations/update.md).
    - `update-config` — изменить конфигурацию указанного кластера [!KEYREF MG].
    - `delete` — [удалить указанный кластер [!KEYREF MG]](../../../managed-mongodb/operations/cluster-delete.md).
    - `backup` — [создать резервную копию указанного кластера [!KEYREF MG]](../../../managed-mongodb/operations/cluster-backups.md#create-backup).
    - `list-backups` — получить список доступных резервных копий для указанного кластера [!KEYREF MG].
    - `list-logs` — получить логи для указанного кластера [!KEYREF MG].
    - `list-operations` — получить список операций для указанного кластера [!KEYREF MG].  
- `yc managed-mongodb hosts` — управление хостами кластеров [!KEYREF MG].
    - `list` — [получить список хостов для указанного кластера [!KEYREF MG]](../../../managed-mongodb/operations/hosts.md#list-hosts). 
    - `add` — [добавить новый хост для кластера в указанной зоне доступности](../../../managed-mongodb/operations/hosts.md#add-host). 
    - `delete` — [удалить указанный хост](../../../managed-mongodb/operations/hosts.md#remove-host). 
- `yc managed-mongodb database` — управление базами данных [!KEYREF MG].
    - `get` — получить информацию об указанной базе данных [!KEYREF MG].
    - `list` — получить список баз данных [!KEYREF MG].
    - `create` — создать базу данных  [!KEYREF MG].
    - `delete` — удалить указанную базу данных [!KEYREF MG].
- `yc managed-mongodb user` — управление пользователями [!KEYREF MG].
    - `get` — получить информацию об указанном пользователе [!KEYREF MG].
    - `list` — [получить список пользователей для указанного кластера [!KEYREF MG]](../../../managed-mongodb/operations/cluster-users.md#list-users).
    - `create` — [создать пользователя [!KEYREF MG]](../../../managed-mongodb/operations/cluster-users.md#adduser).
    - `update` — [изменение указанного пользователя [!KEYREF MG]](../../../managed-mongodb/operations/cluster-users.md#updateuser). 
    - `delete` — [удалить указанного пользователя [!KEYREF MG]](../../../managed-mongodb/operations/cluster-users.md#removeuser).
    - `grant-permission` — предоставить права указанному пользователя [!KEYREF MG].
    - `revoke-permission` — аннулировать права указанного пользователя [!KEYREF MG].
- `yc managed-mongodb backup` — управление [резервными копиями [!KEYREF MG]](../../../managed-mongodb/concepts/backup.md).
    - `get` — [получить информацию об указанной резервной копии [!KEYREF MG]](../../../managed-mongodb/operations/cluster-backups.md#get-backup).
    - `list` — [получить список доступных резервных копий [!KEYREF MG]](../../../managed-mongodb/operations/cluster-backups.md#list-backups).
- `yc managed-mongodb resource-preset` — управление [классами хостов [!KEYREF MG]](../../../managed-mongodb/concepts/instance-types.md).
    - `get` — получить информацию об указанных классах хостов [!KEYREF MG].
    - `list` — получить информацию о доступных классах хостов [!KEYREF MG].
