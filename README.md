## Step 1

To begin your first Server-side project, you need to earn the powers to take your Swift up and above!

To earn those powers we need to know if you're WORTHY

fire up your favorite terminal, but...



# Mr. Eval here will see if you're

`eval "$(curl -sL check.vapor.sh)"`

you should end up with something like this...

![should be fine](https://github.com/ARamy23/Today-I-Read/blob/step-1/checkpoint.png)



If you end up with something like this, you are ready to use Vapor and install it, if not, you gonna have to update your Xcode



Now to the installing part



# Behold the power of Brew!



`brew tap vapor/tap`

`brew install vapor/tap/vapor`



#### Now that you've earned the powers of Vapor, you need to deserve them...



![](https://github.com/ARamy23/Today-I-Read/blob/step-1/great%20powers%2C%20great%20responsibilities.png)



### Let's Fire up our first Server-side App



In the directory of your choice, make a directory and type the following command

`mkdir ~/{Your selectedPath}`
`vapor new TIR` 

`cd TIR`

`vapor build`
`vapor run`


What this does here is creating the project for you, you can specify templates to get a headstart with your project for instance some RESTful API project with data filled in already, or stuff that's similar

run here fires up the system, if you tried to open your browser on the following localHost path

you should expect something like this

![hello, world](https://github.com/ARamy23/Today-I-Read/blob/step-1/hello%2C%20world!.png)

but if you open up the file directory where you created the project at, 
you won't find any xcode project file to run and actually work with the files you may find in the project...

------


next step here is to tell Vapor toolbox to generate you the xcode project file for us to start building the stuff!

`vapor Xcode -y`

------



### Now we created our app and are ready to rain bombs from the cloud on the mobile domain!

### Now head to the next step by executing the following command

`git checkout step-2`

