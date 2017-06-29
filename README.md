# Readme - Proposal -  Productify
[![BCH compliance](https://bettercodehub.com/edge/badge/majstomphorst/productify?branch=master)]

## Programmeerproject - Maxim Stomphorst - 11436727

# Table of contents 
1. [Introduction](#introduction)
2. [The application - UI](#application)
 - [The probem to solve](#problem)
 - [What features](#features)
 - [A sketch](#sketch)
3. [The application - back end](#back)
 - [How to store data](#store)
 - [Application parts](#parts)
 - [External components](#components)
 - [Technical limitations.](#limitations)
4. [similar mobile apps.](#review)
5. [Screen shots](#screenshots)
6. [Proces book ](#proces)


 

## introduction <a name="introduction"></a>


## The application <a name="application"></a>
### The problem to solved. <a name="problem"></a>
De behoeften om studie / werk activiteiten bij te houden. Om vervolgens een overzicht te krijgen van de verrichten activiteiten per tijds periode.

Het hoger doel is om iemand te stimuleren productiever of gerichter zijn of haar taken te vervullen.

### What features. <a name="features"></a>
- Registreren van studie activiteiten. 
- Verwijderen van studie activiteiten.
- Toevoegen van studie activiteiten met een icoon.(Wiskunde met een plaatje)
- verwijderen van icoontjes.

#### Minimum features
1. Het selecteren van een activiteit.<br> 
2. Het bijhouden van een studie/activiteit.<br>
 - Met een timer.
 - De focus tijd instellen.
 - Met een notitie.
3. Een manier om een overzicht te krijgen van de afgelopen activiteiten per dag.
 - Het zien van de notitie.
 - Het zien vah het activiteit's plaatje.
4. Het uploaden van activiteit's plaatjes.

#### Optional features

2. Het maken van een bar chart en of pie chart.
3. Syncronisatie mogenlijkheid.
4. Een Manier om activiteiten na der hand aan te passen. 


### A sketch. <a name="sketch"></a>
![proposal sketch](https://github.com/majstomphorst/producitfy/blob/master/doc/proposal_sketch.jpg?raw=true)

## The application - back end <a name="back"></a>

### How to store data. <a name="store"></a>
De keuze die ik had was SQLlite of Firebase, na overleg met de staff is er gekozen voor <b>Firebase</b>. <br>
Omdat dit direct de mogenlijkheid bied om informatie te synchroniseren ook is de API implenentatie van Firebae gemakenlijker dan die van sqlite in [`swift`](https://github.com/stephencelis/SQLite.swift) 

### application parts <a name="parts"></a>

##### 01 - Main
Dit is de main controller waar je de activiteit kan starten.
##### 02 - Overview
Is de terugblik op de geselecteerde periode. Zodat je kan zien wat je hebt gedaan.
##### 03 - Settings
Hier kan je de instellingen van de app aanpassen. 

### External components <a name="components"></a>
- [Firebase](https://firebase.google.com/)
- [Kingfisher](https://github.com/onevcat/Kingfisher)


### Technical limitations. <a name="limitations"></a>
1. De visualisatie van de activiteiten in bar charts of pie chart. [optional]
2. Het opzoeken van specifieke activiteiten in firbase.


## similar mobile apps. <a name="review"></a>
Ik heb een aantal apps gevonden die soortelijke functionaliteit leveren maar ze zijn niet gericht op het bijhouden van studie activiteiten.

- [Productive](https://itunes.apple.com/us/app/productive-habits-daily-goals-tracker/id983826477?mt=8)<br>
Deze app bied wel wat functie om je te helpen om te focuesen op een taak maar deze is meer gericht op het ontwikkelen van habits.

- [Focus keeper](https://itunes.apple.com/nl/app/focus-keeper-work-study-timer/id830466924?mt=8)<br>
Is en app die enkel een timer bied om je te helpen met werken wel zitten er meer functies onder deze zijn echter wel "pro" en kosten dus geld.

- [Miracle Timer](https://itunes.apple.com/us/app/miracle-timer-be-productive-perfect-for-work-study/id1083895559?mt=8)<br>
Deze app geeft je enkele functies om een bepaalde tijdseenheid gefocust te werken maar heeft geen functie om bij te houden wat je hebt gedaan.

# Screen shots <a name="screenshots"></a>

# Proces book <a name="proces"></a>

### Day 01/19 - 06/06/17
1. App ontworpen
 - Nagedacht over de functionaliteit.
 - Nagedacht over het uiterlijk van de app.
 - ontwerp gemaakt zie proposal.md
2. Database gekozen
 - Er was een keuzen tussen SQLlite en Firbase. SQL had in eerste instantie de voorkeur omdat hier met een simpel command data op datum kon worden verzameld. maar naar overleg met de staff is er toch gekozen voor Firebase. 
Omdat de API gemakkenlijker is. Ook zijn de hindernissen van het selecteren en verzamelen van data volgens de staff te overkomen. Ook kan met firebase een syncronisatie van data gemakenlijker worden gerealiseerd.
En een online database is toch veel stoerder dan een suffe SQL database ;) 
3. Xcode setup
 - pod init
 - Installed Firbase
 - CollectionView setup
 - TabBarController setup
4. .md bestanden gemaakt
 - README.md
 - Proposal.md
 - proces.md

### Day 02/19 - 07/06/17
1. Meeting
 - Talked about the app idea's.
2. App develepment
 - Created simpel timer function.
3.  other activities
 - Created a DESIGN.md doc.

### Day 03/19 - 08/06/17
1. Meeting 
 - started working with the agile guidelines. see the mail for more info.
2. App develepment
 - Had a lot of annoying segue bugs.
 - I find it annoying to write down what my idea's are for struct and classes. I got a a general idea of the flow of the app but this is not set in stone. So what I will write Will is Very likely change.
 - But i think before the weekend a pre alpha build should be ready.

### Day 04/19 - 09/06/17
1. Meeting
 - talkt about the app progress and the idea's see mail.
2. App develpment
 - Extended the basis ui. 
 - Created selectable buttons.
 - Created a uitableview

### Day 05/19 - 10/06/17
1. Meeting
 - 
2. App develpment 
 - extended the UI 
 - Removed a lot of bug that i had with the login and registration
 - played around with time and dat in swift to create a not to store the information in firebas

### Day 06/19 - 11/06/17
1. meeting
 - no meeting weekend! 
2. App develpment
 - Updated some smal thing read a lot of tutorial.

### Day 07/19 - 12/06/17
1. meeting
- I was late. had to meet with my coach school related for next year.
2. App develpment
- finished the backend for the Alpha version!
- the UI is still very meh.

### Day 08/19 - 13/06/17
1. Meeting
- see mail. 
2. App develpment
- made a way to upload image to firebase
- updated the collection view to import a users specifik images and label!
### Day 10/19 - 14/06/17

### Day 11/19 - 15/06/17

### Day 12/19 16/06/17
1. Created a new project 
 - rebuild the compleet project
 
# Git hub commits 
## much better representation of what I have done.
commit 1805de038523a688f60c2523d4f7ef1c215fdad7
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Tue Jun 27 10:56:31 2017 +0200

    moreActivity info viewcontroller

commit ca2080449309239993d07bb0226e2701d7a12578
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Tue Jun 27 10:12:56 2017 +0200

    fix cancel button

commit cd6791ba9026a79c7a632abd9823ee0cb2d3c888
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Mon Jun 26 20:06:12 2017 +0200

    UI improvements

commit ad35de05609fb2ecbfe00f10e8e23b46d293093f
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Mon Jun 26 20:03:20 2017 +0200

    UI fixing

commit 578dca483f0816b68e63d890b9bce86f378c6139
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Mon Jun 26 19:32:37 2017 +0200

    bug fixing

commit 7214d2d1734c2ddfcecdddd663c2a872080bd8b6
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Mon Jun 26 19:09:10 2017 +0200

    You can now remove activitie's

commit 5743d3249b1c3a5ab6904f25fdf3a0726084efb5
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Mon Jun 26 15:30:22 2017 +0200

    We created the filter options in History view

commit a988ac4e932cd3de219f623d6caf6cd9a3aae9c8
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Mon Jun 26 13:38:19 2017 +0200

    Playing with timestamp's (optimisation)

commit 1efe94cc9fb4c110573a3a1815540342614e8c64
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Mon Jun 26 10:33:39 2017 +0200

    Completed:
    - Background notifications.
    - Resume, Cancel, Start buttons now work 100% (i hope)

commit ab8d702f570579258b58f9ab5c55d79488c38a92
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Sun Jun 25 14:52:29 2017 +0200

    Background timer working
    still buggy but working
    I have to take the cancel button into account

commit 679c6905218a7742be38bd255f963a385789ac79
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Sat Jun 24 19:42:51 2017 +0200

    Cleaning up code

commit 2ff1afddb492600138726c1124123ca205e657c6
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Sat Jun 24 19:36:06 2017 +0200

    Small performance improvements and cleaning up the code

commit 7d397b0d760eee2363482d37c14d1734be18c7bf
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Sat Jun 24 19:15:08 2017 +0200

    Cleaned up the time functions (it was very redundant)

commit 1869c3055376e09e7ce4a6187893fcac4dea86c6
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Sat Jun 24 18:50:29 2017 +0200

    Resign and active in the works

commit c19d202044e3d9bad6a25049491351efd410ce1b
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Sat Jun 24 13:25:34 2017 +0200

    Expending on back from background

commit 1f24280fae9f9223e8dd31affe5cd8f4fb6564b3
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Sat Jun 24 13:08:07 2017 +0200

    Found a way to update the UI when returning from background

commit 4d220aa6f3b6554b0839e4e6c51ee3816fe15af0
Author: majstomphorst <maxim.stomphorst@student.uva.nl>
Date:   Fri Jun 23 09:01:24 2017 +0200

    compress images before uploading

commit c8103d144b90de6ad62db30175f83d49bacfbee3
Author: majstomphorst <maxim.stomphorst@student.uva.nl>
Date:   Thu Jun 22 14:59:47 2017 +0200

    remove redundant view controller

commit 39f5de7dfd0005a0c64802eacd61bcf788d07209
Author: majstomphorst <maxim.stomphorst@student.uva.nl>
Date:   Thu Jun 22 14:53:27 2017 +0200

    bug fixing

commit cf6818c0d0b7cd37f26e190ca6cfe391d362f241
Author: majstomphorst <maxim.stomphorst@student.uva.nl>
Date:   Thu Jun 22 13:26:11 2017 +0200

    bug fix

commit b93c954b7d7aae375df014e7d8fa7a78e64214a0
Author: majstomphorst <maxim.stomphorst@student.uva.nl>
Date:   Thu Jun 22 13:19:25 2017 +0200

    Updated the ui of historyview

commit 1b644c3d76db71c29b4a5dab8b6e0f0d9fdc25c4
Author: majstomphorst <maxim.stomphorst@student.uva.nl>
Date:   Wed Jun 21 17:28:22 2017 +0200

    app icon and notifications

commit 97fc07763c06ff2f40310d7d77da6be9240c4183
Author: majstomphorst <maxim.stomphorst@student.uva.nl>
Date:   Wed Jun 21 14:16:06 2017 +0200

    Created a basic notification

commit 0d05d0d63ea425f1dbfb3755aefeb49a840359a9
Author: majstomphorst <maxim.stomphorst@student.uva.nl>
Date:   Wed Jun 21 10:00:47 2017 +0200

    fixing bugs

commit be47992327d6518693bf5b3a63e38ad472ac74af
Author: majstomphorst <maxim.stomphorst@student.uva.nl>
Date:   Wed Jun 21 09:40:27 2017 +0200

    Created way to filter on month and on week.

commit 3877dd445e5a4a17c83e81ef93e79e37d0599c94
Author: majstomphorst <maxim.stomphorst@student.uva.nl>
Date:   Tue Jun 20 17:23:51 2017 +0200

    updated bage

commit 0eaadac9002e677e8cdc7137cedcbfc9d863bd71
Author: majstomphorst <maxim.stomphorst@student.uva.nl>
Date:   Tue Jun 20 15:31:47 2017 +0200

    bug fix

commit 8f2c6a18f94996e5628ff2892a20a600c4184073
Author: majstomphorst <maxim.stomphorst@student.uva.nl>
Date:   Tue Jun 20 15:08:06 2017 +0200

    changing UIPicker

commit 9f87fd41d036e1be22267fe62d853bafc3fe53e7
Author: majstomphorst <maxim.stomphorst@student.uva.nl>
Date:   Tue Jun 20 14:54:26 2017 +0200

    collection view selection

commit 6263494a6965e963b6d662fed1efa2bf21727cf8
Author: majstomphorst <maxim.stomphorst@student.uva.nl>
Date:   Tue Jun 20 12:32:23 2017 +0200

    horizonal picker ??

commit 00e3e54fc5b44348e53f6496ff2fb64d06ec0c1f
Author: majstomphorst <maxim.stomphorst@student.uva.nl>
Date:   Tue Jun 20 11:55:33 2017 +0200

    Filter function with icon's!

commit 90caa81560ce7c6fa56ecbd99b04b33ea4d6e578
Author: majstomphorst <maxim.stomphorst@student.uva.nl>
Date:   Tue Jun 20 11:36:01 2017 +0200

    filter function fully working!

commit 1f0cdfb8a50f931e6c2dc606b2e3acc08b80b3d7
Author: majstomphorst <maxim.stomphorst@student.uva.nl>
Date:   Tue Jun 20 11:25:17 2017 +0200

    created a way to filter data

commit 28bb41d938621054366fb64b2a3233150e3111fa
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Mon Jun 19 21:13:18 2017 +0200

    small change's

commit a63c8f033c86597afb6e9515d321e53c98866cf0
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Mon Jun 19 21:10:53 2017 +0200

    created a way to filter on month's

commit ee31893b1e26c1fb55fbf85ff26cf75a7032dbaa
Author: majstomphorst <maxim.stomphorst@student.uva.nl>
Date:   Mon Jun 19 19:01:48 2017 +0200

    lock device orientation. (portrait only)

commit 1cdd1ea836a4a52d504d9022a7c66505522776cb
Author: Maj <majstomphorst@users.noreply.github.com>
Date:   Mon Jun 19 17:22:00 2017 +0200

    Update README.md

commit 760479b4c83f9c016333efdfc430ec8320939ef9
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Mon Jun 19 17:19:19 2017 +0200

    producitfy -> productify

commit 7669e161b4473376d90fdf9a102ac890671e62f3
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Mon Jun 19 17:13:41 2017 +0200

    copyed and update all .md files

commit ddc37cc11239749fa4c25691517a713ab87ffd82
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Mon Jun 19 17:05:19 2017 +0200

    Created upload function

commit bca9f052a51200675061b310ee19a423bd9b0a25
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Mon Jun 19 16:44:21 2017 +0200

    Cleaning up

commit 3c0725a7a7466088b6437e0f1f7cea366d1e4d92
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Mon Jun 19 16:32:58 2017 +0200

    conformaion VC is now active.

commit b4fc48674e53d294c97045eb075a4e23749c2a9e
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Mon Jun 19 16:23:32 2017 +0200

    Created a segue to send data from main to conformation VC

commit 61bd42465c2ef57bbbf38c04d6fbd2a0bd6432e3
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Mon Jun 19 15:56:03 2017 +0200

    Created ConformationViewController

commit d0fca5be6d9923aaaa578687720469745b5cde92
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Mon Jun 19 11:05:58 2017 +0200

    main collection view is working.

commit 68ce3f7d67801f147e34af21856ff7c2884bdcb3
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Mon Jun 19 10:49:21 2017 +0200

    working collection view. now connect to firebase

commit b06f3b58d5c68cf2dd020f2144ed7f352f35fb92
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Mon Jun 19 10:14:49 2017 +0200

    created second collection view in the main view

commit 91eeecbda709303caaaa723bceb6b28002348c11
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Mon Jun 19 09:47:48 2017 +0200

    fix signout button

commit 5356945c2500687dea3142ce495cdd77bb785925
Author: Maj <majstomphorst@users.noreply.github.com>
Date:   Sun Jun 18 21:32:54 2017 +0200

    Create .bettercodehub.yml

commit c53b11c20bac356407a9413af2a3bc0f530eda59
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Sun Jun 18 20:03:30 2017 +0200

    fix the bug solution add delaget

commit 552402dbdaa18843ef79893982a8088428ef20ef
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Sun Jun 18 19:54:45 2017 +0200

    got a bug didselectcell not working?

commit d0209269f70eea99d4feb163404af0a2b88c4d82
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Sun Jun 18 17:54:34 2017 +0200

    Created a way to send data back to a parent viewController
    UploadViewContoller gets info from UploadFromAppViewController.
    UploadViewContoller  <--- UploadFromAppViewController

commit 8b0990aa1e4645c3d8f0b78abac0d3f4fb79c47e
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Sun Jun 18 16:14:15 2017 +0200

    created a collection view to select a image from the app

commit 5966efbeb08566af9cb021947c8c5f7c4740b381
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Sat Jun 17 15:52:06 2017 +0200

    small improefments

commit 3c60e661c92197581c28fa862840668f33101d08
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Sat Jun 17 11:26:18 2017 +0200

    default signin value's

commit 4397fc35bb7551840ea58a28dc59fab301eb6632
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Sat Jun 17 11:10:50 2017 +0200

    Created a timer i think bug free

commit 16fe7b5381ee92acdd19318366c5290e46880d59
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Fri Jun 16 21:45:27 2017 +0200

    fix a loop bug ( every time it loaded all the icons) and fix the order so that its always the same.
    
    and created a way to remove labels!

commit f8c41e4c9c5bd0d14b627861bf667dc539a88610
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Fri Jun 16 21:03:18 2017 +0200

    fix a loop bug ( every time it loaded all the icons) and fix the order so that its always the same.

commit ee3510c2e44631a2aba2dc21e31f6aa9fcbf0b6a
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Fri Jun 16 20:41:45 2017 +0200

    Loading icons in a brilliant way <3

commit 8f54902c9b3fd5e181e44c2059d95fb6a840dea1
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Fri Jun 16 20:34:28 2017 +0200

    Reading database with label now icon's

commit add21be909acb96895383a95cc9f226c2a406079
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Fri Jun 16 18:38:05 2017 +0200

    Created a function to store and track a icon in firebase. next up reading icon's from firebase!

commit cd701e54474d8a00005388674728fd57ddd136d5
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Fri Jun 16 16:54:39 2017 +0200

    created uiimagePicker and UI

commit 28852006d6cc24ec9fa20d171f0edef07462f196
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Fri Jun 16 16:43:01 2017 +0200

    created upload popup

commit 13e0ab98c37526236b0e54e71d262956198b2737
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Fri Jun 16 15:41:49 2017 +0200

    Created uitable to edit the user icon and labels.

commit 862deec9af0d59d95100825172c0fd4a4f255296
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Fri Jun 16 15:22:55 2017 +0200

    created settings panel

commit f132eed38227e466473810c1d1accbaf2f29eaef
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Fri Jun 16 14:53:18 2017 +0200

    created the login and register page!

commit e3b7b44377fa8118d8e8fca7acb441d0cac45e72
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Fri Jun 16 12:41:07 2017 +0200

    add google.info.plist

commit e5af23f4b7a099efabec7770bc62f3b28dd03ff9
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Fri Jun 16 12:28:05 2017 +0200

    Init commit
    - Installed pod's
    - Connected Firebase

commit a6c853f11900290cbb70366c9bb55758032bef2d
Author: Maj <maxim.stomphorst@student.uva.nl>
Date:   Fri Jun 16 12:21:58 2017 +0200

    Initial Commit

