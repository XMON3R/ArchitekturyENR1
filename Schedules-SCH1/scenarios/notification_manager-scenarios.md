## Notification Manager - Too many notifications from analysis and validation
### Run-time dimensions - Availability

- Source: Notification Manager

- Stimulus: Too many notifications at the same time

- Artifact: Mail server

- Enviroment: Run-time

- Response: Repeat

- Measure: 2s downtime

#### Architecture update

The architecture should be able to handle it. This scenario can happen only in extreme situations which shouldn't arise from normal use.

## Notification Manager - Changing mail server
### Run-time dimensions - Modifiability

- Source: Notification Manager

- Stimulus: New mail server is to be used

- Artifact: Mail server

- Enviroment: Run-time

- Response: New mail server is added

- Measure: 1 man-day of testing

#### Architecture update

The architecture should be able to handle it, notifications are just sent to a different mail server.