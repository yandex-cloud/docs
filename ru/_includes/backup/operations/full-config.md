```json
{
  "compression": "string",
  "format": "string",
  "multiVolumeSnapshottingEnabled": bool,
  "preserveFileSecuritySettings": bool,
  "reattempts": {
    "enabled": bool,
    "interval": {
      "type": "string",
      "count": "string"
    },
    "maxAttempts": "string"
  },
  "silentModeEnabled": bool,
  "splitting": {
    "size": "string"
  },
  "vmSnapshotReattempts": {
    "enabled": bool,
    "interval": {
      "type": "string",
      "count": "string"
    },
    "maxAttempts": "string"
  },
  "vss": {
    "enabled": bool,
    "provider": "string"
  },
  "archive": {
    "name": "string"
  },
  "performanceWindow": {
    "enabled": bool
  },
  "retention": {
    "rules": [
      {
        "backupSet": [
          "string"
        ],
        "maxAge": {
          "type": "string",
          "count": "string"
        },
        "maxCount": "string",
      }
    ],
    "beforeBackup": bool
  },
  "scheduling": {
    "backupSets": [
      {
        "time": {
          "weekdays": [
            "string"
          ],
          "repeatAt": [
            {
              "hour": "string",
              "minute": "string"
            }
          ],
          "repeatEvery": {
            "type": "string",
            "count": "string"
          },
          "timeFrom": {
            "hour": "string",
            "minute": "string"
          },
          "timeTo": {
            "hour": "string",
            "minute": "string"
          },
          "monthdays": [
            "string"
          ],
          "includeLastDayOfMonth": bool,
          "months": [
            "string"
          ],
          "type": "string"
        },
        "sinceLastExecTime": {
          "delay": {
            "type": "string",
            "count": "string"
          }
        },
      }
    ],
    "enabled": bool,
    "maxParallelBackups": "string",
    "randMaxDelay": {
      "type": "string",
      "count": "string"
    },
    "scheme": "string",
    "weeklyBackupDay": "string"
  },
  "cbt": "string",
  "fastBackupEnabled": bool,
  "quiesceSnapshottingEnabled": bool
}
```

Описание спецификации:

| Атрибут | Описание | Возможные значения |
|---|---|---|
| `compression` | Степень сжатия резервной копии. | <ul><li>`COMPRESSION_UNSPECIFIED` — не задано;</li><li>`NORMAL` — стандартное сжатие;</li><li>`HIGH` — сильное сжатие;</li><li>`MAX` — максимальное сжатие;</li><li>`OFF` — отключено.</li></ul> |
| `format` | Формат резервной копии. | <ul><li>`FORMAT_UNSPECIFIED` — не задано;</li><li>`VERSION_11` — устаревший формат, не рекомендуется его использовать.</li><li>`VERSION_12` — рекомендованный формат для быстрого резервного копирования и восстановления.</li><li>`AUTO` — автоматический выбор формата. По умолчанию используется версия 12. Исключение — создание инкрементальных копий для образов, созданных в других версиях.</li></ul> |
| `multiVolumeSnapshottingEnabled` | Делать резервные копии нескольких томов одновременно. | <ul><li>`true` — включено;</li><li>`false` — выключено.</li></ul> |
| `preserveFileSecuritySettings` | Сохранять настройки безопасности файлов. | <ul><li>`true` — включено;</li><li>`false` — выключено.</li></ul> |
| `cbt` | Конфигурация отслеживания содержимого резервных копий Changed Block Tracking. | <ul><li>`CHANGED_BLOCK_TRACKING_UNSPECIFIED` — не задано;</li><li>`USE_IF_ENABLED` — использовать, если включено;</li><li>`ENABLE_AND_USE` — включить и использовать;</li><li>`DO_NOT_USE` — не использовать.</li></ul> |
| `fastBackupEnabled` | Быстрое резервное копирование — настройка отслеживания изменений в файлах. Когда включено, наличие изменений в файле определяется по его размеру и таймстампу. Когда выключено, для проверки наличия изменений содержимое файла сравнивается с содержимым, сохраненным в резервной копии. | <ul><li>`true` — включено;</li><li>`false` — выключено.</li></ul> |
| `quiesceSnapshottingEnabled` | Использовать режим `quiescing` при создании резервных копий. | <ul><li>`true` — включено;</li><li>`false` — выключено.</li></ul> |

