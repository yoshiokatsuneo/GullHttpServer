GullHttpServer
==============

Simple Embedded Web Server for Cocoa (Objective-C)

[Feature]
  - Simplest embedded web server framework for Objective-C. (Just about 100 lines.)
  - For embedded web server.
  - Single thread

[How to use]
  - Just subclass GullHttpServer class.
  - Define methods to corresponding to HTTP request path, and return string.
    ("-hello" for "/hello" request)
  - Initialize class with host and port.
  - Call -run to start service.
  - That's it. :-)
  
