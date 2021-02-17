@echo off

call global-variables.bat

echo "[INFO] ---------------------------------"
echo "[INFO] docker-compose STOP - %clustername%" 
echo "[INFO] ---------------------------------"
docker-compose -p %clustername% stop
echo .
echo .
echo "[INFO] ---------------------------------"
echo "[INFO] RESULT STOP" 
echo "[INFO] ---------------------------------"
docker-compose -p %clustername% ps
