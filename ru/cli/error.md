# Решение проблем CLI

Если во время выполнения операции возникла ошибка, [CLI](../glossary/cli.md) отобразит соответствующее сообщение.

### Пример сообщения об ошибке {#sample}

```
yc compute instance create --name my-inst3 --metadata user-data="#ps1\nnet user Administrator Passw0rd" --zone {{ region-id }}-a --public-ip --create-boot-disk image-folder-id=standard-images,image-name=windows-2016-gvlk-153
7967224
ERROR: rpc error: code = ResourceExhausted desc = The limit on maximum number of instances has exceeded.


server-request-id: 9d42710c-4a14-4561-a491-1f3bf76dbaaa
client-request-id: e69f4463-b9de-45bc-89b3-4db6e4d1bae6
client-trace-id: ddd8c763-81a3-4c58-9a7d-445257b59aee

Use server-request-id, client-request-id, client-trace-id for investigation of issues in cloud support
If you are going to ask for help of cloud support, please send the following trace file: C:\Users\username\yandex-cloud\logs\yc_compute_instance_create-2019-02-18T12-26-39.897.txt
```

### Что делать? {#what-to-do}

Чтобы помочь нашим специалистам быстрее решить вашу проблему, из сообщения об ошибке:

1. Скопируйте все доступные **идентификаторы**. В данном примере это `server-request-id`, `client-request-id` и `client-trace-id`.
1. Скопируйте **файл с логами**, который сохранился на вашем ПК. Путь к логам указан в конце сообщения об ошибке.
В данном примере это:
    ```
    C:\Users\username\yandex-cloud\logs\yc_compute_instance_create-2019-02-18T12-26-39.897.txt
    ```
1. Обратитесь с этой информацией в [службу технической поддержки]({{ link-console-support }}).

