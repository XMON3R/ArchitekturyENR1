## Schedule Generator - Too many different operatins on one container
### Design-time dimensions - Interoperability

- Source: Schedule Generator - Quality Sorter

- Stimulus: Send generated schedule to analyze and cache it

- Artifact: Response Analyzer

- Enviroment: Design-Time

- Response: Cache generated schedule with applied sorting rules

- Measure: 5 seconds

#### Architecture update

Response analyse should be done on the Schedule Generator side of the container, so that the container Response Analyzer does not have to deal with schedule analysis and thus reduces the load on the response analyzer container. All analysis, creation and application of class rules should be handled by one container.

## Schedule Generator - Too many divided into parts when creating schedule
### Run-time dimensions - Performance

- Source: Schedule Generator - Generator Component

- Stimulus: Generated schedule for quality evaluation

- Artifact: Quality Sorter Component

- Enviroment: Run-Time

- Response: Apply sorting rules and refine generated schedule

- Measure: 5 seconds

#### Architecture update

The architecture should already apply sorting rules when creating the schedule. This will lead to faster scheduling than doing 2 operations separately - generating and sorting. 
