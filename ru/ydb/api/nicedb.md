## Описание C++ интерфейса запросов к локальной БД.

Данная библиотека была сделана чтобы обеспечить удобную работу в терминах С++ типов, и их проверки во время компиляции. К примеру, чтобы нельзя было попытаться сохранить 256 в колонку с типом bool или ui8.
Благодаря темплейтной реализации, у библиотеки отсутствует какой либо оверхэд.

Поскольку читать примеры проще, чем абстрактное описание, данный текст весь построен на примерах.

### Пример описания схемы:
``` cpp 
// Основная структура схемы должна наследоваться от NIceDb::Schema
struct Schema : NIceDb::Schema {

    // Описание таблицы. Идентификатор указывается в параметре базового класса.
    // Имя таблицы будет соответствовать имени типа ("Transaction", ID:1).
    struct Transaction : Table<1> {
    
        // Описание колонки, параметры базового класса: идентификатор и тип колонки.
        // Идентификатор умышленно задается вручную, чтобы можно было перемещать и удалять колонки.
        // Имя колонки будет получено из имени типа.
        struct ID : Column<1, NScheme::TTypeIds::Uint64> {};
        
        // Указание значения по-умолчанию для колонки
        // (когда в БД лежит NULL, а его читают как значение через GetValue())
        struct Plan : Column<2, NScheme::TTypeIds::Uint64> { static constexpr ui64 Default = 1234; };

        // Описание колонки с типом ByteString, использующей кастомный тип для хренения данных.
        // Базовые акксесоры заданы в flat_cxx_database.h, но могут быть заданы снаружи путем специализации
        // метода TConvertTypeValue<>::ConvertFrom<>(). В данном примере, вся работа с этой колонкой будет
        // делаться используя тип yvector<TTabletId>.
        struct AffectedSet : Column<3, NScheme::TTypeIds::ByteString> { using Type = yvector<TTabletId>; };

        // Перечисление ключевых колонок.
        using Key = TableKey<ID>;
        
        // Перечисление вообще всех колонок таблицы.
        using Columns = TableColumns<ID, Plan, AffectedSet>;
    };

    struct Mediator : Table<2> {
        struct ID : Column<1, NScheme::TTypeIds::Uint64> {};

        // Указание колонки с таким же типом, как и у какой то другой колонки (полезно для "Foreign keys")
        struct TransactionID : Column<2, Transaction::ID::ColumnType> {};

        struct AffectedSet : Column<3, Transaction::AffectedSet::ColumnType> { using Type = yvector<TTabletId>; };

        // Составной ключ из нескольких колонок
        using Key = TableKey<ID, TransactionID>;
        using Columns = TableColumns<ID, TransactionID, AffectedSet>;
    };

    struct State : Table<3> {
        enum EKeyType {
            KeyLastPlanned,
        };

        // Колонка с типом - енумератором
        struct StateKey : Column<1, NScheme::TTypeIds::Uint64> { using Type = EKeyType; };

        // Опциональное указание кастомного имени колонки (вместо "StateValue" получится "Value")
        struct StateValue : Column<2, NScheme::TTypeIds::Uint64> { static Stroka GetColumnName(const Stroka&) { return "Value"; } };

        using Key = TableKey<StateKey>;
        using Columns = TableColumns<StateKey, StateValue>;

        // Возможность отключить автоматический precharge при чтении
        using Precharge = NoAutoPrecharge;
    };

    // Перечисление всех таблиц в этой схеме
    using Tables = SchemaTables<Transaction, Mediator, State>;
};
```
### Для материализации такой схемы в локальной БД нужно вызвать всего один метод
``` cpp
bool Execute(TTransactionContext &txc, const TActorContext&) {
    Schema::Tables::Materialize(txc.DB);
    return true;
}
```
### Для работы с БД используется инстанс класса TNiceDb
``` cpp
NIceDb::TNiceDb db(txc.DB);
```
Все операции над БД устроены по следующему принципу:
**<БД>.<Таблица>.<Ключ>.<Операция>**

