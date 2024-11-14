```yaml
name: group-for-load # Имя группы ВМ, уникальное в рамках каталога.
service_account_id: ajeab0cnib1p******** # Идентификатор сервисного аккаунта.
allocation_policy: # Политика распределения ВМ в группе.
   zones:
     - zone_id: {{ region-id }}-d
     - zone_id: {{ region-id }}-b
instance_template:
  service_account_id: ajeab0cnib1p******** # Идентификатор сервисного аккаунта для доступа к приватным Docker-образам.
  platform_id: standard-v1 # Идентификатор платформы.
  resources_spec:
    memory: 2G # Количество памяти (RAM).
    cores: 2 # Количество ядер процессора (vCPU).
  boot_disk_spec:
    mode: READ_WRITE # Режим доступа к диску: чтение и запись.
    disk_spec:
      image_id: <идентификатор_последней_версии_COI>
    type_id: network-ssd # Тип диска.
    size: 30G # Размер диска.
  network_interface_specs:
   - network_id: enplhg4nncc7******** # Идентификатор сети.
     subnet_ids:
       - e1lnabc23r1c******** # Идентификатор подсети.
       - b1csa2b3clid********
     primary_v4_address_spec: {
       one_to_one_nat_spec: {
         ip_version: IPV4 # Спецификация версии интернет-протокола IPv4 для публичного доступа к ВМ.
       }
     }         
  metadata: # Значения, которые будут переданы в метаданные ВМ.
    docker-container-declaration: |- # Ключ в метаданных ВМ, при котором используется Docker Container спецификация.
      spec:
        containers:
          - image: {{ registry }}/yc/demo/autoscaling-example-app:v1
            name: nginx
            securityContext:
              privileged: false
            restartPolicy: Always
            tty: false
            stdin: false
    ssh-keys: | # Параметр для передачи SSH-ключа на ВМ.
      yc-user:ssh-ed25519 ABC...d01 user@desktop.ru # Имя пользователя для подключения к ВМ.
deploy_policy: # Политика развертывания ВМ в группе.
  max_unavailable: 4
scale_policy: # Политика масштабирования ВМ в группе.
  fixed_scale:
    size: 6
load_balancer_spec: # Сетевой балансировщик нагрузки.
  target_group_spec:
    name: load-generator
```