Секции атрибутов с несколькими вложенными значениями:

{% list tabs %}

- reattempts

  Настройка повторения операций резервного копирования в случае сбоев. 

  | Атрибут | Описание | Возможные значения |
  |---|---|---|
  | `reattempts.enabled` | Повторять попытки создать резервную копию при возникновении некритических ошибок (например, при сбое подключения к целевому диску). | <ul><li>`true` — включено;</li><li>`false` — выключено.</li></ul> |
  | `reattempts.interval.type` | Единица времени для определения частоты повторения попыток. | <ul><li>`TYPE_UNSPECIFIED` — не задано;</li><li>`SECONDS` — секунды;</li><li>`MINUTES` — минуты;</li><li>`HOURS` — часы;</li><li>`DAYS` — дни;</li><li>`WEEKS` — недели;</li><li>`MONTHS` — месяцы.</li></ul> |
  | `reattempts.interval.count` | Длительность интервала между повторениями попыток. | Целое число. |
  | `reattempts.maxAttempts` | Максимальное количество попыток. При достижении максимального количества повторных попыток операция будет считаться неуспешной. | Целое число. |
  | `silentModeEnabled` | Режим «Не беспокоить». Сокращает количество взаимодействий с пользователем, когда это возможно. По умолчанию выключено. | <ul><li>`true` — включено;</li><li>`false` — выключено.</li></ul> |
  | `splitting.size` | Разбить резервную копию на тома заданного размера в байтах. Если значение не задано, резервная копия сохранится одним файлом. | Целое число. |
  
- vmSnapshotReattempts

  Настройка повторения операций создания резервных копий в случае сбоев.
  
  | Атрибут | Описание | Возможные значения |
  |---|---|---|
  | `vmSnapshotReattempts.enabled` | Повторять попытки создать резервную копию при возникновении ошибок. | <ul><li>`true` — включено;</li><li>`false` — выключено.</li></ul> |
  | `vmSnapshotReattempts.interval.type` | Единица времени для определения частоты повторения попыток. | <ul><li>`TYPE_UNSPECIFIED` — не задано;</li><li>`SECONDS` — секунды;</li><li>`MINUTES` — минуты;</li><li>`HOURS` — часы;</li><li>`DAYS` — дни;</li><li>`WEEKS` — недели;</li><li>`MONTHS` — месяцы.</li></ul> |
  | `vmSnapshotReattempts.interval.count` | Длительность интервала между повторениями попыток. | Целое число. |
  | `vmSnapshotReattempts.maxAttempts` | Максимальное количество повторных попыток. При достижении максимального количества повторных попыток операция будет считаться неуспешной. | Целое число. |
  
- vss

  Настройка службы теневого копирования томов VSS. Служба уведомляет приложения с поддержкой VSS о предстоящем начале резервного копирования. Приложения сохраняют информацию из памяти на диск, что обеспечивает целостность данных при копировании.
  
  | Атрибут | Описание | Возможные значения |
  |---|---|---|
  | `vss.enabled` | Включить VSS. | <ul><li>`true` — включено;</li><li>`false` — выключено.</li></ul> |
  | `vss.provider` | Выбор VSS-провайдера. | <ul><li>`VSS_PROVIDER_UNSPECIFIED` — не задано;</li><li>`NATIVE` — нативный VSS-провайдер;</li><li>`TARGET_SYSTEM_DEFINED` — VSS-провайдер, заданный целевой системой.</li></ul>|
  | `archive.name` | Имя создаваемого архива. | Строка. Может содержать переменные: `[Machine Name]`, `[Plan ID]`, `[Plan Name]`, `[Unique ID]`, `[Virtualization Server Type]`. |
  | `performanceWindow` | Включить окно производительности для ограничения влияния резервного копирования и обслуживания хранилища на производительность. | <ul><li>`true` — включено;</li><li>`false` — выключено.</li></ul> |
  
