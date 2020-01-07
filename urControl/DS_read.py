import os
import pandas as pd
import urx
import time
import msvcrt

#This program should be run in terminal in Windows

mypose = [] # unit: m, rad
mytime= [] # unit: s

dt = 0.03 #sample period (s)
N = int(input("\nNo.: "))

#connect to the robot, using 30003 to read data
rob = urx.Robot("192.168.1.2",use_rt=True)

path = os.getcwd()
filePose = (path+"\\Pose_{}.csv").format(N)

print("\nInput any key to start:")

msvcrt.getch() # wait key to start
print("Start!")
print("\nInput #Enter to stop")

#set the robot to freedrive mode
rob.set_freedrive(val=True,timeout=3600)

startTime = time.time()
while True:
    if msvcrt.kbhit():
        key = msvcrt.getch() #wait the Enter key to stop
        if key == b'\r':
            break
    mytime.append(time.time()-startTime)
    mypose.append(rob.get_myPose())
    # myspeed.append(rob.get_mySpeed())
    time.sleep(dt)
endTime = time.time()

#end the freedrive mode
rob.set_freedrive(val=False)
rob.close()

print("\nEnd!")
print("Program time: ",endTime-startTime,"s\n")

##========================================
# Save the data

column_label1 = ['x','y','z','rx','ry','rz']

pd_pose = pd.DataFrame(columns=column_label1,index=mytime,data=mypose)
pd_pose.to_csv(filePose)
