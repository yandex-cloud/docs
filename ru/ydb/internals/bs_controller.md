# Distributed Storage

Distributed Storage (BlobStorage) состоит из разных компонентов, которые запускаются на разных нодах, которые осуществляют управление следующими ресурсами BlobStorage:

1. Ноды
2. PDisk'и
3. VDisk'и
4. Группы

# Node Warden

Node Warden — часть системы управления BlobStorage (Distributed Storage), которая запускается на каждой ноде системы, как на статических нодах (в т.ч. нодах с хранилищем), так и на динамических нодах. На нодах с хранилищем отвечает за запуск, остановку, форматирование PDisk'ов и VDisk'ов по командам от BS_CONTROLLER'а, а также за управление DS proxy на данной ноде (запуск, остановка, конфигурирование). На всех других нодах управляет только DS proxy.

# BS_CONTROLLER

BS_CONTROLLER является специальной таблеткой (по одной на кластер), которая осуществляет координацию работы всех Node Warden'ов кластера и позволяет централизованно управлять ресурсами кластера.

## Настройки BS_CONTROLLER

Изменение настроек работы BS_CONTROLLER'а производится при помощи универсальной команды UpdateSettings, которую можно подать через `kikimr admin bs config invoke --proto '<proto>'`, либо для старых установок через отдельные команды, также через Command. Стоит заметить, что UpdateSettings и другие команды, которые управляют настройками, должны быть единственной командой в запросе.

### DefaultMaxSlots

Настройка позволяет задать максимальное число слотов для PDisk'ов, у которых в конфигурации явно не указано ExpectedSlotCount. Значение по умолчанию — 16.

`$ kikimr admin bs config invoke --proto 'Command { UpdateSettings { DefaultMaxSlots: 8 } }'`

### Self Heal

Настройка позволяет включить или выключить Self Heal. По умолчанию выключен.

`$ kikimr admin bs config invoke --proto 'Command { UpdateSettings { EnableSelfHeal: true } }'`

Старый формат вызова: `$ kikimr admin bs config invoke --proto 'Command { EnableSelfHeal { Enable: true } }'`

### Donor Mode

Настройка позволяет включить или выключить режим, при котором при перевозе VDisk'ов на новые PDisk'и старые слоты остаются активными до завершения репликации новых, что позволяет снизить риски потери данных. По умолчанию выключен.

`$ kikimr admin bs config invoke --proto 'Command { UpdateSettings { EnableDonorMode: true } }'`

Старый формат вызова: `$ kikimr admin bs config invoke --proto 'Command { EnableDonorMode { Enable: true } }'`

### Scrub

Настройки Scrub позволяют регулировать интервал времени, который проходит от начала предыдущего цикла скраббинга диска до начала следующего, а также максимальное число дисков, которые могут скрабиться одновременно. Значение по умолчанию — 1 месяц.

`$ kikimr admin bs config invoke --proto 'Command { UpdateSettings { ScrubPeriodicitySeconds: 86400 MaxScrubbedDisksAtOnce: 1 } }'`

Старый формат вызова: `$ kikimr admin bs config invoke --proto 'Command { SetScrubPeriodicity { ScrubPeriodicity: 86400 } }'`.

### PDiskSpaceMarginPromille

Определяет максимально допустимый размер заполненности PDisk'а после выполнения перевоза на него. При планировании перевозов, если этот порог будет превышен с учётом потенциальной репликации, перевоз осуществляться не будет. Значение по умолчанию — 150 (15%).

`$ kikimr admin bs config invoke --proto 'Command { UpdateSettings { PDiskSpaceMarginPromille: 100 } }'`

### GroupReserve

Определяет резерв групп для каждого вида Storage Pool'а. Если расширение пула приведёт к тому, что такое число групп создать нельзя, операция отменяется. Резерв считается как `GroupReserveMin + GroupReservePartPPM * MAX_GROUPS / 1000000`, где MAX_GROUPS — максимальное число групп, которое можно создать для определённого вида пулов. По умолчанию отключено.

`$ kikimr admin bs config invoke --proto 'Command { UpdateSettings { GroupReserveMin: 1 GroupReservePartPPM: 27000 } }'`

### PDiskSpaceColorBorder

`$ kikimr admin bs config invoke --proto 'Command { UpdateSettings { PDiskSpaceColorBorder: YELLOW } }'`
