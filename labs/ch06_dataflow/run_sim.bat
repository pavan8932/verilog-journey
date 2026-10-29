@echo off
echo =========================================================
echo Compiling Chapter 6 Dataflow 4-bit Carry Lookahead Adder...
echo =========================================================

C:\iverilog\bin\iverilog.exe -o sim.vvp cla_4bit.v tb_cla_4bit.v
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
start C:\iverilog\gtkwave\bin\gtkwave.exe cla_4bit.vcd
