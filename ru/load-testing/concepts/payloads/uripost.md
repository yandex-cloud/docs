# URIPOST

Тип тестовых данных для описания HTTP-запросов `POST`. Используется в генераторах нагрузки Pandora и Phantom.

Тип тестовых данных указывается при [создании теста](../../operations/create-test-bucket.md#create-test).

Тестовые данные начинаются с заголовков запроса в квадратных скобках. Далее, с новой строки, указываются размер тела запроса в байтах и URI запроса, разделенные пробелом. Например:

```
[Host: example.com]
[User-Agent: Tank]
5 /route/?rll=50.262025%2C53.276083~50.056015%2C53.495561&origin=1&simplify=1
class
6 /route/?rll=50.262025%2C53.276083~50.056015%2C53.495561&origin=1&simplify=1
hello!
7 /route/?rll=37.565147%2C55.695758~37.412796%2C55.691454&origin=1&simplify=1
uripost
```

## Конфигурация для Phantom {#phantom-config}

```
phantom:
  ammo_type: uripost # Обязательно, иначе инструмент для тестирования не сможет их отличить от uri-style.
  ammofile: /path/to/ammo_file # или HTTP-ссылка
```

## Конфигурация для Pandora {#pandora-config}

При конфигурации генератора нагрузки Pandora с помощью файла необходимо указать тип `uripost` в секции `ammo`:

```
config_content:
          pools:
             ammo:
               type: uripost
               file: ./ammo.uripost
```

При загрузке файла с тестовыми данными через консоль управления типы данных и пути подставляются автоматически.