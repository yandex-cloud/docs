```mermaid
flowchart BT
    loadtesting.generatorClient --> loadtesting.externalAgent
    loadtesting.externalAgent --> loadtesting.editor
    loadtesting.loadTester --> loadtesting.editor
    loadtesting.viewer --> loadtesting.editor
    loadtesting.editor --> loadtesting.admin
```