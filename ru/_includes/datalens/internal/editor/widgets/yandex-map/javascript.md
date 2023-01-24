## JavaScript {#javascript}

### Общая информация {#info}

В результате выполнения вкладки JavaScript должны быть экспортированы данные для отрисовки (набора) геобъектов.

### Доступные методы {#methods}

* **`ChartEditor.getParams()`** — возвращает объект с нормализованными параметрами.

* **`ChartEditor.getLoadedData()`** — возвращает объект с данными, запрошенными на вкладке Urls.

* **`ChartEditor.updateHighchartsConfig(config)`** — доопределяет результат вкладки [Yandex Maps](ymap.md) объектом `config`.

### Простые геобъекты {#simple-objects}

Описание из [API Яндекс Карт](https://tech.yandex.ru/maps/doc/jsapi/2.1/dg/concepts/geoobjects-docpage#geoobjects__geometry).
Для всех перечисленных ниже геобъектов доступны следующие кастомные параметры:
```js
{
    feature: {
        properties: {
            // заголовок тултипа/хинта
            name: 'Точка',
            // значение
            value: Math.random(),
            // текст тултипа/хинта
            text: 'случайное число'
            // использовать HTML
            rawText: true
        }
    }
}
```

  * ### Метка {#label}

    Описание [доступных параметров](https://tech.yandex.ru/maps/doc/jsapi/2.1/ref/reference/Placemark-docpage#Placemark__constructor-summary).

    #### Простой пример {#example-simple}

    Вкладка **JavaScript**
    ```js
    module.exports = [{
        feature: {
            geometry: {
                type: 'Point',
                coordinates: [55.98, 37.59]
            },
            properties: {
                name: 'Точка',
                value: Math.random(),
                text: 'случайное число',
                iconContent: Math.random()
            }
        },
        options: {
            preset: "islands#blueStretchyIcon",
        }
    }];
    ```

    Описание [меток-диаграмм](https://tech.yandex.ru/maps/doc/jsapi/2.1/dg/concepts/geoobjects-docpage#geoobjects__piechart).

    #### Пример диаграммы {#example-diagram}

    Вкладка **JavaScript**
    ```js
    module.exports = [{
        feature: {
            geometry: {
                type: 'Point',
                coordinates: [55.80, 38.37]
            },
            properties: {
                name: 'Диаграмма',
                data: [
                    {weight: 52, color: '#FFA002', text: 'оранжевый'},
                    {weight: 42, color: '#880011', text: 'красный'},
                    {weight: 23, color: '#035201', text: 'зеленый'},
                    {weight: 12, color: '#002f55', text: 'синий'}
                ]
            }
        },
        options: {
            iconLayout: 'default#pieChart',
        }
    }];
    ```

  * ### Ломаная линия {#polyline}

    Описание [доступных параметров](https://tech.yandex.ru/maps/doc/jsapi/2.1/ref/reference/Polyline-docpage#Polyline__constructor-summary).

    #### Пример {#polyline-example}

    Вкладка **JavaScript**
    ```js
    module.exports = [{
        feature: {
            geometry: {
                type: 'LineString',
                coordinates: [
                    [55.80, 37.00],
                    [55.80, 37.10],
                    [55.70, 37.00],
                    [55.70, 37.10]
                ]
            },
            properties: {}
        },
        options: {
            strokeWidth: 5
        }
    }];
    ```

  * ### Прямоугольник {#rectangle}

    Описание [доступных параметров](https://tech.yandex.ru/maps/doc/jsapi/2.1/ref/reference/Rectangle-docpage#Rectangle__constructor-summary).

    #### Пример

    Вкладка **JavaScript**
    ```js
    module.exports = [{
        feature: {
            geometry: {
                type: 'Rectangle',
                coordinates: [[55.40, 37.00], [55.50, 37.40]]
            },
            properties: {}
        },
        options: {}
    }];
    ```

  * ### Многоугольник {#polygon}

    Описание [доступных параметров](https://tech.yandex.ru/maps/doc/jsapi/2.1/ref/reference/Polygon-docpage#Polygon__constructor-summary).

    #### Пример {#polygon-example}

    Вкладка **JavaScript**
    ```js
    module.exports = [{
        feature: {
            geometry: {
                type: 'Polygon',
                coordinates: [
                    [[55.45, 37.50], [55.45, 37.71], [55.40, 37.70]],
                    [[55.43, 37.58], [55.42, 37.70], [55.40, 37.70]]
                ]
            },
            properties: {}
        },
        options: {}
    }];
    ```

  * ### Круг {#circle}

    Описание [доступных параметров](https://tech.yandex.ru/maps/doc/jsapi/2.1/ref/reference/Circle-docpage#Circle__constructor-summary).

    #### Пример {#circle-example}

    Вкладка **JavaScript**
    ```js
    module.exports = [{
        feature: {
            geometry: {
                type: 'Circle',
                coordinates: [55.74, 37.61],
                radius: 20000
            },
            properties: {}
        },
        options: {
            fillColor: '#990066',
            opacity: 0.5
        }
    }];
    ```

### Коллекции простых геообъектов {#object-collections}

Описание из [API Яндекс Карт](https://tech.yandex.ru/maps/doc/jsapi/2.1/dg/concepts/geoobjects-docpage#geoobjects__geoobject_collections).

#### Пример {#object-collections-example}

Вкладка **JavaScript**
```js
module.exports = [{
    collection: {
        children: [{
            feature: {
                geometry: {
                    type: 'Point',
                    coordinates: [55.45, 38.20]
                },
                properties: {
                    name: 'первый'
                }
            }
        }, {
            feature: {
                geometry: {
                    type: 'Point',
                    coordinates: [55.45, 38.51]
                },
                properties: {
                    name: 'второй'
                }
            }
        }, {
            feature: {
                geometry: {
                    type: 'Point',
                    coordinates: [55.40, 38.40]
                },
                properties: {
                    name: 'третий'
                }
            }
        }]
    },
    options: {
        preset: 'islands#redIcon',
    }
}];
```

### Кластеры {#clusters}

Описание из [API Яндекс Карт](https://tech.yandex.ru/maps/doc/jsapi/2.1/dg/concepts/geoobjects-docpage#geoobjects__clusters).

#### Пример {#clusters-example}

Вкладка **JavaScript**
```js
module.exports = [{
    clusterer: [{
        feature: {
            geometry: {
                type: 'Point',
                coordinates: [56.023, 36.988]
            }
        }
    }, {
        feature: {
            geometry: {
                type: 'Point',
                coordinates: [56.025, 36.981]
            }
        }
    }, {
        feature: {
            geometry: {
                type: 'Point',
                coordinates: [56.020, 36.981]
            }
        }
    }, {
        feature: {
            geometry: {
                type: 'Point',
                coordinates: [56.021, 36.983]
            }
        }
    }, {
        feature: {
            geometry: {
                type: 'Point',
                coordinates: [56.027, 36.987]
            }
        }
    }],
    options: {
        clusterDisableClickZoom: false
    }
}];
```

### Карты {#maps}

  * ### Области {#areas}

    Описание [доступных параметров](https://a.yandex-team.ru/arcadia/data-ui/ymaps-polygonmap/README.md).
    Доступные наборы полигонов, описывающие территориальное деление можно найти в папке `libs/ymaps`.

    #### Пример с точками {#areas-example-dots}

    Вкладка **JavaScript**
    ```js
    module.exports = [{
        polygonmap: {
            // массив полигонов
            polygons: {
                type: 'FeatureCollection',
                features: [
                    {
                        type: 'Feature',
                        properties: {NAME: '~Арбат'},
                        geometry: {
                            type: 'Polygon',
                            coordinates: [[
                                [55.75477548828043, 37.57627272781645],
                                [55.74635243510465, 37.576101066439506],
                                [55.74867621840859, 37.609575034945365],
                                [55.75671156415544, 37.61129164871488],
                                [55.75477548828043, 37.57627272781645]
                            ]]
                        }
                    },
                    {
                        type: 'Feature',
                        properties: {NAME: '~Хамовники',},
                        geometry: {
                            type: 'Polygon',
                            coordinates: [[
                                [55.738390016974, 37.57386946853912],
                                [55.72570098325864, 37.57438445266996],
                                [55.72657288144814, 37.61009001907623],
                                [55.73955216412115, 37.60888838943755],
                                [55.738390016974, 37.57386946853912]
                            ]]
                        }
                    }
                ]
            },
            // массив точек
            // одни из доступных форматов: [координата, координата] и [координата, координата, вес]
            points: [
                [55.73511657784135, 37.59335767139491], // м. Парк культуры
                [55.74768241559783, 37.58380830408787], // м. Смоленская
                [55.75204787494789, 37.60133687223948], // м. Арбатская
                [55.75249088434589, 37.604219718514926] // м. Арбатская
            ]
        },
        options: {
            // поле из properties, которое будет использоваться как заголовок
            nameProperty: 'NAME',
            // текст значений
            valuesText: 'Посетители',
            // количество цветовых интервалова
            colorRanges: 2,
            // кастомные цветовые интервалы
            colorScheme: ['#4a148c', '#f3e5f5']
        }
    }];
    ```

    #### Пример со значениями {#areas-example-values}

    Вкладка **JavaScript**
    ```js
    module.exports = [
        {
            polygonmap: {
                // массив полигонов
                polygons: {
                    type: 'FeatureCollection',
                    features: [
                        {
                            type: 'Feature',
                            properties: {NAME: '~Арбат', OKATO: '45286590'},
                            geometry: {
                                type: 'Polygon',
                                coordinates: [[
                                    [55.75477548828043, 37.57627272781645],
                                    [55.74635243510465, 37.576101066439506],
                                    [55.74867621840859, 37.609575034945365],
                                    [55.75671156415544, 37.61129164871488],
                                    [55.75477548828043, 37.57627272781645]
                                ]]
                            }
                        },
                        {
                            type: 'Feature',
                            properties: {NAME: '~Хамовники', OKATO: '45286552'},
                            geometry: {
                                type: 'Polygon',
                                coordinates: [[
                                    [55.738390016974, 37.57386946853912],
                                    [55.72570098325864, 37.57438445266996],
                                    [55.72657288144814, 37.61009001907623],
                                    [55.73955216412115, 37.60888838943755],
                                    [55.738390016974, 37.57386946853912]
                                ]]
                            }
                        }
                    ]
                },
                // массив значений
                values: [
                    {OKATO: '45286590', value: 16},
                    {OKATO: '45286552', value: 64},
                ]
            },
            options: {
                // общее поле в properties у polygons и в values для матчинга
                joinByProperty: 'OKATO',
                // поле из properties, которое будет использоваться как заголовок
                nameProperty: 'NAME',
                // текст значений
                valuesText: 'Степень двойки',
                // показывать легенду
                showLegend: false
            }
        }
    ];
    ```

  * ### Сетка {#grid}

    Описание [доступных параметров](https://a.yandex-team.ru/arcadia/data-ui/ymaps-gridmap/README.md).

    #### Пример {#grid-example}

    Вкладка **JavaScript**
    ```js
    module.exports = [{
        // массив точек
        // одни из доступных форматов: [координата, координата] и [координата, координата, вес]
        gridmap: [
            [55.733833225240865, 37.58814345706995, 1], // Яндекс
            [55.73511657784135, 37.59335767139491, 2], // м. Парк культуры
            [55.74768241559783, 37.58380830408787, 3], // м. Смоленская
            [55.75204787494789, 37.60133687223948, 4], // м. Арбатская
            [55.75249088434589, 37.604219718514926, 5] // м. Арбатская
        ],
        options: {
            // текст значений
            valuesText: 'Посетителей',

            // опции Областей
            // 'weight' - высчитывать цвет по весу точек
            // 'points' - высчитывать цвет по количеству точек
            fillBy: 'weight',
            // цветовая схема
            colorScheme: 'summer',

            // опции Сетки
            // зум, который будет использоваться для расчета сетки
            zoom: 10,
            // настройки сетки
            grid: {
                // тип
                type: 'square',
                // длина стороны
                params: {sideLength: 20}
            },
            // grid: {
            //     // тип
            //     type: 'hexagon',
            //     // радиус
            //     params: {bigRadius: 20,}
            // }
        }
    }];
    ```

  * ### Тепловая карта {#heatmap}

    Описание [доступных параметров](https://github.com/yandex/mapsapi-heatmap/blob/84946349b7b54bf20ea630e7077da09ee7c85dfb/README.md#heatmap-constructor).

    #### Пример {#heatmap-example}

    Вкладка **JavaScript**
    ```js
    module.exports = [{
        // массив точек
        // [координата, координата]
        heatmap: [
            [55.733833225240865, 37.58814345706995], // Яндекс
            [55.73511657784135, 37.59335767139491], // м. Парк культуры
            [55.74768241559783, 37.58380830408787], // м. Смоленская
            [55.75204787494789, 37.60133687223948], // м. Арбатская
            [55.75249088434589, 37.604219718514926] // м. Арбатская
        ],
        // массив точек
        // взвешенные точки
        heatmap: [{
            type: 'Feature',
            geometry: {
                type: 'Point',
                coordinates: [55.781959059218, 37.554233969354]
            },
            properties: {
                weight: 1
            }
          }, {
            type: 'Feature',
            geometry: {
                type: 'Point',
                coordinates: [55.875538317095, 37.534865598329]
            },
            properties: {
                weight: 10
            }
        }],
        options: {
            // радиус влияния
            radius: 8,
            // нужно ли уменьшать пиксельный размер точек при уменьшении зума
            // false - не нужно
            dissipating: false,
            // прозрачность тепловой карты
            opacity: 0.8,
            // прозрачность у медианной по весу точки
            intensityOfMidpoint: 0.2,
            // описание градиента
            gradient: {
                0.1: 'rgba(128, 255, 0, 0.7)',
                0.2: 'rgba(255, 255, 0, 0.8)',
                0.7: 'rgba(234, 72, 58, 0.9)',
                1.0: 'rgba(162, 36, 25, 1)'
            }
        }
    }];
    ```
