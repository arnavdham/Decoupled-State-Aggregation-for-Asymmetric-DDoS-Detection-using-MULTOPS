// test.click (Robust Configuration Version)

// --- 1. Packet Generation Pipeline ---
// This part of the script generates IP traffic and sends it to the monitor.

RatedSource(RATE 10000)
-> UDPIPEncap(
SRC 10.0.0.1, SPORT 5000,
DST 18.0.0.1, DPORT 80
)
-> CheckIPHeader(CHECKSUM false)
-> mon :: IPRateMonitor(
// IMPORTANT: We only declare the ORIGINAL arguments here
// to avoid the "unknown argument" error during initialization.
TYPE PACKETS,
RATIO 1.0,
THRESH 100
)
-> Discard;

// --- 2. Runtime Configuration Script ---
// This separate script runs once at startup and configures our 'mon' element
// by calling the write handlers we created in C++.

Script(
TYPE ACTIVE,
// Call the 'aggregator' handler on the 'mon' element
write mon.aggregator 127.0.0.1:49555,
// Call the 'interval' handler on the 'mon' element
write mon.interval 1s
);

// --- 3. Optional Control Socket ---
// This allows you to connect to the running script to inspect elements.
ControlSocket(TCP, 7777);