- retention
  
  Настройка правил хранения резервных копий. Атрибуты `maxAge` и `maxCount` — взаимоисключающие. Использование одного делает невозможным использование другого.
  
  | Атрибут | Описание | Возможные значения |
  |---|---|---|
  | `retention.rules.backupSet` | Группа резервных копий, для которой задаются настройки хранения. | Строка. |
  | `retention.rules.maxAge.type` | Задать правило хранения резервных копий, при котором устаревшие копии будут удаляться в зависимости от их возраста в указанных единицах времени. | <ul><li>`TYPE_UNSPECIFIED` — не задано;</li><li>`SECONDS` — секунды;</li><li>`MINUTES` — минуты;</li><li>`HOURS` — часы;</li><li>`DAYS` — дни;</li><li>`WEEKS` — недели;</li><li>`MONTHS` — месяцы.</li></ul> |
  | `retention.rules.maxAge.count` | Максимальный срок хранения резервных копий в единицах времени, заданных атрибутом `maxAge.type`. | Целое число. |
  | `retention.rules.maxCount` | Задать правило хранения резервных копий, при котором устаревшие копии будут удаляться в зависимости от установленного максимального количества хранимых резервных копий. | Целое число. |
  | `retention.beforeBackup` | Применять правила хранения резервных копий до завершения операции резервного копирования. При создании политики по умолчанию или с помощью консоли управления задается правило `beforeBackup=false`. Настройки правил хранения резервных копий вступят в силу после создания очередной резервной копии. | <ul><li>`true` — включено;</li><li>`false` — выключено.</li></ul> |
  
