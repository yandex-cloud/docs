# Изменить облачную сеть

После создания облачной сети вы можете изменить ее имя, описание и метки.

---

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

1. Посмотрите описание команд CLI для обновления параметров облачных сетей:

    ```
    $ yc vpc network update --help
    ```

1. Получите список всех сетей в каталоге по умолчанию:

    ```
    $ yc vpc network list
    +----------------------+----------------+
    |          ID          |      NAME      |
    +----------------------+----------------+
    | enpavfmgapumnl7cqin8 | test-network-1 |
    | enplom7a98s1t0lhass8 | default        |
    +----------------------+----------------+
    ```

1. Выберите `ID` или `NAME` нужной сети.
1. Измените параметры облачной сети, например:

    ```
    $ yc vpc network update --name test-network-1 --new-name test-network-renamed --labels new_label=test_label
    id: enpavfmgapumnl7cqin8
    folder_id: b1g6ci08ma55klukmdjs
    created_at: "2018-10-23T14:05:32Z"
    name: test-network-renamed
    description: My first network
    labels:
      new_label: test_label
    ```
---