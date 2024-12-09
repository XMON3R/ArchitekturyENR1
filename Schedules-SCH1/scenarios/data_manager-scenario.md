
###  appfronter validation - availability

- Source App fronted

- Stimulus sends wrong data to validate

- Artifact data manager- schedule requirements/data checker

- Response informs app fronted

- Measure 1 second

#### Architecture Update
The architecture should inform app frontend about what was wrong with input data. I would consider expanding architecture by component "info sender" that would better communicate with front end.

###  user permision- security

- Source app frontend

- Stimulus wants to know if user has permision

- Artifact data manager- permision checker

- Response app frontend learns if user has permision

- Measure with avarage latency of 200 ms

#### Architecture Update
The architecture handles permissions independently from other requests from frontend, which entwines frontend and data manager. I would consider checking permisions of requests inside data manager
