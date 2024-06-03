@echo off
set /p project_name="Enter project name: "
mkdir %project_name%

cd %project_name%

@REM 需要正斜杠，否则虽然能正确执行但会报语法不正确
copy ..\create_project_template\Dockerfile Dockerfile
@REM 覆盖写入
@REM echo FROM python:3.10-slim-buster > Dockerfile
@REM 追加写入
echo RUN mkdir -p /home/appuser/%project_name% >> Dockerfile
echo WORKDIR /home/appuser/%project_name% >> Dockerfile

rename Dockerfile Dockerfile.%project_name%

copy ..\create_project_template\requirements.txt requirements.txt
copy ..\create_project_template\.gitignore .gitignore

git init
git add .
git commit -m "Inited repository"
cd ..
echo Dockerfile.%project_name%, requirements.txt and .gitignore created in %project_name% folder and git repository initialized.
pause
