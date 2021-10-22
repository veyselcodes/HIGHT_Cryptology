s='veyselaksoy!!!!!'.encode('utf-8')  #32 bytes Key
MK= s.hex()
print(MK)
WK="" #16 bytes Whittening Free Key
for i in range(0,8):
    if(i<=3):
        WK=WK+MK[2*i+2*12]+MK[2*i+2*12+1]
    else:
        WK=WK+MK[2*i-4*2]+MK[2*i-4*2+1]
print(WK)
