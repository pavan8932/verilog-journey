@echo off
echo =========================================================
echo Compiling Chapter 8 Tasks and Functions Lab...
echo =========================================================

C:\iverilog\bin\iverilog.exe -o sim.vvp packet_formatter.v tb_packet_formatter.v
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
start C:\iverilog\gtkwave\bin\gtkwave.exe packet_formatter.vcd
