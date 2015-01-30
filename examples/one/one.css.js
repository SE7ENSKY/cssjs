cssjsProperty(["aside"], "top", "return $(\"header\").height();");
cssjsProperty(["aside"], "bottom", "return $(\"footer\").height();");
cssjsProperty(["body"], "padding-top", "return $(\"header\").height();");
cssjsProperty(["body"], "padding-bottom", "return $(\"footer\").height();");
cssjsProperty(["main"], "margin-left", "return $(\"aside\").width() + 15;");
cssjsProperty(["main"], "min-height", "function(){\n\t\treturn $(window).height() - $(\"header\").height() - $(\"footer\").height()\n\t};");