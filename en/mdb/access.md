# Clouds and folders internal to Yandex

MDB resources are allocated to a cloud assigned to the ABC service. There is a single folder inside each cloud.

{% include [abc-roles](../_includes/mdb/internal/abc-roles.md) %}


## Finding the folder or cloud ID {#find-id}

You may need folder and cloud IDs for CLI and API calls.

{% list tabs %}

- Web interface

   1. To retrieve a folder ID, select it from the [list of cloud folders](https://yc.yandex-team.ru). You can copy the folder ID from the page URL, for instance: `https://yc.yandex-team.ru/folders/**foodqkuj4ge5j9sg34uq**`.

   2. To retrieve a cloud ID, open the [cloud overview page](https://yc.yandex-team.ru/?tab=info). To switch to another cloud, open the drop-down list in the header on the right (to search by name):

      ![image](../_assets/mdb/cloud-select.png)

- CLI

   To retrieve a cloud ID for a configured CLI profile, run the command below:
   ```bash
   yc config list
   token: AQAD...
   endpoint: gw.db.yandex-team.ru:443
   cloud-id: fooubdgo8ls21u7u4enm
   folder-id: foo1sbbr3283m80ss5tp
   ```

   This command will also display the current default folder. To retrieve the ID of a different folder:

   1. Copy the ABC service slug, such as `https://abc.yandex-team.ru/services/**chemodan**/`.
   1. Run the command:
      ```bash
      yc resource-manager folder get chemodan
      id: foodqkuj4ge5j9sg34uq # folder ID
      cloud_id: fooubdgo8ls21u7u4enm
      created_at: "2018-10-21T23:55:16Z"
      name: chemodan
      description: Yandex.Disk https://abc.yandex-team.ru/services/chemodan/
      labels:
        abc_service_id: "406"
        abc_service_slug: chemodan
      status: ACTIVE
      ```

{% endlist %}

## Network access {#network-access}

[Puncher](https://puncher.yandex-team.ru/) already includes MDB cluster access rules:

- From [all Yandex server networks](https://puncher.yandex-team.ru/?id=5ce6a766d89cb04f14acafb3).
- For [all staff developers and admins](https://puncher.yandex-team.ru/?id=61f8da624928bbfd5d61d651).

Therefore, in general, you do not need to punch any holes.

