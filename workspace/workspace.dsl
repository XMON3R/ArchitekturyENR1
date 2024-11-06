workspace "Enrollment" "Level 1-3" {
    
    !identifiers hierarchical

    model {
        # tohle dát šedou
        mail_server = softwareSystem "Mail Server" "External system to provide desired mail notifications"

        #std_dtb = softwareSystem "Student Database" "Student Database provides basic information about enrolled students for course enrollment management, as name, ID, status of students."
        school_dtb = softwareSystem "School Database" "holds basic information about enrolled students for course enrollment management and all subjects and their teacher"

        # actors
        student = person "Student" "studies at the school and needs to be enrolled in courses" 
        teacher = person "Teacher/Authority" "needs to manage taught lectures, their capacities and enrollment queues"

        enrollment = softwareSystem "Enrollment System" "Provides functionality related to subject enrollment such as enroll and unenroll, request validation and notifications, also can change capacity of subjects and provides the ability to get placed in queue." {
            
            // Rasto
            dashboard = container "Dashboard" {
                requestHandler = component "Request Handler"
                requestHandler2 = component "Request Handler2"
                requestHandler3 = component "Request Handler3"
            }

            // Honza/GameForko
            notificationCenter = container "Notification Center" {
                testA = component "pepega"
            }

            // Vojta
            queue = container "Queue" {

            }

            // sir Simon
            enrollmentProvider = container "Enrollment Provider" {

            }

            // sir Simon
            enrollmentValidator = container "Enrollment Validator" {

            }

            // Honza/Olcor
            enrollmentRepository = container "Enrollment Repository" {

            }

            // Maty
            logger = container "Logger" {

            }

        }

        teacher -> enrollment "uses the system to manage his courses and to edit queues" 
        student -> enrollment "uses the system to get enrolled in subjects and view them"
        
        enrollment -> mail_server "Sends notifications and information"
        
        #std_dtb -> enrollment
        school_dtb -> enrollment "provides data about students, subjects and their teachers"
        #enrollment -> school_dtb

        enrollment.dashboard -> enrollment.enrollmentProvider "sends enrollment requests"
        enrollment.dashboard -> enrollment.notificationCenter "gets notifications"
        enrollment.dashboard -> enrollment.enrollmentRepository "gets available subjects"
        enrollment.enrollmentRepository -> enrollment.logger "logs enrollment entry"
        enrollment.enrollmentProvider -> enrollment.enrollmentRepository "sends enrollment data"
        enrollment.enrollmentProvider -> enrollment.enrollmentValidator "sends enrollment request for validation"
        enrollment.enrollmentProvider -> enrollment.queue "sends enqueue requests"
        enrollment.queue -> enrollment.enrollmentValidator "gets enrollment validation"
        enrollment.enrollmentValidator -> enrollment.logger "logs validation result"
        enrollment.queue -> enrollment.notificationCenter "sends information about availibility"
        enrollment.enrollmentValidator -> enrollment.notificationCenter "sends validation results" 
    }

    views {

        systemContext enrollment "EnrollmentSystem" {
            include *
            autolayout lr
        }

        container enrollment "Enrollment" {
            include *
            autolayout lr
        }

        component enrollment.dashboard "Dashboard" {
            include *
            autolayout lr
        }

        component enrollment.notificationCenter "NotificationCenter" {
            include *
            autolayout lr
        }

        component enrollment.queue "Queue" {
            include *
            autolayout lr
        }

        component enrollment.enrollmentProvider "EnrollmentProvider" {
            include *
            autolayout lr
        }

        component enrollment.enrollmentValidator "EnrollmentValidator" {
            include *
            autolayout lr
        }

        component enrollment.enrollmentRepository "EnrollmentRepository" {
            include *
            autolayout lr
        }

        component enrollment.logger "Logger" {
            include *
            autolayout lr
        }


        styles {
            element "Element" {
                color white
            }
            element "Person" {
                background #116611
                shape person
            }
            element "Software System" {
                background #2D882D
            }
        }
    }
}