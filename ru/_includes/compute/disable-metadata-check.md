Если вы создаете ВМ из образа на основе Amazon Machine Image, `cloud-init` проверит, что ВМ запускается в Amazon EC2. ВМ в {{ compute-full-name }} не пройдут проверку и могут работать некорректно.

Чтобы этого не произошло, отключите проверку метаданных на ВМ. Для этого создайте в директории `/etc/cloud/cloud.cfg.d` конфигурационный файл, например `99-ec2-datasource.cfg`, и добавьте в него код:

```yaml
#cloud-config
datasource:
  Ec2:
    strict_id: false
```