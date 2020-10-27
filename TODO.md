# A Recipe Manager

## General
- [ ] Finish all views
- [ ] Ratings
- [ ] Recipe Sorting (+scope method)
- [ ] authentication (external)
- [ ] Testing
## Features
- [ ] Browse recipes by different filters
    - [ ] date created
    - [ ] ingredient count
    - [ ] rating / comments / etc
- [x] Unique ingredients 
  - so that the first user that adds Chicken to their recipe would create the canonical (or atomic/unique/individual) instance of Chicken (the only row to ever have the name Chicken in the ingredients table). 
    - This will force a join model between ingredients and recipes and provide an easy way to group recipes by ingredients
- [x] Some user-centric data regarding recipes such as ratings or comments 

## Requirements
### Models
- [x] At least:
  - [x] one has_many
  - [x] one belongs_to
  - [x] two has_many :through relationshipsm 
  - [x] a many-to-many relationship implemented with has_many :through associations. (where the join table must include a user-submittable attribute other than foreign keys)
- [x] reasonable validations for the simple attributes. (the models should defend against invalid data)
- [ ] one scope method. 

### Auth 
- [x] standard user authentication
  - [x] signup
  - [x] login
  - [x] logout
  - [ ] passwords
- [ ] allow login from some other service. Facebook, Twitter, Foursquare, Github, etc...

### Routing 
- [x] RESTful URLs
- [x] At least one nested resource with: 
    - [x] a new route with form that relates to the parent resource
    - [x] a nested index or show route

### Forms
- [x] correctly display validation errors (describing the validation failures)
- [ ] fields should be enclosed within a fields_with_errors class

### Coding / Structure
- [x] DRY
- [x] Controller logic should be encapsulated as methods in models.
- [x] Views should use helper methods and partials when appropriate.
- [x] Follow patterns in the Rails Style Guide and the Ruby Style Guide.
- [x] Do not use scaffolding 