## react-playground-package package

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

### Options

You can change the webpack port in the package options. By default the port is
8612.

### Browser

And if you want to look deeper, open a browser at http://localhost:8612.
