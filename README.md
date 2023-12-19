# badalMapping
 checking on issues with the badal calulcator and getting new screen distances
 
 # Notes
 
 MAC wrote code to get the pixel angle, etc. from the EIS file, and then copied that into excel, and then AMC picked up from the excel file, read it back into matlab, did the calculation, and then put it back in excel.

This is the code that "did the calculation". Things to note (that we'll probably forget)

1. The rail is 450mm, which is why we subtract that from the value when reversed.
2. The dove tail railing holding the lens is 50mm long, which is why (1) it was fixed in the flipped rail scenario and (2) is what we are subtracting in the misreading case.
3. We dont have code to get lens distance given the virtual screen distance, which is why we find the matching output.
