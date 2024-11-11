workspace "Enrollment" "Level 1-3" {
    
    !identifiers hierarchical

    model {
        # external SW Systens
        mailServer = softwareSystem "Mail Server" "External system to provide desired mail notifications" {
            tags "External"
        }
        schoolDatabase = softwareSystem "School Database" "holds basic information about enrolled students for course enrollment management and all subjects and their teacher" {
            tags "External, Database"
        }

        # actors
        student = person "Student" "studies at the school and needs to be enrolled in courses" 
        teacher = person "Teacher/Authority" "needs to manage taught lectures, their capacities and enrollment queues"

        enrollment = softwareSystem "Enrollment System" "Provides functionality related to subject enrollment such as enroll and unenroll, request validation and notifications, also can change capacity of subjects and provides the ability to get placed in queue." {
            
            // Rasto
            dashboard = container "Dashboard" {
                description "User interface for students, faculty, and administrators to interact with the system."

                webpage = component "Dashboard Webpage" {
                    description "Main entry point for the Dashboard, providing a user interface and routing for different components."
                }

                enrollmentOverview = component "Enrollment Overview" {
                    description "Fetches the student's current enrollments and pending status."
                }

                subjectCatalog = component "Subject Catalog" {
                    description "Prepares all user's available subjects and subject details."
                }

                enrollmentActions = component "Enrollment Actions" {
                    description "Enables students to add/remove subjects and manage preferences."
                }

                enrollementDataHandler = component "Enrollment Data Handler" {
                    description "Handles request to the Enrollment Repository"
                }

                notifications = component "Notifications Handler" {
                    description "Fetches notifications for enrollment deadlines and announcements."
                }

                enrolledSubjectsHandler = component "Enrolled Subjects Handler" {
                    description "Prepares enrolled subjects."
                }

                # Webpage Component Connections
                webpage -> enrollmentOverview "Renders enrollment overview"
                webpage -> enrollmentActions "Provides enrollment actions UI"
                webpage -> notifications "Renders notifications"
                
                # Enrollment Component Connections
                enrollmentOverview -> subjectCatalog "Fetches subject catalog"
                enrollmentOverview -> enrolledSubjectsHandler "Fetches enrolled subjects"
                
                # Enrolled Subjects Handler Component Connections
                enrolledSubjectsHandler -> enrollementDataHandler "Fetches subjects"
                
                # Subjects Catalog Component Connections
                subjectCatalog -> enrollementDataHandler "Fetches subjects"

                # Enrollment Actions Component Connections
                enrollmentActions -> enrollmentOverview "Updates enrollment status"

                # Actors - todo better descriptions
                teacher -> enrollment.dashboard.webpage "uses the system"
                student -> enrollment.dashboard.webpage "uses the system"
            }

            // Honza/GameForko
            notificationCenter = container "Notification Center" {
                
                description "Manages notifications for students and teachers/authority about events via external Mail Server"

                notificationManager = component "Notification Manager" {
                    description "Manages filtering sending notifications based on notification type request"
                }

                teacherNotification = component "Teacher Notification" {
                    description "Notifies teachers about the result of the enrollment validation"
                }

                studentNotification = component "Student Notification" {
                    description "Notifies students about the results of their enrollment requests"
                }

                notificationManager -> teacherNotification "Handle teachers notifications"
                notificationManager -> studentNotification "Handle students notifications"
                studentNotification -> mailServer "Sends email notifications"
                teacherNotification -> mailServer "Sends email notifications"

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
                description "Provides abstraction for accessing database."

                subjectStatements = component "Subject Statements" {
                    description "Provides all CRUD operations for the subject table in database"
                }

                studentStatements = component "Student Statements" {
                    description "Provides all CRUD operations for the student table in database"
                }

                enrollmentStatements = component "Enrollment Statements" {
                    description "Provides all CRUD operations for the student-subject enrollment relation"
                }

                databaseLogger = component "Database Logger" {
                    description "Logs accesses to the database"    
                }

                enrollmentStatements -> subjectStatements "Utilizes CRUD operations"
                enrollmentStatements -> studentStatements "Utilizes CRUD operations"
                subjectStatements -> databaseLogger "Logs database operations"
                studentStatements -> databaseLogger "Logs database operations"
                enrollmentStatements -> databaseLogger "Logs database operations"
            }

            // Maty
            logger = container "Logger" {

            }

        }

        teacher -> enrollment "uses the system to manage his courses and to edit queues"
        student -> enrollment "uses the system to get enrolled in subjects and view them"
        
        enrollment -> mailServer "Sends notifications and information"
        
        schoolDatabase -> enrollment "provides data about students, subjects and their teachers"
        #enrollment -> schoolDatabase

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

        # Dashboard
        enrollment.dashboard.enrollmentActions -> enrollment.enrollmentProvider "Submits enrollment requests to Enrollment Provider"
        enrollment.dashboard.notifications -> enrollment.notificationCenter "Pulls notifications from Notification Service"
        enrollment.dashboard.enrollementDataHandler -> enrollment.enrollmentRepository "Handles data requests to Enrollment Repository"
        
        # Enrollment Repository
        enrollment.enrollmentRepository.databaseLogger -> enrollment.logger "Logs accesses to the database"
        enrollment.enrollmentRepository.subjectStatements -> schoolDatabase "Accesses database"
        enrollment.enrollmentRepository.studentStatements -> schoolDatabase "Accesses database"
        enrollment.enrollmentRepository.enrollmentStatements -> schoolDatabase "Accesses database"
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

        theme default

        styles {
            element "Person" {
                background #234F80
                shape Person
            }
            
            element "External" {
                background grey
            }

            element "Database" {
                shape Cylinder
            }
        }
    }
}