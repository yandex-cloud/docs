# URI

Тип тестовых данных для описания HTTP-запросов `GET`. Позволяет задавать разные заголовки для разных запросов, указывать теги для запросов. Используется в генераторах нагрузки Pandora и Phantom.

Тип тестовых данных указывается при [создании теста](../../operations/create-test-bucket.md#create-test).

Формат данных:

```text
[Header_name: header_value]
uri1
uri2 tag
```

Заголовки можно добавлять в любом месте файла, они будут применяться для всех URI, указанных после заголовка. Список зацикливается до достижения требуемого количества запросов в секунду.

## Конфигурирование генераторов нагрузки

{% list tabs group=instructions %}

- Phantom {#phantom}

   При конфигурировании генератора нагрузки Phantom с помощью yaml-файла можно указать заголовки и эндпоинты запросов для нагрузочного тестирования в самом файле:

   ```yaml
   phantom:
     address: 203.0.113.1:80
     load_profile:
       load_type: rps
       schedule: line(1, 10, 10m)
     header_http: "1.1"
     headers:
       - "[Host: www.target.example.com]"
       - "[Connection: close]"
     uris:
       - "/uri1"
       - "/buy"
       - "/sdfg?sdf=rwerf"
       - "/sdfbv/swdfvs/ssfsf"
   ```

   Также заголовки и эндпоинты могут быть вынесены в отдельный текстовый файл. В этом случае укажите в yaml-файле тип `uri` для параметра `ammo_type`:

   - Файл конфигурации:

   ```yaml
   phantom:
     address: 203.0.113.1:80
     load_profile:
       load_type: rps
       schedule: line(1, 10, 10m)
     header_http: "1.1"
     ammo_type: uri
     ammofile: ./ammo.txt
   ```

   - Текстовый файл с заголовками и запросами `ammo.txt`:

   ```http
   [Connection: close]
   [Host: target.example.com]
   [Cookie: None]
   /?drg tag1
   /
   /buy tag2
   [Cookie: test]
   /buy/?rt=0&station_to=7&station_from=9
   ```

   Заголовки, указанные в квадратных скобках, могут переопределять друг друга. Так, в примере выше, последний эндпоинт будет использован с кукой `test`, в отличие от предыдущих, которые будут использованы без куки.

- Pandora {#pandora}

   При конфигурировании генератора нагрузки Pandora с помощью yaml-файла можно указать заголовки и эндпоинты запросов для нагрузочного тестирования в самом файле:

   ```yaml
   pandora:
   enabled: true
   package: yandextank.plugins.Pandora
   config_content:
      pools:
      - id: HTTP
         gun:
            type: http
            target: 10.128.0.15:80
            ssl: false
         ammo:
            type: uri
            uris:
            - /index
            - /search
            headers:
            - '[Host: my.host]'
            - '[Connection: keep-alive]'
         result:
            type: phout
            destination: ./phout.log
         startup:
            type: once
            times: 1000
         rps:
            - type: line
            from: 1
            to: 1000
            duration: 60s
         discard_overflow: true
      log:
      level: error
      monitoring:
      expvar:
         enabled: true
         port: 1234
   ```

   Также заголовки и эндпоинты могут быть вынесены в отдельный текстовый файл:

   ```yaml
   config_content:
      pools:
      - id: HTTP
         ammo:
            type: uri
            file: ./ammo.uri
   ```

   В этом случае необходимо указать в yaml-файле тип `uri` для параметра `type` в секции `ammo`.
   При загрузке файла с тестовыми данными через консоль управления это происходит автоматически.


{% endlist %}


## Примеры использования {#examples}

* [{#T}](../../tutorials/loadtesting-https-phantom.md)
* [{#T}](../../tutorials/loadtesting-https-pandora.md)
* [{#T}](../../tutorials/loadtesting-results-compare.md)