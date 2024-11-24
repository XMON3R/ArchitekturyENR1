# Enrollment System

## Core features and responsibilities
System used for management of enrollment and subjects (both for students and teachers/authorities).

Made by: ENR1 2024


--------------------------------------------------------------------------------------------------------------------

### Feature: 1. Enrolling to a new subject (Rasťo, hotové)

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

#### CAN BE VIEWED HERE:
![](embed:EnrollmentProvider)

#### OR HERE (AS FEATURE DIAGRAM):
![](embed:Enrolling_in_subjects)

--------------------------------------------------------------------------------------------------------------------

### Feature: 2. Unenrolling from enrolled subject (Šimon)

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

#### CAN BE VIEWED HERE:
![](embed:EnrollmentProvider)

#### OR HERE (AS FEATURE DIAGRAM):
![](embed:Unenrolling_from_subjects)

--------------------------------------------------------------------------------------------------------------------

### Feature: 3. Viewing enrolled subjects (Maty)
As a student I want to view subjects I am enrolled to, because I want to know them. 

#### Feature breakdown

1. Student opens the dashboard and opens Enrollment module.
2. In the Enrollment module student opens Enrolled module.
2. The student selects for which semester they want to see the Enrollement information.
3. The system displays all enrolled subjects for selected year.

#### Responsibilities

##### Subject viewing responsibilities
* Display information of all enrolled subjects for the student.

#### CAN BE VIEWED HERE:
![](embed:Dashboard)

#### OR HERE (AS FEATURE DIAGRAM):
![](embed:Viewing_enrolled_subjects)

--------------------------------------------------------------------------------------------------------------------

### Feature: 4. Enrolling a student to a teacher's subject (Vojta)

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
* Send email notifcation to the student with the confirmation message and details about the enrollment.

#### CAN BE VIEWED HERE:
![](embed:EnrollmentProvider)

#### OR HERE (AS FEATURE DIAGRAM):
![](embed:Feature_Teacher_Enrollment)

--------------------------------------------------------------------------------------------------------------------

### Feature: 5. Notification of Invalid Enrollment (Honza R.)

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

#### CAN BE VIEWED HERE:
![](embed:NotificationCenter)

#### OR HERE (AS FEATURE DIAGRAM):
![](embed:Feature-Notification)
--------------------------------------------------------------------------------------------------------------------
### Feature: 6. Viewing subjects available for enrollment (Honza Č.)

#### Feature breakdown
1. Student opens the dashboard and navigates to the Enrollment module.
2. Student views all subjects.
3. System displays subjects on the screen.
4. Student filters the subjects by availibility for enrollment.
5. System displays subjects that are only available for enrollment.

### Responsibilities

##### Subject viewing responsibilities
* Display information of all subjects for the student.

##### Filtering responsibility
* Filter available subjects for the student.


#### CAN BE VIEWED HERE:
![](embed:EnrollmentRepository)

![](embed:Dashboard)

#### OR HERE (AS FEATURE DIAGRAM):
![](embed:Feature-viewing-subjects-available-for-enrollement)

--------------------------------------------------------------------------------------------------------------------