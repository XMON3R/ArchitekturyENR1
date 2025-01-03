### COMMENT ###

# All relationships are labeled so that it is easier to make individual views

################

workspace "Module Schedules" {

    !identifiers hierarchical

    model {
        ucitel = person "Učitel"
        student = person "Student"
        rozvrhar = person "Rozvrhář"
        admin = person "Admin"
        # needed for dynamic diagram
        uzivatel = person "Uživatel"
        schedules = softwareSystem "Schedules" {
            app_frontend = container "App Frontend" {
                schedule_view = component "Schedule View"
                building_room_view = component "Building and Room View"
                sched_appr_view = component "Schedule Approval View"
            }

            response_analyzer = container "Response Analyzer" {
                response_collector = component "Response Collector"
                cache = component "Cache" {
                    tag "Cache"
                }
                response_judge = component "Response Judge"
                schedule_cacher = component "Schedule Cacher"
            }

            data_mngr = container "Data Manager" {
                permission_checker = component "Permission Checker"
                schedule_req_checker = component "Schedule Requirements Checker"
                data_checker = component "Data Checker"
                collision_checker = component "Collision Checker"
            }

            #TODO: Predelat
            data_ctrlr = container "Data Controller" {
                api_forwarder = component "API Forwarder"
                data_save_checker = component "Data Save Checker"
                subject_repository = component "Subject Repository"
                room_repository = component "Room Repository"
                reservation_repository = component "Reservation Repository" 
                db_comunicator = component "Database Communicator"
                schedule_repository = component "Schedule Repository"
            }

            schedule_gen = container "Schedule Generator" {
                schedule_generator = component "Schedule Generator"
                quality_sorter = component "Quality Sorter"
            }

            notif_manager = container "Notification Manager" {
                notif_crtr = component "Notification Creator"
                notif_sndr = component "Notification Sender"
            }

            schedule_database = container "Schedule Database" {
                tag "Database"
            }
        }
        mail_server = softwareSystem "Mail Server"
        subjects = softwareSystem "Subjects"
        building_administration = softwareSystem "Building Administration"
        
        development = deploymentEnvironment "Deployment diagram" {
            
            wb = deploymentNode "Web browser" {
                containerInstance schedules.app_frontend
            }
            

            as = deploymentNode "Application Server" {
                    ws = deploymentNode "Web Server" {
                        containerInstance schedules.data_mngr
                        containerInstance schedules.schedule_gen
                        containerInstance schedules.response_analyzer
                    }
                    dhs = deploymentNode "Data Handling Server" {
                        containerInstance schedules.data_ctrlr
                    }
                    ntf_s = deploymentNode "Notification Server" {
                        containerInstance schedules.notif_manager
                    }
            }

            ds = deploymentNode "Database Server" {
                    deploymentNode "Relational DB Server" {
                        containerInstance schedules.schedule_database
                    }
            }
            ms = deploymentNode "Mail Server" {
                softwareSystemInstance mail_server 
            }

            ba = deploymentNode "Building administration" {
                softwareSystemInstance building_administration 
            }

            sub = deploymentNode "Subjects" {
                softwareSystemInstance subjects 
            }            

        }

        ###### L1

        L1_1 = schedules -> mail_server "Send e-mails"
        L1_2 = schedules -> subjects "Fetches data about buildings though API calls from"
        L1_3 = schedules -> building_administration "Fetches data about buildings though API calls from"

        L1_4 = ucitel -> schedules "Views schedule, sets personal requirements, makes room reservations"
        L1_5 = student -> schedules "Views schedule"
        L1_6 = rozvrhar -> schedules "Generates and views schedules"
        L1_7 = admin -> schedules "Manages buildings and rooms"
        
        ######


        ###### L2

        L2_1 = ucitel -> schedules.app_frontend "Views schedule, sets personal requirements, makes room reservations"
        L2_2 = student -> schedules.app_frontend "Views schedule"
        L2_3 = rozvrhar -> schedules.app_frontend "Manages buildings and rooms"
        L2_4 = admin -> schedules.app_frontend "Generates and views schedules"

        L2_5 = schedules.app_frontend -> schedules.data_ctrlr "Reads schedule data from"
        L2_6 = schedules.app_frontend -> schedules.data_mngr "Sends entered data to"
        L2_7 = schedules.app_frontend -> schedules.response_analyzer "Sends schedulers' responses to"

        L2_8 = schedules.data_mngr -> schedules.schedule_gen "Sends validated data to"
        L2_9 = schedules.data_mngr -> schedules.data_ctrlr "Sends validated data to"

        L2_10 = schedules.response_analyzer -> schedules.data_ctrlr "Saves final schedule"

        L2_11 = schedules.data_ctrlr -> schedules.schedule_database "Saves/fetches schedule data"
        L2_12 = schedules.data_ctrlr -> building_administration "Fetches data about buildings"
        L2_13 = schedules.data_ctrlr -> subjects "Fetches data about subjects"
        L2_14 = schedules.data_ctrlr -> schedules.notif_manager "Evokes notification"

        L2_15 = schedules.schedule_gen -> schedules.data_ctrlr "Fetches data about buildings/subjects"
        L2_16 = schedules.schedule_gen -> schedules.notif_manager "Evokes notification"
        L2_17 = schedules.schedule_gen -> schedules.response_analyzer "Sends generated schedules to"

        L2_18 = schedules.notif_manager -> mail_server "Send e-mail"
        
        ######


        ###### L3

        #### APP FRONTEND RELATIONS

        a1 = student -> schedules.app_frontend.schedule_view "Views Schedule"
        a2 = student -> schedules.app_frontend.building_room_view "Views building and room list"

        a3 = ucitel -> schedules.app_frontend.schedule_view "Views Schedule"
        a4 = ucitel -> schedules.app_frontend.building_room_view "Views building and room list"

        a5 = rozvrhar -> schedules.app_frontend.schedule_view "Views Schedule"
        a6 = rozvrhar -> schedules.app_frontend.building_room_view "Views building and room list"
        a7 = rozvrhar -> schedules.app_frontend.sched_appr_view "Approves schedule"

        a8 = admin -> schedules.app_frontend.schedule_view "Views Schedule"
        a9 = admin -> schedules.app_frontend.building_room_view "Views building and room list"
        a10 = admin -> schedules.app_frontend.sched_appr_view "Views approval state"
        
        a11 = schedules.app_frontend.schedule_view -> schedules.data_ctrlr "Fetches schedule data"
        a12 = schedules.app_frontend.schedule_view -> schedules.data_mngr "Checks permissions to view specific schedule using"

        a13 = schedules.app_frontend.building_room_view -> schedules.data_ctrlr "Fetches data about buildings and rooms"
        a14 = schedules.app_frontend.building_room_view -> schedules.data_mngr "Sends reservation requests to"

        a15 = schedules.app_frontend.sched_appr_view -> schedules.response_analyzer "Sends schedulers' responses to"
        
        ####


        #### RESPONSE ANALYZER RELATIONS

        r1 = schedules.app_frontend -> schedules.response_analyzer.response_collector "Sends schedulers' responses to"

        r2 = schedules.schedule_gen -> schedules.response_analyzer.schedule_cacher "Saves generated schedules into"

        r3 = schedules.response_analyzer.schedule_cacher -> schedules.response_analyzer.cache

        r4 = schedules.response_analyzer.cache -> schedules.response_analyzer.response_judge "Notifies about data change"

        r5 = schedules.response_analyzer.response_judge -> schedules.data_ctrlr "Saves final schedule"
        r6 = schedules.response_analyzer.response_judge -> schedules.response_analyzer.cache "Reads responses and schedules from"

        r7 = schedules.response_analyzer.response_collector -> schedules.response_analyzer.cache "Saves responses"

        ####

        
        #### DATA MANAGER RELATIONS

        dm1 = schedules.app_frontend -> schedules.data_mngr.schedule_req_checker "Sends entered data to"
        dm2 = schedules.app_frontend -> schedules.data_mngr.data_checker "Sends entered data to"
        dm3 = schedules.app_frontend -> schedules.data_mngr.permission_checker "Requests user permission check from"
        dm4 = schedules.app_frontend -> schedules.data_mngr.collision_checker "Sends reservation for validation to"

        dm5 = schedules.data_mngr.permission_checker -> schedules.app_frontend "Sends permission check result"

        dm6 = schedules.data_mngr.schedule_req_checker -> schedules.schedule_gen "Sends validated data to"

        dm7 = schedules.data_mngr.data_checker -> schedules.data_ctrlr "Sends validated data to"

        dm8 = schedules.data_mngr.collision_checker -> schedules.data_ctrlr "Reads data about schedules and saves reservation"

        #### 


        #### SCHEDULE GENERATOR RELATIONS

        s1 = schedules.data_mngr -> schedules.schedule_gen.schedule_generator "Sends validated data to"

        s2 = schedules.schedule_gen.schedule_generator -> schedules.data_ctrlr "Reads data about buildings/subjects"
        s3 = schedules.schedule_gen.schedule_generator -> schedules.schedule_gen.quality_sorter "Gives schedule drafts to"

        s4 = schedules.schedule_gen.quality_sorter -> schedules.response_analyzer "Sends generated schedule to"
        s5 = schedules.schedule_gen.quality_sorter -> schedules.notif_manager "Evokes notification"

        ####


        #### DATA CONTROLLER RELATIONS

        d1 = schedules.schedule_gen -> schedules.data_ctrlr.api_forwarder "Fetches data about buildings and subjects"
        d2 = schedules.app_frontend -> schedules.data_ctrlr.api_forwarder "Reads data using"
        d3 = schedules.data_mngr -> schedules.data_ctrlr.api_forwarder "Sends validated data to"
        d4 = schedules.response_analyzer -> schedules.data_ctrlr.api_forwarder "Saves responses using"
        
        d5 = schedules.data_ctrlr.api_forwarder -> schedules.notif_manager  "Sends validation or analysis data for notification"
        d6 = schedules.data_ctrlr.api_forwarder -> schedules.data_ctrlr.subject_repository "Forwards requests to or results back from"
        d7 = schedules.data_ctrlr.api_forwarder -> schedules.data_ctrlr.room_repository "Forwards requests to or results back from"
        d8 = schedules.data_ctrlr.api_forwarder -> schedules.data_ctrlr.reservation_repository "Forwards requests to or results back from"
        d9 = schedules.data_ctrlr.api_forwarder -> schedules.data_ctrlr.schedule_repository "Forwards requests to or results back from"
        
        d10 = schedules.data_ctrlr.subject_repository -> subjects "Fetches data about subjects"
        d11 = schedules.data_ctrlr.room_repository -> building_administration "Saves data about rooms"
        d12 = schedules.data_ctrlr.reservation_repository -> building_administration "Fetches data about buildings and rooms"
        d13 = schedules.data_ctrlr.reservation_repository -> schedules.data_ctrlr.db_comunicator "Sends request for saving a reservation"
        d14 = schedules.data_ctrlr.schedule_repository -> schedules.data_ctrlr.db_comunicator "Fetches or saves data about schedules" 

        d15 = schedules.data_ctrlr.db_comunicator -> schedules.data_ctrlr.data_save_checker "Notifies about data save"
        d16 = schedules.data_ctrlr.db_comunicator -> schedules.schedule_database "Fetches and saves schedules into"

        d17 = schedules.data_ctrlr.data_save_checker -> schedules.schedule_database "Checks success after saving in"
        
        ####


        #### NOTIFICATION MANAGER RELATIONS

        n1 = schedules.schedule_gen -> schedules.notif_manager.notif_crtr "Evokes notification about generated schedule"
        n2 = schedules.data_ctrlr -> schedules.notif_manager.notif_crtr "Evokes notification"

        n3 = schedules.notif_manager.notif_crtr -> schedules.notif_manager.notif_sndr "Sends notification using"

        n4 = schedules.notif_manager.notif_sndr -> mail_server "Send e-mail"

        ####

        ######


        ###### DUMMY RELATIONS FOR DYNAMICS

        # Not used in any L3 but needed for dynamic diagram
        dum1 = schedules.data_mngr -> schedules.notif_manager "Evokes notification"
        dum2 = uzivatel -> schedules.app_frontend "Opens dashboard/clicks \"buildings and rooms\""
        
        ######

        
        ###### RELATIONS FOR DEPLOYMENT

        development.wb -> development.as.ws "Delivers requests to"
        development.as.dhs -> development.wb "Delivers to the customer's web browser"
        development.as.dhs -> development.as.ws "Transfers data to"
        development.as.ws -> development.as.dhs "Delivers requests to write or read"
        development.as.ws -> development.as.ntf_s "Sends messages for notifying to"

        development.as.dhs -> development.ds "Reads from and/or writes to"
        development.as.dhs -> development.ba "Reads from and/or writes to"
        development.as.dhs -> development.sub "Reads from and/or writes to"
         
        development.as.ntf_s -> development.ms "Sends created notification"

        ######
    }



    views {
        systemContext schedules "L1" {
            # includes
            include L1_1 L1_2 L1_3 L1_4 L1_5 L1_6 L1_7
            include ucitel student rozvrhar admin
            include schedules mail_server subjects building_administration

            #layout
            autolayout tb
        }

        container schedules "L2" {
            # includes
            include L2_1 L2_2 L2_3 L2_4 L2_5 L2_6 L2_7 L2_8 L2_9 L2_10 L2_11 L2_12 L2_13 L2_14 L2_15 L2_16 L2_17 L2_18
            include ucitel student rozvrhar admin
            include "element.parent==schedules"
            include mail_server subjects building_administration

            #excludes
            exclude L1_1 L1_2 L1_3 L1_4 L1_5 L1_6 L1_7
            exclude a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15
            exclude r1 r2 r3 r4 r5 r6 r7
            exclude dm1 dm2 dm3 dm4 dm5 dm6 dm7 dm8
            exclude d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 d11 d12 d13 d14 d15 d16 d17
            exclude s1 s2 s3 s4 s5
            exclude n1 n2 n3 n4
            exclude dum1 dum2

            #layout
            autolayout tb
        }

        component schedules.app_frontend "L3_App_Frontend" {
            # includes
            include a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15
            include ucitel student rozvrhar admin
            include "element.parent==schedules.app_frontend"
            include schedules.data_ctrlr schedules.data_mngr schedules.response_analyzer

            # excludes
            exclude L2_1 L2_2 L2_3 L2_4 L2_5 L2_6 L2_7 L2_8 L2_9 L2_10 L2_11 L2_12 L2_13 L2_14 L2_15 L2_16 L2_17 L2_18
            exclude r1 r2 r3 r4 r5 r6 r7
            exclude dm1 dm2 dm3 dm4 dm5 dm6 dm7 dm8
            exclude d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 d11 d12 d13 d14 d15 d16 d17
            exclude s1 s2 s3 s4 s5
            exclude n1 n2 n3 n4
            exclude dum1 dum2

            # layout
            autolayout lr
        }

        component schedules.response_analyzer "L3_Response_Analyzer" {
            # includes
            include r1 r2 r3 r4 r5 r6 r7
            include "element.parent==schedules.response_analyzer"
            include schedules.app_frontend schedules.data_ctrlr schedules.schedule_gen

            # excludes
            exclude L2_1 L2_2 L2_3 L2_4 L2_5 L2_6 L2_7 L2_8 L2_9 L2_10 L2_11 L2_12 L2_13 L2_14 L2_15 L2_16 L2_17 L2_18
            exclude a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15
            exclude dm1 dm2 dm3 dm4 dm5 dm6 dm7 dm8
            exclude d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 d11 d12 d13 d14 d15 d16 d17
            exclude s1 s2 s3 s4 s5
            exclude n1 n2 n3 n4
            exclude dum1 dum2

            # layout
            autolayout lr
        }

        component schedules.data_mngr "L3_Data_Manager" {
            # includes
            include dm1 dm2 dm3 dm4 dm5 dm6 dm7 dm8
            include "element.parent==schedules.data_mngr"
            include schedules.app_frontend schedules.data_ctrlr schedules.schedule_gen

            # excludes
            exclude L2_1 L2_2 L2_3 L2_4 L2_5 L2_6 L2_7 L2_8 L2_9 L2_10 L2_11 L2_12 L2_13 L2_14 L2_15 L2_16 L2_17 L2_18
            exclude a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15
            exclude r1 r2 r3 r4 r5 r6 r7
            exclude d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 d11 d12 d13 d14 d15 d16 d17
            exclude s1 s2 s3 s4 s5
            exclude n1 n2 n3 n4
            exclude dum1 dum2
            
            # layout
            autolayout lr
        }

        component schedules.schedule_gen "L3_Schedule_Generator" {
            # includes
            include s1 s2 s3 s4 s5
            include "element.parent==schedules.schedule_gen"
            include schedules.data_ctrlr schedules.notif_manager schedules.response_analyzer schedules.data_mngr

            # excludes
            exclude L2_1 L2_2 L2_3 L2_4 L2_5 L2_6 L2_7 L2_8 L2_9 L2_10 L2_11 L2_12 L2_13 L2_14 L2_15 L2_16 L2_17 L2_18
            exclude a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15
            exclude r1 r2 r3 r4 r5 r6 r7
            exclude dm1 dm2 dm3 dm4 dm5 dm6 dm7 dm8
            exclude d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 d11 d12 d13 d14 d15 d16 d17
            exclude n1 n2 n3 n4
            exclude dum1 dum2

            # layout
            autolayout lr
        }

        component schedules.data_ctrlr "L3_Data_Controller" {
            # includes
            include d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 d11 d12 d13 d14 d15 d16 d17
            include "element.parent==schedules.data_ctrlr"
            include "element.parent==schedules"
            include subjects building_administration

            # excludes
            exclude L2_1 L2_2 L2_3 L2_4 L2_5 L2_6 L2_7 L2_8 L2_9 L2_10 L2_11 L2_12 L2_13 L2_14 L2_15 L2_16 L2_17 L2_18
            exclude a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15
            exclude r1 r2 r3 r4 r5 r6 r7
            exclude dm1 dm2 dm3 dm4 dm5 dm6 dm7 dm8
            exclude s1 s2 s3 s4 s5
            exclude n1 n2 n3 n4
            exclude schedules.data_ctrlr
            exclude dum1 dum2
            
            # layout
            autolayout lr
        }

        component schedules.notif_manager "L3_Notification_Manager" {
            # includes
            include n1 n2 n3 n4
            include "element.parent==schedules.notif_manager"
            include schedules.schedule_gen schedules.data_ctrlr
            include mail_server

            # excludes
            exclude L2_1 L2_2 L2_3 L2_4 L2_5 L2_6 L2_7 L2_8 L2_9 L2_10 L2_11 L2_12 L2_13 L2_14 L2_15 L2_16 L2_17 L2_18
            exclude a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15
            exclude r1 r2 r3 r4 r5 r6 r7
            exclude dm1 dm2 dm3 dm4 dm5 dm6 dm7 dm8
            exclude d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 d11 d12 d13 d14 d15 d16 d17
            exclude s1 s2 s3 s4 s5
            exclude dum1 dum2
            
            # layout
            autolayout lr
        }

        deployment * development {
            include *
            exclude dum1 dum2
            exclude L2_1 L2_2 L2_3 L2_4 L2_5 L2_6 L2_7 L2_8 L2_9 L2_10 L2_11 L2_12 L2_13 L2_14 L2_15 L2_16 L2_17 L2_18
            exclude a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11 a12 a13 a14 a15
            exclude r1 r2 r3 r4 r5 r6 r7
            exclude dm1 dm2 dm3 dm4 dm5 dm6 dm7 dm8
            exclude d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 d11 d12 d13 d14 d15 d16 d17
            exclude s1 s2 s3 s4 s5
            exclude n1 n2 n3 n4
            autolayout lr
        }

        dynamic schedules {
            title "Automaticky generovat celý rozvrh"

            rozvrhar -> schedules.app_frontend "Opens dashboard"
            schedules.app_frontend -> schedules.data_ctrlr "Reads data about subjects"
            schedules.app_frontend -> schedules.data_mngr "Enters schedule requirements"
            schedules.data_mngr -> schedules.schedule_gen "System generates schedules"
            schedules.schedule_gen -> schedules.data_ctrlr "Fetches data about buildings/subjects"
            schedules.app_frontend -> schedules.response_analyzer "Sends schedulers' responses to"
            schedules.response_analyzer -> schedules.data_ctrlr "Saves final schedule"
            schedules.schedule_gen -> schedules.notif_manager "Evokes notification"

            autoLayout lr
        }

        dynamic schedules {
            title "Zrušit rozvrhnutý předmět"

            rozvrhar -> schedules.app_frontend "Opens dashboard/clics \"subjects\""
            schedules.app_frontend -> schedules.data_ctrlr "Reads data about subjects"
            rozvrhar -> schedules.app_frontend "Picks a subject"
            schedules.app_frontend -> schedules.data_ctrlr "Reads schedule data of a subject"
            rozvrhar -> schedules.app_frontend "Picks a block to cancel"
            schedules.app_frontend -> schedules.data_mngr "Sends selection for validation"
            schedules.data_mngr -> schedules.data_ctrlr "Cancels selected block"
            schedules.data_mngr -> schedules.notif_manager "Evokes notification"

            autolayout lr
        }

        dynamic schedules {
            title "Rezervace místností"

            uzivatel -> schedules.app_frontend "Opens dashboard/clicks \"buildings and rooms\""
            schedules.app_frontend -> schedules.data_ctrlr "Reads data about buildings"
            uzivatel -> schedules.app_frontend "Picks a building"
            schedules.app_frontend -> schedules.data_ctrlr "Reads data about rooms"
            uzivatel -> schedules.app_frontend "Picks a room"
            schedules.app_frontend -> schedules.data_ctrlr "Reads schedule data"
            uzivatel -> schedules.app_frontend "Picks a free block for reservation"
            schedules.app_frontend -> schedules.data_mngr "Sends reservation for validation"
            schedules.data_mngr -> schedules.data_ctrlr "Sends reservation to"

            autolayout lr
        }

        dynamic schedules {
            title "Zobrazit rozvrh"

            uzivatel -> schedules.app_frontend "Opens dashboard"
            schedules.app_frontend -> schedules.data_mngr "Checks who is logged"
            schedules.app_frontend -> schedules.data_ctrlr "Reads schedule data from"

            autolayout lr
        }

        dynamic schedules {
            title "Informace o místnostech"

            admin -> schedules.app_frontend "Opens dashboard/clicks \"buildings and rooms\""
            schedules.app_frontend -> schedules.data_ctrlr "Reads data about buildings"
            admin -> schedules.app_frontend "Selects building"
            schedules.app_frontend -> schedules.data_ctrlr "Reads data about rooms"
            admin -> schedules.app_frontend "Selects room then press \"Edit\""
            admin -> schedules.app_frontend "Edits parameters of the room"
            schedules.app_frontend -> schedules.data_mngr "Sends changes for validation"
            schedules.data_mngr -> schedules.data_ctrlr "Saves changes to"

            autolayout lr
        }

        dynamic schedules {
            title "Výběr nejlepšího rozvrhu podle studijního plánu"

            schedules.schedule_gen -> schedules.response_analyzer "Saves generated and scored schedules into"
            schedules.app_frontend -> schedules.response_analyzer "Sends request to view schedules"
            schedules.response_analyzer -> schedules.app_frontend "Returns schedules for viewing"
            schedules.app_frontend -> schedules.response_analyzer "Sends schedulers' selections to"
            schedules.response_analyzer -> schedules.data_ctrlr "Saves final schedule using"
            
            # dont know how to get rid of the text of the arrow
            rozvrhar -> schedules.app_frontend "              "

            autolayout lr
        }

        dynamic schedules {
            title "Přidat paralelku předmětu do rozvrhu"

            rozvrhar -> schedules.app_frontend "Opens dashboard/clicks \"subjects\""
            schedules.app_frontend -> schedules.data_ctrlr "Reads schedule data about subjects"
            rozvrhar -> schedules.app_frontend "Picks a subject"
            schedules.app_frontend -> schedules.data_ctrlr "Reads schedule data"
            rozvrhar -> schedules.app_frontend "Picks free block for new parallel"
            schedules.app_frontend -> schedules.data_mngr "Sends selection for validation"
            schedules.data_mngr -> schedules.data_ctrlr "Saves new parallel of selected subject into selected free block using"
            
            autolayout lr
        }

        styles {
            element "Person" {
                background #ba1e75
                shape person
            }
            element "Software System" {
                background #333333
            }
            element "Container" {
                background #f8289c
                shape RoundedBox
            }
                element "Database" {
                shape cylinder
            }
            element "Component" {
                background #0c660a
                
            }
                element "Cache" {
                    background #7a4a91
                    shape diamond
            }
            element "Element" {
                color #ffffff
            }
        }
    }

    configuration {
        scope softwaresystem
    }

}