### Вставка строки / апдейт колонки
``` cpp
NIceDb::TNiceDb db(txc.DB);

// NIceDb::TUpdate - операция по обновлению одной колонки (колонка задается темплейтом, значение колонки параметром)
// В Update() может быть передано произвольное количество апдейтов
// В данном примере мы в таблице Schema::State, в строке с ключом = 123 обновляем колонку Schema::State::StateValue в значение "abc" 
db.Table<Schema::State>().Key(123).Update(NIceDb::TUpdate<Schema::State::StateValue>("abc"));
// или
db.Table<Schema::State>().Key(123).Update<Schema::State::StateValue>("abc");

// множество значений:
db.Table<Schema::State>().Key(123).Update(NIceDb::TUpdate<Schema::State::StateValue1>("abc"), NIceDb::TUpdate<Schema::State::StateValue2>(13));
// или
db.Table<Schema::State>().Key(123).Update<Schema::State::StateValue1>("abc").Update<Schema::State::StateValue2>(13);
// или
db.Table<Schema::State>().Key(123).Update<Schema::State::StateValue1, Schema::State::StateValue2>("abc", 13);
```
### Удаление строки
``` cpp
NIceDb::TNiceDb db(txc.DB);

// В данном примере мы в таблице Schema::State, удаляем строку с ключом = 456 
db.Table<Schema::State>().Key(456).Delete();
```
### При чтении из БД создается инстанс класса Rowset, условно его можно представить так
``` cpp
class Rowset {
public:
    // Данные готовы. Если нет - нужно перезапускать транзакцию.
    bool IsReady() const;

    // Итератор стоит на правильной позиции и ключ совпадает.
    bool IsValid() const;

    // Конец rowset'а
    bool EndOfSet() const { return !IsValid(); }

    // Переход на следующую строку (если нет - данные не готовы и нужно перезапускать транзакцию).
    bool Next();

    // Проверяет, что для указанной колонки есть значение (не NULL)
    bool HaveValue<Column>() const;

    // Возвращает значение указанной колонки (в соответствии с типом схемы)
    auto GetValue<Column>() const;

    // Возвращает значение колонки, или default, если в колонке нет значения (NULL)
    auto GetValueOrDefault<Column>(auto default) const;

    // Возвращает ключ (как tuple из соответствующих значений колонок)
    tuple GetKey() const;
};
```
### Чтение из БД возможно при помощи нескольких операций, каждая из которых возвращает Rowset
``` cpp
// Чтение по полному совпадению ключа (если количество параметров соответствует количеству колонок в ключе)
db.Table<...>().Key(a,b,c).Select<...>();

// Чтение по частичному ключу (index range scan / key prefix) (если количество параметров меньше чем количество колонок в ключе)
db.Table<...>().Range(a,b).Select<...>();
// или
db.Table<...>().Prefix(a,b).Select<...>();

// Чтение всех строк (full table scan)
db.Table<...>().Range().Select<...>();
// или
db.Table<...>().All().Select<...>();
// или
db.Table<...>().Select<...>();

// Чтение по приципу "больше или равно"
db.Table<...>().GreaterOrEqual(a,b).Select<...>();

// ..."меньше или равно"
db.Table<...>().LessOrEqual(a,b).Select<...>();

// ... диапазон
db.Table<...>().GreaterOrEqual(a,b).LessOrEqual(c,d).Select<...>();
```
### В качестве параметров Select может быть как перечисление колонок (тогда будут выбранны только эти колонки), так и специальный класс - "все колонки" из схемы
``` cpp
// Более эффективный вариант
auto rowset = db.Table<Schema::Mediator>().Key(1234).Select<Schema::Mediator::ID, Schema::Mediator::TransactionID>();

// Более простой вариант
auto rowset = db.Table<Schema::Mediator>().Key(1234).Select<Schema::Mediator::Columns>();
// или
auto rowset = db.Table<Schema::Mediator>().Key(1234).Select();
```
### Типичный цикл чтения из БД
``` cpp
NIceDb::TNiceDb db(txc.DB);
auto rowset = db.Table<Schema::Node>().Key(123).Select<Schema::Node::Columns>();
if (!rowset.IsReady())
    return false;
while (!rowset.EndOfSet()) {
    TNodeId nodeId = rowset.GetValue<Schema::Node::ID>();
    TActorId local = rowset.GetValueOrDefault<Schema::Node::Local>(TActorId());
    if (!rowset.Next())
        return false;
}
```
На все операции чтения, по возможности, делается автоматический precharge. Его можно отключить настройкой на таблице и сделать самостоятельно (синтаксис такой же как у Select<>). Также, вся проверка типов, и маппинг колонок в позицию в роусетах происходят во время компиляции. Список колонок для выборки аллоцируется статически на каждую кобинацию выборки, один раз за все время выполнения.