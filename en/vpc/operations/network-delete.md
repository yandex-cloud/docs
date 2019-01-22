# Deleting a cloud network

> [!WARNING]
>
> Before you delete a network, you need to [delete](subnet-delete.md) all its subnets.
> You cannot restore a network after it is deleted.
>

---

**[!TAB Management console]**

To delete a [cloud network](../concepts/network.md#network):

1. Open the **Virtual Private Cloud** section in the folder you want to delete the cloud network from.
1. Click ![vertical-ellipsis](../../_assets/vertical-ellipsis.svg) in the row of the network to delete.
1. In the menu that opens, click **Delete**.
1. In the window that opens, click **Delete**.

**[!TAB CLI]**

If you don't have the Yandex.Cloud command line interface yet, [install it](https://cloud.yandex.ru/docs/cli/quickstart#install).

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

1. See the description of the CLI's delete cloud network command:

    ```
    $ yc vpc network delete --help
    ```

1. Get a list of all networks in the default folder:

    ```
    $ yc vpc network list
    +----------------------+----------------+
    |          ID          |      NAME      |
    +----------------------+----------------+
    | enpiuvhhd4t80k4n80i8 | test-network-1 |
    | enplom7a98s1t0lhass8 | default        |
    +----------------------+----------------+
    ```

1. Select the `ID` or `NAME` of the network you need.

1. Delete the network:

    ```
    $ yc vpc network delete test-network-1 
    ```

---

