Slight improvement of the default `authorBios` block plugin in OJS 2.4.8.

Embedded the pure js [ReadMore.js](https://github.com/georapbox/ReadMore.js) to shorten author bios.  
Author: George Raptis; License: MIT

I am aware this is far from a good practice, but the js is embedded inline rather than invoked as a separate file because OJS 2.4 already makes a bazillion HTTP requests. For the moment all custom variables are defined in a separated inline js portion.
