## Project Wrap Up

### Designs

- API definition:
  - [RAW](https://github.com/NgariNdungu/p2p-payments-api/blob/develop/design/openapi.yml)
  - [Swaggerhub - Browsable](https:///app.swaggerhub.com/apis/NgariNdungu/green-mamba-re/1.0.0#/)
- [Product designs -  DFDs, DB models etc](https://github.com/NgariNdungu/p2p-payments-api/tree/develop/design/product%20design)
- [Feature Specs](https://github.com/NgariNdungu/p2p-payments-api/tree/develop/design/feature-specs.md)

### API  Development

Development is still WIP. While the basic functionality is there, it still needs polishing up.
A major part that is incomplete is conformance with the jsonapi spec.
This is being done using [jsonapi-utils](https://github.com/tiagopog/jsonapi-utils) but could be changed.

#### Functionality tracking 
1. User - Incomplete
   - User registration marked complete
   - Written blank tests for show, update and delete actions
   - To do:
     - test cannot deposit or withdraw if not agent

2. Authentication - Complete
3. Agency - Incomplete
  - To do:
    - Test destroy agency

4. Daily reports - Incomplete
  - To do: 
    - Test get daily reports

5. Statement - Incomplete
  - To do:
    - To configure queing
    - To generate pdfs

6. Transactions - Incomplete
  - To do:
    - Test user sending money above their balance
    - Test user withdrawing money above their balance
    - Test deposit to agent with no float

### Deployment

The project is auto-deployed to Heroku from Travis ci.
Tests on travis are run within a docker environment, but deployment is dependent on Heroku's environment.
- TODO: deploy with docker

There's a start-up delay as heroku starts things up so, if the first request fails, try a second time.
- [Project Staging Server URL](https://green-mamba-staging.herokuapp.com/) - if you get a blank page, you're home!

### UI Development:
**Unstarted**  

Mockups available [here](https://github.com/NgariNdungu/p2p-payments-api/blob/develop/design/product%20design/mockups.png)
