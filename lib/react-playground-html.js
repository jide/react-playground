module.exports = function(scriptPath) {
  return "<!doctype html>\
<html>\
  <style>\
    html, body, #root { height: 100% }\
    body { padding: 0; margin: 0 }\
  </style>\
  <body>\
    <div id='root'></div>\
    <script src='" + scriptPath + "'></script>\
  </body>\
</html>";
};
