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
                teacher -> enrollment.dashboard.webpage "uses the system to get enrolled in subjects and view them"
                student -> enrollment.dashboard.webpage "uses the system to get enrolled in subjects and view them"
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
                description "Provides queue enrollments, if the capacity of the subject is full"

                subjectsQueue = component "Subject queue" {
                    description "Handles queue of students for subjects "
                }

                queueHandler = component "Queue handler" {
                    description "Handles operations of the queue such as enqueue, dequeue or view"
                }

                Notifier = component "Notifier" {
                    description "Trigger notification, if there is any change in the queue"
                }
                queueHandler -> subjectsQueue "Handles queue requests"
                subjectsQueue -> Notifier "Informs about changes in the queue"
            }

            // sir Simon
            enrollmentProvider = container "Enrollment Provider" {
                description "Manages enrollment and unenrollment operations for subjects"

                enrollmentProcessor = component "Enrollment Processor" {
                    description "Processes student enrollment to the subject"
                }
                unenrollmentProcessor = component "Unenrollment Processor" {
                    description "Processes student unenrollment from the subject"
                }
                queueManager = component "Queue Manager" {
                    description "Create queue requests for students for the selected subject if it's full"
                }

                enrollmentProcessor -> queueManager "Enqueues students if subject is full"
                unenrollmentProcessor -> queueManager "Updates queue after unenrollment"
            }

            // sir Simon
           enrollmentValidator = container "Enrollment Validator" {
                description "Validates and processes enrollment requests"

                availabilityChecker = component "Availability Checker" {
                    description "Validates the availability of space for the selected subject"
                }

                teacherRequestValidator = component "Teacher Request Validator" {
                    description "Validates enrollment requests from teachers"
                }

                studentPrerequisiteValidator = component "Student Prerequisite Validator" {
                    description "Validates student prerequisites for enrollment"
                }

                credentialsValidator = component "Credentials Validator" {
                    description "Validates student credentials for enrollment"
                }

                enrollmentCriteriaChecker = component "Enrollment Criteria Checker" {
                    description "Checks if the enrollment request meets specific criteria"
                }

                unEnrollmentCriteriaChecker = component "Unenrollment Criteria Checker" {
                    description "Checks if the unenrollment request meets specific criteria"
                }

                resultLogger = component "Result Logger" {
                    description "Logs validation results"
                }

                notificationSender = component "Notification Sender" {
                    description "Sends validation results to the Notification Center"
                }

                // Connections between components
                enrollmentCriteriaChecker -> availabilityChecker "Checks space availability"
                enrollmentCriteriaChecker -> teacherRequestValidator "Validates teacher requests"
                availabilityChecker -> studentPrerequisiteValidator "Ensures prerequisites are met"
                studentPrerequisiteValidator -> credentialsValidator "Validates credentials"
                credentialsValidator -> resultLogger "Logs validation outcome"
                credentialsValidator -> notificationSender "Sends validation outcome to Notification Center"

                unEnrollmentCriteriaChecker -> resultLogger "Logs unenrollment validation outcome"
                unEnrollmentCriteriaChecker -> notificationSender "Sends unenrollment validation result to Notification Center"
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
            description "Ensure that all actions done are logged"
            resultLogger = component "Validation result logs"{
                description "Saves logs based on the validation result to a log file"
            }
            entryLogger = component "Enrollment entry logs"{
                description "Saves logs based on the accesses to the database to a log file"
            }
            logFile = component "log file"{
                description "Stores all logs generated by logger"
            }
            resultLogger -> logFile "Saves logs to the file"
            entryLogger -> logFile "Saves logs to the file"
            }


        }
        
        enrollment -> mailServer "Sends notifications and information"
        
        schoolDatabase -> enrollment "provides data about students, subjects and their teachers"

        enrollment.dashboard -> enrollment.enrollmentProvider "sends enrollment requests"
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
        enrollment.dashboard.enrollementDataHandler -> enrollment.enrollmentRepository "Handles data requests to Enrollment Repository"
        
        # Enrollment Repository
        enrollment.enrollmentRepository.databaseLogger -> enrollment.logger.entryLogger "Logs enrollment entry"
        enrollment.enrollmentRepository.subjectStatements -> schoolDatabase "Accesses database"
        enrollment.enrollmentRepository.studentStatements -> schoolDatabase "Accesses database"
        enrollment.enrollmentRepository.enrollmentStatements -> schoolDatabase "Accesses database"

        enrollment.dashboard -> enrollment.enrollmentRepository.subjectStatements "gets available subjects"
        enrollment.enrollmentProvider -> enrollment.enrollmentRepository.enrollmentStatements "sends enrollment data"


        # Enrollment Provider 
        enrollment.enrollmentProvider.queueManager -> enrollment.queue "sends queue requests"
        enrollment.enrollmentProvider.enrollmentProcessor -> enrollment.EnrollmentRepository "sends enrollment data" 
        enrollment.enrollmentProvider.unenrollmentProcessor -> enrollment.EnrollmentRepository "sends enrollment data" 
        enrollment.enrollmentProvider.enrollmentProcessor -> enrollment.EnrollmentValidator "sends enrollment data" 
        enrollment.enrollmentProvider.unenrollmentProcessor -> enrollment.EnrollmentValidator "sends enrollment data" 

        enrollment.dashboard -> enrollment.enrollmentProvider.enrollmentProcessor "Submits enrollment requests"
        enrollment.dashboard -> enrollment.enrollmentProvider.unenrollmentProcessor "Submits enrollment requests"

        # Enrollment Validator
        enrollment.enrollmentValidator.resultLogger -> enrollment.logger.resultLogger "Logs validation result"
        enrollment.enrollmentValidator.notificationSender -> enrollment.notificationCenter "Sends validation results"

        enrollment.enrollmentProvider -> enrollment.enrollmentValidator.enrollmentCriteriaChecker "sends enrollment data"
        enrollment.queue -> enrollment.enrollmentValidator.enrollmentCriteriaChecker "gets enrollment validation"

        # Queue
        enrollment.queue.Notifier -> enrollment.notificationCenter "Sends notifications about changes in the queue"
        enrollment.enrollmentProvider -> enrollment.queue.queueHandler "Sends enqueue requests"
        enrollment.queue.Notifier -> enrollment.enrollmentValidator "Gets enrollment validations"

        # Notification center
        enrollment.notificationCenter.notificationManager -> enrollment.dashboard.notifications "sends notifications"
        enrollment.enrollmentValidator -> enrollment.notificationCenter.notificationManager "sends validation results"
        enrollment.queue -> enrollment.notificationCenter.notificationManager "sends information about availability"

        deploymentEnvironment "Live"     {
            deploymentNode "User's web browser" "" "" {
                dashboardHTMLInstance = containerInstance enrollment.dashboard
            }

            deploymentNode "Application Server" "" "Ubuntu 18.04 LTS"   {
                deploymentNode "Web server" "" "Apache Tomcat 10.1.15"  {
                    providerInstance = containerInstance enrollment.enrollmentProvider
                    notificationCenterInstance = containerInstance enrollment.NotificationCenter
                    repositoryInstance = containerInstance enrollment.enrollmentRepository
                }               
            }

            deploymentNode "Validator Server" "" "Ubuntu 18.04 LTS"   {
                validatorInstance = containerInstance enrollment.enrollmentValidator
            }

            deploymentNode "Logger Server" "" "Ubuntu 18.04 LTS" {
                 logDBInstance = containerInstance enrollment.logger
            }
        }
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

        deployment enrollment "Live" "Live_Deployment"   {
            include *
            autolayout lr
        }

        #feature 1 DIAGRAM
        
        dynamic enrollment "Feature1" {
            description "The sequence of interactions for enrolling in a subject."

            student -> enrollment.dashboard "Student opens dashboard website & views all available subjects"
            enrollment.dashboard -> enrollment.enrollmentRepository "Requests available subjects"
            enrollment.enrollmentRepository -> enrollment.dashboard "Sends back available subjects"
            enrollment.dashboard -> enrollment.enrollmentProvider "Sends student's enrollment request"
            enrollment.enrollmentProvider -> enrollment.enrollmentValidator "Sends enrollment request for validation"
            enrollment.enrollmentValidator -> enrollment.notificationCenter "Sends result of validation"
            enrollment.notificationCenter -> enrollment.dashboard "Sends notifications of validaiton result"
            enrollment.notificationCenter -> mailServer "Sends notifications of validaiton result"

            autolayout lr
        }

        dynamic enrollment "Feature-Notification" {
            
            description "The sequence of interactions for notification."

            student -> enrollment.dashboard "Student opens dashboard website & views all available subjects"
            enrollment.dashboard -> enrollment.enrollmentRepository "Views available subjects that are open for enrollment"
            enrollment.enrollmentRepository -> enrollment.dashboard "Sends back available subjects"
            enrollment.dashboard -> enrollment.enrollmentProvider "Sends student's enrollment request"
            enrollment.enrollmentProvider -> enrollment.enrollmentValidator "Sends enrollment request for validation"
            enrollment.enrollmentValidator -> enrollment.notificationCenter "Sends result of validation"
            enrollment.notificationCenter -> mailServer "Sends notifications of inv result"

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