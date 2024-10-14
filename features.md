
# Enrollment System

## Core features and responsibilities

### Feature: Enrolling to a new subject

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


Unenrolling from enrolled subject
2. As a student I want to unenroll from a subject, because I want to be unenrolled.
Core -
    1) Student opens the dashboard and opens Enrollement module.
    2) Student displays their enrolled subjects.
    3) Student selects the subject they want to unenroll from.
        a) If the unenrollment is possible, the system unenrolls the selected subject.
        b) If the unenrollment is not possible, the system notifies the student.
    4) If the unenrollemnt has been succesfull, the system shows a confirmation.

Viewing enrolled subjects
3. As a student I want to view subject I am enrolled to, because I want to know them.
Core -

Viewing overlaping subjects
4. As a student I want to know overlaping subjects I am enrolled to, because I want to attend them in person.
Function -

Enqueuing to a subject queue.
5. As a student I want to enqueue to a subject queue, so that I can enroll to a full subject.
Function -

Notifying enrolled students
6. As a teacher I want to notify all enrolled students, because I want to inform students.
Function -

Enrolling a student to a teacher's subject
7. As a teacher I want to be able to enroll a student to my subject, because I want
Core -

Creating a pre-planned enrollment schedule
8. As a student I want to be able to create a pre-planned enrollment schedule, because I want to enroll to all these subjects at once.
Function -

Enrolling to all pre-planned subjects at once
9. As a student I want to be able to enroll to all of my pre-planned subjects at once, because I want to be able to do this enrollemnt at once.
Function -

Removing a pre-planned subject from enrollment schedule
10. As a student I want to be able to remove a pre-planned subject from my pre-planned enrollment schedule, because I want to have this option.
Function -

Being notified of ...
11. As a student I want to be notified when I get enrolled from queue, because I want to be notified of these changes.
Function -

Viewing subjects available for enrollment.
12. As a student I want to view available subjects I can enroll to, because I want to be able to view them in one place.
Core -

Notification of invalid enrollment.
13. As a student I want to be notified of a subject I am unable to enroll to, because I want to be enrolled only in valid subjects.
Core -
