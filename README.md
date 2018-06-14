# Homebrew 65816

## Hardware (so far)

- CPU: *W65C816S6PG-14*
- ROM: *AT28C64B-15PU* (8k x 8, 150ns)
- Address decoding: *GAL22V10D-15LP*

## Prerequisites

```
# apt install cc65 minipro
```

## Building and Uploading ROM

```
$ cd rom
$ make
$ minipro -p AT28C64B -w rom.bin
```