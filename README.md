# cssjs
Write JavaScript right inside CSS!

## Problem
TBD

## Example
```css
header, footer {
    position: fixed;
    left: 0;
    right: 0;
}
header {
    top: 0;
    height: 100px;
}
footer {
    bottom: 0;
    height: 50px;
}
body {
    padding-top: return $("header").height() + 15;
    padding-bottom: return $("footer").height() + 15;
    min-height: function(){
        return $(window).height()
               - $("header").height()
               - $("footer").height()
               - 30;
    };
}
```

See more in `examples` folder. Note that `.css.js` and `.css.css` files are compiled from `.css` files by `cssjs`.

## Installation
* to install command line utility: `npm install -g cssjs`
* for API usage: `npm install --save cssjs`

## Usage
`cssjs file.css` processes file into `file.css.css` and `file.css.js`.

## Roadmap
* provide and support pretty good documentation
* smart internal event handling (for best performance and right processing order)
* remove jQuery dependency and make minimal but powerful substitute (selectors, dimensions and offsets)
* full Meteor.js integration (reactivity, data contexts, building)
* extend scripting away just property calculating
* extend interoperability (support pseudo selectors, ...)
* write browser runtime that does not require preprocessor
* make plugins for `grunt`, `gulp`, `verstat`, `docpad` and other task runners and static site builders
* make plugins/integrations for `stylus`, `less`, `reworkcss` and other preprocessors

## Running tests
PHP must be installed to run tests.
```bash
npm intall --dev
npm test
```

## Contributing
Pull requests, sharing experience and ideas are welcomed :)

## Contributors
* Ivan Kravchenko [@ivankravchenko](https://github.com/ivankravchenko) at [SE7ENSKY](https://github.com/SE7ENSKY)

## License
MIT
