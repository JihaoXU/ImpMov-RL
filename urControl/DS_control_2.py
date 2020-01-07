import onnx
from onnx_tf.backend import prepare
import numpy as np
import os
import pandas as pd
import time
import msvcrt
import urx

os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'

print("\nDS: newPolicy")
N = int(input("\nNo.: "))

path = os.getcwd()
filePose = (path+"\\DS_newPolicy_Pose_{}.csv").format(N)

model = onnx.load('newPolicy450.onnx')
newPolicy = prepare(model)

recPose = []
recTime = []
XD=np.array([[0,0,0],[0.5,0,0],[-0.5,0,0],[0,0.5,0],[0,-0.5,0]])
xd=XD[N-1,:]
goal=np.array([-7.24412093378752,-4.07353966583585,0.220879116932907])
x0=np.array([4.87597029690398,-2.48125229981619,2.58900872710849])
pose0=((x0+goal)/10).tolist()+[3.142,0,0]
dt=0.05

rob = urx.Robot("192.168.1.2",use_rt=True)

print("\nPress any key to initialize:")
msvcrt.getch() # wait key to start
print("Move to the initial pose, waiting")
rob.movel(pose0,vel=0.15,acc=0.5)
print("\nPress any key to start:")
msvcrt.getch() # wait key to start
print("\nInput #Enter to stop")

startTime = time.time()
while True:
    if msvcrt.kbhit():
        key = msvcrt.getch() #wait the Enter key to stop
        if key == b'\r':
            break

    curTime=time.time()-startTime
    curPose=rob.get_myPose()
    recTime.append(curTime)
    recPose.append(curPose)

    curPosition=np.array(curPose[0:3])*10-goal-xd

    if np.linalg.norm(curPosition)<0.13 or curTime>17:
        break

    desVelocity=np.squeeze(np.array(newPolicy.run(curPosition.reshape([1,1,3,1]))))/10
    desVelocity=desVelocity/9
    desVelocity=desVelocity.tolist()+[0,0,0]
    rob.speedl(velocities=desVelocity,acc=3,min_time=1)
    time.sleep(dt)

endTime = time.time()
rob.stopl(acc=3)
time.sleep(dt)
rob.close()

print("\nEnd!")
print("Program time: ",endTime-startTime,"s\n")

##========================================
# Save the data

column_label = ['x','y','z','rx','ry','rz']
pd_position = pd.DataFrame(columns=column_label,index=recTime,data=recPose)
pd_position.to_csv(filePose)
