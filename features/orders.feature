Feature: Orders management

  Scenario: List orders
    When I list all "orders"
    Then I should have response "OK"
    And following "orders" list:
      | id                                   | orderDate  | recipeId                             | quantity | userId                               |
      | 7d822bc6-75ce-4e06-be64-6db18477f97f | 2023-01-24 | a35ce12d-d52b-4a07-90ad-68e985b779e7 |        5 | fe523f18-6b19-44e0-b156-446edc0e6862 |
      | 1dcfacd0-43a9-47d5-932e-11eb124f50cc | 2023-02-08 | a35ce12d-d52b-4a07-90ad-68e985b779e7 |        1 | 63dcff89-47c5-4365-875d-8934a250d0fe |
      | 72c00698-bb07-4ae9-bc50-c1731ada0226 | 2023-03-15 | dc466424-4297-481a-a8de-aa0898852da1 |        8 | fe523f18-6b19-44e0-b156-446edc0e6862 |

  Scenario: Get a order
    When I get the "order" having id "7d822bc6-75ce-4e06-be64-6db18477f97f"
    Then I should have response "OK"
    And following "order" item:
      | id                                   | orderDate  | recipeId                             | quantity | userId                               |
      | 7d822bc6-75ce-4e06-be64-6db18477f97f | 2023-01-24 | a35ce12d-d52b-4a07-90ad-68e985b779e7 |        5 | fe523f18-6b19-44e0-b156-446edc0e6862 |

  Scenario: Get an inexistant order
    When I get the "order" having id "5793ee17-5d65-4e73-92fd-6c4d9fef9abc"
    Then I should have response "NOT_FOUND"
    And following error : "Order with id 5793ee17-5d65-4e73-92fd-6c4d9fef9abc not found"

  Scenario: Create a order
    When I create the following "order":
      | orderDate  | recipeId                             | quantity | userId                               |
      | 2023-01-24 | dc466424-4297-481a-a8de-aa0898852da1 |        2 | 5793ee17-5d65-4e73-92fd-6c4d9fef96a8 |
    Then I should have response "CREATED"
    And following new "order" item:
      | orderDate  | recipeId                             | quantity | userId                               |
      | 2023-01-24 | dc466424-4297-481a-a8de-aa0898852da1 |        2 | 5793ee17-5d65-4e73-92fd-6c4d9fef96a8 |

  Scenario: Create a order with wrong orderDate format
    When I create the following "order":
      | orderDate  | recipeId                             | quantity | userId                               |
      | 20230124   | dc466424-4297-481a-a8de-aa0898852da1 |        2 | 5793ee17-5d65-4e73-92fd-6c4d9fef96a8 |
    Then I should have response "BAD_REQUEST"
    And following error : "OrderDate format incorrect (yyyy-mm-dd)"

  Scenario: Create a order with inexistant user
    When I create the following "order":
      | orderDate  | recipeId                             | quantity | userId                               |
      | 2023-01-24 | dc466424-4297-481a-a8de-aa0898852da1 |        2 | 5793ee17-5d65-4e73-92fd-6c4d9fef9fff |
    Then I should have response "NOT_FOUND"
    And following error : "User with id 5793ee17-5d65-4e73-92fd-6c4d9fef9fff not found"

  Scenario: Create a order with inexistant recipe
    When I create the following "order":
      | orderDate  | recipeId                             | quantity | userId                               |
      | 2023-01-24 | dc466424-4297-481a-a8de-aa0898852fff |        2 | 5793ee17-5d65-4e73-92fd-6c4d9fef96a8 |
    Then I should have response "NOT_FOUND"
    And following error : "Recipe with id dc466424-4297-481a-a8de-aa0898852fff not found"

  Scenario: Update a order
    When I update the "order" having id "7d822bc6-75ce-4e06-be64-6db18477f97f" with following data:
      | orderDate  | recipeId                             | quantity | userId                               |
      | 2023-10-01 | a35ce12d-d52b-4a07-90ad-68e985b779e7 |        0 | fe523f18-6b19-44e0-b156-446edc0e6862 |
    Then I should have response "OK"
    And following "order" item:
      | id                                   | orderDate  | recipeId                             | quantity | userId                               |
      | 7d822bc6-75ce-4e06-be64-6db18477f97f | 2023-10-01 | a35ce12d-d52b-4a07-90ad-68e985b779e7 |        0 | fe523f18-6b19-44e0-b156-446edc0e6862 |

  Scenario: Update a order with wrong orderDate format
    When I update the "order" having id "7d822bc6-75ce-4e06-be64-6db18477f97f" with following data:
      | orderDate  | recipeId                             | quantity | userId                               |
      | 20231001   | a35ce12d-d52b-4a07-90ad-68e985b779e7 |        0 | fe523f18-6b19-44e0-b156-446edc0e6862 |
    Then I should have response "BAD_REQUEST"
    And following error : "OrderDate format incorrect (yyyy-mm-dd)"

  Scenario: Update a order with inexistant user
    When I update the "order" having id "7d822bc6-75ce-4e06-be64-6db18477f97f" with following data:
      | orderDate  | recipeId                             | quantity | userId                               |
      | 2023-10-01 | a35ce12d-d52b-4a07-90ad-68e985b779e7 |        0 | fe523f18-6b19-44e0-b156-446edc0e6fff |
    Then I should have response "NOT_FOUND"
    And following error : "User with id fe523f18-6b19-44e0-b156-446edc0e6fff not found"

  Scenario: Update a order with inexistant recipe
    When I update the "order" having id "7d822bc6-75ce-4e06-be64-6db18477f97f" with following data:
      | orderDate  | recipeId                             | quantity | userId                               |
      | 2023-10-01 | a35ce12d-d52b-4a07-90ad-68e985b77fff |        0 | fe523f18-6b19-44e0-b156-446edc0e6862 |
    Then I should have response "NOT_FOUND"
    And following error : "Recipe with id a35ce12d-d52b-4a07-90ad-68e985b77fff not found"

  Scenario: Update an inexistant order
    When I update the "order" having id "63dcff89-47c5-4365-875d-6c4d9fef9abc" with following data:
      | orderDate  | recipeId                             | quantity | userId                               |
      | 2023-10-01 | a35ce12d-d52b-4a07-90ad-68e985b779e7 |        0 | fe523f18-6b19-44e0-b156-446edc0e6862 |
    Then I should have response "NOT_FOUND"
    And following error : "Order with id 63dcff89-47c5-4365-875d-6c4d9fef9abc not found"

  Scenario: Delete a order
    When I delete the "order" having id "1dcfacd0-43a9-47d5-932e-11eb124f50cc"
    Then I should have response "OK"
    And following deleted "order" item:
      | id                                   | orderDate  | recipeId                             | quantity | userId                               |
      | 1dcfacd0-43a9-47d5-932e-11eb124f50cc | 2023-02-08 | a35ce12d-d52b-4a07-90ad-68e985b779e7 |        1 | 63dcff89-47c5-4365-875d-8934a250d0fe |

  Scenario: Delete an inexistant order
    When I delete the "order" having id "63dcff89-47c5-4365-875d-6c4d9fef9abc"
    Then I should have response "NOT_FOUND"
    And following error : "Order with id 63dcff89-47c5-4365-875d-6c4d9fef9abc not found"
