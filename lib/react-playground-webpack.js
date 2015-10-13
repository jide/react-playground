var path = require('path');
var webpack = require('webpack');

var extra = {
  "react-transform": {
    "transforms": [{
      "transform": "react-transform-hmr",
      "imports": ["react"],
      "locals": ["module"]
    }, {
      "transform": "react-transform-catch-errors",
      "imports": ["react", "redbox-react"]
    }]
  }
};

module.exports = function(projectPath, filePath) {
  return {
    devtool: 'eval',
    output: {
      path: path.join(projectPath, 'react-playground'),
      filename: 'react-playground.js',
      publicPath: '/'
    },
    context: projectPath,
    entry: ['webpack-hot-middleware/client?reload=true', './src/js/cards/CardAnimal/.playground.js'],
    plugins: [
      new webpack.HotModuleReplacementPlugin(),
      new webpack.NoErrorsPlugin()
    ],
    babel: {
      plugins: [
        require('babel-plugin-react-transform')
      ]
    },
    resolve: {
      root: [filePath, projectPath, path.resolve(__dirname, '../node_modules')],
      extensions: ['', '.webpack.js', '.web.js', '.js', '.jsx', '.es6', '.less', '.css']
    },
    resolveLoader: {
      root: [projectPath, path.resolve(__dirname, '../node_modules')]
    },
    module: {
      loaders: [{
        test: /(\.jsx?|\.es6)$/,
        loader: 'babel',
        query: {
          "stage": 0,
          "extra": extra,
          "env": {
            "development": {
              "extra": extra
            }
          }
        },
        include: filePath
      }]
    }
  }
};
