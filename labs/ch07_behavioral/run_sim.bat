@echo off
echo =========================================================
echo Compiling Chapter 7 Sequence Detector (Moore FSM)...
echo =========================================================

C:\iverilog\bin\iverilog.exe -o sim.vvp seq_detector_1011.v tb_seq_detector_1011.v
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
start C:\iverilog\gtkwave\bin\gtkwave.exe seq_detector_1011.vcd
