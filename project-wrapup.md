## Project Wrap Up

### Design
- API definition:
  - [RAW](https://github.com/NgariNdungu/p2p-payments-api/blob/develop/design/openapi.yml)
  - [Swaggerhub - Browsable](https:///app.swaggerhub.com/apis/NgariNdungu/green-mamba-re/1.0.0#/)
- [Product designs - mockups, DFDs, DB models etc](https://github.com/NgariNdungu/p2p-payments-api/tree/develop/design/product%20design)
- [Feature Specs](https://github.com/NgariNdungu/p2p-payments-api/tree/develop/design/feature-specs.md)

### Deployment
The project is hosted on Heroku - there's a start-up hit so, if the first request fails, try a second time.
[Project Staging Server URL](https://green-mamba-staging.herokuapp.com/) - if you get a blank page, you're home!

## Functionality tracking 
### User - Incomplete
- User registration marked complete
- Written blank tests for show, update and delete actions
#### To do:
- test cannot deposit or withdraw if not agent

### Authentication - Complete

### Agency - Incomplete
#### To do:
- Test destroy agency

### Daily reports - Incomplete
#### To do: 
- Test get daily reports

### Statement - Incomplete
#### To do:
- To configure queing
- To generate pdfs

### Transactions - Incomplete
#### To do:
- Test user sending money with above their balance
- Test user withdrawing money above their balance
- Test deposit to agent with no float
