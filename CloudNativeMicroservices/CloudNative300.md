![](images/300/PictureLab.png)  

Update: February 2, 2017

## Introduction

This is the third of several labs that are part of the **Oracle Public Cloud Native Microservices** workshop. This workshop will walk you through the Software Development Lifecycle (SDLC) for a Cloud Native project that will create and use several Microservices.

In the previous lab (200), the Java Developer created several microservices that pull data from twitter and allow for dynamic filtering based on keywords. In this lab, you will assume the role of the front-end JavaScript developer who will create a web application that incorporates the data from those microservices. This node.js application will be developed in the Developer Cloud Service taking advantage of automated builds and deployments to the Application Container Cloud Service.

Please direct comments to: Dennis Foley (dennis.foley@oracle.com)

## Objectives

- Access Developer Cloud Service
- Import Code from external Git Repository
- Import Project into Brackets
- Build and Deploy project using Developer Cloud Service and Oracle Application Container Cloud Service

## Required Artifacts

- The following lab an Oracle Public Cloud account that will be supplied by your instructor. You will need to download and install latest version of Brackets text editor.


# Create Initial Twitter Marketing UI Service

## Explore Developer Cloud Service

### **STEP 1**: Login to your Oracle Cloud Account

- If you just completed lab 200, or if you are still logged in as Lisa.Jones, you will need to first sign out before continuing this lab. Sign out by clicking on the user’s name (lisa.jones) at the top right corner of the screen, then selecting **Sign Out** from the dropdown menu.

    ![](images/300/Picture1.png)  

- Now we can login again. From any browser, go to the following URL: https://cloud.oracle.com

- Click **Sign In** in the upper right hand corner of the browser

    ![](images/300/image003.png)  

- ***IMPORTANT*** - Under My Services, ***ask your instructor*** which **Region** to select from the drop down list, and **click** on the **My Services** button.

    ![](images/300/image004.png)  

- Enter your identity domain and click **Go**

    **NOTE:** the **Identity Domain, User Name and Password** values will be given to you from your instructor.

    ![](images/300/image005.png)  

- Once your Identity Domain is set, enter your User Name and Password and click **Sign In**

    ***NOTE:*** For this lab you will be acting as the JavaScript Developer ***John Dunbar***. As with the previous lab, if you are not able to support multiple users, login as a supported user, and assume the “logical” identify of John Dunbar, the JavaScript Developer.

    ![](images/300/image006.png)  

- You will be presented with a Dashboard displaying the various cloud services available to this account.

    ![](images/300/image007.png)  

### **STEP 2:**	Login to Developer Cloud Service

Oracle Developer Cloud Service provides a complete development platform that streamlines team development processes and automates software delivery. The integrated platform includes issue tracking system, agile development dashboards, code versioning and code review platform, continuous integration and delivery automation, as well as team collaboration features such as wikis and live activity stream. With a rich web based dashboard and integration with popular development tools, Oracle Developer Cloud Service helps deliver better applications faster.

- From Cloud UI dashboard click on the **Developer** service. In our example the Developer Cloud Service is named **developer71725**.

    ![](images/300/image008.png)  

- The Service Details page gives you a quick glance of the service status.

    ![](images/300/image009.png)  

- Click **Open Service Console** for the Oracle Developer Cloud Service. The Service Console will list all projects that you are currently a member.

    ![](images/300/image010.png)  

### **STEP 3**: Review Agile Board

- Click **Twitter Feed Marketing Project** to access the project.

    ![](images/300/image011.png)  

- Click on **Agile** on the navigation panel.

    ![](images/300/image012.png)  

- If the **Microservices** is not the default board, click on the current board’s dropdown, select the filter **All**, and click on **Microservices**

    ![](images/300/image013.png)  

- Click on the **Microservices** Board **Active Sprints**.

    ![](images/300/image014.png)  

## Create Initial Git Repository

### **STEP 4**: Create Initial Git Repository

As in the previous lab, we could start coding this application from scratch at this point. However, one of our colleagues has already begun working on the shell for our web application outside of the Developer Cloud Service. We want to use his work as a starting point and extend it to incorporate our twitter microservices. To pull his code into the Developer Cloud Service, we will clone his external GIT repository. First let’s update our agile board to show that we are working on this task:

- Drag and drop **Task 3 - Create Initial GIT Repository for Twitter Marketing UI** into the **In Progress** swim-lane.  Click **OK** on Change Progress popup.

    ![](images/300/image015.png)  

    ![](images/300/image016.png)  

- Click on **Project** on the navigation panel.

- Click on **New Repository** to create a new Git Repository

    ![](images/300/image017.png)  

