#!/bin/bash

cd apifva
grails prod run-app -Dgrails.server.port=80 -https >> ../log.out &
cd -
