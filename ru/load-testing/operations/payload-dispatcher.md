---
title: Как собрать пользовательские запросы для нагрузочного тестирования с помощью {{ load-testing-full-name }}
description: Следуя данной инструкции, вы сможете собрать пользовательские запросы и использовать эти данные для нагрузочного тестирования.
---

# Подготовка тестовых данных с помощью инструмента Dispatcher

Инструмент `dispatcher` предназначен для сбора пользовательских запросов и их сохранения в файлы данных, предназначенные для последующего проведения нагрузочного тестирования.

Этот инструмент работает как прокси: он перенаправляет HTTP-запросы на целевой сервер и возвращает ответы сервера обратно клиенту. Если проксированный запрос завершается успешно с HTTP-статусом 2хх, он записывается в файлы [данных](../concepts/payload.md), которые потом используются для нагрузочных тестов. `dispatcher` позволяет настраивать правила и объем сохраняемых данных с помощью специальных флагов.

## Перед началом работы {#before-you-begin}

1. Установите [Go не ниже версии 1.22](https://go.dev/doc/install):

   ```bash
   wget https://go.dev/dl/go1.22.2.linux-amd64.tar.gz
   tar -C /usr/local -xzf go1.22.2.linux-amd64.tar.gz
   export PATH=$PATH:/usr/local/go/bin
   ```

1. Установите [Git](https://ru.wikipedia.org/wiki/Git) с помощью команды:

   ```bash
   sudo apt install git
   ```

## Сбор запросов { #collecting-payload }

1. Клонируйте [репозиторий](https://github.com/yandex-cloud-examples/yc-load-testing-dispatcher) из GitHub и перейдите в папку `yc-load-testing-dispatcher`:
   
   ```bash
   git clone https://github.com/yandex-cloud-examples/yc-load-testing-dispatcher.git
   cd yc-load-testing-dispatcher
   ```

1. Запустите `dispatcher` с нужными флагами:

   ```bash
   go run dispatcher.go -target '<адрес_цели>' -port <порт> -ssl -noproxy -saveall -nostatic
   ```

   Где:
   * `target` – адрес сервиса, для которого выполняется проксирование и сохранение запросов;
   * `port` – порт, на котором будет запущен сервер. По умолчанию используется порт 8888;
   * `ssl` – позволяет проксировать запросы через защищенное HTTPS-соединение;
   * `noproxy` – определяет, следует ли сохранять запросы без их проксирования;
   * `saveall` – позволяет сохранять все запросы независимо от HTTP-кода ответа на проксированный запрос;
   * `nostatic` – позволяет не сохранять запросы статического контента, такого как CSS, JS, JPEG, JPG, PNG, GIF, ICO, SVG, WOFF и WOFF2.

   Пример запуска:

   ```bash
   go run dispatcher.go -target 'yandex.ru' -port 8080 -nostatic
   ```

   Результат:
   ```text
   Dispatcher listens to your requests
   ```

   После запуска все запросы для нагрузочного тестирования следует отправлять на адрес `localhost:8080`. Кроме того, вы можете открыть в браузере страницу `localhost:8080`, и там будет загружен сайт, указанный в флаге `target`.

   Все запросы записываются последовательно непосредственно после приема ответа. Следовательно, порядок параллельно выполняемых запросов может отличаться от порядка в финальном файле.

   Результат:
   ```text
   The payload is written to a raw.payload file
   The payload is written to a httpjson.payload file
   The payload is written to a uri.payload file
   The payload is written to a uripost.payload file
   ```

   После выполнения всех необходимых запросов, нажмите **Ctrl + C**, чтобы закрыть `dispatcher`.
   
      {% note warning %}

      Следует избегать ситуаций, когда закрытие происходит до получения всех ответов, так как тестовые данные могут не успеть записаться.

      {% endnote %}

   Cохранение запросов происходит в следующие файлы:

   * Файл `uri.payload` содержит запросы типа [URI](https://yandex.cloud/ru/docs/load-testing/concepts/payloads/uri);
   * Файл `uripost.payload` содержит запросы типа [URIPOST](https://yandex.cloud/ru/docs/load-testing/concepts/payloads/uripost);
   * Файл `raw.payload` содержит запросы типа [RAW](https://yandex.cloud/ru/docs/load-testing/concepts/payloads/raw);
   * Файл `httpjson.payload` содержит запросы типа [HTTP_JSON](https://yandex.cloud/ru/docs/load-testing/concepts/payloads/http-json).