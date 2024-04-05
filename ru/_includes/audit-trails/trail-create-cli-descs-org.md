
* `--filter-from-organisation-id` — идентификатор организации, которой принадлежит создаваемый трейл и для ресурсов которой будут собираться аудитные логи. Получите идентификатор организации в консоли [{{org-full-name}}]({{link-org-main}}) или с помощью команды CLI `yc organization-manager organization list`.

    При использовании параметра `--filter-from-organisation-id` необходимо также задать идентификаторы облаков в параметре `--filter-some-cloud-ids`.

    Использование параметра `--filter-from-organisation-id` исключает использование параметра `--filter-all-organisation-id`.

* `--filter-some-cloud-ids` — список [идентификаторов облаков](../../resource-manager/operations/cloud/get-id.md), для ресурсов которых трейл будет собирать аудитные логи. Используйте этот параметр только в том случае, если задан параметр `--filter-from-organisation-id`.

    Указанные в параметре облака должны принадлежать организации, заданной в параметре `--filter-from-organisation-id`.

    Если аудитные логи нужно собирать во всех облаках, принадлежащих организации, используйте параметр `--filter-all-organisation-id`.

* `--filter-all-organisation-id` — идентификатор организации, которой принадлежит создаваемый трейл и для всех ресурсов во всех облаках которой будут собираться аудитные логи.

    Получите идентификатор организации в консоли [{{org-full-name}}]({{link-org-main}}) или с помощью команды CLI `yc organization-manager organization list`.

    Использование параметра `--filter-all-organisation-id` исключает использование параметра `--filter-from-organisation-id`.