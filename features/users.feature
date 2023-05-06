Feature: Users management

  Scenario: List users
    When I list all "users"
    Then I should have response "OK"
    And following "users" list:
      | id                                   | lastName  | firstName | birthDate  | address                                   | phone         | email                    |
      | 5793ee17-5d65-4e73-92fd-6c4d9fef96a8 | GOUPIL    | Alban     | 1995-11-17 |          3 rue des aubépines 44300 Nantes |  +33634689374 | alban.goupil@gmail.com   |
      | fe523f18-6b19-44e0-b156-446edc0e6862 | GROLLIER  | Théo      | 1989-03-04 | 18 boulevard des trois croix 35000 Rennes |    0657836652 | theo.grollier@gmail.com  |
      | 63dcff89-47c5-4365-875d-8934a250d0fe | BLANCHARD | Hugo      | 1996-06-30 |            14 allée oseraie 94260 fresnes | 0033678398215 | hugo.blanchard@gmail.com |

  Scenario: Get a user
    When I get the "user" having id "5793ee17-5d65-4e73-92fd-6c4d9fef96a8"
    Then I should have response "OK"
    And following "user" item:
      | id                                   | lastName | firstName | birthDate  | address                          | phone        | email                  |
      | 5793ee17-5d65-4e73-92fd-6c4d9fef96a8 | GOUPIL   | Alban     | 1995-11-17 | 3 rue des aubépines 44300 Nantes | +33634689374 | alban.goupil@gmail.com |

  Scenario: Get an inexistant user
    When I get the "user" having id "5793ee17-5d65-4e73-92fd-6c4d9fef9abc"
    Then I should have response "NOT_FOUND"
    And following error : "User with id 5793ee17-5d65-4e73-92fd-6c4d9fef9abc not found"

  Scenario: Create a user
    When I create the following "user":
      | lastName | firstName | birthDate  | address                         | phone        | email                     |
      | GONZALEZ | Nathan    | 1992-04-18 | 268 Rue Jouffroy, 59100 Roubaix | +33674354418 | nathan.gonzalez@gmail.com |
    Then I should have response "CREATED"
    And following new "user" item:
      | lastName | firstName | birthDate  | address                         | phone        | email                     |
      | GONZALEZ | Nathan    | 1992-04-18 | 268 Rue Jouffroy, 59100 Roubaix | +33674354418 | nathan.gonzalez@gmail.com |
  
  Scenario: Create a user with wrong birthdate format
    When I create the following "user":
      | lastName | firstName | birthDate  | address                         | phone        | email                     |
      | GONZALEZ | Nathan    | 19920418   | 268 Rue Jouffroy, 59100 Roubaix | +33674354418 | nathan.gonzalez@gmail.com |
    Then I should have response "BAD_REQUEST"
    And following error : "BirthDate format incorrect (yyyy-mm-dd)"

  Scenario: Create a user with wrong phone format
    When I create the following "user":
      | lastName | firstName | birthDate  | address                         | phone        | email                     |
      | GONZALEZ | Nathan    | 1992-04-18 | 268 Rue Jouffroy, 59100 Roubaix | 674354418   | nathan.gonzalez@gmail.com |
    Then I should have response "BAD_REQUEST"
    And following error : "Phone format incorrect (+33 or 0 or 0033 follewed by 9 digits)"

  Scenario: Update a user 
    When I update the "user" having id "63dcff89-47c5-4365-875d-8934a250d0fe" with following data:
      | lastName  | firstName | birthDate  | address                        | phone         | email                    |
      | BLANCHARD | Huguette  | 1996-06-30 | 14 allée oseraie 94260 fresnes | 0033678398215 | hugo.blanchard@gmail.com |
    Then I should have response "OK"
    And following "user" item:
      | id                                   | lastName  | firstName | birthDate  | address                        | phone         | email                    |
      | 63dcff89-47c5-4365-875d-8934a250d0fe | BLANCHARD | Huguette  | 1996-06-30 | 14 allée oseraie 94260 fresnes | 0033678398215 | hugo.blanchard@gmail.com |

  Scenario: Update a user with wrong birthdate format
    When I update the "user" having id "63dcff89-47c5-4365-875d-8934a250d0fe" with following data:
      | lastName  | firstName | birthDate  | address                        | phone         | email                    |
      | BLANCHARD | Huguette  | 19960630 | 14 allée oseraie 94260 fresnes | 0033678398215 | hugo.blanchard@gmail.com |
    Then I should have response "BAD_REQUEST"
    And following error : "BirthDate format incorrect (yyyy-mm-dd)"

  Scenario: Update a user with wrong phone format
    When I update the "user" having id "63dcff89-47c5-4365-875d-8934a250d0fe" with following data:
      | lastName  | firstName | birthDate  | address                        | phone         | email                    |
      | BLANCHARD | Huguette  | 1996-06-30 | 14 allée oseraie 94260 fresnes | 678398215 | hugo.blanchard@gmail.com |
    Then I should have response "BAD_REQUEST"
    And following error : "Phone format incorrect (+33 or 0 or 0033 follewed by 9 digits)"

  Scenario: Update an inexistant user
    When I update the "user" having id "63dcff89-47c5-4365-875d-6c4d9fef9abc" with following data:
      | lastName  | firstName | birthDate  | address                        | phone         | email                    |
      | BLANCHARD | Huguette  | 1996-06-30 | 14 allée oseraie 94260 fresnes | 0033678398215 | hugo.blanchard@gmail.com |
    Then I should have response "NOT_FOUND"
    And following error : "User with id 63dcff89-47c5-4365-875d-6c4d9fef9abc not found"

  Scenario: Delete a user
    When I delete the "user" having id "63dcff89-47c5-4365-875d-8934a250d0fe"
    Then I should have response "OK"
    And following deleted "user" item:
      | id                                   | lastName  | firstName | birthDate  | address                        | phone         | email                    |
      | 63dcff89-47c5-4365-875d-8934a250d0fe | BLANCHARD | Huguette  | 1996-06-30 | 14 allée oseraie 94260 fresnes | 0033678398215 | hugo.blanchard@gmail.com |

  Scenario: Delete an inexistant user
    When I delete the "user" having id "63dcff89-47c5-4365-875d-6c4d9fef9abc"
    Then I should have response "NOT_FOUND"
    And following error : "User with id 63dcff89-47c5-4365-875d-6c4d9fef9abc not found"
