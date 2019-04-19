## Step 1

To begin your first Server-side project, you need to earn the powers to take your Swift up and above!

fire up your favorite terminal and...



# Behold the power of Brew!



`brew tap vapor/tap`

`brew install vapor/tap/vapor`





> ### *or if you are on Linux...*



# Behold the power of Curl!



`eval "$(curl -sL check.vapor.sh)"`



you should end up with something like this...

![image-20190417154904302](Today-I-Read/checkpoint.png)



------



#### Now that you've earned the powers of Vapor, you need to deserve them...



![image-20190417155457599](/Users/ahmedramy/Desktop/Workstation/iOS/Today-I-Read/great powers, great responsibilities.png)



### Let's Fire up our first Server-side App



In the directory of your choice, make a directory and type the following command

`mkdir ~/{Your selectedPath}`
`vapor new TIR`  # TIR stands for Today I read

`cd TIR`

`vapor build`
`vapor run`


What this does here is creating the project for you, you can specify templates to get a headstart with your project for instance some RESTful API project with data filled in already, or stuff that's similar

run here fires up the system, if you tried to open your browser on the following localHost path

you should expect something like this

![image-20190417160123709](/Users/ahmedramy/Desktop/Workstation/iOS/Today-I-Read/hello, world!.png)

but if you open up the file directory where you created the project at, 
you won't find any xcode project file to run and actually work with the files you may find in the project...

------


next step here is to tell Vapor toolbox to generate you the xcode project file for us to start building the stuff!

`vapor Xcode -y`

------



### Now we created our app and are ready to rain bombs from the cloud on the mobile domain!

### Now head to the next step by executing the following command

`git checkout step-2`

