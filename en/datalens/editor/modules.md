
# Modules

A module is a fragment of code that exports certain functions/variables/constants to be used in scripts.

Modules can be classified into two groups: custom modules and external libraries like [moment.js](https://momentjs.com)

## Custom modules {#user-modules}

You can extract useful code fragments from your  scripts and arrange them into modules, as well as use modules built by
other users.
For this, you need to import them in the tab where you want to use them, with the `require` function:

```js
const ClickHouse = require('Statbox/ClickHouse');
```

To learn more about creating custom modules, see the [Module](widgets/module/index.md) widget page.

## External libraries{#external-libraries}

We use a number of external libraries that are available in the `vendor` folder, adding new libraries to them by request.

### moment.js {#moment-js}

A library for managing time, dates, and time zones.
[Official site](https://momentjs.com/)

Current version: `v2.24`

```js
const moment = require('vendor/moment/v2.24');
```

Archived versions: `v2.21`, `v2.19`, `v2.17`

### lodash {#loadsh}

It simplifies your JavaScript code, removing the headache of handling arrays, numbers, objects, strings, and other related entities. [Official site](https://lodash.com/).

Current version: `v4.17`

```js
const lodash = require('vendor/lodash/v4.17');
```

### underscore {#underscore}

The Underscore library includes more than 100 functions: some of them solve standard tasks, for example, simplify operations with
connections and others enable more specific features, for example, functional binding,
JavaScript templating, equality tests (for instance, for objects), and so on. [Official site](http://underscorejs.org/).

Current version: `v1.9.1`

```js
const underscore = require('vendor/underscore/v1.9.1');
```

### tinyColor {#tinycolor}

This is a small and fast library for color management and conversion in JavaScript. [Official site](https://bgrins.github.io/TinyColor/)

Current version: `v1.4.1`

```js
const tinyColor = require('vendor/tinyColor/v1.4.1');
```

### regression {#regression}

A module for calculating trends. [Official site](http://tom-alexander.github.io/regression-js/)

Current version: `v1.4`

```js
const regression = require('vendor/regression/v1.4');
```
