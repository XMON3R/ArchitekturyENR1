
## Data controller

#### Architecture update

Add AplicationMonitor to monitor data controller

### Run-time dimension - Availability

- Source: Data controller

- Stimulus: Unable to read current schedules data

- Artifact: Schedule Database

- Enviroment: Normal operation

- Response: Mask(repeat), log

- Measure: 2s downtime


### Run-time dimension - Performance

- Source: Student

- Stimulus: Displays information about buildings and scheludes there (500 requests per minute)

- Artifact: Data controller

- Enviroment: Normal operation

- Response: All requests processed

- Measure: With an average latency of 500 ms

#### Architecture update

The architecture should be able to handle it, all request are handled by data controller succesfully.


## Data Controller - Fetching from multiple external services 
### Design-time dimensions - Interoperability  

Source: Data Controller

Stimulus: Fetching data from external services

Artifact: Subjects System OR Building Administration System

Enviroment: Design-Time

Response: Normalize fetched data

Measure: Performance was not affected

#### Architecture update

The architecture should have better consistency when fetching data from external.
