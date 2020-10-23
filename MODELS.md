# Models

## Recipe
### Fields
- Name of recipe
- estimated time to make (int)
- directions (text)
- timestamps (i.e. date created)

### Relationships:
- `:has_many` ingredients (many-to-many)
- `:belongs_to` category
- `:has_many` ratings
- `:has_many users_rating, through: :ratings` 

### Functions:
  - average rating
  - ingredient count
  
### Scopes:
- `in_category(name)`

## Ingredient
### Fields
- Name
- Units of Measure

### Relationships:
- `:has_many :recipe_ingredients`
- `:has_many :recipes, through: :recipe_ingredients`

## RecipeIngredient
- Join table between Recipe and Ingredient 
- Extra column: quantity

## User
### Fields
- Name
- Email
- Password
- Password_hash or password_digest or has_secure_password??
- field for user id for FB/Google/etc

### Relationships:
- `:has_many :rated_recipies through :recipes??`

# Rating
- Join table between user and recipe containing int field for rating