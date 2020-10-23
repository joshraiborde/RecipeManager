# A Recipe Manager

## Features
- [ ] Browse recipes by different filters
    - [ ] date created
    - [ ] ingredient count
    - [ ] rating / comments / etc
- [ ] Unique ingredients 
  - so that the first user that adds Chicken to their recipe would create the canonical (or atomic/unique/individual) instance of Chicken (the only row to ever have the name Chicken in the ingredients table). 
    - This will force a join model between ingredients and recipes and provide an easy way to group recipes by ingredients
- [ ] Some user-centric data regarding recipes such as ratings or comments 

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
- [ ] standard user authentication
  - [ ] signup
  - [ ] login
  - [ ] logout
  - [ ] passwords
- [ ] allow login from some other service. Facebook, Twitter, Foursquare, Github, etc...

### Routing 
- [ ] RESTful URLs
- [ ] At least one nested resource with: 
    - [ ] a new route with form that relates to the parent resource
    - [ ] a nested index or show route

### Forms
- [ ] correctly display validation errors (describing the validation failures)
- [ ] fields should be enclosed within a fields_with_errors class

### Coding / Structure
- [ ] DRY
- [ ] Controller logic should be encapsulated as methods in models.
- [ ] Views should use helper methods and partials when appropriate.
- [ ] Follow patterns in the Rails Style Guide and the Ruby Style Guide.
- [ ] Do not use scaffolding 