- In the New Repository wizard enter the following information and click **Create**.

    **Name:** `TwitterMarketingUIMicroservice`

    **Description:** `Twitter Marketing UI Microservice`

    **Initial content:** Import existing repository and enter the URL: `https://github.com/oraclenassolutionengineering/JETTwitterQuickStart.git`

    ![](images/300/image018.png)  

- You have now created a new GIT repository based on an existing repository.

    ![](images/300/image019.png)  

## Create Default Build and Deployment Process

### **STEP 5**: Create Default Build Process

Now that we have the source code in our managed GIT repository, we need to create a build process that will be triggered whenever a commit is made to the master branch. We will set up a shell script build process in this section.

- Click **Build** on the navigation panel to access the build page and click **New Job**.

    ![](images/300/image020.png)  

- In the New Job popup enter `Twitter Marketing UI Build` for Job Name and click **Save**.

    ![](images/300/image021.png)  

- You are now placed into the job configuration screen.

    ![](images/300/image022.png)  

- Click the **Source Control** tab. Click Git and select **TwitterMarketingUIMicroservice.git** from the URL drop down.

    **Note:** Make sure you select the Git repository for the Twitter Marketing UI Microservice.

    ![](images/300/image023.png)  

- Click the **Triggers** tab.  Select Based on **SCM polling schedule**.

    ![](images/300/image024.png)  

- Click the **Build Steps** tab. Click **Add Build Step**, and select **Execute shell**.

    ![](images/300/image025.png)  

- For **Command** enter: `npm install`

    ![](images/300/image026.png)  

- Click the **Post Build** tab. Check **Archive the artifacts** and enter `**/target/*` for Files to Archive.  Verify **GZIP** in the Compression Type.

    ![](images/300/image027.png)  

- Click **Save** to complete the configuration. A build should start automatically within a minute or two.  If it does not start automatically, click on the **Build Now** button. The status will change to the following:

    ![](images/300/image028.png)  

- Once the build begins, it should take about approximately 1 to 2 minutes for the build to complete. Wait for the build to complete before continuing on to the next step, as we need the build artifact to create the deployment configuration.

    ![](images/300/image029.png)  

### **STEP 6**: Create Default Deployment Process

Now that we have an automated build process, we will set up a deployment configuration that will push our build artifacts to a node.js environment running on the Application Container Cloud Service whenever a successful build occurs.

- Click Deploy to access the Deployment page and click **New Configuration**.

    ![](images/300/image030.png)  

- Enter the following data:

    **Configuration Name:** `TwitterMarketingUIDeploy`

    **Application Name:** `JETFrontEndApp`

    ![](images/300/image031.png)  

- Right of Deployment Target click **New** and select **Application Container Cloud**

    ![](images/300/image032.png)  

- Enter the following data and click Test Connection. If Successful click Use Connection

    **Data Center**: `<Your Assigned Datacenter>` ***(Ask instructor if needed)***

    **Identity Domain**: `<Your Identity Domain>`

    **Username**: `john.dunbar` **(or your appropriate username if running as single user)**

    **Password**: `<Supplied Password>`

    ![](images/300/image033.png)  

- Set ACCS Properties to Runtime **Node** and Subscription **Hourly**. Click Type **Automatic**. Select Job **Twitter Marketing UI** Build and select **target/jet-quickstart-client-dist.zip** for Artifact.

    ![](images/300/image034.png)  

- Click **Save**

    ![](images/300/image035.png)  

- Click drop down and select **Start**

    ![](images/300/image036.png)  

- Wait until the message **Starting application** changes to **Last deployment succeeded**

    ![](images/300/image037.png)  

## Verify default deployment of Twitter Marketing UI

### **STEP 7**: Change status to Verified

Now that we have successfully deployed the build artifact to the Application Container Cloud Service, we will update our agile board to reflect that status. Although the complexity of the next task (verification) is quite simple, we will still move the task to the “Verify Code” column before manually verifying the new functionality.

- Click on **Agile**, followed by clicking **Active Sprints**. Drag and drop **Task 3** from **In Progress** to the **Verify Code** column.

    ![](images/300/image039.png)  

- In the Change Progress popup, click on **OK**

    ![](images/300/image040.png)  

- The code is now ready for verification before moving to Completed

    ![](images/300/image041.png)  

### **STEP 8**: Login to Oracle Application Container Cloud Service

- Navigate back to the Oracle Public Cloud tab. Click **Dashboard** to return back to main Cloud Service Dashboard.

    ![](images/300/image042.png)  

- On the Application Container Cloud Service (ACCS) click ![](images/300/image043.png)  and select **Open Service Console**

    ![](images/300/image044.png)  

