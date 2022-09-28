#!/bin/bash

for P in $(ps aux | grep grails | grep java | awk '{print $2};'); do
kill -9 $P
done
exit 0
