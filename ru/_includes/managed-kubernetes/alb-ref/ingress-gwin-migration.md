# Миграция с ALB Ingress Controller на Gwin

С помощью этой инструкции вы перенесете приложения {{ k8s }} с Ingress-контроллера {{ alb-name }} на новый контроллер Gwin для {{ managed-k8s-name }}.

Чтобы мигрировать приложение с Ingress-контроллера {{ alb-name }} на контроллер Gwin:

1. [Установите Gwin](#gwin-install).
1. [Запустите скрипт конвертации](#run-script-converter).
1. [Создайте новые ресурсы в кластере](#create-resources).
1. [Проверьте корректность балансировки нагрузки](#check-load-balancing).
1. [Перенаправьте трафик на новый балансировщик нагрузки](#dns-switch).
1. [Удалите ненужные ресурсы](#clear-out).

## Установите Gwin {#gwin-install}

Разверните контроллер Gwin в вашем кластере по [инструкции](../../../application-load-balancer/tools/gwin/quickstart.md). Контроллер не будет реагировать на ресурсы контроллера ALB Ingress, поскольку в его спецификации используется другой `ingressClassName`.

## Запустите скрипт конвертации {#run-script-converter}

Для автоматического преобразования существующих ресурсов контроллера ALB Ingress в формат контроллера Gwin используется инструмент `alb-ingress-converter`.

Конвертер выполняет следующие преобразования ресурсов {{ k8s }}:

* **IngressClass** — изменяет класс ALB Ingress на `gwin-default`.
* **Аннотации** — преобразует `ingress.alb.yc.io/*` в формат `gwin.yandex.cloud/*`.
* **Backend Groups** — преобразует `HttpBackendGroup`/`GrpcBackendGroup` в `IngressBackendGroup`.
* **Storage Buckets** — преобразует ссылки на бакеты {{ objstorage-name }} в ресурсы `YCStorageBucket`.
* **Services** — создает ресурсы `IngressBackendGroup` для групп бэкендов при необходимости.
* **Path Types** — обновляет типы путей для поддержки регулярных выражений (`ImplementationSpecific`).

Чтобы запустить скрипт конвертации:

1. Загрузите бинарный файл конвертера и сделайте его исполняемым. Файл хранится в публичном бакете {{ objstorage-name }}. Доступны сборки для следующих ОС:

   * [Linux AMD64](https://{{ s3-storage-host }}/gwin/utils/alb-ingress-converter/alb-ingress-converter-v1.0.0.linux-amd64.tar.gz)
   * [Linux ARM64](https://{{ s3-storage-host }}/gwin/utils/alb-ingress-converter/alb-ingress-converter-v1.0.0.linux-arm64.tar.gz)
   * [macOS AMD64](https://{{ s3-storage-host }}/gwin/utils/alb-ingress-converter/alb-ingress-converter-v1.0.0.darwin-amd64.tar.gz)
   * [macOS ARM64](https://{{ s3-storage-host }}/gwin/utils/alb-ingress-converter/alb-ingress-converter-v1.0.0.darwin-arm64.tar.gz)
   * [Windows AMD64](https://{{ s3-storage-host }}/gwin/utils/alb-ingress-converter/alb-ingress-converter-v1.0.0.windows-amd64.tar.gz)
   * [Windows ARM64](https://{{ s3-storage-host }}/gwin/utils/alb-ingress-converter/alb-ingress-converter-v1.0.0.windows-arm64.tar.gz)

   Пример загрузки файла для Linux:

   ```bash
   wget https://{{ s3-storage-host }}/gwin/utils/alb-ingress-converter/alb-ingress-converter-v1.0.0.linux-amd64.tar.gz &&
   tar -xzf alb-ingress-converter-v1.0.0.linux-amd64.tar.gz &&
   chmod +x alb-ingress-converter
   ```

1. (Опционально) Экспортируйте все ресурсы ALB Ingress из вашего кластера с помощью команды:

   ```bash
   kubectl get ingress,ingressclasses,ingressgroupsettings,httpbackendgroups,grpcbackendgroups,services \
       -A -o yaml > current-resources.yaml
   ```

   Также вы сможете запустить конвертер и получить ресурсы напрямую из кластера. При этом конвертер может использовать конфигурацию `kubectl` по умолчанию или конфигурацию, заданную в параметре `-kubeconfig`.

1. Запустите конвертер. Доступно несколько способов запуска:

   * Базовое использование конвертера:

       ```bash
       # Конвертация из файлов
       ./alb-ingress-converter -input-files current-resources.yaml

       # Конвертация напрямую из кластера
       ./alb-ingress-converter
       ```

   * Использование конвертера с расширенными опциями:

       ```bash
       # Указание директории для результатов
       ./alb-ingress-converter -input-files input.yaml -output-dir ./migration-output

       # Добавление префиксов/суффиксов к именам для избежания конфликтов
       ./alb-ingress-converter -input-files input.yaml -add-name-suffix "-migrated"

       # Сохранение diff-файлов для просмотра изменений
       ./alb-ingress-converter -input-files input.yaml -save-diff

       # Только валидация (без генерации вывода)
       ./alb-ingress-converter -input-files input.yaml -validate-only

       # Обработка нескольких файлов или директорий
       ./alb-ingress-converter -input-files file1.yaml,file2.yaml
       ./alb-ingress-converter -input-dirs ./manifests -recursive
       ```

       Для конвертера доступны параметры, перечисленные в таблице ниже.

       | Флаг | Описание |
       | --- | --- |
       | `-kubeconfig` | Путь к конфигурации `kubectl`. |
       | `-input-files` | Список YAML-файлов с исходной конфигурацией ресурсов через запятую. |
       | `-input-dirs` | Список директорий с исходной конфигурацией ресурсов через запятую. |
       | `-recursive` | Рекурсивное сканирование директорий.<br>По умолчанию: `false`. |
       | `-output-dir` | Выходная директория.<br>По умолчанию: `./alb-ingress-converter-output`. |
       | `-output-format` | Формат вывода: `files` или `stdout`.<br>По умолчанию: `files`. |
       | `-save-diff` | Сохранение diff-файлов с изменениями.<br>По умолчанию: `false`. |
       | `-validate-only` | Только валидация входных файлов.<br>По умолчанию: `false`. |
       | `-add-name-prefix` | Добавление префикса к именам генерируемых ресурсов.<br>По умолчанию: `""`. |
       | `-add-name-suffix` | Добавление суффикса к именам генерируемых ресурсов.<br>По умолчанию: `""`. |
       | `-ingress-controller-name` | Имя контроллера для фильтрации.<br>По умолчанию: `ingress.alb.yc.io/yc-alb-ingress-controller`. |

1. Проверьте результат работы конвертера. Директория с файлами вывода организована следующим образом:

    ```text
    output/
    ├── alb-ingress/ # Оригинальные ресурсы ALB Ingress
    │   ├── ...
    ├── gwin/ # Преобразованные ресурсы Gwin
    │   ├── ...
    └── diff/  # Diff файлы (если использован параметр -save-diff)
        └── ...
    ```

## Создайте новые ресурсы в кластере {#create-resources}

Просмотрите преобразованные ресурсы и примените их к вашему кластеру:

1. Проверьте сгенерированные YAML-файлы в папке `gwin`.
1. Примените их с помощью команды `kubectl apply -f <YAML_файл>`. В результате будет создан новый балансировщик нагрузки.
1. Убедитесь, что все ресурсы созданы успешно. Для этого проверьте статус ресурсов командой `kubectl get`.

Новый балансировщик нагрузки будет создан без удаления существующего.

## Проверьте корректность балансировки нагрузки {#check-load-balancing}

Протестируйте новый балансировщик нагрузки, чтобы убедиться в его корректной работе:

1. Получите IP-адрес нового балансировщика нагрузки:
    * Запросите статус ресурса `Ingress` командой `kubectl get Ingress`.
    * В [консоли управления]({{ link-console-main }}):
      * Перейдите на страницу кластера {{ managed-k8s-name }}.
      * На панели слева выберите ![image](../../../_assets/console-icons/timestamps.svg) **{{ ui-key.yacloud.k8s.cluster.switch_network }}**.
      * Перейдите на вкладку **{{ ui-key.yacloud.k8s.network.label_ingress }}**.
1. Убедитесь, что маршрутизация работает, как ожидается. Для этого протестируйте доступность HTTP/HTTPS-эндпоинтов вашего приложения.
1. Убедитесь, что проверки статуса бэкендов показывают их работоспособность.
1. Проверьте наличие ошибок в [логах](../../../application-load-balancer/operations/application-load-balancer-get-logs.md) и наличие признаков проблем с производительностью в [метриках балансировщика](../../../application-load-balancer/metrics.md).

## Перенаправьте трафик на новый балансировщик нагрузки {#dns-switch}

1. Обновите DNS-записи ваших доменов на IP-адрес нового балансировщика нагрузки для перенаправления трафика.
1. Следите за метриками приложения во время переключения трафика.
1. Убедитесь, что функциональность приложения полностью доступна после перенаправления трафика.

## Удалите ненужные ресурсы {#clear-out}

1. Удалите старые ресурсы ALB Ingress — оригинальные Ingress-контроллеры, группы бэкендов и т. д.
2. Удалите приложение ALB Ingress Controller.
3. Удалите неиспользуемые балансировщики нагрузки или сертификаты.

## Решение проблем {#troubleshooting}

### Ошибки в работе конвертера {#converter-errors}

Ресурсы не найдены (`No resources found`):

* Убедитесь, что ресурсы `IngressClass` включены во входные данные.
* Проверьте, что фильтр имени контроллера соответствует вашей настройке.

## Примеры изменения ресурсов при конвертации {#examples}

### Базовая конвертация ресурса Ingress {#base-config-example}

До конвертации (класс ALB Ingress):

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    ingress.alb.yc.io/group-name: "my-group"
    ingress.alb.yc.io/security-groups: "sg-1,sg-2"
spec:
  ingressClassName: yc-alb-ingress
  rules:
  - host: example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: grpc-service
            port:
              number: 80
```

После конвертации (класс Gwin):

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    gwin.yandex.cloud/groupName: "my-group"
    gwin.yandex.cloud/securityGroups: "sg-1,sg-2"
spec:
  ingressClassName: gwin-default
  rules:
  - host: example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          resource:
            apiGroup: gwin.yandex.cloud
            kind: IngressBackendGroup
            name: grpc-service-80
```

### Конвертация группы бэкендов {#backend-groups-example}

До конвертации (версия ALB Ingress):

```yaml
apiVersion: alb.yc.io/v1alpha1
kind: HttpBackendGroup
metadata:
  name: weighted-backends
spec:
  backends:
  - name: v1
    service:
      name: app-v1
      port:
        number: 8080
    weight: 70
```

После конвертации (версия Gwin):

```yaml
apiVersion: gwin.yandex.cloud/v1
kind: IngressBackendGroup
metadata:
  name: weighted-backends
spec:
  type: HTTP
  backends:
  - name: v1
    backendRef:
      name: app-v1
      port: 8080
    weight: 70
```
