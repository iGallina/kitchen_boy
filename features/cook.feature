Feature: kitchen_boy cook
  In order to apply kitchen_boy recipes
  The user can call the binary with the recipe name
  The cook action will also be aliased with install

  Scenario: Running a recipe in ruby
    Given a created kitchen_boy home directory
    And a file named ".kitchen_boy/https_github_com_aitherios_kitchen_boy_recipe_book_git/write_file.rb" with:
      """
      File.open('genesis', 'w') { |f| f.write('content') }
      """
    When I run kitchen_boy cook "write_file"
    Then the exit status should be 0
    And the file "genesis" should contain:
      """
      content
      """

  # Scenario: Running a recipe with thor
  #   Given a created kitchen_boy home directory
  #   And a directory named ".kitchen_boy/https_github_com_aitherios_kitchen_boy_recipe_book_git/dir"
  #   And a file named ".kitchen_boy/https_github_com_aitherios_kitchen_boy_recipe_book_git/dir/before.rb" with:
  #     """
      
  #     """

  Scenario: Running a recipe with arguments

  @wip
  Scenario: Running a recipe that uses thor actions

  Scenario: Running a recipe that uses rails actions

  Scenario: Passing arguments to the ruby recipe
