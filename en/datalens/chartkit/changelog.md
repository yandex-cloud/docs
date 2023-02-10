
# Releases

### 7.0.0 {#upd_7.0.0}

* Migrating the code gradually to TypeScript
* The source code is now imported from `/build/` rather than `/lib/`
* The built bundle is now imported from `/lib/` rather than `/dist/`.
   You also need to import the `commons` part.
   For more, see the [imports](index.md#imports).
* The method of adding extensions has now changed.
   For more, see the [imports](index.md#imports).
* The default theme is now `common`.
   The `light` and `dark` themes are now `deprecated` and will be removed in the next version.
   For more, see the [styles](index.md#style).
* `ChartKit.setSettings` divided into the  `ChartKit.setGeneralSettings` and `ChartKit.setDataProviderSettings`.
   To learn more, see the [general settings](index.md#main-settings) and the [settings for the Charts provider](index.md#provider-settings).
* New settings in the `props`.
   For more information, see [Available properties](index.md#properties)
* The `silentLoading` parameter in `props` that accepted `boolean` and `number`, has been split into `noLoader: boolean` and `loaderDelay: number`
* The public `reflow` method (for example, for charts and tables)
* Animated element transition between states has been disabled 

### 6.17.2 {#upd_6.17.2}

* Showing `null` values in the table

### 6.17.1 {#upd_6.17.1}

* Fixed the value display for a custom tooltip for `arearange`
* Overriding a title in a custom tooltip using `headerFormat`

### 6.17.0 {#upd_6.17.0}

* Added the `noJsonFn` flag to `setSettings` to avoid calling `eval`.

### 6.16.2 {#upd_6.16.2}

* Fixed a bug that resulted in a failure to show a column with percentages in a tooltip (for Wizard charts)

### 6.16.1 {#upd_6.16.1}

* Fixed a bug that resulted in a failure to show a column with percentages in a tooltip (for Editor charts)

### 6.16.0 {#upd_6.16.0}

* More information is provided in API errors for sources

### 6.15.0 {#upd_6.15.0}

* Links in tables are sanitized
* Added an option to override and append to table cells in a custom tooltip

### 6.14.8 {#upd_6.14.8}

* Setting navigator borders on the basic X-axis instead of the navigator axis 

### 6.14.7 {#upd_6.14.7}

* Yandex Maps localization fix
* Rollback of overriding of the `overflow` style on the chart container (added in 6.14.4) because of incorrect behavior
* Original settings for navigator borders doesn't exceed the data borders

### 6.14.6 {#upd_6.14.6}

* Fix to check for `group` in the table in the case of a multi-level header 

### 6.14.5 {#upd_6.14.5}

* Disabled table sorting with `group: false`
* When exporting the table data, the `format` wasn't taken into account
* For the V2 measure, `onLoad` wasn't invoked at the first render

### 6.14.4 {#upd_6.14.4}

* Overridden the `overflow: hidden` style on the chart container to resolve the failure to scroll the chart with an explicit height 
* An active line drawn on top of the main list is shown in the tooltip only if it hasn't been output in the main list

### 6.14.3 {#upd_6.14.3}

* A fix for the tooltip behavior when the scroll isn't in the body

### 6.14.2 {#upd_6.14.2}

* English menu version
* Fix for tooltip mispositioning (that is, when it overlaps the bottom window border at a certain combination of styles on body)
* Fix for tooltip mispositioning when there's a horizontal scroll on the page

### 6.14.1 {#upd_6.14.1}

* Fixed the situation when the percentage was shown in the absolute value column in the pie chart tooltip.

### 6.14.0 {#upd_6.14.0}

* Themes for the chart navigator
* The section for a title in the map tooltip is rendered only if the title has been passed

### 6.13.0 {#upd_6.13.0}

* Changed the logic for displaying the active line in the tooltip and its styling

### 6.12.4 {#upd_6.12.4}

* Changed the logic for the auxiliary `deepAssign` function in the case of `null`

### 6.12.3 {#upd_6.12.3}

* Fixed the direct use of the `Control` component (for the `DashKit` case) after the changes of 6.12.1

### 6.12.2 {#upd_6.12.2}

* Rolled back the changes of 6.9.3

### 6.12.1 {#upd_6.12.1}

* Fixed overriding of non-empty parameter object by an empty object
* `Control` now requests the data and processes the response similarly to `ChartKit`

### 6.12.0 {#upd_6.12.0}

* Added the option of setting up the number of displayed decimal digits for percentage in the tooltip

### 6.11.0 {#upd_6.11.0}

* Added the option to show both absolute values and percentage in the tooltip for `pie`, `funnel`, and `solidgauge`
* Resolved the issue of tooltip overlapping the viewport borders after its position is fixed (if one of the added lines is longer than the total length of all the lines displayed before the fixing).

### 6.10.2 {#upd_6.10.2}

* Fixed the situation when the `size` property isn't defined for the V2 measure.

### 6.10.1 {#upd_6.10.1}

* The version of Highcharts changed from `^8.0.0` to `~8.0.0` because of [highcharts#13461](https://github.com/highcharts/highcharts/issues/13461)

### 6.10.0 {#upd_6.10.0}

* For the V2 measure, we no longer adjust the font size depending on the width and use simply a static font set

### 6.9.3 {#upd_6.9.3}

* Fixed a bug that resulted in the divergence between the real `params` values and the actual state of controls in `Control`

### 6.9.2 {#upd_6.9.2}

* Added a class to be matched by snapter for the table and markdown content

### 6.9.1 {#upd_6.9.1}

* Calling `onLoad` from the V2 measure

### 6.9.0 {#upd_6.9.0}

* Set the minimum and maximum font size for the V2 measure

### 6.8.1 {#upd_6.8.1}

* Fixed the situation when an error in the control section was passed outside the `ChartKit` component

### 6.8.0 {#upd_6.8.0}

* Hiding a fixed tooltip when clicking outside the chart area
* Changed the paradigm for tooltip positioning on mobile devices: the lower boundary is now linked to the pointer
* Changed the principle of defining the active `area`: now, it's the area under the cursor
* A multiple-choice control now returns an empty string instead of an empty array when no values are selected

### 6.7.2 {#upd_6.7.2}

* Fixed the total for the lines that aren't displayed on the tooltip when overriding `manageTooltipConfig`

### 6.7.1 {#upd_6.7.1}

* Fixed the total for the lines that aren't displayed on the tooltip when overriding `manageTooltipConfig` (incorrect)

### 6.7.0 {#upd_6.7.0}

* Fixed the criteria for showing the "Comments" item in the menu for new Wizard charts
* Added a new `label` props to the `Chips`Component of the `yandex-map` module to display the label at the center of the point

### 6.6.0 {#upd_6.6.0}

* Featuring V2 measure as an independent chart type in the new design

### 6.5.2 {#upd_6.5.2}

* Selector mechanics fixed

### 6.5.1 {#upd_6.5.1}

* Fixed the incorrect display of `stackLabels` in the case of a `stacking` `column` with `highstock`
* Maintaining the height of the control block when the loader appears
* Fixed handling of the `postUpdateOnChange` flag by the selector

### 6.5.0 {#upd_6.5.0}

* Adjusting the maximum tooltip height in view of the viewport height in the portrait orientation of the mobile version
* Fixed incorrect behavior of some controls in the case of an error in the chart

### 6.4.1 {#upd_6.4.1}

* If the chart is first loaded with an error, an empty section is output

### 6.4.0 {#upd_6.4.0}

* Chart controls are now displayed even if the chart loaded with an error
* For the cells with `type: 'date'`, tables now include the date `format`.
* `returnInterval` for the calendar control for the interval
* The calendar control for the interval that handles the case when "from" is selected, but "till" is omitted, and sets "till" to the value of "from"

### 6.3.1 {#upd_6.3.1}

* Comments for new Wizard charts

### 6.3.0 {#upd_6.3.0}

* `Textarea` in chart controls

### 6.2.0 {#upd_6.2.0}

* `ErrorComponent` in the `setSettings`.
   Overriding the component that displays chart errors

### 6.1.0 {#upd_6.1.0}

* `isMobile` in the `setSettings`.
   For example, to change the logic of tooltip positioning on mobile devices
   so that it's displayed in portrait orientation on the chart.

### 6.0.0 {#upd_6.0.0}

* New tooltip
* Updating dependencies
   * `highcharts: ^8.0.0`
   * `highcharts-react-official: ^3.0.0`
* `sideEffects` on the `*.scss` files in the `package.json`
* `Highcharts` are not written to the `window`

### 5.4.0 {#upd_5.4.0}

* Updating dependencies
   * `@yandex-data-ui/common: ^5.22.0`
   * `axios: ^0.19.2`
* `@yandex-data-ui/charts-shared` new dependence

### 5.3.0 {#upd_5.3.0}

* Clicking table cells
* Updating parameters when clicking a button control

### 5.2.1 {#upd_5.2.1}

* An option to decorate request body using `requestDecorator`

### 5.2.0 {#upd_5.2.0}

* `postUpdateOnChange` for `Control`

### 5.1.0 {#upd_5.1.0}

* Added `requestIdPrefix` to the common settings level (`setSettings`)
*  `requestIdPrefix` are passed as the first argument in the `requestIdGenerator`
* Export to Markdown and Wiki is now available in the menu

### 5.0.0 {#upd_5.0.0}

* Changed imports for `@yandex-data-ui/common` styles.

   For example, instead of
   ```
   @import '~@yandex-data-ui/common/src/styles/yc-theme-light.scss';
   ```
   use the
   ```
   @import '~@yandex-data-ui/common/styles/yc-theme-light.scss';
   ```

### 4.11.0 {#upd_4.11.0}

* When updating parameters, a standard loader appears in the center
* `compactLoader` enables the mode of a small loader in the upper-right corner instead of a standard loader at the center
* Replaced the `default`/`night` themes with `light`/`dark` themes, and  converted them to [common colors](https://github.yandex-team.ru/data-ui/common/blob/master/src/styles/yc-chartkit-theme-common.scss)
* Variables for the color of the loader and veil

### 4.10.0 {#upd_4.10.0}

* The `config` in `setSettings` isn't downloaded by default

### 4.7.0 {#upd_4.7.0}

* The `/api/run` request is retried once in the case of error 5**

### 4.6.0 {#upd_4.6.0}

* When updating the parameters, a small loader appears in the upper-right corner instead of a standard centered loader
* The loader is now blue, with no option to use variables to change the color

### 4.5.0 {#upd_4.5.0}

* Markdown as the new chart type 

### 4.3.0 {#upd_4.3.0}

* `@yandex-data-ui/common`: new major version
* Names of elements used for styling the `control` extension now have the `yc` prefix

### 4.2.0 {#upd_4.2.0}

* `jQuery` is used optionally only in Wiki texts

### 4.1.0 {#upd_4.1.0}

* `@yandex-data-ui/dt100`: new major version
* Changed names of CSS variables for tables

### 4.0.3 {#upd_4.0.3}

* `requestIdGenerator`in the settings.

### 4.0.0 {#upd_4.0.0}

*  `@yandex-data-ui/common` Dependence
* Controls now constitute a separate extension

### 3.4.1 {#upd_3.4.1}

* `theme` in the `setSettings`

### 3.4.0 {#upd_3.4.0}

* Removed `@yandex-data-ui/common` from dependencies
* Added new CSS variables for the theme

### 3.3.4 {#upd_3.3.4}

* Added `@yandex-data-ui/common` to the dependencies.

### 3.3.0 {#upd_3.3.0}

* Changed the color palette for charts

### 3.2.0 {#upd_3.2.0}

* `type: grid` for tables

### 3.1.0 {#upd_3.1.0}

* New design for error display

### 3.0.5 {#upd_3.0.5}

* `silentLoading` in the available properties

### 3.0.4 {#upd_3.0.4}

* Menu button and popup in `lego-on-react`

### 3.0.2 {#upd_3.0.2}

* Renamed the library to `@yandex-data-ui/chartkit`
* Switching from the `islands` to the `lego-on-react`
* Browser-based charts are no longer supported
* Configurable menu
* Theme modifiers and the basic set of CSS variables

### 2.7.0 {#upd_2.7.0}

* `yate-loader` is no longer used, so you don't need to include it

### 2.6.0 {#upd_2.6.0}

* In `graph-extended`, you now have `indicators` and `ema` for Highcharts

### 2.5.1 {#upd_2.5.1}

* The components responsible for embedded Node.js controls for charts and tables (`Controls`) and the left part of the chart
   (`SideHtml`) are now included in `graph-extended`
* Without extensions, ChartKit doesn't depend on `islands`

### 2.4.0 {#upd_2.4.0}

* New type of scripts with Yandex Maps
* Instead of `refWrap` is the `ref`

### 2.3.0 {#upd_2.3.0}

* Changed the import mechanics for `graph-extended`: now importing and calling without arguments

### 2.2.2 {#upd_2.2.2}

* You can now set up request decorator in `setSettings`. Only labels are now available for styling.

### 2.2.0 {#upd_2.2.0}

* Moved tables to [DT100](https://github.yandex-team.ru/data-ui/data-table): without the jQuery dependency. Moreover, when
   Connecting to ChartKit, you need to add `node_modules/dt100` to the build (in the  webpack's `include`)

### 2.0.x -> 2.1.0 {#upd_2.1.0}

* When including ChartKit into the build, you no longer need to add  `node_modules/react-highchart` to the webpack's `include`
   and add the plugin `DefinePlugin` `isProdMode`
* The `graph-extended` extension now returns nothing during import.
