## JavaScript {#javascript}

### General information {#info}

As a result of executing the JavaScript tab, data required for rendering (a set of) geo objects should be exported.

### Available methods {#methods}

* **`ChartEditor.getParams()`**: Returns an object with normalized parameters.

* **`ChartEditor.getLoadedData()`**: Returns an object with data requested in the URLs tab.

* **`ChartEditor.updateHighchartsConfig(config)`**: Extends the definition of the [Yandex Maps](ymap.md) tab output with the `config` object.

### Simple geo objects {#simple-objects}

Description from the [Yandex Maps API](https://tech.yandex.ru/maps/doc/jsapi/2.1/dg/concepts/geoobjects-docpage#geoobjects__geometry).
The following custom parameters are available for all the geo objects listed below:
```js
{
    feature: {
        properties: {
            // tooltip/hint title
            name: 'Point',
            // value
            value: Math.random(),
            // tooltip/hint text
            text: 'random number'
            // use HTML
            rawText: true
        }
    }
}
```

* 
   ### Label {#label}

   [Available parameters](https://tech.yandex.ru/maps/doc/jsapi/2.1/ref/reference/Placemark-docpage#Placemark__constructor-summary) descriptions.

   #### Simple example {#example-simple}

   **JavaScript** tab
   ```js
   module.exports = [{
       feature: {
           geometry: {
               type: 'Point',
               coordinates: [55.98, 37.59]
           },
           properties: {
               name: 'Point',
               value: Math.random(),
               text: 'random number',
               iconContent: Math.random()
           }
       },
       options: {
           preset: "islands#blueStretchyIcon",
       }
   }];
   ```

   [Label chart](https://tech.yandex.ru/maps/doc/jsapi/2.1/dg/concepts/geoobjects-docpage#geoobjects__piechart) descriptions.

   #### Chart example {#example-diagram}

   **JavaScript** tab
   ```js
   module.exports = [{
       feature: {
           geometry: {
               type: 'Point',
               coordinates: [55.80, 38.37]
           },
           properties: {
               name: 'Chart',
               data: [
                   {weight: 52, color: '#FFA002', text: 'orange'},
                   {weight: 42, color: '#880011', text: 'red'},
                   {weight: 23, color: '#035201', text: 'green'},
                   {weight: 12, color: '#002f55', text: 'blue'}
               ]
           }
       },
       options: {
           iconLayout: 'default#pieChart',
       }
   }];
   ```

* 
   ### Polyline {#polyline}

   [Available parameters](https://tech.yandex.ru/maps/doc/jsapi/2.1/ref/reference/Polyline-docpage#Polyline__constructor-summary) descriptions.

   #### Example {#polyline-example}

   **JavaScript** tab
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

* 
   ### Rectangle {#rectangle}

   [Available parameters](https://tech.yandex.ru/maps/doc/jsapi/2.1/ref/reference/Rectangle-docpage#Rectangle__constructor-summary) descriptions.

   #### Example

   **JavaScript** tab
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

* 
   ### Polygon {#polygon}

   [Available parameters](https://tech.yandex.ru/maps/doc/jsapi/2.1/ref/reference/Polygon-docpage#Polygon__constructor-summary) descriptions.

   #### Example {#polygon-example}

   **JavaScript** tab
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

* 
   ### Circle {#circle}

   [Available parameters](https://tech.yandex.ru/maps/doc/jsapi/2.1/ref/reference/Circle-docpage#Circle__constructor-summary) descriptions.

   #### Example {#circle-example}

   **JavaScript** tab
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

### Simple geo object collections {#object-collections}

Description from the [Yandex Maps API](https://tech.yandex.ru/maps/doc/jsapi/2.1/dg/concepts/geoobjects-docpage#geoobjects__geoobject_collections).

#### Example {#object-collections-example}

**JavaScript** tab
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
                    name: 'first'
                }
            }
        }, {
            feature: {
                geometry: {
                    type: 'Point',
                    coordinates: [55.45, 38.51]
                },
                properties: {
                    name: 'second'
                }
            }
        }, {
            feature: {
                geometry: {
                    type: 'Point',
                    coordinates: [55.40, 38.40]
                },
                properties: {
                    name: 'third'
                }
            }
        }]
    },
    options: {
        preset: 'islands#redIcon',
    }
}];
```

### Clusters {#clusters}

Description from the [Yandex Maps API](https://tech.yandex.ru/maps/doc/jsapi/2.1/dg/concepts/geoobjects-docpage#geoobjects__clusters).

#### Example {#clusters-example}

**JavaScript** tab
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

### Maps {#maps}

* 
   ### Areas {#areas}

   [Available parameters](https://a.yandex-team.ru/arcadia/data-ui/ymaps-polygonmap/README.md) descriptions.
   You can find the available sets of polygons that describe the territorial division in the `libs/ymaps` directory.

   #### Example with points {#areas-example-dots}

   **JavaScript** tab
   ```js
   module.exports = [{
       polygonmap: {
           // polygon array
           polygons: {
               type: 'FeatureCollection',
               features: [
                   {
                       type: 'Feature',
                       properties: {NAME: '~Arbat'},
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
                       properties: {NAME: '~Khamovniki',},
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
           // point array
           // possible formats: [coordinate, coordinate] and [coordinate, coordinate, weight]
           points: [
               [55.73511657784135, 37.59335767139491], // Park Kultury metro station
               [55.74768241559783, 37.58380830408787], // Smolenskaya metro station
               [55.75204787494789, 37.60133687223948], // Arbatskaya metro station
               [55.75249088434589, 37.604219718514926] // Arbatskaya metro station
           ]
       },
       options: {
           // a field from properties to be used as a title
           nameProperty: 'NAME',
           // text of values
           valuesText: 'Visitors',
           // number of color ranges
           colorRanges: 2,
           // custom color ranges
           colorScheme: ['#4a148c', '#f3e5f5']
       }
   }];
   ```

   #### Example with values {#areas-example-values}

   **JavaScript** tab
   ```js
   module.exports = [
       {
           polygonmap: {
               // polygon array
               polygons: {
                   type: 'FeatureCollection',
                   features: [
                       {
                           type: 'Feature',
                           properties: {NAME: '~Arbat', OKATO: '45286590'},
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
                           properties: {NAME: '~Khamovniki', OKATO: '45286552'},
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
               // value array
               values: [
                   {OKATO: '45286590', value: 16},
                   {OKATO: '45286552', value: 64},
               ]
           },
           options: {
               // a common field in properties for polygons and in values for matching
               joinByProperty: 'OKATO',
               // a field from properties to be used as a title
               nameProperty: 'NAME',
               // text of values
               valuesText: 'Power of two',
               // show legend
               showLegend: false
           }
       }
   ];
   ```

* 
   ### Grid {#grid}

   [Available parameters](https://a.yandex-team.ru/arcadia/data-ui/ymaps-gridmap/README.md) descriptions.

   #### Example {#grid-example}

   **JavaScript** tab
   ```js
   module.exports = [{
       // point array
       // possible formats: [coordinate, coordinate] and [coordinate, coordinate, weight]
       gridmap: [
           [55.733833225240865, 37.58814345706995, 1], // Yandex
           [55.73511657784135, 37.59335767139491, 2], // Park Kultury metro station
           [55.74768241559783, 37.58380830408787, 3], // Smolenskaya metro station
           [55.75204787494789, 37.60133687223948, 4], // Arbatskaya metro station
           [55.75249088434589, 37.604219718514926, 5] // Arbatskaya metro station
       ],
       options: {
           // text of values
           valuesText: 'Visitors',

           // Area options
           // 'weight' - Determine the color by point weight
           // 'points' - Determine the color by the number of points
           fillBy: 'weight',
           // color scheme
           colorScheme: 'summer',

           // Grid options
           // zoom to be used to calculate the grid
           zoom: 10,
           // grid settings
           grid: {
               // type
               type: 'square',
               // side length
               params: {sideLength: 20}
           },
           // grid: {
           //     // type
           //     type: 'hexagon',
           //     // radius
           //     params: {bigRadius: 20,}
           // }
       }
   }];
   ```

* 
   ### Heat map {#heatmap}

   [Available parameters](https://github.com/yandex/mapsapi-heatmap/blob/84946349b7b54bf20ea630e7077da09ee7c85dfb/README.md#heatmap-constructor) descriptions.

   #### Example {#heatmap-example}

   **JavaScript** tab
   ```js
   module.exports = [{
       // point array
       // [coordinate, coordinate]
       heatmap: [
           [55.733833225240865, 37.58814345706995], // Yandex
           [55.73511657784135, 37.59335767139491], // Park Kultury metro station
           [55.74768241559783, 37.58380830408787], // Smolenskaya metro station
           [55.75204787494789, 37.60133687223948], // Arbatskaya metro station
           [55.75249088434589, 37.604219718514926] // Arbatskaya metro station
       ],
       // point array
       // weighted points
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
           // radius of influence
           radius: 8,
           // whether to reduce point pixel sizes when zooming out
           // false - No
           dissipating: false,
           // heatmap opacity
           opacity: 0.8,
           // intensity of the mid point by point weight
           intensityOfMidpoint: 0.2,
           // gradient description
           gradient: {
               0.1: 'rgba(128, 255, 0, 0.7)',
               0.2: 'rgba(255, 255, 0, 0.8)',
               0.7: 'rgba(234, 72, 58, 0.9)',
               1.0: 'rgba(162, 36, 25, 1)'
           }
       }
   }];
   ```
