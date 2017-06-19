# procesBook - Producitfy
## Programmeerproject - Maxim Stomphorst - 11436727

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
 - 
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


 
 