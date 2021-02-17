# Helpful command for operation

There's cripple situation when you fuck up build/run etc., the scripts
(act as aliases/shortcuts) allow to you repair (clean) state:

*   dcrem.bat       >> docker container rm -f %1
*   dcstop-rem.bat  >> docker container stop %1 && docker container rm -f %1
*   dcstop.bat      >> docker container stop %1
*   direm.bat       >> docker rmi -f %1
*   
--

If you have bullshit in your hands and docker labs is big smell you can use the command
which helps you with clean the state (!!!warning clean all images!!!) at local machine:

$ docker system prune -a
--