- On the ACCS Service Console you can view all the deployed applications including our newly create **JETFrontEndApp**.

    ![](images/300/image045.png)  

- Click on URL to bring up the application.

    ![](images/300/image046.png)  

### **STEP 9**: Complete Task

We have now verified that our application has been deployed and is functional. To finish up this part of the lab we will want to mark the Issue as completed in our Sprint.

- Back in the Developer Cloud Service, click **Agile**, followed by clicking **Active Sprints**.

- Drag and drop **Task 3** from **Verify Code** to **Completed**.

    ![](images/300/image047.png)  

- In the Change Progress popup click **Next** and then **OK**

    ![](images/300/image048.png)  

- Your Sprint should now look like the following:

    ![](images/300/image049.png)  

# Extend default application to Display Twitter Feed

Now that we have our default application we want to extend this application to add the display of the twitter feed. For this task we will use Brackets text editor to pull down the code from Developer Cloud Service and add in our modifications. Once the new code is ready for deployment we will check the code in on a branch so that it can go through a code review prior to build and deployment.

### **STEP 10**: Move Task to In Progress

To start this part of the lab we will want to mark the Issue as In Progress in our Sprint.

- Back in the Developer Cloud Service, click **Agile**, followed by clicking **Active Sprints**.

- Drag and drop **Feature 4** from **To Do** to **In Progress**.

    ![](images/300/image050.png)  

- In the Change Progress popup click **OK**

    ![](images/300/image051.png)  

## Clone Project to Brackets Text Editor

### **STEP 11**:	Start Brackets Text Editor

- Start **Brackets** text editor. How you start Brackets will depend on your OS. We have documented how to start Brackets from our OEL image.

**Note**: If you do not have Brackets installed please follow the appendix.

- Right click **Brackets** desktop icon and select **Open**

    ![](images/300/image052.png)  

- Brackets should open with the **TwitterMarketingUI** folder already loaded.

    ![](images/300/image053.png)  

### **STEP 12**: Copy GIT URL

- Back in Developer Cloud Service, click on **Project**. On right side, select the URL for **TwitterMarketingUIMicroservice.git**. Right click and select **Copy**

    ![](images/300/image054.png)  

### **STEP 13**: Clone GIT Repository

- Back in the Brackets editor, on the right hand side, click ![](images/300/image055.png) GIT icon.

  ![](images/300/image056.png)  

- Click **Clone** and paste in Git URL that you captured from Developer Cloud Service. Username should be populated automatically. Enter your **Password** and click **Save credentials**. Once completed click **OK** to start the cloning process.

    ![](images/300/image057.png)  

- While the clone is running a dialog box will show you the progress.

    ![](images/300/image058.png)  

- You now have a local copy of the repository.

    ![](images/300/image059.png)  

### **STEP 14**: Run Live Preview.

- Before we make our code changes lets first run the code locally.

- Expand **doc_root** and select i**ndex.html**

    ![](images/300/image060.png)  

- On right hand panel, click ![](images/300/image061.png) Live Preview. This will start your JavaScript application in a browser. Once you verify the application is working you can close the browser.

![](images/300/image062.png)  

## Add Code to display Twitter Feed in Table Format

### **STEP 15**:	Modify graphics.html

- Expand **doc_root -> js -> views** and click **graphics.html**.

    ![](images/300/image063.png)  

- Replace the existing code with the code block below:

```
<h1>Graphics Content</h1>

<table id="table" summary="Tweet List" data-bind="ojComponent:{component:'ojTable',
        data: tweets,
        columns: [
               {headerText: 'User Name', field: 'User', id: 'name', sortable: 'enabled'},
               {headerText: 'User Location', field: 'Location', id: 'location', sortable: 'enabled'},
               {headerText: 'Source', field: 'Source', id: 'source', sortable: 'enabled'},
               {headerText: 'Tweet', field: 'Text', id: 'text'}
               ],
        rootAttributes: {'style':'width: 100%; height:100%;'},
        scrollPolicy: 'loadMoreOnScroll',
        scrollPolicyOptions: {'fetchSize': 10}}">
</table>
```

![](images/300/image064.png)  

### **STEP 16**: Modify graphics.js

- Expand **doc_root -> js -> viewModels** and click **graphics.js**.

    ![](images/300/image065.png)  

- Add the code block below to the bottom on the **graphics.js** file:

