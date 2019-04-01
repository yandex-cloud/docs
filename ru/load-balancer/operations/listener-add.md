# Добавление обработчика к балансировщику

---

**[!TAB Консоль управления]**

Чтобы добавить [обработчик](../concepts/listener.md) к сетевому балансировщику: 

1. Откройте раздел **Yandex Load Balancer** в каталоге, где требуется добавить обработчик к балансировщику.
1. Нажмите значок ![image](../../_assets/vertical-ellipsis.svg) в строке балансировщика, к которому нужно добавить обработчик.
1. В открывшемся меню нажмите кнопку **Добавить обработчик**.
1. Введите порт для обработчика.
1. Нажмите кнопку **Добавить**.

**[!TAB CLI]**

Если у вас еще нет интерфейса командной строки Яндекс.Облака, [установите его](https://cloud.yandex.ru/docs/cli/quickstart#install).

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

Чтобы добавить обработчик к балансировщику:

1. Получите список балансировщиков:

   ```
   $ yc load-balancer network-load-balancer list
   +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
   |          ID          |        NAME        |  REGION ID  |   TYPE   | LISTENER COUNT | ATTACHED TARGET GROUPS |  STATUS  |
   +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+
   | c58r8boim8qfkcqtuioj | test-load-balancer | ru-central1 | EXTERNAL |              0 |                        | INACTIVE |
   +----------------------+--------------------+-------------+----------+----------------+------------------------+----------+

   ```

1. Добавьте обработчик, указав его имя, порт и версию IP-адреса:

   ```
   $ yc load-balancer network-load-balancer add-listener c580id04kvumgn7ssfh1 \
   --listener name=test-listener,port=80,external-ip-version=ipv4
   .....done
   id: c58r8boim8qfkcqtuioj
   folder_id: aoerb349v3h4bupphtaf
   created_at: "2019-04-01T09:29:25Z"
   name: test-load-balancer
   region_id: ru-central1
   status: INACTIVE
   type: EXTERNAL
   listeners:
   - name: test-listener
     address: <IP-адрес обработчика>
     port: "80"
     protocol: TCP
   ```

**[!TAB API]**

Добавить обработчик можно с помощью метода API [addListener](../api-ref/NetworkLoadBalancer/addListener.md).

---