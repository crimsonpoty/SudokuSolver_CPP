@echo off
REM replace user_name to your account name at "PY_INCLUDE_PATH" and "PY_LIB_PATH"

set SRC_PATH="..\..\..\c++"
set OBJ_PATH="%CD%\src"
set INCLUDE_PATH=%OBJ_PATH%
set PY_INCLUDE_PATH="C:\Users\user_name\AppData\Local\Programs\Python\Python36-32\include"
set PY_LIB_PATH="C:\Users\user_name\AppData\Local\Programs\Python\Python36-32\libs"

if not exist "src" (mkdir "src")

copy %SRC_PATH%"\MyDebug.h" src
copy %SRC_PATH%"\Sudoku.h" src
copy %SRC_PATH%"\Sudoku.cpp" src

g++ -std=c++11 -O2 -Wall -c -fmessage-length=0 -o %OBJ_PATH%"\Sudoku.o" %OBJ_PATH%"\Sudoku.cpp" 

swig -c++ -python Sudoku.i

REM [pyd lib file for Windows]
g++ -std=c++11 -O2 -Wall -c Sudoku_wrap.cxx -fPIC -Wall -I%PY_INCLUDE_PATH% -I%INCLUDE_PATH%
g++ -o _cppSudoku.pyd %OBJ_PATH%"\Sudoku.o" Sudoku_wrap.o -Wall -shared -lpython36 -L%PY_LIB_PATH%
