@echo off
echo =========================================================
echo Compiling Chapter 5 Gate-Level 4-to-1 Multiplexer...
echo =========================================================

C:\iverilog\bin\iverilog.exe -o sim.vvp mux4_to_1.v tb_mux4_to_1.v
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
start C:\iverilog\gtkwave\bin\gtkwave.exe mux4_to_1.vcd
