enum declaration
enumDecl
	^{
	#LIBUSB_REQUEST_TYPE_STANDARD -> (16r00<<5).
	#LIBUSB_REQUEST_TYPE_CLASS -> (16r01<<5).
	#LIBUSB_REQUEST_TYPE_VENDOR -> (16r02<<5).
	#LIBUSB_REQUEST_TYPE_RESERVED -> (16r03<<5).
	} asDictionary