---
author: vladd11
---

# Building Node.js function using TypeScript

Because Node.js doesn't support [TypeScript](https://www.typescriptlang.org/) natively, you need to compile TypeScript code to JavaScript. Then you will be able to upload and run your function in {{ sf-name }}.

1. Install [Node.js](https://nodejs.org/ru/).
1. Enter into your project's directory.
1. Install [TypeScript](https://www.typescriptlang.org/download):
    ```
    npm install typescript --save-dev
    ```
1. Initialize a TypeScript project:
    ```
    npx ts --init --preserveConstEnums --moduleResolution Node --isolatedModules --outDir build --strict false --target ES2021
    ```
    
    You can change the value of `target` argument, if you want to use newer JavaScript version. Max value depends on Node.js version:
    | Node.js version | Max ECMAScript version |
    |----|----|
    | 12 | ES2019 |
    | 14 | ES2020 |
    | 16 | ES2021 |

1. Compile your function:
    ```
    npx tsc
    ```
1. The `build` directory will appear in the project folder. Zip its contents into an archive.
1. [Create a function](../operations/function/function-create.md).
1. [Create the version of the function](../operations/function/version-manage.md).
