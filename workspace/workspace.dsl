workspace "Enrollment" "Level 1" {
    model {
        # software system 
        enrollment = softwareSystem "Enrollment System" "Provides functionality related to subject enrollment such as enroll and unenroll, request validation and notifications, also can change capacity of subjects and provides the ability to get placed in queue."

        # tohle dát šedou
        mail_server = softwareSystem "Mail Server" "External system to provide desired mail notifications"

        #std_dtb = softwareSystem "Student Database" "Student Database provides basic information about enrolled students for course enrollment management, as name, ID, status of students."
        school_dtb = softwareSystem "School Database" "holds basic information about enrolled students for course enrollment management and all subjects and their teacher"

        # actors
        student = person "Student" "studies at the school and needs to be enrolled in courses" 
        teacher = person "Teacher/Authority" "needs to manage taught lectures, their capacities and enrollment queues"

        teacher -> enrollment "uses the system to manage his courses and to edit queues" 
        student -> enrollment "uses the system to get enrolled in subjects and view them"
        
        enrollment -> mail_server "Sends notifications and information"
        
        #std_dtb -> enrollment
        school_dtb -> enrollment "provides data about students, subjects and their teachers"
        #enrollment -> school_dtb
    }

    views {
        systemContext enrollment "Enrollment" {
            include *
        }
    }
}