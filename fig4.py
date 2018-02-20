

import matplotlib.pyplot as plt
import numpy as np


## fig 4a
#v1=np.genfromtxt('f4v1.csv',delimiter=',')
#v2=np.genfromtxt('f4v2.csv',delimiter=',')
#v3=np.genfromtxt('f4v3.csv',delimiter=',')
#t=np.genfromtxt('time.csv',delimiter=',')

#fig=plt.figure()


#ax1=fig.add_subplot(3,1,1)
#plt.plot(t,v1,'k')
#plt.xlim(0,6)
##plt.ylabel('V')
#ax1.text(5,30,'1.8 $^o$C')

#ax2=fig.add_subplot(3,1,2)
#plt.plot(t,v2,'k')
#plt.xlim(0,6)
##plt.ylabel('V')
#ax2.text(5,20,'10.2 $^o$C')

#ax3=fig.add_subplot(3,1,3)
#plt.plot(t,v3,'k')
#plt.xlim(0,6)
##plt.ylabel('V')
#plt.xlabel('Time (ms)')
#ax3.text(5,20,'20.0 $^o$C')

#plt.setp(ax1.get_xticklabels(), visible=False)
#plt.setp(ax2.get_xticklabels(), visible=False)
#plt.setp(ax1.get_yticklabels(), visible=False)
#plt.setp(ax2.get_yticklabels(), visible=False)
#plt.setp(ax3.get_yticklabels(), visible=False)



##plt.savefig('fig4a.jpeg',format='jpeg',dpi=600,bbox_inches='tight')
#plt.show()


#raw_input('go')
## fig 4b

T=[0,5,7.5,10,12.5,15,17.5,20,25]
#ror=[169,227,283,330,404,466,508,554,700]
ror=[141,252,324,390, 457,548,610,666,704]# recorded at 50 % with 15000 nA stimulation
ror_may=[153,270,331,400,467,528,608,681,776] #obtained from Data Thief
#rof=[39,57,71,80,100,131,167,207,292]
rof=[37,62,78,96,120,164,221,288,404]# recorded at 50 % with 15000 nA stimulation
rof_may=[30,60,82,118,157,209,276,358,516] #obtained from Data Thief

plt.plot(T,ror,"ko-",label='Maximum Rate of Rise')
plt.scatter(T,ror_may,marker='x',color='k',label='Published Experimental Maximum Rate of Rise ')
plt.plot(T,rof,"k^-",label='Maximum Rate of Fall')
plt.scatter(T,rof_may,marker='+',color='k',label='Published Experimental Maximum Rate of Rise ')
plt.xlabel(r'Temperature ($^o$C)')
plt.ylabel('dV/dt (V/s)')
plt.xlim(-4,30)
plt.ylim(0, 900)
plt.legend(loc=2,prop={'size':10})


#plt.savefig('fig4b.jpeg',format='jpeg',dpi=600,bbox_inches='tight')
#plt.show()

#raw_input("go")

# fig 4c

vel=[9.82,12.05,13.39,14.89,16.57,18.44,20.52,22.80,27.99]
t=T[1:]
print t
vel_paper=[11.3,13.02,14.8,16.1,18.2,20.0, 22.0,25.6] #obtained from Data Thief
plt.plot(T,vel,"ko-",label='Modeled Conduction Velocity')
plt.scatter(t,vel_paper,marker='x',color='k',label='Published Conduction Velocity')
plt.legend(loc=2,prop={'size':10})
plt.xlabel(r'Temperature ($^o$C)')
plt.ylabel('Conduction Velocity (m/s)')
plt.xlim(-4,30)
plt.ylim(6, 30)

plt.savefig('fig4c.jpeg',format='jpeg',dpi=600,bbox_inches='tight')
plt.show()

#fig 4d

vel_may=[448,562,622,685,749,818,884,959,1092]
vel_may_paper=[350,489,558,640,714,798,872,954,1120] #obtained from Data Thief
vel_aug=[515,646,715,788,861,940,1016,1103,1255]
vel_aug_paper=[457,580,683,771,835,984,1040,1140,1344]#obtained from Data Thief
plt.scatter(T,vel_may,marker="x",color='r',label='Modeled Normalized Conduction Velcotiy (May)')
plt.plot(T,vel_may_paper,color='k',ls ='--',label='Published Experimental Conduction Velocity (May)')
plt.scatter(T,vel_aug,marker="+",color='r',label='Modeled Normalized Conduction Velocity (Aug)')
plt.plot(T,vel_aug_paper,color='k',label='Published Experimental Conduction Velocity (Aug)')
plt.legend(loc=2,prop={'size':14},frameon=False)
#plt.legend()
plt.xlabel(r'Temperature ($^o$C)', fontsize=18)
plt.ylabel('Normalized Conduction Velocity ($m^{0.5}$/s)',fontsize=18)
plt.xlim(-4,30)
plt.ylim(250, 2000)

plt.savefig('fig4d.jpeg',format='jpeg',dpi=600)
plt.show()
