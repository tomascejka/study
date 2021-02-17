@echo off

call global-variables.bat

echo "[INFO] ---------------------------------"
echo "[INFO] docker-compose UP - %clustername%" 
echo "[INFO] ---------------------------------"
docker-compose -p %clustername% up -d --build --remove-orphans
echo .
echo .
echo "[INFO] ---------------------------------"
echo "[INFO] RESULT UP" 
echo "[INFO] ---------------------------------"
docker-compose -p %clustername% ps
