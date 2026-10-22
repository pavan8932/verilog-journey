@echo off
echo =========================================================
echo Compiling and Simulating Chapter 2 Ripple Carry Counter...
echo =========================================================

iverilog -o sim.vvp dff.v tff.v ripple_carry_counter.v tb_ripple_carry_counter.v
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Compilation failed. Make sure Icarus Verilog is installed and in your PATH.
    pause
    exit /b %ERRORLEVEL%
)

echo.
echo Running simulation via vvp...
vvp sim.vvp
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Simulation execution failed.
    pause
    exit /b %ERRORLEVEL%
)

echo.
echo Opening waveform in GTKWave...
start gtkwave counter.vcd

pause
