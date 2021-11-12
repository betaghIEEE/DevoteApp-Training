#  Main objectives of this Core Data and SwiftUI project

## DEVOTE
In this SwiftUI tutorial, we will develop a task manager iOS application with Core Data integration. This is not a project with a boring user interface. This iOS and iPadOS application provides a personal touch and feel.

## Learn how to integrate Core Data with SwiftUI

Apple's Core Data framework helps developers to manage and interact with data on a persistent store. It works on iPhone, iPad, Mac computer, or even Apple Watch.

When we start from a brand new project, the easiest way to use the Core Data framework is by enabling the Core Data option on the setup screen. By doing that Xcode will generate all the required file templates with code and the managed object model for us.

This Xcode 12's new Core Data template comes with the SwiftUI app life cycle integration and the required Core Data Model. This is why it is worth knowing how to get started with this new template and how to create a working application.

## TOPICS WILL BE COVERED:
1.  How to integrate Core Data with the SwiftUI App Life Cycle
2.  How to get familiar with Xcode's new Core Data template
3.  How to create a basic Widget for iOS and iPadOS devices
4.  How to develop a Widget sets with different sizes (small, medium, large)
5.  How to set up the Preview to test the different Widget sizes on the Canvas
6.  How to Create, Read, Update and Delete a database item (CRUD method)
7.  How to show SwiftUI views conditionally
8.  How to switch from Light mode to Dark mode the app's appearance
9.  How to store the app's appearance using App Storage
10. How to create a visual effect with SwiftUI (blur, overlay, display mode)
11. How to add the required assets for the Widget extension
12. How to develop a custom Toggle style and make a checkbox

13. How to improve the User Experience with sound effects
14. Practice how to use Apple's Feedback Generator and implement haptics




# Images

![App icon](./NoteImages/2021-02-18_17-24-29-5d03624c81ba86285765f50543764a5e.jpeg "App Icon")

![Core Data application](.NoteImages/2021-02-18_17-24-58-8e4f15200062d411b78577f26ac0eb9d.jpeg)



![iOS 14 Widgets](/Users/danielbeatty/projects/Tutorials/udemy/iOS 15 & Swift/DEVOTE/Students/Devote/Devote/NoteImages/2021-02-18_18-37-39-cceebb4fc6f96d9e3c8456c1e1dd7fff.jpeg)

![Text field and custom visual effect](file://./Devote/NoteImages/textFieldCustomVisualEffect.jpeg)

![App appearance toggle (Light and Dark mode)](file://./Devote//NoteImages/AppAppearanceToggle.jpeg)

![Launch Screen](file://./Devote/NoteImages/LaunchScreen.jpeg)


# What is Core Data
Apple's Native Persistent Storage is Core Data.  This type of persistent storage is also known as an Object-Relational Machine/ Model.  

We take a look at:
1.  What is Core Data 
2.  The Core Data Stack
3.  Core Data Template

 ##  The Core Data Stack / Framework
 We can use  Core Data to save the applications' permanent data for offline use, to cache temporary data, and to add the undo and redo functionalities to our app on a single device.
 
 Core Data is available on just about every Apple platform.  
 1. The Core Data is a model layer in the application.   
 2. Core Data can store, retrieve, update, and delete data.  
 3. Core Data manages the object graph.
 4. Add Undo and Redo functionalities.
 5. Cache temporary data
 6. Share or synchronize data using Cloud Kit.
 
 What is an Object Graph?   Notice the example of Movie, Genre, and Actor. 
 
 Core Data is not directly a database.  Rather is an ORM to many types of databases systems such as:
 *  XML
 *  Binary
 *  SQLite
 *  In-Memory
 
 Remember your model for an ORM Stack (dissertation)
 
 Working with Core Data entails working with the classes for relational entities.  The class code generation can occur in the following manners:
 1. Manual
 2. Class Definition
 3. Extension
 
 Chose Manual/none to edit the properties in your managed object sub-class, for example, to alter access modifiers and to add additional convenience methods or business logic.  In other words, Core Data doesn't provide or produce the code generation for managed objects.   We the developers do that in this case.
 Chose Class Definition option when you don't need to edit the properties or functionality of the managed object sub-class and properties files that Core Data generates for you.  This is the default.
 Choose Category/ Extension to add logic to the Managed Object to add additional convenience methods or business logic inside your managed object sub-class.  This is more or less an extension of Chose Class Definition.  In this case, we develop using the grandfather design pattern/principle.  The extension provides esentially the same thing as a sub-class to the entity class definition.   The extension allows the developer to add features to the Class Definition without actually editing the generated class definition.  
 
 Note: this approach is very similar to the Enterprise Object generation observed under the Java WebObjects frameworks from at least 2005.  The Java WebObjects Frameworks represents WebObjects version 5 and version 6 exist as Swift Objects.
 
 Observe how the generated classes are created.  Observe during the commit of this project to the GIT repo. 
   
