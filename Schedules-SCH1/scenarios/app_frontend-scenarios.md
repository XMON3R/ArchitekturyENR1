## App Frontend - High traffic during semester start scenario
### Run-time dimension - Availability

- Source: App Frontend - Schedule View

- Stimulus: Unresponsive schedule viewing

- Artifact: Data Controller

- Enviroment: Normal operation

- Response: Repeat

- Measure: 2s downtime

#### Architecture update

The architecture has complex data fetching with many layers of abstraction in pair with multiple databases present. Consider reducing this to a single database with centralized API for data request.


## App Frontend - Adding new reservation rules/configurations
### Design-time dimension - Modifiability

- Source: App Frontend - Building and Room View

- Stimulus: New rules for reservations are to be added

- Artifact: Data Manager

- Enviroment: Run-time

- Response: New reservation rules are added and working

- Measure: 5 man-day of testing

#### Architecture update

The architecture should be able to handle it. Container - Data Manager, contains neccessary "checker" components. A more centralized approach may be beneficial to simplify this process.