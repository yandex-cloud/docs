---
author: vladd11
---

# Creating a Node.js function using TypeScript

Node.js doesn't support [TypeScript](https://www.typescriptlang.org/). Before uploading TypeScript code to {{ sf-name }}, you need to compile it in JavaScript.

1. Install [Node.js]{% if lang == "ru" %}(https://nodejs.org/ru/){% endif %}{% if lang == "en" %}(https://nodejs.org/en/){% endif %}.
1. Open your project directory.
1. Install [TypeScript](https://www.typescriptlang.org/download):
   ```
   npm install typescript --save-dev
   ```
1. Create a Typescript configuration:
   ```
   npx ts --init --preserveConstEnums --moduleResolution Node --isolatedModules --outDir build --strict false --target ES2021
   ```

   To use a different version of JavaScript, change the value of the `target` argument. The latest JavaScript version that can be specified depends on the Node.js version used:
   | Node.js version | Latest JavaScript version |
   |----|----|
   | 12 | ES2019 |
   | 14 | ES2020 |
   | 16 | ES2021 |

1. Compile a function:
   ```
   npx tsc
   ```
1. The `build` directory will appear in the project folder. Add its contents to a ZIP archive.
1. [Create a function](../operations/function/function-create.md).
1. [Create a function version](../operations/function/version-manage.md).
