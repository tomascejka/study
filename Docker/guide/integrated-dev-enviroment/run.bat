REM
REM Running the below run command will pass the extra environment variables 
REM required for user/group ID mapping and permission setting.
REM
REM @see https://medium.com/@ls12styler/docker-as-an-integrated-development-environment-95bc9b01d2c1
REM @see https://stackoverflow.com/questions/605686/windows-how-to-specify-multiline-command-on-command-prompt
REM 
docker run -it --rm ^
	-v //f/Study/Docker/guide/integrated-dev-enviroment/workspace:/workspace ^
	-v /usr/local/bin/docker:/usr/bin/docker ^
	-e HOST_USER_ID=tc ^
	-e HOST_GROUP_ID=devel ^
	toce/ide:latest