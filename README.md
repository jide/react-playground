## react-playground-package

ATOM plugin to preview and edit your JSX right from your favorite editor.

[gif]

### Install

If you want to customize the webpack config, create a playground.config.js file
at the root of your project and export a function like this :

```js
module.exports = function(config, webpack) {
  // Alter config, inject webpack plugins...
  return config;
}
```

### Usage

In your project, any folder containing a .playground.js file will then be
possible to live preview.
Toggle the pane using "Atom React Playground: Toggle"
command.
A .playground.js file might look like this :

```js
import React from 'react';
import MyComponent from './index';

React.render(<MyComponent some='prop'/>, document.getElementById('root'));
```
