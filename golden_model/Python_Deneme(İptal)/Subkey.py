s='veyselaksoy!!!!!'.encode('utf-8')  #32 bytes Key
MK= s.hex()
s0='0';s1='1';s2='0';s3='1';s4='1';s5='0';s6='1';
delta=[]
delta.insert(0,s6+s5+s4+s3+s2+s1+s0)
#si=s6+s5+s4+s3+s2+s1+s0
si=s0+s1+s2+s3+s4+s5+s6
for i in range(1, 127):
    si = si +chr(((ord(si[i+2])-48)^(ord(si[i-1])-48))+48)
    delta.insert(i,si[i+6]+si[i+5]+si[i+4]+si[i+3]+si[i+2]+si[i+1]+si[i])
print(si)
print(delta)

# Key Schedule

#for i in range(0,7):
#    for j in range(0,7):
#        SK = 
