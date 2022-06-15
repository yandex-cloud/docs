## JavaScript {#javascript}

### Общая информация {#common}

В результате выполнения вкладки JavaScript должны быть экспортированы объекты/функции/переменные/константы.

### Пример {#example}

```js
// определяем константу Пи с двумя знаками после запятой
const PI = Math.PI.toFixed(2);

// определяем фукнцию, которая возвращает случайное число между 0 и 1
function getRandom() {
    return Math.random();
}

// экпортируем объект с константой и функцией
module.exports = {
    PI,
    getRandom
};
```

Также можно экпортировать только константу

```js
module.exports = PI;
```

или только функцию

```js
module.exports = getRandom;
```
