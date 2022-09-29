# Схема дашборда

* Все `id` (вкладок, элементов, табов чартов (элемент типа `widget`)) в рамках схемы должны быть уникальными
* Каждый элемент (`items`) должен иметь соответствующую запись в схеме (`layout`)
* На данный момент `namespace` всех элементов (`items`) должен быть равен `default` и в `alises` может быть единственное свойство `default`
* В связях (`connections`) могут участвовать только пара селекторов (элементы типа `control`) или селектор и таб чарта (элемент типа `widget`)

```json
{
  // описание дашборда
  "description": "Dashboard description",

  // текст, показываемый при отсутствии прав доступа к дашборду
  "accessDescription": "Message when access restricted",

  // текст, показываемый при обращении в поддержку
  "supportDescription": "Message on contact support",
  
  // вкладки
  // обязательное
  "tabs": [
    {
      // обязательное
      "id": "WR",

      // заголовок
      // обязательное
      "title": "Sales",

      // элементы
      // обязательное
      "items": [
        {
          // обязательное
          "id": "7r5",

          // тип элемента
          // обязательное
          "type": "title",

          // обязательное
          "namespace": "default",

          // данные элемента типа title
          // обязательное
          "data": {
            // размер: xs, s, m, l
            // обязательное
            "size": "l",

            // текст
            // обязательное
            "text": "Sales",

            // отображать в оглавлении
            "showInTOC": true
          }
        },
        {
          // обязательное
          "id": "Gv",

          // тип элемента
          // обязательное
          "type": "text",

          // обязательное
          "namespace": "default",

          // данные элемента типа text
          // обязательное
          "data": {
            // текст
            // обязательное
            "text": "Пример дашборда построенный по данным Sample SuperStore."
          }
        },
        {
          // обязательное
          "id": "Xb",

          // тип элемента
          // обязательное
          "type": "widget",

          // обязательное
          "namespace": "default",

          // данные элемента типа widget
          // обязательное
          "data": {
            // скрыть заголовок (только для случая если в tabs один элемент)
            "hideTitle": false,

            // табы
            // обязательное
            "tabs": [
              {
                // обязательное
                "id": "xq",

                // заголовок
                // обязательное
                "title": "Sales dynamics by Region",

                // параметры по умолчанию
                "params": {},

                // id чарта
                // обязательное
                "chartId": "rj9ym88l5zd8q",

                // является ли вкладкой по умолчанию
                "isDefault": true,

                "description": ""
              }
            ]
          }
        },
        {
          // обязательное
          "id": "wz",

          // тип элемента
          // обязательное
          "type": "control",

          // обязательное
          "namespace": "default",

          // данные элемента типа control
          // обязательное
          "data": {
            // заголовок
            // обязательное
            "title": "Segment",

            // тип источника
            // обязательное
            "sourceType": "dataset",

            // данные источника типа dataset
            // обязательное
            "source": {
              // показывать заголовок
              "showTitle": true,

              // id датасета (только для "sourceType": "dataset")
              // обязательное
              "datasetId": "aoetfany4sy88",

              // id поля датасета (только для "sourceType": "dataset")
              // обязательное
              "datasetFieldId": "b9024e08-70ca-402e-9236-ec1e63a3e91b",

              // тип элемента
              // обязательное
              "elementType": "select",

              // множественный выбор (только для "elementType": "select")
              "multiselectable": true,

              // значение по умолчанию
              // (для "elementType": "select")
              "defaultValue": ["Consumer"]

              // (для "elementType": "date")
              // "defaultValue": "__interval_2014-01-01_2014-01-31"
            }
          },

          // параметры по умолчанию
          // обязательное (для "type": "control")
          "defaults": {
            "b9024e08-70ca-402e-9236-ec1e63a3e91b": ["Consumer"]
          }
        },
        {
          // обязательное
          "id": "9Ag",

          // тип элемента
          // обязательное
          "type": "control",

          // обязательное
          "namespace": "default",

          // данные элемента типа control
          // обязательное
          "data": {
            // заголовок
            // обязательное
            "title": "Date",

            // тип источника
            // обязательное
            "sourceType": "manual",

            // данные источника типа manual
            // обязательное
            "source": {
              // показывать заголовок
              "showTitle": true,

              // имя параметра (только для "sourceType": "manual")
              // обязательное
              "fieldName": "Date",

              // доступные значения (только для "sourceType": "manual")
              // (только для "elementType": "date")
              // обязательное
              "acceptableValues": {
                "to": "2017-12-31",
                "from": "2014-01-01"
              },

              // доступные значения (только для "sourceType": "manual")
              // (только для "elementType": "select")
              // обязательное
              // "acceptableValues": [{
              //   "title": "daily",
              //   "value": "daily"
              // }, ...],

              // тип элемента
              // обязательное
              "elementType": "date",

              // календарь на интервал (только для "elementType": "date")
              "isRange": true,

              // значение по умолчанию
              // (для "elementType": "date")
              "defaultValue": "__interval_2014-01-01_2014-01-31"

              // (для "elementType": "select")
              // "defaultValue": ["Consumer"]
            }
          },

          // параметры по умолчанию
          // обязательное (для "type": "control")
          "defaults": {
            "Date": "__interval_2014-01-01_2014-01-31"
          }
        },
        {
          // обязательное
          "id": "wmz",

          // тип элемента
          // обязательное
          "type": "control",

          // обязательное
          "namespace": "default",

          // данные элемента типа control
          // обязательное
          "data": {
            // заголовок
            // обязательное
            "title": "Sample External Selector",

            // тип источника
            // обязательное
            "sourceType": "external",

            // данные источника типа external
            // обязательное
            "source": {
              // id чарта типа селектор
              // обязательное
              "chartId": "az26sxbs6uga7"
            }
          },

          // параметры по умолчанию
          // обязательное (для "type": "control")
          "defaults": {
            "Date": "",
            "Category": ""
          }
        },
        ...
      ],

      // расположение элементов
      // обязательное
      "layout": [
        {
          // id элемента
          // обязательное
          "i": "Xb",

          // высота
          // обязательное
          "h": 14,

          // ширина
          // обязательное
          "w": 12,

          // обязательное
          "x": 21,

          // обязательное
          "y": 4
        },
        ...
      ],

      // обязательное
      "aliases": {
        // namespace
        "default": [
          // имена параметров
          [
            "Category",
            "b029ce50-4551-4267-9241-74c079c130d5"
          ],
          ...
        ]
      },

      // связи
      // обязательное
      "connections": [
        {
          // id элемента типа control или id таба элемента типа widget
          // обязательное
          "to": "wz",

          // id элемента типа control или id таба элемента типа widget
          // обязательное
          "from": "lRM",

          // вид связи
          // обязательное
          "kind": "ignore"
        },
        ...
      ]
    }
  ]
}
```
