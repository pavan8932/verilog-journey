@echo off
echo =========================================================
echo Compiling Chapter 3 Data Types and 4-State Logic Demo...
echo =========================================================

C:\iverilog\bin\iverilog.exe -o sim.vvp data_types_demo.v tb_data_types_demo.v
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Compilation failed.
    pause
    exit /b %ERRORLEVEL%
)

echo.
echo Running simulation...
C:\iverilog\bin\vvp.exe sim.vvp
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Simulation failed.
    pause
    exit /b %ERRORLEVEL%
)

echo.
echo Opening waveform in GTKWave...
start C:\iverilog\gtkwave\bin\gtkwave.exe data_types.vcd