- scheduling

  Настройка расписания резервного копирования. Атрибуты `time` (по заданному времени) и `sinceLastExecTime` (с заданным интервалом между операциями) — взаимоисключающие. Использование одного делает невозможным использование другого.
  
  | Атрибут | Описание | Возможные значения |
  |---|---|---|
  | `scheduling.backupSets.time.weekdays` | Дни недели, в которые должно происходить копирование. Можно указать одновременно несколько значений, разделенных запятой. | <ul><li>`DAY_UNSPECIFIED` — не задано;</li><li>`MONDAY` — понедельник;</li><li>`TUESDAY` — вторник;</li><li>`WEDNESDAY` — среда;</li><li>`THURSDAY` — четверг;</li><li>`FRIDAY` — пятница;</li><li>`SATURDAY` — суббота;</li><li>`SUNDAY` — воскресенье.</li></ul> |
  | `scheduling.backupSets.time.repeatAt.hour` | Время для повторения копирования: часы. | Целое число от 0 до 23. |
  | `scheduling.backupSets.time.repeatAt.minute` | Время для повторения копирования: минуты. | Целое число от 0 до 59. |
  | `scheduling.backupSets.time.repeatEvery.type` | Единицы времени для определения частоты повторения операции резервного копирования. | <ul><li>`TYPE_UNSPECIFIED` — не задано;</li><li>`SECONDS` — секунды;</li><li>`MINUTES` — минуты;</li><li>`HOURS` — часы;</li><li>`DAYS` — дни;</li><li>`WEEKS` — недели;</li><li>`MONTHS` — месяцы.</li></ul> |
  | `scheduling.backupSets.time.repeatEvery.count` | Частота повторения операции резервного копирования в единицах измерения, заданных в атрибуте `repeatEvery.type`. | Целое число. |
  | `scheduling.backupSets.time.timeFrom.hour` | Время начала временного интервала для копирования (от): часы. | Целое число от 0 до 23. |
  | `scheduling.backupSets.time.timeFrom.minute` | Время начала временного интервала для копирования (от): минуты. | Целое число от 0 до 59. |
  | `scheduling.backupSets.time.timeTo.hour` | Время окончания временного интервала для копирования (до): часы. | Целое число от 0 до 23. |
  | `scheduling.backupSets.time.timeTo.minute` | Время окончания временного интервала для копирования (до): минуты. | Целое число от 0 до 59. |
  | `scheduling.backupSets.time.monthdays` | День месяца, когда должно выполняться резервное копирование. Можно указать одновременно несколько значений, разделенных запятой. | Целое число от 1 до 31. |
  | `scheduling.backupSets.time.includeLastDayOfMonth` | Выполнение резервного копирования в последний день месяца. | <ul><li>`true` — включено;</li><li>`false` — выключено.</li></ul> |
  | `scheduling.backupSets.time.months` | Месяцы, в которые должно выполняться резервное копирование. Можно указать одновременно несколько значений, разделенных запятой. | Целое число от 1 до 12. |
  | `scheduling.backupSets.time.type` | Периодичность копирования. | <ul><li>`REPEATE_PERIOD_UNSPECIFIED` — не задано;</li><li>`HOURLY` — каждый час;</li><li>`DAILY` — ежедневно;</li><li>`WEEKLY` — еженедельно;</li><li>`MONTHLY` — ежемесячно.</li></ul> |
  | `scheduling.backupSets.sinceLastExecTime.delay.type` | Единицы времени для определения интервала между операциями резервного копирования. | <ul><li>`TYPE_UNSPECIFIED` — не задано;</li><li>`SECONDS` — секунды;</li><li>`MINUTES` — минуты;</li><li>`HOURS` — часы;</li><li>`DAYS` — дни;</li><li>`WEEKS` — недели;</li><li>`MONTHS` — месяцы.</li></ul> |
  | `scheduling.backupSets.sinceLastExecTime.delay.count` | Длительность интервала между резервными копированиями в единицах времени, заданных атрибутом `delay.type`. | Целое число. |
  | `scheduling.enabled` | Выполнение резервного копирования по расписанию. | <ul><li>`true` — включено;</li><li>`false` — выключено.</li></ul> |
  | `scheduling.maxParallelBackups` | Максимально допустимое количество одновременно запущенных процессов резервного копирования. Если не задано — без ограничений. | Целое число. |
  | `scheduling.randMaxDelay.type` | Единицы времени для определения максимальной задержки между запуском параллельных задач. | <ul><li>`TYPE_UNSPECIFIED` — не задано;</li><li>`SECONDS` — секунды;</li><li>`MINUTES` — минуты;</li><li>`HOURS` — часы;</li><li>`DAYS` — дни;</li><li>`WEEKS` — недели;</li><li>`MONTHS` — месяцы.</li></ul> |
  | `scheduling.randMaxDelay.count` | Значение максимальной задержки между запуском параллельных задач в единицах времени, заданных атрибутом `randMaxDelay.type`. Задержка определяется случайным образом, но не превышает заданного здесь значения. | Целое число. |
  | `scheduling.scheme` | Схема расписания резервного копирования. | <ul><li>`SCHEME_UNSPECIFIED` — не задано;</li><li>`SIMPLE` — простая;</li><li>`ALWAYS_FULL` — всегда полная;</li><li>`ALWAYS_INCREMENTAL` — всегда инкрементальная;</li><li>`WEEKLY_INCREMENTAL` — еженедельно: инкрементальная;</li><li>`WEEKLY_FULL_DAILY_INCREMENTAL` — еженедельно: полная, ежедневно: инкрементальная;</li><li>`CUSTOM` — пользовательская;</li><li>`CDP` — Continuous Data Protection, непрерывная защита данных.</li></ul> |
  | `scheduling.weeklyBackupDay` | День недели, в который будут выполняться еженедельные операции копирования. | Целое число от 1 до 7. |

{% endlist %}