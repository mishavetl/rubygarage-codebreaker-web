@echo off
docker run -p 9292:9292 -it -v %cd%:/app %1
