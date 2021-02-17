#!/usr/bin/jjs -fv
var cmd = "docker build -t airhacks/wildfly-configured ."
var System = Java.type("java.lang.System");
$EXEC(cmd, System.in, System.out, System.err);

//- 192.168.99.100