# libusb-pharo

This project provides binding to the libusb library for Pharo. We currently target Pharo 7.

## Install
Execute the following code snippet to install the package:

~~~
Metacello new
    repository: 'github://tamerescrl/libusb-pharo/repository';
    baseline: 'LibUsb';
    load
~~~


## Quickstart

### Listing all the connected USB devices
```
LUContext withAllDevicesDo: [ :context :devices | "Play with devices..." ]
```

### Get a lsusb like output for a device printed in Transcript
```
LUContext withAllDevicesDo: [ :context :devices |
    | ps3Controller |
    context logLevelDebug.
    "Searching the ps3 controller using its vendor id and product id."
    ps3Controller := devices detect: [ :dev |
                            dev idVendor = 16r054c
                                and: [ dev idProduct = 16r0268 ] ].
    Transcript
        show: 'Bus ';
        show: (ps3Controller busNumber printPaddedWith: $0 to: 3 base: 10);
        show: ' Device ';
        show: (ps3Controller address printPaddedWith: $0 to: 3 base: 10);
        show: ': ID ';
        show: (ps3Controller idVendor printPaddedWith: $0 to: 4 base: 16);
        show: ':';
        show: (ps3Controller idProduct printPaddedWith: $0 to: 4 base: 16);
        space;
        show: ps3Controller manufacturerDescription;
        show: ps3Controller productDescription; cr ]
```

# HID layer
This repository also holds an implementation of the Human Interface Device protocol with a driver to be used with libusb binding.

## Install
Execute the following code snippet to install the package:
```
Metacello new
    repository: 'github://tamerescrl/libusb-pharo/repository';
    baseline: 'HumanInterfaceDevice';
    load
```
You are now ready to use this project!

### Only install the packages you need
It is also possible to install only the packages you need. For example, you may want to use the libusb-backend with the core package only. To be able to do that, the baseline defines groups:

- `'core'`: contains only the HumanDeviceInterface package, nothing else.
- `'libusb-backend'`: contains the core package and the libusb backend.
- `'simulated-backend'`: contains the core package and the simulated backend (for learning/testing purpose).

If you do not specify a particular group, all packages are loaded including tests packages (this is useful for development).

To load a group (for example `'core'`), simply pass the string representing the package name to `#load:` message as follow:

```
Metacello new
    repository: 'github://tamerescrl/libusb-pharo/repository';
    baseline: 'HumanInterfaceDevice';
    load: 'core'.
```

## Quick start
The following code gives you hints on how to use the HID layer.

If you use linux, the following command is probably available on your system:
```
$ lsusb
```

It will print the following output that shows multiple information about the
usb devices connected to the system. For the example we will take the vid:pid
of the `Linux Foundation 2.0 root hub` (`046d:c52f`).

```
Bus 004 Device 003: ID 045e:07a5 Microsoft Corp. Wireless Receiver 1461C
Bus 004 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching Hub
Bus 004 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 003 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 002 Device 002: ID 046d:c52f Logitech, Inc. Unifying Receiver
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 004: ID 058f:6366 Alcor Micro Corp. Multi Flash Reader
Bus 001 Device 003: ID 05c8:030d Cheng Uei Precision Industry Co., Ltd (Foxlink) 
Bus 001 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching Hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
                       ^    ^
                       vid  pid
```

Do not forget to replace **vid** and **pid** by those from your usb device in the following code: 

```
backend := HIDLibusbBackend vid: 16r046d pid: 16rc52f.

backend open.
backend takeDeviceControl.

"Get the report descriptor from the device or returns the one in cache if it has already be done."
reportDescriptor := backend reportDescriptor.

backend releaseDeviceControl.
backend close.
```
