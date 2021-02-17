@echo off

call global_var.bat

set tagv=1
set tname=%iname%:%tagv%

REM -- localni build image, buildcontext je aktualni adresar
call docker build -t %gname%/%tname% .
REM -- smazani jiz existujiciho kontejneru
call docker rm -f %iname%

REM
REM Adresa WSDL, kt. funguje prevzate odsud
REM @see https://jansipke.nl/examples-of-public-soap-web-services/
REM
REM --docker run --name %iname% -it %gname%/%tname% python -m zeep http://webservices.oorsprong.org/websamples.countryinfo/CountryInfoService.wso?WSDL
docker run --name %iname% %gname%/%tname%