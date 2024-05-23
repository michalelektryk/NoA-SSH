import numpy as np
import matplotlib.pyplot as plt
import os

#dodać oś X referencyjną
show_to_user=False

Xcolor=[0.91015625 , 0.015625, 0.015625]
Dcolor=[0.0078125  , 0.0, 0.81015625]
Acolor=[0.03515625 , 0.60421875, 0.01171875]
print((np.array(Xcolor)*256).astype(int))
print((np.array(Dcolor)*256).astype(int))
print((np.array(Acolor)*256).astype(int))
file_list=['abs1.png','abs2.png','crossover1.png','crossover2.png','sin_doubled.png','tri_doubled.png']
font_size='16'
line_width=4

def map(x,x1,x2,y1,y2):
	return y1+(y2-y1)/(x2-x1)*(x-x1)

def abs(inp,param):
	if(param<0):
		return np.where(inp<0,inp*map(param,-1,0,-1,1),inp)
	else:
		return np.where(inp>0,inp*map(param,0,1,1,-1),inp)

def doubler(inp,param):
	return inp*inp*param-np.mean(inp*inp*param)

def crossover(inp,param):
	sign=np.where(inp>0,1,-1)
	mag=np.abs(inp)
	return sign*np.where((mag+param)<0,0,mag+param)

for file in os.listdir():
	if file in file_list:
		print('removing: ',file)
		os.remove(file)

'''plt.rcParams.update({
    "lines.color": "white",
    "patch.edgecolor": "white",
    "text.color": "black",
    "axes.facecolor": "white",
    "axes.edgecolor": "lightgray",
    "axes.labelcolor": "white",
    "xtick.color": "white",
    "ytick.color": "white",
    "grid.color": "lightgray",
    "figure.facecolor": "black",
    "figure.edgecolor": "black",
    "savefig.facecolor": "black",
    "savefig.edgecolor": "black"})'''

time=np.linspace(0,2,10**5)
tri=4*(np.abs(time%1-0.5)-0.25)
sin=np.sin(2*np.pi*time)
# plt.plot(time,tri,label='input wave',linewidth=line_width)
# plt.savefig('tri.png', edgecolor='none', dpi=400, bbox_inches='tight', transparent=True)
# plt.plot(time,abs(tri,-0.3)-1,label='A clockwise',linewidth=line_width)
# plt.savefig('A clockwise.png', edgecolor='none', dpi=400, bbox_inches='tight', transparent=True)
# plt.plot(time,abs(tri,-0.7)-2,label='A more clockwise',linewidth=line_width)
# plt.savefig('A more.png', edgecolor='none', dpi=400, bbox_inches='tight', transparent=True)
# plt.plot(time,abs(tri,0)-3,label='A middle',linewidth=line_width)
# plt.plot(time,abs(tri,0.3)-4,label='A counterclockwise',linewidth=line_width)
# plt.plot(time,abs(tri,0.7)-5,label='A more counterclockwise',linewidth=line_width)

plt.plot(time,tri,'k',label='input wave',linewidth=line_width)
plt.plot(time,doubler(tri,1),color=Dcolor,label='doubled wave',linewidth=line_width)
plt.axis('off')
plt.legend(fontsize=font_size)
plt.savefig('tri_doubled.png', edgecolor='none', dpi=400, bbox_inches='tight', transparent=True)
if(show_to_user):
	plt.show()
else:
	plt.clf()

plt.plot(time,sin,'k',label='input wave',linewidth=line_width)
plt.plot(time,doubler(sin,1),color=Dcolor,label='doubled wave',linewidth=line_width)
plt.axis('off')
plt.legend(fontsize=font_size)
plt.savefig('sin_doubled.png', edgecolor='none', dpi=400, bbox_inches='tight', transparent=True)
if(show_to_user):
	plt.show()
else:
	plt.clf()

plt.plot(time,tri,'k',label='input wave',linewidth=line_width)
plt.plot(time,crossover(tri,-0.3),color=Xcolor,label='counterclockwise X',linewidth=line_width)
plt.plot(time,crossover(tri,-0.6),color=Xcolor,label='counterclockwise X',linewidth=line_width)
plt.axis('off')
plt.legend(fontsize=font_size)
plt.savefig('crossover1.png', edgecolor='none', dpi=400, bbox_inches='tight', transparent=True)
if(show_to_user):
	plt.show()
else:
	plt.clf()

plt.plot(time,tri,'k',label='input wave',linewidth=line_width)
plt.plot(time,crossover(tri,0.3),color=Xcolor,label='clockwise X',linewidth=line_width)
plt.plot(time,crossover(tri,0.6),color=Xcolor,label='clockwise X',linewidth=line_width)
plt.axis('off')
plt.legend(fontsize=font_size)
plt.savefig('crossover2.png', edgecolor='none', dpi=400, bbox_inches='tight', transparent=True)
if(show_to_user):
	plt.show()
else:
	plt.clf()

plt.plot(time,tri,'k',label='input wave',linewidth=line_width)
color=plt.plot(time,abs(tri,-0.2),color=Acolor,label='counterclockwise A',linewidth=line_width)
color=plt.plot(time,abs(tri,-0.8),color=Acolor,label='counterclockwise A',linewidth=line_width)
plt.axis('off')
plt.legend(fontsize=font_size)
plt.savefig('abs1.png', edgecolor='none', dpi=400, bbox_inches='tight', transparent=True)
if(show_to_user):
	plt.show()
else:
	plt.clf()

plt.plot(time,tri,'k',label='input wave',linewidth=line_width)
color=plt.plot(time,abs(tri,0.2),color=Acolor,label='clockwise A',linewidth=line_width)
color=plt.plot(time,abs(tri,0.8),color=Acolor,label='clockwise A',linewidth=line_width)
plt.axis('off')
plt.legend(fontsize=font_size)
plt.savefig('abs2.png', edgecolor='none', dpi=400, bbox_inches='tight', transparent=True)
if(show_to_user):
	plt.show()
else:
	plt.clf()