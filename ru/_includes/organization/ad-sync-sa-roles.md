* [`organization-manager.userpools.syncAgent`](../../organization/security/index.md#organization-manager-userpools-syncAgent);
* [`organization-manager.groups.viewer`](../../organization/security/index.md#organization-manager-groups-viewer);
* [`organization-manager.groups.externalCreator`](../../organization/security/index.md#organization-manager-groups-externalCreator);
* [`organization-manager.groups.externalConverter`](../../organization/security/index.md#organization-manager-groups-externalConverter).

Если вы планируете выгружать логи работы агента синхронизации в [лог-группу](../../logging/concepts/log-group.md) {{ cloud-logging-full-name }}, дополнительно назначьте сервисному аккаунту [роль](../../logging/security/index.md#logging-writer) `logging.writer` на соответствующую лог-группу или [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором она расположена.