```
/*global $, define, console*/
/*jslint sloppy:true*/

define(['ojs/ojcore', 'knockout', 'ojs/ojtable'], function (oj, ko) {

    function mainContentViewModel() {

        // change this root variable to point to YOUR environment
        var root = 'https://javatwittermicroservice-metcsgse00210.apaas.em2.oraclecloud.com/',
            self = this,
            uri = 'statictweets/',
            prettySource = function (source) {
                return source.substring(source.indexOf('>') + 1, source.lastIndexOf('<'));
            },
            url = root + uri;

        self.items = ko.observableArray([]);
        self.tweets = new oj.ArrayTableDataSource(self.items, {
            idAttribute: 'Id'
        });

        $.ajax({
            url: url,
            method: 'GET'
        }).success(function (result) {
            console.log(result.tweets);
            var items = self.items();
            ko.utils.arrayForEach(result.tweets, function (value) {
                // make sure this is a creation tweet
                if (!!value.user) {
                    items.push({
                        Id: value.id,
                        Location: value.user.location,
                        Text: value.text,
                        Source: prettySource(value.source),
                        User: value.user.name
                    });
                }
            });
            self.items.valueHasMutated();
        });
    }
    return mainContentViewModel;
});
```

- Back in the browser; navigate back to the Application Container Cloud Service service console. Copy URL for **JavaTwitterMicroservice** that was created in Lab 200.

    ![](images/300/image066.png)  

- Replace existing URL with your URL for the **root variable**. Make sure there is a '`/`' (backslash) at the **end of the URL**.

    ![](images/300/image067.png)  

- Completed graphics should look something like the image below:

    ![](images/300/image068.png)  

- Save all files by clicking **File -> Save All**

![](images/300/image069.png)  

### **STEP 17**: Test new changes

- Click ![](images/300/image070.png) Live Preview to test out the new changes.

- Click ![](images/300/image071.png) and select **Graphics**

    ![](images/300/image072.png)

- In the graphics sections you can now see all the twitter feed data:

    ![](images/300/image073.png)

# Create a new Branch and Commit Code

## Create a Branch and Commit Code

### **STEP 18**: Create a new Branch and Commit Code

- First we need to create a new branch to check in all of our changes for this feature. In the left hand navigation panel, select **master** and click **Create new branch**.

    ![](images/300/image074.png)

- In popup window, **enter** `Feature4` for branch name and click **OK**.

    ![](images/300/image075.png)

- Click  Git ![](images/300/image076.png) icon. Check the box next to **Commit** to select all modified files.

    ![](images/300/image077.png)

- Click **Commit**.

- In popup enter the **comment** `Added code to display twitter feed in table format` and click **OK**. This will commit the changes to your local Git repository.

    ![](images/300/image078.png)

- Click ![](images/300/image079.png) Git Push icon.

- In popup window leave all defaults and click **OK**

    ![](images/300/image080.png)

- Once Git Push completes click **OK**.

    ![](images/300/image081.png)

### **STEP 19**: Complete the Display Twitter Feed Task

- Back in the Developer Cloud Service window, click **Agile**, followed by clicking **Active Sprints**.  Make Sure you are viewing the **Microservices** board.

- Drag and drop **Feature 4** from **In Progress** to **Verify Code**.

    ![](images/300/image082.png)

- In the Change Progress popup click **Next** and then **OK**.

    ![](images/300/image083.png)

## Create Merge Request

### **STEP 20**: Review Sprint Status and create Merge Request

- Click on the **Code** tab, select the **Feature4** branch and then click on the **Commits** sub tab. Now view the recent commit that we made to branch from Brackets.

    ![](images/300/image084.png)

- Now that John Dunbar has completed the task of displaying twitter feed in table format, a Merge Request can be created by John and assigned to Lisa Jones. Click on **Merge Requests**, and then click on the **New Merge Request button**.

    ![](images/300/image085.png)

- Enter the following information into the New Merge Request and click **Next**

    **Repository:** `TwitterMarketingUIMicroservice.git`

    **Target Branch:** `master`

    **Review Branch:** `Feature4`

    ![](images/300/image086.png)

- Enter the following information into Details and click **Create**

    **Summary:** `Merge Feature 4 into master`

    **Reviewers:**  `Lisa Jones` (or current user in non-multi user env)

    ![](images/300/image087.png)

- In the **Write** box, enter the following comment and then click on the **Comment** button to save

    **Comment:** `I added table of Twitter feed to graphics tab`

    ![](images/300/image088.png)

## Merge the Branch as Lisa Jones

In the following steps “Lisa” will merge the branch created by “John” into the master.

***NOTE: If you are using a single user environment, you will skip the next step, and go to the following step titled: “Merge Requests”***

### **STEP 21**: Sign Out as John Dunbar and Sign In as Lisa Jones

