@echo off
echo =========================================================
echo Compiling Chapter 4 Hierarchical 4-bit Adder...
echo =========================================================

C:\iverilog\bin\iverilog.exe -o sim.vvp half_adder.v full_adder.v adder4.v tb_adder4.v
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
start C:\iverilog\gtkwave\bin\gtkwave.exe adder4.vcd
