Feature: Adding a new post to the blog
  As a blog author
  In order to share my ideas with the world
  I want to add a new post to my blog

  Scenario: Adding a new post
    When I add a new post to the blog
    Then I should see the post on the homepage