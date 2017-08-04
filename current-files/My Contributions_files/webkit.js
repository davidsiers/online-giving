// this allows the browser to be set for future ajax scripts from MS to treat the browser correctly
// this will fix Chrome/Safari 3.0 while leaving Safari 2.0 working as well.
Sys.Browser.WebKit = {}; 
if (navigator.userAgent.indexOf('WebKit/') > -1) {
    Sys.Browser.agent = Sys.Browser.WebKit;
    Sys.Browser.version = parseFloat(navigator.userAgent.match(/WebKit\/(\d+(\.\d+)?)/)[1]);
    Sys.Browser.name = 'WebKit';
}