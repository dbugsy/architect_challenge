FAIL
====

Double check your responsibilities, does the plane tell the station it wants to land?
Or should the port command the plane to land?

It becomes clear when the plane has to ask the port before it does anything.
[http://c2.com/cgi/wiki?FeatureEnvySmell](http://c2.com/cgi/wiki?FeatureEnvySmell)

Do not use strings to represent success or failure.
You need to have two contexts clear weather and stormy weather and create tests for each context.
It's conventional to match your filename with class name.

Your tests are tightly coupled between classes, port needs plane and plane needs port.
[http://c2.com/cgi/wiki?CouplingAndCohesion](http://c2.com/cgi/wiki?CouplingAndCohesion)



architect_challenge
===================

Software to control flow of planes at an airport
