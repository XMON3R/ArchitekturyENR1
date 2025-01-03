## Schedule Generator - Too many requests at once
### Run-time dimension - Scability

- Source: Scheduler

- Stimulus: needs schedules for a recording amount of students

- Artifact: Schedule Generator

- Enviroment: Normal operation

- Response: Schedule Genetor component needed to be scalled up

- Measure: Performance was not affected

#### Architecture Update
Based on this scenario, the current architecture should hold up, but the Schedule generator component needs to be scalled up, so that many request (for example at the start of a semester) can be resolved without the system failing.

## App Frontend - Security Attacks
### Run-time dimension - Security

- Source: Attacker that wants student data

- Stimulus: wants student and school data

- Artifact: AppFrontend (to Data Controller)

- Enviroment: Run-time

- Response: Attacker's script/hack is not accepted and is blocked from the system

- Measure: The data is untouched 

#### Architecture update 
Based on this scenario, the AppFrontEnd container should have an extra "Entry point" component that deals with script injections and unauthorised access.
