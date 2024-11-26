
# Enrollment module  
| Content |
| :---: |
| [Overview](#overview) |
| [Containers](#containers) |
| [Features](#core-features-and-responsibilities) |
| [Deployment diagrams](#deployment-diagrams) | 

## Overview

The enrollment module is responsible for handling all requests for enrollment to subjects and unenrollment from them. 
There are two main actors, first is a student, who wants to (un)enroll (from)/to subjects. The second one is teacher/authority, who has higher rights/privileges then students and wants to manage his courses. 
The module communicates with external database system, where are all needed data stored, and also with external mail server, which handles sending notification via email.
![](embed:EnrollmentSystem)

## Containers

Funtionality of the enrollment module is split between 7 containers such as [Dashboard](#dashboard), [Enrollment Provider](#enrollment-provider), [Queue](#queue), [Enrollment Validator](#enrollment-validator), [Logger](#logger), [Enrollment repository](#enrollment-repository) and [Notification center](#notification-center). 

![](embed:Enrollment)
Below you can read more about the functionality of each container.

### Dashboard
The dashboard provides the main way of communication between the user and the system, becaue it encapsulate all the needed functionality for them.
![](embed:Dashboard)

#### Dashboard responsibilities
 - Display information of available subjects for the student
 - Display all enrolled subjects for the student
 - Display selector to choos a specific subject for unenrollment

### Enrollment Provider
TODO: Description
![](embed:EnrollmentProvider)

#### Provider responsibilites
- Enroll to subject
- Unenroll from subject 

### Queue
The queue container is responsible of all the actions with enrollment requests, if the course capacity is already full. It tracks students in the queue and handles the actual enrollment if the capacity of the course is opened up. Also is sends reguest to notification manager, if needed to infrom the student of the change in the enrollment.
![](embed:Queue)

#### Queue resposibilities 
- Offer to place the student into an enrollemnt queue for the selected subject
- Place the student to the enrollment queue for the selected subject
- Enroll the student to the subject if the capacity is opened up

### Enrollment validator
Enrollment validator has resposibility for validation of enrollment reaguest such as prerequities, subject capacity, enrollment priority mode, etc.
![](embed:EnrollmentValidator)

#### Validator responsibilites 
 - Validate students credentials
 - Validate students prerequisities
 - Check if the unenrollment request meets specific criteria
 - Validate capacity of the selected subject

### Logger
The main funtionality of this container is to store all actions happenning across the system with enrollment and unenrollment reguests, it stores all the logs in multiple log files. 
![](embed:Logger)

#### Logger responsibilites
 - Log all acctions happening in the module

### Enrollment repository
This module is very important, because it handles all communication with the external database server such as writing data, getting data, filtering data, etc. It provides abstraction for other containers of the module for easier commutiona with database.
![](embed:EnrollmentRepository)

#### Repository responsibilities
 - Add subject to the students list of enrolled subjects
 - Remove the subject from the students list of enrolled subjects
 - Get available subjects for the student

### Notification center
The notification center has the main responsibility of sending notification to the user, if needed, for example if the student was succesfully enrolled to the subject.
There two types of notification, the first one is the email notification, which is handled via the external mail server. The second type is "frontend" notification, which occurs on the dashboard page.
![](embed:NotificationCenter)

#### Notifier responsibilites
- Notify student about the enrollment request result
- Inform teacher about the result of the request

## Core features and responsibilities

--------------------------------------------------------------------------------------------------------------------

### Enrolling to a new subject

As a student, I want to enroll to a subject, because I must be enrolled to a subject to be able to get credits for it.

#### Feature breakdown

1. Student opens the dashboard and opens Enrollment module.
2. Student views available subjects.
3. System displays all available subjects.
4. Student selects a subject to enroll to.
5. System validates the enrollment request.
6. If the request is denied:
    <ol type="a">
        <li>System notifies the student that their request has been denied and informs them of the reason for the denial.</li>
        <li>In case the subject's capacity is full, the system offers to the student to be place in a queue for the subject.</li>
    </ol>
7. If the request has been successfully validated, the system processes the request internally and informs the student.

#### Responsibilities

##### Subject viewing and interaction responsibilities
* Display information of available subjects for the student
* Ensure enrollment requests can be made

##### Enrollment validation responsibilities
* Validate student credentials, prerequisites
* Validate availability of space for selected subject
* Inform student of any issues that occured during validation
* Offer to place the student into an enrollemnt queue for the selected subject

##### Enrollment processing responsibilities
* Ensure enrollment requests are correctly processed
* Ensure that the student is correctly enrolled to the selected subject
* Ensure that all actions done are logged

![](embed:Enrolling_in_subjects)

--------------------------------------------------------------------------------------------------------------------

### Unenrolling from enrolled subject

As a student I want to unenroll from a subject, because I want to be unenrolled from a subject.

#### Feature breakdown

1. The student opens the dashboard and opens enrollement module.
2. The system displays all subjects in which the student is currently enrolled.
3. The student selects a subject to unenroll from.
4. The system validates the unenrollment request:
5. The system informs the resulf of request:
    <ol type="a">
        <li>If the unenrollment has not been succesfully accepted, the system notifies the student why the selected subject cannot be unenrolled.</li>
        <li>If the unenrollemnt has been succesfully accepted, the system shows a confirmation.</li>
    </ol>

#### Responsibilities

##### Display responsibilities
* Display the list of subjects in which the student is enrolled.
* Display a selector to choose a specific subject for unenrollment.

##### Validation responsibilities
* Check if the unenrollment request meets specific criteria.
* Check if there was some error during the unenrollment request.

##### Processing responsibilities
* Remove the subject from the students list of enrolled subjects.

##### Notification responsibilities
* Notify the student if request was success or not.


![](embed:Unenrolling_from_subjects)

--------------------------------------------------------------------------------------------------------------------

### Viewing enrolled subjects
As a student I want to view subjects I am enrolled to, because I want to know them. 

#### Feature breakdown

1. Student opens the dashboard and opens Enrollment module.
2. In the Enrollment module student opens Enrolled module.
2. The student selects for which semester they want to see the Enrollement information.
3. The system displays all enrolled subjects for selected year.

#### Responsibilities

##### Subject viewing responsibilities
* Display information of all enrolled subjects for the student.

![](embed:Viewing_enrolled_subjects)

--------------------------------------------------------------------------------------------------------------------

### Enrolling a student to a teacher's subject

As a teacher, I want to be able to enroll a student to my subject, because for some reason the student couldn't do that himself or from the queue.

#### Feature breakdown:
    
1. The teacher opens the dashboard and chooses Enrollment module
2. The system displays all of his active classes.
3. The teacher selects the class, which he wants to enroll the student in.
4. The teacher enrolls the student to the chosen class.
5. The system validates the enrollment request.
6. If the request is denied, the system notifies the teacher that the request has been denied and displays the reason
6. If the request is accepted the system informs the teacher and also sends confirmation email to the student.

#### Responsibilities:

##### Enrollment validation responsibilities
* Validate student credentials, prerequisites
* Inform teacher of any issues that occured during validation

#### Notification responsibilities
* Send email notification to the student with the confirmation message and details about the enrollment.

![](embed:Feature_Teacher_Enrollment)

--------------------------------------------------------------------------------------------------------------------

### Notification of Invalid Enrollment
As a student, I want to be notified if I am unable to enroll in a subject, so that I only enroll in valid subjects.

#### Feature Breakdown

1. **Student opens the dashboard** and navigates to the Enrollment module.
2. **Student views available subjects** that are open for enrollment.
3. **System displays all available subjects**, indicating their availability and other key information.
4. **Student selects a subject** to enroll in.
5. **System validates the enrollment request** against the following criteria:
    * Does the student meet all the prerequisites for the subject?
    * Is there available capacity in the subject?
    * Is the student's current enrollment valid (e.g., no schedule conflicts)?
6. If the **enrollment request is invalid**:
    1. **System notifies the student** that their enrollment request has been denied.
    2. **System provides a clear reason** for the denial (e.g., "Subject is full," "Prerequisites not met").
    3. If the **subject is full**, the system offers the student an option to be placed in a **queue for that subject**.
7. If the **request is valid**, the system:
    * **Processes the enrollment internally**.
    * **Informs the student of successful enrollment**.
    * Logs the action for audit and reference.

#### Responsibilities

##### **Subject Viewing and Interaction Responsibilities**
* Display the list of available subjects for the student.
* Ensure that the student can easily request enrollment in any available subject.

##### **Enrollment Validation Responsibilities**
* Verify the student's eligibility based on prerequisites.
* Check subject availability and other constraints (like scheduling conflicts).
* Notify the student clearly if the enrollment request fails, specifying the reason.
* Offer the student a queue option if the subject is full.

##### **Enrollment Processing Responsibilities**
* Process the enrollment request upon successful validation.
* Log the enrollment actions for tracking and auditing.
* Notify the student promptly of the outcome of the request.

![](embed:Feature-Notification)

--------------------------------------------------------------------------------------------------------------------

### Viewing subjects available for enrollment

#### Feature breakdown
1. Student opens the dashboard and navigates to the Enrollment module.
2. Student views all subjects.
3. System displays subjects on the screen.
4. Student filters the subjects by availibility for enrollment.
5. System displays subjects that are only available for enrollment.

#### Responsibilities

##### Subject viewing responsibilities
* Display information of all subjects for the student.

##### Filtering responsibility
* Filter available subjects for the student.

![](embed:Feature-viewing-subjects-available-for-enrollement)

--------------------------------------------------------------------------------------------------------------------

## Deployment diagrams
Here is the overview of production and development deployment diagrams, which explains, how the enrollment module will be deployed in both scenarios.

### Production diagram
The Dashboard will be on the users web browser.

The Enrollment Validator will be deployed on his own Validator server, because its needs to hadle many operations with validation proccesses.
Logger container will be also deployed on his own Logger server to handle all the needed logging actions.

At the main application server is running web server with Enrollment Provider, Enrollment Repository and Notification center containers.

Last but not least is the queue, with also its own server, because it needs to handle all the queue requests.
![](embed:ProductionDiagram)

#### Development diagram
TODO: Description 
TODO: Create the diagram