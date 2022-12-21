## JavaScript {#javascript}

### General information {#common}

As a result of executing the JavaScript tab, objects/functions/variables/constants should be exported.

### Example {#example}

```js
// define the constant PI with two decimal places
const PI = Math.PI.toFixed(2);

// define a function that returns a random number from 0 to 1
function getRandom() {
    return Math.random();
}

// export the object with the constant and function
module.exports = {
    PI,
    getRandom
};
```

This way, you can export only constant

```js
module.exports = PI;
```

or only the function

```js
module.exports = getRandom;
```