- Click on the **john.dunbar** dropdown located in the top right corner of the screen. Select **Sign Out**.

    ![](images/300/image089.png)

- Following the previously documented steps, go to the URL: http://cloud.oracle.com, click on **Sign In** found on the Top Right corner of the window. As previously performed, select your **correct Data Center**, click on the **My Services** button, enter the correct **Identity Domain** and click on **Go**.


- Enter `lisa.jones` for the username, and enter your password. Click on **Sign In**.

    ![](images/300/image090.png)

- When the Dashboard is displayed, click on the **Developer Cloud Service**.

    ![](images/300/image091.png)

- From the Developer Cloud Service Dashboard, click on the **Open Service Console** button

    ![](images/300/image092.png)

- Select the **Twitter Feed Marketing Project**

    ![](images/300/image093.png)

### **STEP 22**: Merge Requests

- Click on **Merge Requests**. Select the **Assigned to Me** search. After the search completes, click on the **Merge Feature 4 into master** assigned request.

    ![](images/300/image094.png)

- Once the request has loaded, select the **Changed Files tab**. As the persona Lisa, you will now have the opportunity to review the changes in the branch, make comments, request more information, etc. before Approving, Rejecting or Merging the Branch.

    ![](images/300/image095.png)

- Click on the **Merge** button.

    ![](images/300/image096.png)

- Leave the defaults, and click on the **Merge** button in the confirmation dialog.

    ![](images/300/image097.png)

- Now that the code has been committed to the Developer Cloud Service repository, the build and deployment will automatically start. Click on **Build**, and you should see a **Twitter Marketing UI Build** in the Queue

    ![](images/300/image098.png)

- Wait a minute or two for the build to complete. The **Last Success** will be set to **Just Now** when the build completes.

    ![](images/300/image099.png)

- Click on Deploy. Wait for the **Deploy** Status to change to **Deployment update in progress**, and then change to **Last deployment succeeded** – **Just now**.

    ![](images/300/image100.png)

## Test the JETFrontEndAPP UI in the Cloud

### **STEP 23**: Test the Front End

- Once the service has successfully deployed, click on the **JETFrontEndApp** link

    ![](images/300/image101.png)

- When the new browser tab loads, click **Graphics** to display twitter feed data.

    ![](images/300/image102.png)

- To complete the Sprint Feature, click on **Agile** in the Twitter Feed Marketing Project Dashboard. Then click on the **Active Sprints** button.

    ![](images/300/image103.png)

- Complete the feature request by Dragging and Dropping **Feature 4** (Display Twitter Feed in Table Format) from the **Verify** Column to the **Completed** Column.

    ![](images/300/image104.png)

- Set the Status to **VERIFIED – FIXED** and click **Next** and then **OK**

    ![](images/300/image105.png)

- You are now ready to move to the next lab.

# Appendix 1 – Installing Brackets and Git

Download and Install Git

### **STEP 24**: Download Git

- Go to the following URL: https://git-scm.com/downloads

    ![](images/300/image106.png)

- Select you OS. In our example we will show how to install on Windows. Click **Windows** Download and click **Save File**

    ![](images/300/image107.png)

- Select you download location and click **Save**. We will use D:\Software

    ![](images/300/image108.png)

- Open Windows Explorer and navigate you where you downloaded the Git executable. Double click on Git executable to start install process.

    ![](images/300/image109.png)

- Run through the installation process

    ![](images/300/image110.png)

## Download and Install Brackets Text Editor

### **STEP 25**: Download Brackets Text Editor

- Go to the following URL: http://brackets.io

    ![](images/300/image111.png)

- Click **Download Brackets 1.7** then click **Save File**

    ![](images/300/image112.png)

- Select you download location and click **Save**. We will use D:\Software

    ![](images/300/image113.png)

- Open Windows Explorer and navigate you where you downloaded Brackets. Double click on Git executable to start install process.

    ![](images/300/image114.png)

- Run through the installation process

## Start Brackets and Configure Git

### **STEP 26**: Start Brackets and Configure Git

- Create directory T**witterMarketingUI**. From Windows Explorer navigate to the directory **TwitterMarketingUI**, right click and select **Open as Brackets Project**

    ![](images/300/image115.png)

- Select **File -> Extension Manager...**

- In search window enter `GIT`. Click **Install** for **Brackets Git**

    ![](images/300/image116.png)

- After install completes, leave defaults for Git Settings and click **Save**

    ![](images/300/image117.png)

- Click **OK** to restart Brackets

    ![](images/300/image118.png)

- You will now see the Git icon on the right hand panel

    ![](images/300/image119.png)
