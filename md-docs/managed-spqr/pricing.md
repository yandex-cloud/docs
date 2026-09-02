[Документация Yandex Cloud](../index.md) > [Yandex Managed Service for Sharded PostgreSQL](index.md) > Правила тарификации

# Правила тарификации для Managed Service for Sharded PostgreSQL

::: page-constructor
blocks:
  - type: card-layout-block
    animated: false
    colSizes:
      all: 12
      md: 6
    indent:
      top: '0'
      bottom: '0'
    children:
      - type: basic-card
        title: Калькулятор цен
        text: Рассчитайте стоимость использования сервиса, исходя из ваших потребностей
        gravityIcon: Calculator
        iconPosition: left
        urlTitle: Калькулятор цен
        url: https://yandex.cloud/ru/prices?state=44d352affb85#calculator
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Прайс-лист
        text: Актуальные тарифы на все наши услуги
        gravityIcon: CircleRuble
        iconPosition: left
        urlTitle: Прайс-лист
        url: https://yandex.cloud/ru/price-list?services=dn2sdm5cvhv4serguw5l
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
:::




В этом разделе описаны [правила](#rules), по которым тарифицируется использование сервиса Managed Service for Sharded PostgreSQL, и представлены [актуальные цены](#prices) на предоставляемые им ресурсы.


Все цены в рублях и тенге указаны с НДС, все цены в долларах — без НДС.

## Статус кластера {#running-stopped}

В зависимости от статуса кластера тарифы применяются различным образом:

* Для запущенного кластера (`Running`) тарифицируются как вычислительные ресурсы, так и объем хранилища и резервных копий.
* Для остановленного кластера (`Stopped`) тарифицируется только объем хранилища и резервных копий.

{% note alert %}

Если кластер использует хранилище на локальных SSD-дисках (`local-ssd`), то вычислительные ресурсы кластера не освобождаются при его остановке. Поэтому даже остановленный кластер будет тарифицироваться в полном объеме.

{% endnote %}

## Из чего складывается стоимость использования Managed Service for Sharded PostgreSQL {#rules}

Расчет стоимости использования Managed Service for Sharded PostgreSQL учитывает:

* тип диска и размер хранилища;

* вычислительные ресурсы, выделенные хостам кластера;

* настройки и количество резервных копий;

* объем исходящего трафика из Yandex Cloud в интернет.

Во всех расчетах 1 ГБ = 2<sup>30</sup> байт, 1 МБ = 2<sup>20</sup> байт.

### Использование хостов БД {#rules-hosts-uptime}

Стоимость начисляется за каждый час работы хоста в соответствии с его классом. Точные характеристики классов приведены в разделе [Классы хостов](concepts/instance-types.md).

Минимальная единица тарификации — минута (например, стоимость 1,5 минут работы хоста равна стоимости 2 минут). Время, когда хост не может выполнять свои основные функции, не тарифицируется.

### Использование дискового пространства {#rules-storage}

Оплачивается:

* Размер хранилища, выделенный для кластеров БД.

    * Хранилище на локальных SSD-дисках (`local-ssd`) можно заказывать только для кластеров с тремя хостами и более:

        * для платформы Intel Cascade Lake — с шагом 100 ГБ;
        * для платформы Intel Ice Lake — с шагом 368 ГБ.

    * Хранилище на нереплицируемых SSD-дисках (`network-ssd-nonreplicated`) можно заказывать только для кластеров с тремя хостами и более, с шагом 93 ГБ.

* Объем, занимаемый резервными копиями баз данных сверх заданного хранилища для кластера.

    {% note info %}

    Объем хранилища кластера равен суммарному объему хранилищ всех его хостов.

    {% endnote %}

    * Хранение резервных копий не тарифицируется, пока их суммарный объем не превышает суммарный объем хранилищ хостов кластера. Объем, занимаемый данными самой базы данных, в этом расчете не учитывается.

    * Если сумма всех резервных копий становится больше размера хранилища кластера, тарифицируется только превышение этого размера. 

Подробнее в разделе [Резервные копии в Managed Service for Sharded PostgreSQL](concepts/backup.md).

Минимальная единица тарификации — 1 ГБ в минуту (например, стоимость хранения 1 ГБ в течение 1,5 минут равна стоимости хранения в течение 2 минут).

## Скидка за резервируемый объем ресурсов (CVoS) {#cvos}

Вы можете получить гарантированную скидку за потребление ресурсов сервиса, запланированное на 6 месяцев или 1 год вперед. Чтобы посмотреть ресурсы, для которых можно получить такую скидку:

1. Перейдите в раздел [**Yandex Cloud Billing**](https://center.yandex.cloud/billing/accounts).
1. Нажмите на нужный платежный аккаунт.
1. Выберите раздел ![image](../_assets/console-icons/lock.svg) **Резервируемый объём** в меню слева.

Механизм CVoS гарантирует скидку на потребление, но не гарантирует наличие заказанного объема ресурсов.  Подробнее о механизме работы CVoS читайте в [документации сервиса Yandex Cloud Billing](../billing/concepts/cvos.md).

Сервис Managed Service for Sharded PostgreSQL предоставляет CVoS двух видов: на vCPU и RAM для хостов, которые вы планируете использовать в кластерах БД. В консоли управления вы можете увидеть потенциальную экономию для текущего потребления ресурсов при переводе их на схему CVoS, а также предварительно рассчитать месячные платежи для нужного количества ядер процессора и оперативной памяти.

{% note info %}

По схеме CVoS можно заказать только ресурсы определенного вида: для недоступных видов ресурсов в колонках CVoS в разделе [Цены](#prices) стоят прочерки. Размер хранилища и интернет-трафика заказать таким образом пока невозможно.

{% endnote %}

## Цены для региона Россия {#prices}

{% note info %}

Цены на ресурсы Yandex Cloud в разных регионах различаются. Подробнее о доступных регионах в разделе [Регионы](../overview/concepts/region.md).

Валюта, которой можно оплачивать ресурсы, зависит от юридического лица, с которым пользователь заключил договор. Подробнее о регистрации аккаунта в разделе [Регистрация аккаунта в Yandex Cloud](../billing/quickstart/index.md).

{% endnote %}

Цены за месяц использования формируются из расчета 720 часов в месяц.

{% note info %}

Доступ к платформе **Intel Ice Lake (Compute Optimized)** предоставляется по запросу. Обратитесь в [техническую поддержку](https://center.yandex.cloud/support) или к вашему аккаунт-менеджеру.

{% endnote %}

{% note info %}

Доступ к хранилищу на локальных SSD-дисках при использовании стандартных хостов на платформе **Intel Ice Lake** предоставляется по запросу. Обратитесь в [техническую поддержку](https://center.yandex.cloud/support) или к вашему аккаунт-менеджеру.

{% endnote %}


| Услуга                                                                                                                  | Цена      | Ед. тарификации | Действует с  | Действует до |
| ----------------------------------------------------------------------------------------------------------------------- | --------- | --------------- | ------------ | ------------ |
| Managed Service for Sharded PostgreSQL. Вычислительные ресурсы хостов, AMD Zen 4 HighFreq, 100% vCPU                    | 3,65 ₽    | vCPU × час      | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Вычислительные ресурсы хостов, AMD Zen 4 HighFreq, RAM                          | 0,7145 ₽  | ГБ × час        | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Вычислительные ресурсы хостов, AMD Zen 4, 100% vCPU                             | 1,8792 ₽  | vCPU × час      | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Вычислительные ресурсы хостов, AMD Zen 4, 100% vCPU, CVoS на 1 год              | 1,46 ₽    | vCPU × час      | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Вычислительные ресурсы хостов, AMD Zen 4, 100% vCPU, CVoS на 6 месяцев          | 1,59 ₽    | vCPU × час      | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Вычислительные ресурсы хостов, AMD Zen 4, RAM                                   | 0,5072 ₽  | ГБ × час        | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Вычислительные ресурсы хостов, AMD Zen 4, RAM, CVoS на 1 год                    | 0,3957 ₽  | ГБ × час        | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Вычислительные ресурсы хостов, AMD Zen 4, RAM, CVoS на 6 месяцев                | 0,43 ₽    | ГБ × час        | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Вычислительные ресурсы хостов, Intel Broadwell,  5% vCPU                        | 1,0892 ₽  | vCPU × час      | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Вычислительные ресурсы хостов, Intel Broadwell, 100% vCPU                       | 2,35 ₽    | vCPU × час      | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Вычислительные ресурсы хостов, Intel Broadwell, 20% vCPU                        | 1,0892 ₽  | vCPU × час      | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Вычислительные ресурсы хостов, Intel Broadwell, 50% vCPU                        | 1,0892 ₽  | vCPU × час      | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Вычислительные ресурсы хостов, Intel Broadwell, RAM                             | 0,5387 ₽  | ГБ × час        | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Вычислительные ресурсы хостов, Intel Cascade Lake, 100% vCPU                    | 2,08 ₽    | vCPU × час      | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Вычислительные ресурсы хостов, Intel Cascade Lake, 100% vCPU, CVoS на 1 год     | 1,62 ₽    | vCPU × час      | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Вычислительные ресурсы хостов, Intel Cascade Lake, 100% vCPU, CVoS на 6 месяцев | 1,77 ₽    | vCPU × час      | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Вычислительные ресурсы хостов, Intel Cascade Lake, 20% vCPU                     | 1,0892 ₽  | vCPU × час      | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Вычислительные ресурсы хостов, Intel Cascade Lake, 5% vCPU                      | 1,0892 ₽  | vCPU × час      | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Вычислительные ресурсы хостов, Intel Cascade Lake, 50% vCPU                     | 1,0892 ₽  | vCPU × час      | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Вычислительные ресурсы хостов, Intel Cascade Lake, RAM                          | 0,5649 ₽  | ГБ × час        | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Вычислительные ресурсы хостов, Intel Cascade Lake, RAM, CVoS на 1 год           | 0,44 ₽    | ГБ × час        | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Вычислительные ресурсы хостов, Intel Cascade Lake, RAM, CVoS на 6 месяцев       | 0,48 ₽    | ГБ × час        | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Вычислительные ресурсы хостов, Intel Ice Lake (Compute Optimized), 100% vCPU    | 3 ₽       | vCPU × час      | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Вычислительные ресурсы хостов, Intel Ice Lake (Compute Optimized), RAM          | 0,5879 ₽  | ГБ × час        | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Вычислительные ресурсы хостов, Intel Ice Lake, 100% vCPU                        | 1,8792 ₽  | vCPU × час      | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Вычислительные ресурсы хостов, Intel Ice Lake, 100% vCPU, CVoS на 1 год         | 1,46 ₽    | vCPU × час      | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Вычислительные ресурсы хостов, Intel Ice Lake, 100% vCPU, CVoS на 6 месяцев     | 1,59 ₽    | vCPU × час      | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Вычислительные ресурсы хостов, Intel Ice Lake, 50% vCPU                         | 1,0892 ₽  | vCPU × час      | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Вычислительные ресурсы хостов, Intel Ice Lake, RAM                              | 0,5072 ₽  | ГБ × час        | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Вычислительные ресурсы хостов, Intel Ice Lake, RAM, CVoS на 1 год               | 0,3956 ₽  | ГБ × час        | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Вычислительные ресурсы хостов, Intel Ice Lake, RAM, CVoS на 6 месяцев           | 0,43 ₽    | ГБ × час        | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Публичный IP-адрес                                                              | 0,2766 ₽  | IP-адрес × час  | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Резервные копии сверх размера хранилища                                         | 0,00307 ₽ | ГБ × час        | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Сверхбыстрое сетевое хранилище с тремя репликами (SSD)                          | 0,0365 ₽  | ГБ × час        | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Хранилище на локальных SSD-дисках                                               | 0,0198 ₽  | ГБ × час        | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Хранилище на нереплицируемых SSD-дисках                                         | 0,0147 ₽  | ГБ × час        | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Хранилище на сетевых HDD-дисках                                                 | 0,0052 ₽  | ГБ × час        | 16 июня 2026 | —            |
| Managed Service for Sharded PostgreSQL. Хранилище на сетевых SSD-дисках                                                 | 0,0218 ₽  | ГБ × час        | 16 июня 2026 | —            |



### Исходящий трафик {#prices-traffic}

При использовании сервиса оплачивается исходящий трафик из Yandex Cloud в интернет. Передача трафика между сервисами Yandex Cloud по внутренним адресам, как и входящий трафик из интернета, не тарифицируется.

Каждый месяц не тарифицируются первые 100 ГБ исходящего трафика.

Минимальная единица тарификации — 1 МБ.


| Услуга                                                    | Цена              | Ед. тарификации | Действует с    | Действует до |
| --------------------------------------------------------- | ----------------- | --------------- | -------------- | ------------ |
| Исходящий трафик, от 0 до 100 единицы тарификации в месяц | Не тарифицируется | ГБ              | 30 апреля 2026 | —            |
| Исходящий трафик, от 100 единицы тарификации в месяц      | 1,42 ₽            | ГБ              | 30 апреля 2026 | —            |